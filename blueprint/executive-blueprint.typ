// =============================================================================
// 3-PAGE EXECUTIVE ARCHITECTURE BRIEFING (VORSTANDSVORLAGE)
// KI-gestützte Schadenregulierung auf Microsoft Azure, Foundry & Databricks
// =============================================================================

#set document(
  title: "Management-Briefing: KI-gestützte Schadenregulierung (Azure, Foundry & Databricks)",
  author: "Jannis Ebling",
)

#set page(
  paper: "a4",
  margin: (top: 1.0cm, bottom: 1.05cm, left: 1.15cm, right: 1.15cm),
  footer: context [
    #set text(size: 7.4pt, fill: rgb("#64748b"))
    #line(length: 100%, stroke: 0.5pt + rgb("#cbd5e1"))
    #v(2pt)
    *Management-Briefing: KI-gestützte Schadenregulierung* — Strategie, Kernprozesse, Technologien & Regulatorik
    #h(1fr)
    Seite #counter(page).display("1 / 1", both: true)
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

#let card(title, accent: rgb("#0284c7"), body) = {
  block(
    width: 100%,
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
// SEITE 1: EXECUTIVE SUMMARY, GESAMTÜBERSICHT & DOKUMENTEN-INGESTION
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
  card("1. Datenschutz vor KI-Einsatz")[
    Namen, Adressen und Bankdaten werden direkt beim Eingang neutralisiert, bevor ein KI-Modell den Vorgang analysiert (DSGVO-Schutz).
  ],
  card("2. Strikte Vertragstreue")[
    Jeder Schaden wird verbindlich gegen genau die Bedingungen (AVB) geprüft, die bei Vertragsabschluss gültig waren.
  ],
  card("3. KI steuert, Software rechnet")[
    KI-Agenten sichten Belege und koordinieren den Ablauf; Auszahlungsbeträge und Abzüge berechnet ein festes Rechenwerk.
  ],
  card("4. Schutz für Versicherte")[
    Eindeutige Fälle werden sofort ausgezahlt (Dunkelverarbeitung). Jede Ablehnung erfordert zwingend einen Sachbearbeiter.
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
*Strategische Einordnung:* Die Architektur verbindet hohe Bearbeitungsgeschwindigkeit bei Standardschäden mit kompromissloser regulatorischer Kontrolle. Alle Systeme arbeiten in einer vom öffentlichen Internet abgeschirmten Cloud-Umgebung auf Microsoft Azure. Eingehende Meldungen durchlaufen vier klar abgegrenzte Phasen: *(1) Dokumenten-Ingestion & Datenschutz*, *(2) Klassifikation & Vertragsbindung*, *(3) Multi-Agenten-Schadenprüfung* sowie bei Bedarf *(4) Sicherheits-Schranken & menschliche Fachprüfung*.

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
  card("Ablauf der Eingangsverarbeitung")[
    - *Annahme & Lastpufferung:* Schadenmeldungen erreichen das System über Webportal, App, E-Mail oder Telefon. Eine vorgeschaltete Warteschlange fängt plötzliche Lastspitzen (etwa nach schweren Unwettern) zuverlässig ab.
    - *Unveränderliche Archivierung:* Jedes eingereichte Dokument, Foto oder Telefonat wird sofort im Originalzustand revisionssicher archiviert, um gesetzliche Aufbewahrungs- und Nachweispflichten zu erfüllen.
    - *Fundstellen-Markierung:* Beim Auslesen von PDFs und Rechnungen speichert das System die genaue Position jedes Wertes auf der Seite, damit Sachbearbeiter Angaben später mit einem Klick im Originalbeleg prüfen können.
  ],
  card("Eingesetzte KI-Dienste & Datenschutz-Grund")[
    - *Dokumenten- & Sprach-KI (Azure Document Intelligence & Speech):* Trennt mehrteilige PDF-Sendungen automatisch, liest Werkstattrechnungen tabellengenau aus und verschriftlicht telefonische Schadenmeldungen im Dialog.
    - *Bild-, Medizin- & Übersetzungs-KI (Azure Vision, Language & Translator):* Analysiert Unfallfotos, verpixelt automatisch Gesichter unbeteiligter Dritter aus Datenschutzgründen, strukturiert Arztberichte und übersetzt Fremdsprachenbelege.
    - *Frühe Anonymisierung:* Sensible Personendaten werden durch neutrale Platzhalter ersetzt und getrennt verwahrt. So gelangen niemals Klartext-Kontodaten oder Namen in die nachgelagerten KI-Sprachmodelle.
  ]
)

#pagebreak()

// =============================================================================
// SEITE 2: MULTI-AGENTEN-SYSTEM, REGELWERK-STEUERUNG & RECHEN-ENGINE
// =============================================================================

#section-title("3. Workflow 2: Multi-Agenten-System für die Schadenprüfung (Microsoft Foundry)")

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
  card("Zentrale Steuerung & Interne KI-Qualitätskontrolle")[
    - *Auftragssteuerung nach Schadensart:* Sobald der Schaden im Bestandssystem angelegt ist, lädt das System den passenden Prüfplan (z. B. für Glasschaden, Leitungswasser oder Personenschaden).
    - *Zentraler Orchestrator:* Ein übergeordneter Steuerungs-Agent koordiniert fünf spezialisierte Fach-Agenten. Fehlen Unterlagen vom Kunden, pausiert der Orchestrator den Vorgang automatisch und setzt ihn nahtlos fort, sobald die Antwort eintrifft.
    - *Interne Prüf-Agenten (Vier-Augen-Prinzip innerhalb der KI):* Bevor ein Kundenbrief versendet oder eine Rechnung einem Tarif zugeordnet wird, kontrolliert ein zweiter, unabhängiger Prüf-Agent das Ergebnis auf Richtigkeit und korrekte Paragraphen-Zitate.
  ],
  card("Aufgabenteilung der fünf Spezial-Agenten")[
    1. *Kundenkommunikation:* Prüft die Vollständigkeit der Unterlagen, fordert fehlende Belege gezielt nach und erstellt verständliche Abrechnungsschreiben.
    2. *Deckungsprüfung:* Gleicht den Schadenfall mit dem Vertrag und exakt den zum Abschlusszeitpunkt gültigen Versicherungsbedingungen (AVB) ab.
    3. *Betrugs- & Risikoprüfung:* Erkennt doppelt eingereichte Schadensfotos sowie über *Azure Databricks* organisierte Betrugsnetzwerke (z. B. auffällige Muster zwischen Werkstätten und Gutachtern).
    4. *Rechnungs- & Tarifprüfung:* Übersetzt Rechnungspositionen in standardisierte Gebührenziffern und übergibt diese an die deterministische Rechen-Engine.
    5. *Auszahlung & Buchung:* Passt Schadenrückstellungen an und stößt bei eindeutiger Freigabe die Banküberweisung im Finanzsystem (SAP) an.
  ]
)

#section-title("4. Workflow 3: Regelwerk-Steuerung (Policy Management) & Deterministische Berechnung")

#grid(
  columns: (1fr, 1fr),
  gutter: 8pt,
  card("Warum KI niemals Auszahlungsbeträge schätzen darf", accent: rgb("#1e293b"))[
    Sprachmodelle sind hervorragend darin, unstrukturierte Briefe, Rechnungen und Fotos zu verstehen – sie dürfen jedoch aus Gründen der *BaFin-Revisionssicherheit* und *Solvency-II-Bilanztreue* niemals über Euro-Beträge, Höchstgrenzen oder Selbstbehalte frei entscheiden.

    *Die architektonische Lösung:*
    - *Einheitliche, deterministische Rechen-Engine:* Sobald die KI-Agenten den Sachverhalt und die Rechnungspositionen strukturiert haben, übernimmt eine klassische, mathematisch exakte Software-Engine die Berechnung.
    - *Verbindliche Kombination aller Regeln:* Die Engine verrechnet sowohl die historisch zum Vertrag gehörenden Tarifbedingungen als auch aktuelle interne Kulanz- und Partnerwerkstatt-Regeln nach fest definiertem Schema.
    - *Vollständige Reproduzierbarkeit:* Jeder berechnete Auszahlungsbetrag ist zu 100 % nachvollziehbar und liefert bei gleichen Eingangsdaten jederzeit exakt dasselbe Ergebnis.
  ],
  card("Vier-Augen-Prozess für neue Regeln & Tarife", accent: rgb("#0284c7"))[
    Damit Fachabteilungen und Aktuariat das Regelwerk schnell anpassen können, ohne finanzielle Risiken einzugehen, durchläuft jede Regeländerung einen vierstufigen Governance-Prozess:

    1. *Fachliche Eingabe ohne Programmieraufwand:* Juristen laden neue Bedingungswerke hoch; Fachbereiche formulieren interne Regulierungsregeln in normaler Alltagssprache.
    2. *KI-gestützte Regel-Übersetzung:* Ein Entwurfs-Agent übersetzt die fachliche Vorgabe in formalen Programmcode und erstellt automatisch passende Testfälle.
    3. *Mathematische Konfliktprüfung & Simulation (Azure Databricks):* Das System prüft vollautomatisch auf logische Widersprüche zu bestehenden Regeln und simuliert die finanziellen Auswirkungen auf dem historischen Schadenbestand in *Azure Databricks*.
    4. *Verbindliche Vier-Augen-Freigabe:* Ein unabhängiger Risiko- und Compliance-Manager prüft den Simulationsbericht im Freigabe-Portal und schaltet die Regel erst danach für den Produktivbetrieb frei.
  ]
)

