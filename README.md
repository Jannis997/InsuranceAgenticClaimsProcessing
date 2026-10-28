# Enterprise Agentic Claims Architecture Blueprint (Azure-Native)

> **Reference Architecture & System Design Case Study**  
> **Author:** Jannis Ebling — AI Software Architect (Generative AI, Multi-Agent Systems & LLMOps)  
> **Domain:** Regulated P&C Insurance Claims Processing (BaFin / Solvency II / EU AI Act / GDPR Compliant)

---

## 1. Executive Summary

Dieses Repository dokumentiert eine produktionsreife **Enterprise Multi-Agenten-Referenzarchitektur auf Microsoft Azure** für die automatisierte und hybride Schadenregulierung (Claims Processing) in der Sach- und Kfz-Versicherung (P&C).

Während theoretische Konzepte (vgl. *More & Zhang, 2026: "AI Agent-Driven Insurance Platform"*) das Potenzial kollaborativer Agenten skizzieren, beantwortet dieser Architektur-Blueprint die **harten Engineering-Fragen der Praxis**:
- Wie verhindert man Halluzinationen bei juristischen Deckungsprüfungen und Auszahlungsbeträgen?
- Wie trennt man das allgemeine Bedingungswerk (**AVB**), kundenindividuelle **Vertragsklauseln** und tägliche **betriebliche Regulierungsrichtlinien** sauber voneinander?
- Wie pausiert man einen Agenten-Workflow zustandsbehaftet über Tage hinweg, wenn Kundendokumente fehlen?
- Wie erfüllt man **DSGVO Art. 22**, **BaFin-Revisionssicherheit** und den **EU AI Act** durch asymmetrische Automatisierung und **Bidirektionales Source-Grounding (Bounding-Box-Highlighting)**?

---

## 2. Die 3 Kern-Säulen der Architektur

```text
┌──────────────────────────────────────────────────────────────────────────────┐
│ SÄULE 1: Policy, AVB & Rule Governance Layer                                 │
│ • Natural Language -> Typed DSL (YAML/JSON) via Policy Authoring Agent       │
│ • 4-Stufen-Testbatterie inkl. Backtesting auf 50.000+ Altschäden (Fabric)    │
│ • GitOps mit verpflichtendem 4-Augen-Prinzip (BA -> Manager -> Compliance)   │
│ • Deterministische Ausführung in der GoRules Zen-Engine (Rust Microservice)  │
├──────────────────────────────────────────────────────────────────────────────┤
│ SÄULE 2: Multi-Agent Orchestration Runtime (LangGraph + MCP)                 │
│ • Asynchrone Ingestion via Azure API Management & Azure Service Bus          │
│ • Hierarchischer LangGraph-Orchestrator mit Durable Checkpointing (Cosmos DB)│
│ • Single-Pass Multimodal Extraction (Azure AI Content Understanding)         │
│ • Spezial-Agenten mit Generate-and-Critique & Azure AI Foundry Safeguards    │
├──────────────────────────────────────────────────────────────────────────────┤
│ SÄULE 3: Enterprise Data Spine, Compliance & HITL Adjuster Workbench         │
│ • Bi-temporale Vertragsabfrage (Point-in-Time Lookup im PAS via MCP)         │
│ • Asymmetrische Automatisierung: Auto-Approve (STP) JA | Auto-Reject NEIN    │
│ • Click-to-Verify UI: Bounding-Box-Highlighting im Original-PDF / E-Mail     │
│ • 100% EU Data Residency (Germany West Central) & Langfuse Audit-Tracing     │
└──────────────────────────────────────────────────────────────────────────────┘
```

---

## 3. Repository-Struktur

