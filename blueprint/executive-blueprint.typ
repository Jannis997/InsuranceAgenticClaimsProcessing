// =============================================================================
// 6-PAGE BILINGUAL EXECUTIVE ARCHITECTURE BRIEFING (EN PAGES 1-3 | DE PAGES 4-6)
// AI-Powered Claims Processing on Microsoft Azure, Foundry & Databricks
// =============================================================================

#set document(
  title: "Executive Briefing: AI-Powered Claims Processing (Azure, Foundry & Databricks)",
  author: "Jannis Ebling",
)

#set page(
  paper: "a4",
  margin: (top: 1.0cm, bottom: 1.05cm, left: 1.15cm, right: 1.15cm),
  footer: context [
    #set text(size: 7.4pt, fill: rgb("#64748b"))
    #line(length: 100%, stroke: 0.5pt + rgb("#cbd5e1"))
    #v(2pt)
    #if counter(page).get().first() <= 3 [
      *Executive Briefing: AI-Powered Claims Processing* — Strategy, Core Workflows, Technologies & Regulation
      #h(1fr)
      Page #counter(page).display("1 / 1", both: true)
    ] else [
      *Management-Briefing: KI-gestützte Schadenregulierung* — Strategie, Kernprozesse, Technologien & Regulatorik
      #h(1fr)
      Seite #counter(page).display("1 / 1", both: true)
    ]
  ]
)

#set text(font: ("Segoe UI", "Inter", "Arial", "Liberation Sans"), size: 8.1pt, fill: rgb("#0f172a"))
#set par(justify: false, leading: 0.46em)

#let section-title(title) = {
  v(4pt)
  block(
    width: 100%,
    fill: rgb("#0f172a"),
    inset: (x: 8pt, y: 4.5pt),
    radius: 3pt,
    text(fill: white, weight: "bold", size: 9pt, title)
  )
  v(2pt)
}

#let card(title, accent: rgb("#0284c7"), height: auto, body) = {
  block(
    width: 100%,
    height: height,
    fill: rgb("#f8fafc"),
    stroke: (left: 2.5pt + accent, top: 0.6pt + rgb("#cbd5e1"), right: 0.6pt + rgb("#cbd5e1"), bottom: 0.6pt + rgb("#cbd5e1")),
    inset: (x: 7pt, y: 5.5pt),
    radius: 3pt,
    [
      #text(weight: "bold", size: 8.4pt, fill: rgb("#0f172a"), title)
      #v(2pt)
      #body
    ]
  )
}

// =============================================================================
// PAGE 1 (EN): EXECUTIVE SUMMARY, END-TO-END OVERVIEW & DOCUMENT INGESTION
// =============================================================================

#block(
  width: 100%,
  fill: rgb("#0f172a"),
  inset: (x: 11pt, y: 8pt),
  radius: 4pt,
  [
    #text(fill: white, weight: "bold", size: 13pt)[AI-Powered Claims Processing: Target Architecture & Governance]
    #v(2pt)
    #text(fill: rgb("#cbd5e1"), size: 8.2pt)[
      Executive Briefing for Audit-Proof Automation in P&C Insurance — Compliant with EU AI Act, GDPR, DORA, BaFin & Solvency II
    ]
    #v(2pt)
    #text(fill: rgb("#38bdf8"), size: 7.8pt)[
      Interactive Full Architecture (Web View): #link("https://jannis997.github.io/InsuranceAgenticClaimsProcessing/")[https://jannis997.github.io/InsuranceAgenticClaimsProcessing/]
    ]
  ]
)

#v(3pt)

#grid(
  columns: (1fr, 1fr, 1fr, 1fr),
  gutter: 6pt,
  card("1. Anonymization at Intake", height: 90pt)[
    Sensitive customer data remains in a protected vault — language models operate exclusively on anonymized claim facts.
  ],
  card("2. Intelligent Document Prep", height: 90pt)[
    AI translates free text, invoices, and photos into structured decision data and performs qualitative pre-checks.
  ],
  card("3. Binding Calculation Engine", height: 90pt)[
    Zero AI hallucinations on monetary amounts: all tariffs, limits, and deductibles are calculated with mathematical precision.
  ],
  card("4. Automation with Guardrails", height: 90pt)[
    Instant payout for clear standard claims (dark processing) and targeted handover to specialists for exceptions.
  ]
)

#section-title("1. End-to-End Process Architecture at a Glance")

#block(
  width: 100%,
  stroke: 0.6pt + rgb("#cbd5e1"),
  radius: 3pt,
  inset: 4pt,
  fill: white,
  [
    #image("../diagrams/level1-overview-en.svg", width: 100%)
  ]
)