#pagebreak()

// =============================================================================
// SEITE 3: HUMAN-IN-THE-LOOP ESKALATION, TECHNOLOGIE-STACK & COMPLIANCE-MATRIX
// =============================================================================

#section-title("5. Workflow 4: Sicherheits-Schranken (Circuit Breaker) & Sachbearbeiter-Eskalation (HITL)")

#grid(
  columns: (1fr, 1fr),
  gutter: 8pt,
  card("Asymmetrische Automatisierung & Vorarbeit für Spezialisten")[
    - *Gesetzlicher Schutz vor automatischer Ablehnung:* Nach *DSGVO Art. 22* und dem *EU AI Act* dürfen Kunden nicht durch eine rein automatisierte KI-Entscheidung benachteiligt werden. Deshalb gilt in dieser Architektur: *Automatische Auszahlung (Dunkelverarbeitung) = Ja*, aber *Automatische Ablehnung = Technisch gesperrt*.
    - *Harte Sicherheits-Schranken (Circuit Breaker):* Bei jeder drohenden Ablehnung, bei Betrugsverdacht, Personenschäden oder Überschreitung definierter Auszahlungslimits stoppt eine fest programmierte Schranke den KI-Prozess sofort.
    - *Optimale Entscheidungsvorlage:* Der Spezial-Sachbearbeiter erhält keine unübersichtliche Rohakte, sondern eine kompakte Zusammenfassung, den genauen Eskalationsgrund sowie direkte farbliche Hervorhebungen der relevanten Textstellen im Originalbeleg.
  ],
  card("Zwei klar getrennte Auflösungswege nach der Fachprüfung")[
    Je nach Grund der Vorlage unterscheidet die Sachbearbeiter-Anwendung strikt zwischen zwei Wegen:

    - *Pfad 1 — Reine Beleg-Bestätigung (Prozess läuft weiter):* Wurde ein Fall nur vorgelegt, weil ein handschriftliches Datum oder ein Rechnungsbetrag schlecht lesbar war, bestätigt der Mitarbeiter kurz den markierten Wert. Danach führt das Multi-Agenten-System die Bearbeitung normal zu Ende.
    - *Pfad 2 — Finale Sachentscheidung (Kein erneuter KI-Lauf):* Entscheidet der Spezialist über eine Ablehnung, eine Kulanzzahlung oder einen komplexen Großschaden, geht der Fall *nicht* zurück an die KI. Ein direkter Ausführungsdienst setzt die menschliche Entscheidung eins zu eins in Zahlungssystem, Bestandsführung und Kundenbrief um.
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
  [Auslesen von PDFs, Rechnungen, Arztberichten, Telefonaten und Unfallfotos inkl. Anonymisierung.],
  [Spezialisierte Fachmodelle liefern präzise Beleg-Fundstellen für die Sachbearbeiter-Oberfläche und ermöglichen das Entfernen von Personendaten *vor* dem KI-Agenten-Einsatz (DSGVO).],

  [*Microsoft Foundry* \ (Multi-Agenten-Plattform)],
  [Betrieb des zentralen Orchestrators und der fünf spezialisierten Schaden-Agenten.],
  [Bietet isolierte Ausführungsumgebungen, eigene Sicherheits-Identitäten je Agent (Minimalprinzip) sowie integrierte Schutzschilde gegen Manipulationsversuche in Dokumenten.],

  [*Azure AI Search* \ (Vertrags-Wissensbasis)],
  [Durchsucht historische und aktuelle Versicherungsbedingungen (AVB) sowie Tariftabellen.],
  [Kombiniert wortgenaue Paragraphensuche mit inhaltlichem Verständnis und stellt technisch sicher, dass nur die zum jeweiligen Vertrag gehörende Tarifgeneration durchsucht wird.],

  [*Deterministische Rechen-Engine*],
  [Ausführung des versionierten Regelwerks für Tarife, Höchstgrenzen und Selbstbehalte.],
  [Verhindert Rechenfehler und Halluzinationen von Sprachmodellen; garantiert 100 % reproduzierbare, BaFin-revisionssichere Auszahlungsbeträge.],

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
  text(fill: white, weight: "bold")[Regulatorischer Rahmen],
  text(fill: white, weight: "bold")[Zentrale Vorgabe für Versicherer],
  text(fill: white, weight: "bold")[Architektonische Absicherung],

  [*EU AI Act* \ (Europäische KI-Verordnung)],
  [Menschliche Aufsicht, Transparenz, Schutz vor Fehlentscheidungen und lückenlose Dokumentation.],
  [Verbindliche Eskalations-Schranken an Sachbearbeiter, direkte Quellen-Markierung im Originalbeleg, Schutz vor manipulierten Dokumenten und laufende Qualitätsmessung.],

  [*DSGVO / Datenschutz* \ (insb. Art. 22 & Art. 25)],
  [Verbot rein automatisierter Negativ-Entscheidungen, Datensparsamkeit und Recht auf Löschung.],
  [Technisches Verbot automatischer Ablehnungen, frühe Anonymisierung vor jedem KI-Aufruf, automatische Gesichtsverpixelung auf Fotos und europäische Datenhaltung ohne Modelltraining durch Dritte.],

  [*DORA & BaFin (VAIT)* \ (Digitale Betriebsstabilität)],
  [Hohe Ausfallsicherheit, Schutz kritischer Systeme und kontrollierte Änderungsprozesse.],
  [Vollständig vom öffentlichen Internet isoliertes Netzwerk (Private Link), automatische Lastpufferung bei Großschadenereignissen sowie verpflichtendes 4-Augen-Prinzip bei Regeländerungen.],

  [*Solvency II & HGB* \ (Finanz- & Bilanztreue)],
  [Vertragskonforme Abrechnung, nachvollziehbare Datenqualität und valide Schadenrückstellungen.],
  [Unveränderliche Bindung der historischen Vertragsbedingungen, exakte mathematische Berechnung ohne KI-Schätzungen und revisionssichere Historie für das Aktuariat in Azure Databricks.]
)
