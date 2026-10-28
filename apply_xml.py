#!/usr/bin/env python3
import os
import sys
import re
import difflib
import subprocess
import shutil

BLOCK_PATTERN = re.compile(
    r"^(?P<file>[^\n\r<>]+?)\s*\r?\n"
    r"<<<<<<<\s*SEARCH\r?\n"
    r"(?P<search>.*?)"
    r"=======\r?\n"
    r"(?P<replace>.*?)"
    r">>>>>>>\s*REPLACE",
    re.MULTILINE | re.DOTALL,
)

DELETE_PATTERN = re.compile(
    r"^(?P<file>[^\n\r<>]+?)\s+(?:DELETE FILE|delete file)\s*$",
    re.MULTILINE,
)


def normalize_newlines(text: str) -> str:
    return text.replace("\r\n", "\n") if text else ""


def check_syntax(file_path: str) -> bool:
    """Verifies syntax for modified files."""
    if file_path.endswith(".py"):
        try:
            with open(file_path, "r", encoding="utf-8") as f:
                content = f.read()
            compile(content, file_path, "exec")
            return True
        except SyntaxError as e:
            print(f"⚠️ Python Syntax Error in '{file_path}':\n{e}")
            return False
        except Exception:
            return True

    elif file_path.endswith((".js", ".jsx", ".ts", ".tsx")):
        if shutil.which("npx"):
            try:
                res = subprocess.run(
                    ["npx", "--no-install", "esbuild", file_path, "--log-level=silent"],
                    stdout=subprocess.DEVNULL,
                    stderr=subprocess.PIPE,
                    text=True,
                    timeout=5,
                )
                if res.returncode != 0:
                    print(f"⚠️ JS/TS Syntax Error in '{file_path}':\n{res.stderr.strip()}")
                    return False
                return True
            except Exception:
                pass

        if file_path.endswith(".js") and shutil.which("node"):
            try:
                res = subprocess.run(
                    ["node", "--check", file_path],
                    capture_output=True,
                    text=True,
                    timeout=3,
                )
                if res.returncode != 0:
                    print(f"⚠️ JavaScript Syntax Error in '{file_path}':\n{res.stderr.strip()}")
                    return False
                return True
            except Exception:
                pass

    return True


def replace_exact(file_content: str, search_text: str, replace_text: str) -> str | None:
    count = file_content.count(search_text)
    if count == 1:
        return file_content.replace(search_text, replace_text)
    elif count > 1:
        print("⚠️ Warning: Multiple exact occurrences found. Skipping exact match to prevent incorrect replacements.")
    return None


def replace_line_stripped(file_content: str, search_text: str, replace_text: str) -> str | None:
    """Matches lines ignoring indentation differences and aligns replacement indentation."""
    file_lines = file_content.splitlines(keepends=True)
    search_lines = [s.strip() for s in search_text.splitlines() if s.strip()]

    if not search_lines:
        return None

    match_len = len(search_lines)
    matches = []

    for i in range(len(file_lines) - match_len + 1):
        window = [line.strip() for line in file_lines[i : i + match_len]]
        if window == search_lines:
            matches.append(i)

    if len(matches) != 1:
        return None

    idx = matches[0]
    orig_chunk = "".join(file_lines[idx : idx + match_len])

    # Detect indentation of first matched line
    orig_indent = ""
    for line in file_lines[idx : idx + match_len]:
        if line.strip():
            orig_indent = line[: len(line) - len(line.lstrip())]
            break

    # Re-indent replacement lines
    repl_lines = replace_text.splitlines()
    common_indent = None
    for line in repl_lines:
        if line.strip():
            indent = line[: len(line) - len(line.lstrip())]
            common_indent = indent if common_indent is None else os.path.commonprefix([common_indent, indent])

    if common_indent is None:
        common_indent = ""

    adjusted = []
    for line in repl_lines:
        if line.strip():
            rel = line[len(common_indent):] if line.startswith(common_indent) else line.lstrip()
            adjusted.append(orig_indent + rel)
        else:
            adjusted.append("")

    has_trailing = replace_text.endswith("\n")
    adjusted_text = "\n".join(adjusted)
    if has_trailing and not adjusted_text.endswith("\n"):
        adjusted_text += "\n"

    new_lines = file_lines[:idx] + [adjusted_text] + file_lines[idx + match_len :]
    return "".join(new_lines)