#v(2pt)
*Strategic Overview:* This architecture combines high processing speed for standard claims with uncompromising regulatory control. All systems operate within a cloud environment on Microsoft Azure that is completely shielded from the public internet. Incoming claims pass through four clearly separated phases: *(1) Document Ingestion & Data Privacy*, *(2) Classification & Claim Setup*, *(3) Multi-Agent Claim Review*, and where required *(4) Safety Guardrails & Specialist Human Review*.

#section-title("2. Workflow 1: Document Ingestion & AI Preparation (Azure AI Services)")

#block(
  width: 100%,
  stroke: 0.6pt + rgb("#cbd5e1"),
  radius: 3pt,
  inset: 4pt,
  fill: white,
  [
    #image("../diagrams/ingestion-workflow-en.svg", width: 100%)
  ]
)

#v(2pt)
#grid(
  columns: (1fr, 1fr),
  gutter: 8pt,
  card("Intake Processing Workflow", height: 140pt)[
    - *Intake & Peak Buffering:* Claims reach the system via web portal, app, email, or phone. An upstream queue reliably absorbs sudden volume spikes (such as after severe storms).
    - *Immutable Archiving:* Every submitted document, photo, or call recording is immediately archived in its original state in an audit-proof repository to satisfy statutory retention obligations.
    - *Source Highlighting Coordinates:* While reading PDFs and invoices, the system records the exact page position of every extracted value so adjusters can verify details with a single click in the original document.
  ],
  card("Applied AI Services & Data Privacy Rationale", height: 140pt)[
    - *Document & Speech AI (Azure Document Intelligence & Speech):* Automatically splits multi-part PDF submissions, extracts workshop invoices with table precision, and transcribes phone claims and voice messages automatically.
    - *Vision, Medical & Translation AI (Azure Vision, Language & Translator):* Analyzes damage photos for affected components, structures medical reports, and translates foreign-language documents while preserving their layout.
    - *Early Anonymization:* Sensitive personal details are replaced with neutral placeholders and stored separately. Cleartext bank details or names never reach downstream AI language models.
  ]
)

#pagebreak()

// =============================================================================
// PAGE 2 (EN): MULTI-AGENT SYSTEM, POLICY MANAGEMENT & CALCULATION ENGINE
// =============================================================================

#section-title("3. Workflow 2: Multi-Agent System for Claim Review")

#block(
  width: 100%,
  stroke: 0.6pt + rgb("#cbd5e1"),
  radius: 3pt,
  inset: 4pt,
  fill: white,
  [
    #image("../diagrams/multi-agent-system-en.svg", width: 100%)
  ]
)

#v(2pt)
#grid(
  columns: (1fr, 1fr),
  gutter: 8pt,
  card("Central Orchestration & Interaction with Calculation Engine", height: 210pt)[
    - *Claim-Type Routing:* Once a claim is registered in the policy system, the central orchestrator loads the appropriate review plan (e.g., for glass damage, water damage, or auto comprehensive) and coordinates the five specialized agents.
    - *Two-Stage Coverage & Benefit Verification:* The coverage agent performs the *qualitative pre-check* (verifying whether the reported cause of loss aligns with the clauses of the policy terms). The *binding financial decision* on coverage limits, deductibles, and final payout is always executed by the deterministic calculation engine.
    - *Internal AI Quality Control:* Before any customer letter is sent or any invoice line is mapped, an independent review agent verifies accuracy and policy citations.
  ],
  card("Responsibilities & System Access of the Five Agents", height: 210pt)[
    1. *Customer Communication:* Checks the document checklist in the *claim file*, retrieves matching clause citations from the *policy terms base (Azure AI Search)* for settlement letters, and resolves recipient details via the *privacy vault* only upon dispatch.
    2. *Coverage Pre-Check:* Reads policy status and insured modules from the *policy system* and matches the cause of loss qualitatively against the *policy terms base*.
    3. *Fraud & Risk Review:* Checks photos in the *image archive* for duplicates, reviews prior claims in the *policy system*, and queries *Azure Databricks* for a real-time fraud network risk score.
    4. *Invoice & Line-Item Review:* Translates free-text invoice lines into *standardized repair and service positions* and hands them over to the *calculation engine*.
    5. *Payout & Accounting:* Upon approval, resolves the IBAN in the *privacy vault*, posts the payment in *SAP*, and updates the reserve in the *policy system*.
  ]
)