| Pfad | Beschreibung |
| :--- | :--- |
| [`docs/01-policy-and-rule-governance.md`](docs/01-policy-and-rule-governance.md) | **Teilbereich 1:** Zusammenspiel von AVB, Vertrag und Betriebsregeln, Bespoke-Clause-Erkennung, NL-to-DSL Pipeline, Backtesting, GitOps & Prompt-Management. |
| [`docs/02-multi-agent-orchestration.md`](docs/02-multi-agent-orchestration.md) | **Teilbereich 2:** Event-Ingestion, LangGraph Checkpointing (Pause/Resume), Agenten-Rollen (Coverage, Fraud, Adjudication, Communications), Azure Foundry Shields & Langfuse. |
| [`docs/03-data-compliance-and-hitl-ux.md`](docs/03-data-compliance-and-hitl-ux.md) | **Teilbereich 3:** Azure-Datenbanklandschaft, Datenflüsse, Edge-Case-Behandlung, DSGVO Art. 22 Asymmetrie und die Adjuster Workbench mit Bounding-Box-Grounding. |
| [`docs/04-ide-visualization-guide.md`](docs/04-ide-visualization-guide.md) | **Anleitung:** Wie du das Typst-PDF und die IcePanel-/Eraser-/Mermaid-Diagramme direkt in **VS Code / Cursor** und im Browser live visualisierst. |
| [`blueprint/executive-blueprint.typ`](blueprint/executive-blueprint.typ) | **Typst-Code:** Kompakter, druckfertiger 2-Seiten „Executive Architecture Blueprint“ (PDF-Generator-Code). |
| [`diagrams/icepanel-landscape.yaml`](diagrams/icepanel-landscape.yaml) | **IcePanel Model-as-Code:** Vollständiges C4-Architekturmodell inkl. ADRs (Architecture Decision Records) und Datenflüssen zum Import in IcePanel. |
| [`diagrams/eraser-architecture.dsl`](diagrams/eraser-architecture.dsl) | **Eraser.io Diagram-as-Code:** Cloud-Infrastruktur-Diagramm mit Azure-Icons und Datenflüssen. |
| [`schemas/domain_models.py`](schemas/domain_models.py) | **Python / Pydantic v2 Schemas:** Referenz-Implementierung der Datenverträge, Bounding-Box-Koordinaten, Gatekeeper-Logik und Rules-Engine-Schnittstellen. |

---

## 4. Schnellstart: Interaktive LikeC4-Website (Lokal & GitHub Pages)

### A. Öffentlicher Link via GitHub Pages (Automatisiertes Deployment)
Dieses Repository enthält eine fertige GitHub Actions Pipeline (`.github/workflows/deploy-pages.yml`), die aus `likec4.txt` vollautomatisch eine interaktive Architektur-Webseite (inkl. Zoom, Drill-Down von Level 1 bis Level 3G, Suchfunktion und Markdown-Inspektor) baut und auf **GitHub Pages** veröffentlicht:

1. Öffne dein GitHub-Repository im Browser und gehe auf **Settings** $\rightarrow$ **Pages**.
2. Wähle unter **Build and deployment** $\rightarrow$ **Source** die Option **`GitHub Actions`** aus.
3. Pushe deine Änderungen auf den `main`-Branch (oder starte den Workflow manuell unter **Actions** $\rightarrow$ *Deploy LikeC4 Architecture to GitHub Pages* $\rightarrow$ *Run workflow*).
4. Nach ca. 60 Sekunden ist deine interaktive Architektur unter folgendem Link erreichbar:  
   `https://<dein-github-username>.github.io/<dein-repo-name>/`

### B. Lokal im Browser starten
- Abhängigkeiten installieren: `npm install`
- Live-Server mit Hot-Reload starten: `npm run dev` (öffnet automatisch `http://localhost:5173`)
- Statischen Export lokal bauen: `npm run build`

### C. Weitere Artefakte (Typst PDF & IcePanel)
1. **Typst PDF in VS Code / Cursor live ansehen:**
   - Installiere die Extension **`Tinymist Typst`** (`myriad-dreamin.tinymist`).
   - Öffne [`blueprint/executive-blueprint.typ`](blueprint/executive-blueprint.typ) und drücke `Strg+K V` (Preview).
2. **Interaktives C4-Modell in IcePanel öffnen:**
   - Gehe auf [app.icepanel.io](https://app.icepanel.io) $\rightarrow$ *Import Landscape* $\rightarrow$ Lade [`diagrams/icepanel-landscape.yaml`](diagrams/icepanel-landscape.yaml) hoch.
3. **Detaillierte Anleitung:** Siehe [`docs/04-ide-visualization-guide.md`](docs/04-ide-visualization-guide.md).

---

## 5. Quellen & Referenz-Kontext

* Konzeptionelle Domänen-Inspiration: *More, V., & Zhang, J. (2026). AI Agent-Driven Insurance Platform: A Multi-Agent Architecture for Intelligent, Deterministic, and Auditable Insurance Processing. DIGITAL 2026 / ThinkMind.*
* Weiterentwickelt zu einer produktionsreifen **Microsoft Azure Reference Architecture** mit LangGraph, Model Context Protocol (MCP), GoRules Zen-Engine, Azure AI Foundry Safeguards und Self-Hosted Langfuse.