def replace_fuzzy(file_content: str, search_text: str, replace_text: str) -> str | None:
    """Sliding line window match using difflib for slight deviations (>92% similarity)."""
    file_lines = file_content.splitlines(keepends=True)
    search_lines = search_text.splitlines(keepends=True)
    search_str = "".join(search_lines)

    if len(search_lines) < 2:
        return None

    best_ratio = 0.0
    best_range = (-1, -1)
    win_len = len(search_lines)

    for sz in range(max(1, win_len - 1), min(len(file_lines), win_len + 2)):
        for i in range(len(file_lines) - sz + 1):
            window_str = "".join(file_lines[i : i + sz])
            ratio = difflib.SequenceMatcher(None, window_str, search_str).ratio()
            if ratio > best_ratio:
                best_ratio = ratio
                best_range = (i, i + sz)

    if best_ratio >= 0.92:
        start, end = best_range
        out = file_lines[:start] + [replace_text] + file_lines[end:]
        return "".join(out)

    return None


def parse_and_apply(patch_text: str):
    patch_text = normalize_newlines(patch_text)

    # 1. Handle explicit file deletions
    for del_match in DELETE_PATTERN.finditer(patch_text):
        file_path = del_match.group("file").strip()
        if os.path.exists(file_path):
            os.remove(file_path)
            print(f"✅ Success: Deleted '{file_path}'")
        else:
            print(f"⚠️ Warning: File to delete not found: '{file_path}'")

    # 2. Handle SEARCH / REPLACE blocks
    blocks = list(BLOCK_PATTERN.finditer(patch_text))

    if not blocks:
        print("⚠️ No valid SEARCH/REPLACE blocks found in input.")
        return

    for block in blocks:
        file_path = block.group("file").strip()
        # Clean potential markdown headers or comments from the path
        file_path = re.sub(r"^#+\s*", "", file_path).strip()
        file_path = file_path.strip("`'\"")

        search_chunk = block.group("search")
        replace_chunk = block.group("replace")

        # Action: File Creation (Empty SEARCH block)
        if not search_chunk.strip():
            os.makedirs(os.path.dirname(os.path.abspath(file_path)), exist_ok=True)
            with open(file_path, "w", encoding="utf-8", newline="\n") as f:
                f.write(replace_chunk)
            print(f"✅ Success: Created '{file_path}'")
            continue

        # Action: File Deletion (Empty SEARCH & REPLACE block)
        if not search_chunk.strip() and not replace_chunk.strip():
            if os.path.exists(file_path):
                os.remove(file_path)
                print(f"✅ Success: Deleted '{file_path}'")
            continue

        if not os.path.exists(file_path):
            print(f"❌ Error: Target file does not exist: '{file_path}'")
            continue

        with open(file_path, "r", encoding="utf-8") as f:
            original_content = normalize_newlines(f.read())

        # Strategy 1: Exact Match
        new_content = replace_exact(original_content, search_chunk, replace_chunk)
        strategy = "Exact Match"

        # Strategy 2: Line-Stripped Match (Indentation insensitive)
        if new_content is None:
            new_content = replace_line_stripped(original_content, search_chunk, replace_chunk)
            strategy = "Line-Stripped Match"

        # Strategy 3: Fuzzy Line Match
        if new_content is None:
            new_content = replace_fuzzy(original_content, search_chunk, replace_chunk)
            strategy = "Fuzzy Match"

        if new_content is not None:
            with open(file_path, "w", encoding="utf-8", newline="\n") as f:
                f.write(new_content)

            if not check_syntax(file_path):
                print(f"❌ Syntax validation failed for '{file_path}'. Rolling back.")
                with open(file_path, "w", encoding="utf-8", newline="\n") as f:
                    f.write(original_content)
            else:
                print(f"✅ Success: Updated '{file_path}' ({strategy})")
        else:
            print(f"\n❌ ERROR: Could not find matching block in '{file_path}'.")
            preview = search_chunk[:250] + ("\n...[truncated]" if len(search_chunk) > 250 else "")
            print("--- SEARCH TEXT WAS ---")
            print(preview)
            print("-----------------------\n")


if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("Usage: python apply_patch.py <patch_file>")
        print("Or pipe input: git diff | python apply_patch.py -")
        sys.exit(1)

    input_arg = sys.argv[1]
    if input_arg == "-":
        content = sys.stdin.read()
    else:
        if not os.path.exists(input_arg):
            print(f"❌ File not found: {input_arg}")
            sys.exit(1)
        with open(input_arg, "r", encoding="utf-8") as f:
            content = f.read()

    parse_and_apply(content)