#section-title("4. Workflow 3: Policy Management & Deterministic Calculation")

#grid(
  columns: (1fr, 1fr),
  gutter: 8pt,
  card("Why AI Must Never Estimate Monetary Payouts", accent: rgb("#1e293b"), height: 210pt)[
    Language models excel at structuring unstructured letters, invoices, and photos — however, due to *BaFin auditability* and *Solvency II accounting rules*, they must never freely decide on monetary amounts, caps, or deductibles.

    *The Architectural Solution:*
    - *Unified, Deterministic Calculation Engine:* Once the AI agents have structured the claim facts and invoice items, a classical, mathematically exact software engine takes over final validation and payout calculation.
    - *Binding Combination of All Rules:* The engine evaluates both the historical policy terms bound to the contract and current internal goodwill or partner-workshop rules according to a fixed schema.
    - *100% Reproducibility:* Every calculated payout amount is fully traceable and always produces the exact same result for identical inputs.
  ],
  card("Four-Eyes Governance Process for New Rules & Tariffs", accent: rgb("#0284c7"), height: 210pt)[
    To enable business departments and actuaries to update rules rapidly without introducing financial risk, every rule change passes through a four-stage governance workflow:

    1. *Business Input Without Coding:* Legal teams upload new policy terms; business analysts formulate internal adjustment rules in plain natural language.
    2. *AI-Assisted Rule Translation:* An authoring agent translates the business specification into formal program code and automatically generates test cases.
    3. *Mathematical Conflict Check & Simulation (Azure Databricks):* The system automatically verifies logical consistency against existing rules and simulates the financial impact across historical claims in *Azure Databricks*.
    4. *Mandatory Four-Eyes Approval:* An independent risk and compliance manager reviews the simulation report in the approval portal before releasing the rule to production.
  ]
)

#pagebreak()

// =============================================================================
// PAGE 3 (EN): HUMAN-IN-THE-LOOP ESCALATION, TECHNOLOGY STACK & COMPLIANCE
// =============================================================================

#section-title("5. Workflow 4: Safety Guardrails (Circuit Breaker) & Specialist Escalation (HITL)")

#grid(
  columns: (1fr, 1fr),
  gutter: 8pt,
  card("Binding Safety Guardrails (When Does a Human Take Over?)", height: 140pt)[
    - *No Automated Disadvantage for Customers:* Under *GDPR Art. 22* and the *EU AI Act*, policyholders must not be penalized by a purely automated AI rejection. Therefore: *Automated payout for clear claims = Yes*, but *Automated rejection = Technically blocked*.
    - *Hard Triggers for Specialist Review:* A hard-coded safety guardrail immediately halts automated processing in cases of potential claim rejection, suspected fraud or network collusion, bodily injury, poorly legible documents, or claims exceeding defined payout thresholds.
  ],
  card("Prepared Decision Brief & Direct Execution", height: 140pt)[
    - *Prepared Dossier Instead of Raw Data Search:* In their workbench application, specialist adjusters receive a concise case summary, the exact escalation reason, and direct color highlights of the relevant passages in the original document.
    - *Unaltered Execution of Specialist Decisions:* Once the adjuster decides or corrects a case, their decision is executed directly in the payment system, policy administration system, and customer letter without being re-interpreted by AI.
  ]
)

#section-title("6. Core Technologies & Strategic Selection Rationale")

#table(
  columns: (1.15fr, 1.45fr, 2.1fr),
  inset: 5pt,
  align: (left, left, left),
  fill: (x, y) => if y == 0 { rgb("#0f172a") } else if calc.odd(y) { rgb("#f8fafc") } else { white },
  stroke: 0.5pt + rgb("#cbd5e1"),
  text(fill: white, weight: "bold")[Technology Component],
  text(fill: white, weight: "bold")[Role in Claims Process],
  text(fill: white, weight: "bold")[Why Selected? (Business & Compliance Rationale)],

  [*Azure AI Services* \ (Documents, Speech, Vision)],
  [Extracts PDFs, invoices, medical reports, phone calls, and damage photos incl. anonymization.],
  [Specialized domain models provide exact document coordinates for the adjuster UI and strip personal data *before* AI agent processing (GDPR).],

  [*Microsoft Foundry* \ (Multi-Agent Platform)],
  [Hosts the central orchestrator and the five specialized claims agents.],
  [Provides isolated execution environments, strictly segregated access rights per agent, and built-in shields against manipulation attempts in uploaded documents.],

  [*Azure AI Search* \ (Policy Knowledge Base)],
  [Searches historical and current policy terms (AVB) as well as repair guidelines.],
  [Supplies both the coverage agent and the communication agent with exact clauses and citations from the specific tariff generation bound to the contract.],

  [*Deterministic Calculation Engine*],
  [Executes the versioned rule repository for limits, deductions, and deductibles.],
  [Eliminates arithmetic errors and language-model estimation; guarantees 100% reproducible, BaFin-auditable payout amounts.],

  [*Central Azure Data Platform* \ (Archive, File, Policy DB, Vault)],
  [Consolidated storage for original documents, claim files, policies, and privacy mappings.],
  [Strict separation between the anonymized claim file (accessible to AI agents) and the encrypted privacy vault (blocked for AI) inside a private network.],

  [*Azure Databricks* \ (Analytics & AI Platform)],
  [Historical rule simulation, fraud network detection, and actuarial reserving analytics.],
  [Completely decouples compute-intensive simulations and cross-claim fraud analytics from operational databases so real-time claims processing is never slowed down.],

  [*Langfuse Observability* \ (Self-Hosted in VNet)],
  [Quality monitoring, cost control, and central management of agent instructions.],
  [End-to-end audit logging of all AI steps for regulators (EU AI Act) within the insurer's own cloud perimeter; leverages adjuster corrections for continuous improvement.]
)

#section-title("7. Regulatory Compliance Matrix (Compliance-by-Design)")

#table(
  columns: (1.15fr, 1.45fr, 2.1fr),
  inset: 5pt,
  align: (left, left, left),
  fill: (x, y) => if y == 0 { rgb("#1e293b") } else if calc.odd(y) { rgb("#f8fafc") } else { white },
  stroke: 0.5pt + rgb("#cbd5e1"),
  text(fill: white, weight: "bold")[Law / Regulatory Framework],
  text(fill: white, weight: "bold")[Statutory Duty When Using AI],
  text(fill: white, weight: "bold")[Concrete Implementation in This Architecture],

  [*EU AI Act* \ (European AI Regulation)],
  [Mandatory human oversight (Art. 14), traceability of AI outputs, and protection against manipulation.],
  [Hard safety guardrails prior to critical decisions, direct source highlighting in original documents for adjusters, and complete audit logging of all review steps.],

  [*GDPR / Data Privacy* \ (esp. Art. 22 & Art. 25)],
  [Prohibition of purely automated adverse decisions against customers and technical privacy-by-design.],
  [Technical block on automated rejections (mandatory handover to human adjusters), early anonymization prior to any language model, and EU data residency without third-party model training.],

  [*DORA & BaFin (VAIT)* \ (IT Resilience & Supervision)],
  [Protection of critical financial systems against outages and cyberattacks, plus controlled change governance.],
  [Network completely isolated from the public internet, automated load buffering during severe weather events, and mandatory 4-eyes approval before any rule change.],

  [*Solvency II & GAAP* \ (Financial & Actuarial Integrity)],
  [Contract-compliant benefit settlement, verifiable data quality, and valid calculation of claim reserves.],
  [Strict verification against the policy terms valid at contract inception, exact mathematical settlement via the calculation engine, and auditable data history for actuaries.]
)

#pagebreak()

// =============================================================================
// SEITE 4 (DE): EXECUTIVE SUMMARY, GESAMTÜBERSICHT & DOKUMENTEN-INGESTION
// =============================================================================

#block(
  width: 100%,
  fill: rgb("#0f172a"),
  inset: (x: 11pt, y: 8pt),
  radius: 4pt,
  [
    #text(fill: white, weight: "bold", size: 13pt)[KI-gestützte Schadenregulierung: Zielarchitektur & Governance]
    #v(2pt)
    #text(fill: rgb("#cbd5e1"), size: 8.2pt)[
      Management-Vorlage zur revisionssicheren Automatisierung in der Schadenversicherung — konform mit EU AI Act, DSGVO, DORA, BaFin & Solvency II
    ]
    #v(2pt)
    #text(fill: rgb("#38bdf8"), size: 7.8pt)[
      Interaktive Gesamtarchitektur (Web-Ansicht): #link("https://jannis997.github.io/InsuranceAgenticClaimsProcessing/")[https://jannis997.github.io/InsuranceAgenticClaimsProcessing/]
    ]
  ]
)

#v(3pt)

#grid(
  columns: (1fr, 1fr, 1fr, 1fr),
  gutter: 6pt,
  card("1. Anonymisierung am Eingang", height: 90pt)[
    Sensible Kundendaten bleiben im geschützten Tresor – Sprachmodelle arbeiten ausschließlich mit anonymisierten Sachdaten.
  ],
  card("2. Intelligente Beleg-Aufbereitung", height: 90pt)[
    KI übersetzt Freitext, Rechnungen und Bilder in strukturierte Entscheidungsdaten und prüft diese inhaltlich vor.
  ],
  card("3. Verbindliches Rechenwerk", height: 90pt)[
    Keine KI-Halluzinationen bei Geldbeträgen: Alle Tarife, Limits und Abzüge werden mathematisch exakt berechnet.
  ],
  card("4. Automatisierung mit Schutzschranke", height: 90pt)[
    Sofort-Auszahlung bei klaren Standardschäden (Dunkelverarbeitung) und gezielte Übergabe an Spezialisten bei Ausnahmefällen.
  ]
)

#section-title("1. End-to-End Prozessarchitektur im Überblick")

#block(
  width: 100%,
  stroke: 0.6pt + rgb("#cbd5e1"),
  radius: 3pt,
  inset: 4pt,
  fill: white,
  [
    #image("../diagrams/level1-overview.svg", width: 100%)
  ]
)

#v(2pt)
*Strategische Einordnung:* Die Architektur verbindet hohe Bearbeitungsgeschwindigkeit bei Standardschäden mit kompromissloser regulatorischer Kontrolle. Alle Systeme arbeiten in einer vom öffentlichen Internet abgeschirmten Cloud-Umgebung auf Microsoft Azure. Eingehende Meldungen durchlaufen vier klar abgegrenzte Phasen: *(1) Dokumenten-Ingestion & Datenschutz*, *(2) Klassifikation & Schadenanlage*, *(3) Multi-Agenten-Schadenprüfung* sowie bei Bedarf *(4) Sicherheits-Schranken & menschliche Fachprüfung*.

#section-title("2. Workflow 1: Dokumenten-Ingestion & KI-Aufbereitung (Azure AI Services)")

#block(
  width: 100%,
  stroke: 0.6pt + rgb("#cbd5e1"),
  radius: 3pt,
  inset: 4pt,
  fill: white,
  [
    #image("../diagrams/ingestion-workflow.svg", width: 100%)
  ]
)

#v(2pt)
#grid(
  columns: (1fr, 1fr),
  gutter: 8pt,
  card("Ablauf der Eingangsverarbeitung", height: 140pt)[
    - *Annahme & Lastpufferung:* Schadenmeldungen erreichen das System über Webportal, App, E-Mail oder Telefon. Eine vorgeschaltete Warteschlange fängt plötzliche Lastspitzen (etwa nach schweren Unwettern) zuverlässig ab.
    - *Unveränderliche Archivierung:* Jedes eingereichte Dokument, Foto oder Telefonat wird sofort im Originalzustand revisionssicher archiviert, um gesetzliche Aufbewahrungs- und Nachweispflichten zu erfüllen.
    - *Fundstellen-Markierung:* Beim Auslesen von PDFs und Rechnungen speichert das System die genaue Position jedes Wertes auf der Seite, damit Sachbearbeiter Angaben später mit einem Klick im Originalbeleg prüfen können.
  ],
  card("Eingesetzte KI-Dienste & Datenschutz-Grund", height: 140pt)[
    - *Dokumenten- & Sprach-KI (Azure Document Intelligence & Speech):* Trennt mehrteilige PDF-Sendungen automatisch, liest Werkstattrechnungen tabellengenau aus und verschriftlicht Telefonate sowie Sprachmeldungen automatisch.
    - *Bild-, Medizin- & Übersetzungs-KI (Azure Vision, Language & Translator):* Analysiert Schadensfotos auf beschädigte Bauteile, strukturiert medizinische Berichte und übersetzt ausländische Belege unter Erhalt des Dokumentenlayouts.
    - *Frühe Anonymisierung:* Sensible Personendaten werden durch neutrale Platzhalter ersetzt und getrennt verwahrt. So gelangen niemals Klartext-Kontodaten oder Namen in die nachgelagerten KI-Sprachmodelle.
  ]
)

#pagebreak()

// =============================================================================
// SEITE 5 (DE): MULTI-AGENTEN-SYSTEM, REGELWERK-STEUERUNG & RECHEN-ENGINE
// =============================================================================

#section-title("3. Workflow 2: Multi-Agenten-System für die Schadenprüfung")

#block(
  width: 100%,
  stroke: 0.6pt + rgb("#cbd5e1"),
  radius: 3pt,
  inset: 4pt,
  fill: white,
  [
    #image("../diagrams/multi-agent-system.svg", width: 100%)
  ]
)

#v(2pt)
#grid(
  columns: (1fr, 1fr),
  gutter: 8pt,
  card("Zentrale Steuerung & Zusammenspiel mit der Rechen-Engine", height: 210pt)[
    - *Auftragssteuerung nach Schadensart:* Sobald der Schaden im Bestandssystem angelegt ist, lädt der zentrale Orchestrator den passenden Prüfplan (z. B. für Glasschaden, Leitungswasser oder Kfz-Kasko) und steuert die fünf Spezial-Agenten.
    - *Zweistufige Deckungs- & Leistungsprüfung:* Der Deckungs-Agent übernimmt die *inhaltliche Vorprüfung* (ob die geschilderte Schadenursache grundsätzlich zu den Klauseln der Versicherungsbedingungen passt). Die *verbindliche finanzielle Entscheidung* über Höchstgrenzen, Selbstbehalte und Auszahlungshöhe trifft anschließend immer die deterministische Rechen-Engine.
    - *Interne KI-Qualitätskontrolle:* Vor jedem Briefversand und jeder Rechnungszuordnung prüft ein unabhängiger Kontroll-Agent das Ergebnis auf Richtigkeit und korrekte Klausel-Zitate.
  ],
  card("Aufgaben & Systemzugriffe der fünf Spezial-Agenten", height: 210pt)[
    1. *Kundenkommunikation:* Prüft in der *Schadenakte* die Dokumenten-Checkliste, ruft aus dem *Bedingungswerk (Azure AI Search)* die passenden Paragraphen-Zitate für das Abrechnungsschreiben ab und löst Empfängerdaten erst beim Versand über den *Datenschutz-Tresor* auf.
    2. *Deckungs-Vorprüfung:* Liest Vertragsstatus und versicherte Bausteine aus dem *Bestandssystem* und gleicht die Schadenursache inhaltlich mit dem *Bedingungswerk* ab.
    3. *Betrugs- & Risikoprüfung:* Prüft Fotos im *Bild-Archiv* auf Dubletten, liest Vorschäden im *Bestandssystem* und ruft in *Azure Databricks* einen Risikoscore für organisierte Betrugsnetzwerke ab.
    4. *Rechnungs- & Positionsprüfung:* Übersetzt Freitext-Positionen einer Rechnung in *normierte Reparatur- und Leistungspositionen* und übergibt diese an die *Rechen-Engine*.
    5. *Auszahlung & Buchung:* Löst bei Freigabe die IBAN im *Datenschutz-Tresor* auf, bucht die Zahlung in *SAP* und aktualisiert die Reserve im *Bestandssystem*.
  ]
)

#section-title("4. Workflow 3: Regelwerk-Steuerung (Policy Management) & Deterministische Berechnung")

#grid(
  columns: (1fr, 1fr),
  gutter: 8pt,
  card("Warum KI niemals Auszahlungsbeträge schätzen darf", accent: rgb("#1e293b"), height: 210pt)[
    Sprachmodelle sind hervorragend darin, unstrukturierte Briefe, Rechnungen und Fotos inhaltlich aufzubereiten – sie dürfen jedoch aus Gründen der *BaFin-Revisionssicherheit* und *Solvency-II-Bilanztreue* niemals über Euro-Beträge, Höchstgrenzen oder Selbstbehalte frei entscheiden.

    *Die architektonische Lösung:*
    - *Einheitliche, deterministische Rechen-Engine:* Sobald die KI-Agenten den Sachverhalt und die Rechnungspositionen strukturiert haben, übernimmt eine klassische, mathematisch exakte Software-Engine die finale Prüfung und Abrechnung.
    - *Verbindliche Kombination aller Regeln:* Die Engine verrechnet sowohl die zum Vertrag gehörenden Tarifbedingungen als auch aktuelle interne Kulanz- und Partnerwerkstatt-Regeln nach fest definiertem Schema.
    - *Vollständige Reproduzierbarkeit:* Jeder berechnete Auszahlungsbetrag ist zu 100 % nachvollziehbar und liefert bei gleichen Eingangsdaten jederzeit exakt dasselbe Ergebnis.
  ],
  card("Vier-Augen-Prozess für neue Regeln & Tarife", accent: rgb("#0284c7"), height: 210pt)[
    Damit Fachabteilungen und Aktuariat das Regelwerk schnell anpassen können, ohne finanzielle Risiken einzugehen, durchläuft jede Regeländerung einen vierstufigen Governance-Prozess:

    1. *Fachliche Eingabe ohne Programmieraufwand:* Juristen laden neue Bedingungswerke hoch; Fachbereiche formulieren interne Regulierungsregeln in normaler Alltagssprache.
    2. *KI-gestützte Regel-Übersetzung:* Ein Entwurfs-Agent übersetzt die fachliche Vorgabe in formalen Programmcode und erstellt automatisch passende Testfälle.
    3. *Mathematische Konfliktprüfung & Simulation (Azure Databricks):* Das System prüft vollautomatisch auf logische Widersprüche zu bestehenden Regeln und simuliert die finanziellen Auswirkungen auf dem historischen Schadenbestand in *Azure Databricks*.
    4. *Verbindliche Vier-Augen-Freigabe:* Ein unabhängiger Risiko- und Compliance-Manager prüft den Simulationsbericht im Freigabe-Portal und schaltet die Regel erst danach für den Produktivbetrieb frei.
  ]
)

#pagebreak()

// =============================================================================
// SEITE 6 (DE): HUMAN-IN-THE-LOOP ESKALATION, TECHNOLOGIE-STACK & COMPLIANCE
// =============================================================================

#section-title("5. Workflow 4: Sicherheits-Schranken (Circuit Breaker) & Sachbearbeiter-Eskalation (HITL)")

#grid(
  columns: (1fr, 1fr),
  gutter: 8pt,
  card("Verbindliche Sicherheits-Schranken (Wann übernimmt der Mensch?)", height: 140pt)[
    - *Kein automatischer Nachteil für Kunden:* Nach *DSGVO Art. 22* und dem *EU AI Act* dürfen Versicherte nicht durch eine rein automatisierte KI-Entscheidung abgelehnt werden. Deshalb gilt: *Automatische Auszahlung bei klaren Fällen = Ja*, aber *Automatische Ablehnung = Technisch gesperrt*.
    - *Feste Auslöser für die Fachprüfung:* Eine fest programmierte Sicherheits-Schranke stoppt den automatischen Durchlauf sofort bei drohender Leistungsablehnung, bei Betrugs- oder Netzwerkverdacht, bei Personenschäden, bei schlecht lesbaren Belegen sowie ab definierten Schadensummen.
  ],
  card("Optimale Entscheidungsvorlage & Direkte Abwicklung", height: 140pt)[
    - *Aufbereitete Akte statt Rohdaten-Suche:* Der Spezial-Sachbearbeiter erhält in seiner Arbeitsanwendung eine kompakte Fall-Zusammenfassung, den genauen Eskalationsgrund sowie direkte farbliche Markierungen der relevanten Stellen im Originaldokument.
    - *Unverfälschte Umsetzung der Fach-Entscheidung:* Sobald der Sachbearbeiter den Fall entschieden oder korrigiert hat, wird seine Entscheidung ohne erneute KI-Uminterpretation direkt im Zahlungssystem, in der Bestandsführung und im Kundenschreiben umgesetzt.
  ]
)

#section-title("6. Eingesetzte Haupttechnologien & Strategische Auswahlbegründung")

#table(
  columns: (1.15fr, 1.45fr, 2.1fr),
  inset: 5pt,
  align: (left, left, left),
  fill: (x, y) => if y == 0 { rgb("#0f172a") } else if calc.odd(y) { rgb("#f8fafc") } else { white },
  stroke: 0.5pt + rgb("#cbd5e1"),
  text(fill: white, weight: "bold")[Technologie-Baustein],
  text(fill: white, weight: "bold")[Aufgabe im Schadenprozess],
  text(fill: white, weight: "bold")[Warum gewählt? (Geschäfts- & Compliance-Begründung)],

  [*Azure AI Services* \ (Dokumente, Sprache, Bild)],
  [Auslesen von PDFs, Rechnungen, Arztberichten, Telefonaten und Schadensfotos inkl. Anonymisierung.],
  [Spezialisierte Fachmodelle liefern präzise Beleg-Fundstellen für die Sachbearbeiter-Oberfläche und entfernen Personendaten *vor* dem KI-Agenten-Einsatz (DSGVO).],

  [*Microsoft Foundry* \ (Multi-Agenten-Plattform)],
  [Betrieb des zentralen Orchestrators und der fünf spezialisierten Schaden-Agenten.],
  [Bietet isolierte Ausführungsumgebungen, streng getrennte Zugriffsrechte je Agent sowie integrierte Schutzschilde gegen Manipulationsversuche in eingereichten Dokumenten.],

  [*Azure AI Search* \ (Vertrags-Wissensbasis)],
  [Durchsucht historische und aktuelle Versicherungsbedingungen (AVB) sowie Reparatur-Richtlinien.],
  [Liefert sowohl dem Deckungs-Agenten als auch dem Kommunikations-Agenten wortgenaue Paragraphen und Zitate aus exakt der zum Vertrag gehörenden Tarifgeneration.],

  [*Deterministische Rechen-Engine*],
  [Ausführung des versionierten Regelwerks für Limits, Abzüge und Selbstbehalte.],
  [Verhindert Rechenfehler und Schätzungen von Sprachmodellen; garantiert 100 % reproduzierbare, BaFin-revisionssichere Auszahlungsbeträge.],

  [*Zentrale Azure Datenplattform* \ (Archiv, Akte, Bestand, Tresor)],
  [Konsolidierte Speicherung von Originalbelegen, Schadenakten, Verträgen und Datenschutz-Zuordnungen.],
  [Strikte Trennung zwischen anonymisierter Schadenakte (für KI-Agenten zugänglich) und dem verschlüsselten Datenschutz-Tresor (für KI gesperrt) innerhalb eines privaten Netzwerks.],

  [*Azure Databricks* \ (Analyse- & KI-Plattform)],
  [Historische Regelsimulation, Betrugsnetzwerk-Erkennung und aktuarische Auswertungen.],
  [Entkoppelt rechenintensive Simulationen und aktenübergreifende Betrugsanalysen vollständig vom operativen Tagessystem, sodass die Echtzeit-Schadenbearbeitung niemals gebremst wird.],

  [*Langfuse Observability* \ (Selbstgehostet im VNet)],
  [Qualitätsüberwachung, Kostenkontrolle und zentrale Verwaltung der Agenten-Arbeitsanweisungen.],
  [Lückenlose Protokollierung aller KI-Schritte für Aufsichtsbehörden (EU AI Act) innerhalb der eigenen Cloud-Umgebung; nutzt Sachbearbeiter-Korrekturen zur laufenden Qualitätsverbesserung.]
)

#section-title("7. Erfüllung regulatorischer Kernanforderungen (Compliance-by-Design)")

#table(
  columns: (1.15fr, 1.45fr, 2.1fr),
  inset: 5pt,
  align: (left, left, left),
  fill: (x, y) => if y == 0 { rgb("#1e293b") } else if calc.odd(y) { rgb("#f8fafc") } else { white },
  stroke: 0.5pt + rgb("#cbd5e1"),
  text(fill: white, weight: "bold")[Gesetz / Aufsichtsrahmen],
  text(fill: white, weight: "bold")[Gesetzliche Pflicht beim KI-Einsatz],
  text(fill: white, weight: "bold")[Konkrete Umsetzung in dieser Architektur],

  [*EU AI Act* \ (Europäische KI-Verordnung)],
  [Pflicht zur menschlichen Aufsicht (Art. 14), Nachvollziehbarkeit von KI-Ausgaben und Schutz vor Manipulation.],
  [Harte Sicherheits-Schranken vor kritischen Entscheidungen, direkte Quellen-Markierung im Originalbeleg für Sachbearbeiter und lückenlose Protokollierung aller Prüfschritte.],

  [*DSGVO / Datenschutz* \ (insb. Art. 22 & Art. 25)],
  [Verbot rein automatisierter Negativ-Entscheidungen zu Lasten des Kunden sowie technischer Datenschutz (Privacy-by-Design).],
  [Technisches Verbot automatischer Ablehnungen (zwingende Vorlage an Sachbearbeiter), frühe Anonymisierung vor jedem Sprachmodell und europäische Datenhaltung ohne Modelltraining durch Dritte.],

  [*DORA & BaFin (VAIT)* \ (IT-Resilienz & Aufsicht)],
  [Absicherung kritischer Finanzsysteme gegen Ausfälle und Cyberangriffe sowie kontrollierte Freigabe von Systemänderungen.],
  [Vollständig vom öffentlichen Internet isoliertes Netzwerk, automatische Lastpufferung bei Großschadenereignissen sowie verpflichtendes 4-Augen-Prinzip vor jeder Regeländerung.],

  [*Solvency II & HGB* \ (Finanz- & Bilanztreue)],
  [Vertragskonforme Leistungsabrechnung, nachweisbare Datenqualität und valide Berechnung der Schadenrückstellungen.],
  [Strikte Prüfung gegen die bei Vertragsabschluss gültigen Bedingungen, exakte mathematische Abrechnung über die Rechen-Engine und revisionssichere Datenhistorie für das Aktuariat.]
)
