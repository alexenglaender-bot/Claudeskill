---
name: audit-compliance
description: >
  Fuehrt ein umfassendes rechtswissenschaftliches Compliance-Audit einer beliebigen
  Software durch (Web-App, SaaS, Mobile, Enterprise). 12 spezialisierte Compliance-
  Agenten pruefen alle anwendbaren Rechtsbereiche (Datenschutz, Vertragsrecht,
  Verbraucherschutz, Wettbewerbsrecht, Steuerrecht, IT-Sicherheitsrecht, AGB-Recht,
  E-Commerce, Arbeitsrecht falls HR-Software, Branchen-spezifisches Recht).
  Use this skill whenever the user says "/audit-compliance", "Compliance-Audit",
  "Legal-Audit", "rechtliche Pruefung", "Norm-Pruefung", "DSGVO-Audit",
  "Rechtskonformitaets-Check", or asks to check any software against applicable
  laws/regulations. Generic version — funktioniert mit beliebigen Jurisdiktionen
  (EU/DE/US/UK/...). User definiert zu Beginn die anwendbaren Jurisdiktionen +
  Branchen. No shortcuts, no efficiency compromises, every relevant file read
  completely, every regulation verified against actual code behavior.
---

# audit-compliance: Universelles Compliance-/Legal-Audit

App-agnostische Version. User definiert zu Beginn die anwendbaren Jurisdiktionen,
Branchen und Datenkategorien — der Skill leitet daraus den Pruefumfang ab.

## DETECT-Phase (Phase 0, vor Audit-Start)

Der Main-Agent fragt den User zu Beginn:

1. **Jurisdiktion(en)** — EU? DE? US? UK? Schweiz? Mehrere? Sitz des Unternehmens?
   Sitz der Nutzer?
2. **Branche** — Healthcare? Finanzdienstleistungen? E-Commerce? SaaS B2B?
   HR-/Workforce-Management? Bildung? Gastronomie? Industrie?
3. **Datenkategorien** — Welche Daten verarbeitet die App? PII? Health-Data
   (Art. 9 DSGVO)? Payment-Data? Minderjaehrige? Behoerden-Daten? Geo-Location?
   Biometrics?
4. **Geschaeftsmodell** — B2B / B2C? Subscription? One-Time-Payment? Free-Tier?
   Marketplace? Anbieter eigener Inhalte oder Drittinhalte?
5. **Regulatorische Kategorisierung** — KI-System (EU AI Act)? Wesentlicher
   Dienst (NIS2)? Verbraucherprodukt (CRA)? Daten-Treuhaender (Data Act)?
6. **Datei-Locator** — Wo liegt: Impressum, Datenschutzerklaerung, AGB, Cookie-
   Banner, Consent-Logger, DSGVO-Tools (Auskunft/Loeschung/Export), Audit-Trail?

Diese Detection liefert die Liste der **anwendbaren Agenten** (z.B. Healthcare-
Agent nur bei Branche=Healthcare) und der **Pflichtnormen**.

---

## ANTI-SPAR-PROTOKOLL (NICHT VERHANDELBAR)

**Dieser Skill ist explizit so designt, dass Spar-Strategien VERBOTEN sind. Der
Fokus liegt zu 100 % auf Gruendlichkeit, nicht auf Geschwindigkeit oder Tokens.
Verstoesse machen das Audit wertlos und sind disqualifizierend.**

Folgende Praktiken sind ausdruecklich UNTERSAGT:

1. **Keine Stichproben.** Jede rechtlich relevante Datei MUSS vollstaendig gelesen
   werden. "5 von 12 Server-Actions" reicht NICHT — alle 12. Norm-Beleg ohne
   Code-Sichtung ist ungueltig.
2. **Keine Agenten-Reduktion.** 12 Agenten (oder die je nach Branche/Jurisdiktion
   anwendbare Anzahl), parallel in 3-4 Batches.
3. **Keine "wahrscheinlich-OK"-Verzichte.** Verifikation = exakte Normzitation
   (§ Abs. S. Nr.) + Code-Zitat mit Datei:Zeile.
4. **Keine Token-Sparmassnahmen.** Vollstaendige OUTPUT-FORMAT-Felder pro Befund.
5. **Keine Zeitlimit-Anpassung.** Token-Budget knapp → User-Meldung.
6. **Keine Selbst-Bewertung als "gut genug".**
7. **Keine Vorab-Annahmen.** Recht aendert sich — frisch nachsehen, aktuelle Stand-
   Datums-Pruefung (EU AI Act, CRA, Data Act, Pay-Transparency-Directive etc.).
8. **Falsch-Negativ-Vermeidung.** "Vorbildlich/OK"-Liste >= Findings-Liste.

Verstoesse haben reale Konsequenzen — uebersehene Norm bedeutet Bussgeld oder
Geschaeftsfuehrer-Haftung. DSGVO bis 20 Mio EUR / 4 % Jahresumsatz, NIS2 bis
10 Mio EUR / 2 % Jahresumsatz, EU AI Act bis 35 Mio EUR / 7 %, CRA bis 15 Mio EUR.
Der Skill optimiert auf **Gruendlichkeit zu 100 %**.

Wenn der Agent in Versuchung ist hier zu sparen: lies diesen Block erneut.

---

## GRUNDSAETZLICHE ANWEISUNGEN

Du fuehrst ein rechtswissenschaftliches Audit auf hoechstem Niveau durch. Dieses
Audit simuliert die Arbeit eines spezialisierten Fachanwalts-Teams mit Expertise
in mehreren Rechtsgebieten und Jurisdiktionen.

**Jede Zeile Code mit rechtlicher Relevanz MUSS gelesen werden. Kein Ueberfliegen,
kein Zusammenfassen, kein Abkuerzen.**

**DOPPELTE VERIFIKATION:** Jedes Finding durchlaeuft zwei Pruefungsrunden:
1. **Erstfund:** Rechtswidrigkeit mit exaktem Normzitat (§ Abs. S. Nr. oder
   Art. Abs. der EU-Verordnung) und Datei:Zeile
2. **Verifikation:** Stimmt die Norm? Ist der Sachverhalt korrekt? Gibt es eine
   Ausnahme/Rechtfertigung im Code? Greift eine Privilegierung (z.B. Kleinst-
   unternehmen, Test-/Forschungsbetrieb)?

**FALSCH-POSITIV-VERMEIDUNG:** Ein Finding wird NUR gemeldet, wenn:
- Norm korrekt zitiert ist (Paragraph, Absatz, Satz, Nummer / Article-Section)
- Code tatsaechlich gegen Norm verstoesst (nicht nur theoretisch)
- KEINE kompensierende Klausel/Logik/Migration im Code gefunden
- Bussgeld-/Strafhoehe in konkreter Waehrung benennbar

**FALSCH-NEGATIV-VERMEIDUNG:** "Vorbildlich umgesetzt"-Liste pro Agent —
mindestens so lang wie Findings-Liste.

**OUTPUT-FORMAT pro Finding:**

```
FINDING [AGENT-XX-YY]
SEVERITY: CRITICAL | HIGH | MEDIUM | LOW | HINWEIS
NORM: [Exaktes Zitat — § Abs. S. Nr. / Art. Abs. lit.]
JURISDIKTION: [EU / DE / US / UK / ...]
DATEI: [Pfad:Zeile]
IST-ZUSTAND: [Was der Code tut]
SOLL-ZUSTAND: [Was die Norm verlangt]
RECHTSFOLGE: [Bussgeld in EUR/USD + Vorschrift; ggf. strafrechtliche Folge]
KOMPENSATION-SUCHE: [Wo gesucht + warum nicht greifend]
FIX: [Konkreter Code-Vorschlag]
VERIFIKATION: [Bestaetigung + Ausschluss-Suche fuer Kompensation]
```

---

## DURCHFUEHRUNG

Dispatche die anwendbaren Agenten **parallel** in 3-4 Batches. Welche Agenten
anwendbar sind, haengt von der DETECT-Phase ab. Jeder Agent liest seine Pflicht-
dateien VOLLSTAENDIG und schreibt
`docs/audits/YYYY-MM-DD-audit-compliance-agentXX.md` als Rohmaterial.

---

### AGENT 1: Datenschutz / Privacy (DSGVO / GDPR / CCPA / LGPD)

**Pflicht-Normen:** EU DSGVO Art. 5-7, 9, 12-22, 25, 28, 30, 32-35, 44-49, 83;
BDSG (DE) § 22, § 26; CCPA (US-CA); LGPD (BR); UK GDPR / Data Protection Act 2018.

**Pruefungsfragen:** Rechtsgrundlage pro Verarbeitung dokumentiert? Einwilligung
korrekt (freiwillig, informiert, granular, widerrufbar)? Art. 9-Daten (Health/
Biometrics/Sexuality/etc.) verschluesselt? Datenminimierung? Speicherbegrenzung?
Betroffenenrechte (Auskunft/Loeschung/Berichtigung/Portabilitaet) funktional?
TOM (Art. 32) — Verschluesselung at-rest + in-transit, Zugriffskontrolle,
Backup, Incident-Response? Art. 30 VVT vorhanden? DSFA bei Hochrisiko (Art. 35)?
Auftragsverarbeitung (Art. 28) — AVV mit jedem Sub-Processor? Drittlandtransfer
(Art. 44-49) — SCC / TIA / Adequacy-Decision? Cookie-Banner TDDDG § 25 / ePrivacy.

**Vorbildlich-Liste:** mindestens 5 gut umgesetzte Bereiche mit Datei:Zeile.

---

### AGENT 2: AGB & Vertragsrecht / Terms of Service

**Pflicht-Normen:** BGB § 305-310 (AGB-Recht), § 327-327u (Digitale Produkte);
EU Consumer Rights Directive; UK Consumer Rights Act 2015.

**Pruefungsfragen:** AGB-Klausel-Kontrolle — ueberraschende Klauseln (§ 305c)?
Transparenzgebot (§ 307)? Wesentliche Vertragspflichten nicht ausgehoehlt?
Haftungsbeschraenkung bei Vorsatz/grober Fahrlaessigkeit ausgeschlossen? BGB
§ 327e — Updatepflicht dokumentiert? § 327i — Vertragsgemaessheit objektiv +
subjektiv erfuellt? Kuendigungsfristen angemessen? Auto-Renewal-Reminder?

**Vorbildlich-Liste:** mindestens 3 gut umgesetzte Bereiche.

---

### AGENT 3: E-Commerce & Verbraucherschutz

**Pflicht-Normen:** BGB § 312 ff (Fernabsatz); EU E-Commerce-Directive; DDG § 5
(Impressumspflicht); FTC Act (US); UK Consumer Contracts Regulations 2013.

**Pruefungsfragen:** Impressum vollstaendig (Name, Anschrift, E-Mail, Handels-
register, USt-ID, Aufsichtsbehoerde)? Widerrufsrecht bei B2C — Belehrung
+ Widerrufsformular? Preisangaben mit USt + Versand? Bestaetigungs-E-Mail
nach Bestellung? Bestellbutton "zahlungspflichtig bestellen" beschriftet?
Wesentliche Eigenschaften vor Bestellung dargestellt?

**Vorbildlich-Liste:** mindestens 3 gut umgesetzte Bereiche.

---

### AGENT 4: IT-Sicherheits-/Cyber-Regulierung

**Pflicht-Normen:** NIS2 (EU 2022/2555); CRA (EU 2024/2847); KRITIS / IT-SiG (DE);
NIST CSF (US); UK NIS Regulations 2018.

**Pruefungsfragen:** NIS2-Pflichten falls "wesentlicher" / "wichtiger" Dienst —
Incident-Reporting innerhalb 24h, Sicherheitsmassnahmen, Governance? CRA Art. 13
— Vulnerability-Disclosure-Policy publiziert? CRA-Konformitaetsbewertung
(Annex VIII) wo anwendbar? Backup-Strategie + Restore-Test dokumentiert?
Incident-Response-Playbook?

**Vorbildlich-Liste:** mindestens 3 gut umgesetzte Bereiche.

---

### AGENT 5: KI-/AI-Regulierung (falls anwendbar)

**Pflicht-Normen:** EU AI Act (VO 2024/1689); Colorado AI Act; UK AI Code.

**Wann anwendbar:** Wenn die App KI-Funktionen nutzt oder bereitstellt.

**Pruefungsfragen:** Risikoklassifikation (verboten / Hochrisiko / begrenzt /
minimal)? Annex III Hochrisiko-Liste durchgegangen? Wenn Hochrisiko —
Konformitaetsbewertung, Risikomanagement, Transparenz, Human-Oversight, Logging,
Robustheit? Art. 50 — Transparenzpflicht (AI-generierte Inhalte gekennzeichnet)?
Art. 22 DSGVO — automatisierte Einzelentscheidungen mit erheblicher Wirkung?

**Vorbildlich-Liste:** mindestens 3 gut umgesetzte Bereiche.

---

### AGENT 6: Steuer-/Rechnungswesen (falls Software finanzrelevant)

**Pflicht-Normen:** AO § 145-147a (DE GoBD); HGB § 238 ff; UStG § 14 (E-Rechnung
EN 16931); EU VAT-Directive; Sarbanes-Oxley (US).

**Pruefungsfragen:** GoBD-konforme Aufbewahrung (Vollstaendigkeit, Richtigkeit,
Zeitgerechtigkeit, Ordnung, Unveraenderbarkeit)? 10-Jahres-Aufbewahrung
durchgesetzt? Audit-Trail manipulationssicher (Hash-Chain)? E-Rechnung —
strukturiertes XML-Format (XRechnung/ZUGFeRD/Factur-X) bei B2B-Rechnungen?
Kassensystem (falls anwendbar) — Konformitaet § 146a AO + KassenSichV?

**Vorbildlich-Liste:** mindestens 3 gut umgesetzte Bereiche.

---

### AGENT 7: Arbeitsrecht (falls HR-/Workforce-Software)

**Pflicht-Normen:** EU Working Time Directive, MuSchG (DE), JArbSchG (DE),
ArbZG (DE), BEEG (DE), AGG (DE), EU Platform Workers Directive 2024/2831,
EU Pay-Transparency-Directive 2023/970.

**Wann anwendbar:** Wenn die App Mitarbeiterdaten verwaltet (HR-/Workforce-
Management/Stempelung/Scheduling/Payroll).

**Pruefungsfragen:** Tageshoechstarbeitszeit (10h / 8h Jugendliche) erzwungen?
Ruhezeiten (11h DE / 11h EU)? Pausenregelung (30 min ab 6h / 45 min ab 9h)?
Mutterschutz-Schutzfristen? Jugendarbeitsschutz (Nachtruhe, Feiertagsarbeit)?
Pay-Transparency — Gehaltsranges + Auskunftsanspruch implementiert? Platform
Workers — algorithmisches Management transparent gemacht?

**Vorbildlich-Liste:** mindestens 3 gut umgesetzte Bereiche.

---

### AGENT 8: Branchen-spezifisches Recht

Wird auf Basis der DETECT-Phase aktiviert:
- **Healthcare**: HIPAA (US), MDR/IVDR (EU), eHealth-Norm DE
- **Financial Services**: MiFID II, PSD2, ZAG (DE)
- **Gastronomie**: GastG, IfSG, LMIV, HACCP
- **Bildung**: DigitalCharta, COPPA (US bei Minderjaehrigen)
- **Public Sector**: Vergaberecht, BSI-Grundschutz

**Vorbildlich-Liste:** mindestens 3 gut umgesetzte Bereiche.

---

### AGENT 9: Wettbewerbsrecht & Marketing

**Pflicht-Normen:** UWG (DE), EU Unfair Commercial Practices Directive,
TMG/DDG, ePrivacy.

**Pruefungsfragen:** Irrefuehrende Werbung? Compliance-Claims ("DSGVO-konform",
"GoBD-konform") rechtlich abgesichert? Dark-Patterns (DSA Art. 25)? Cookie-
Banner mit echter Wahlmoeglichkeit? Newsletter — Double-Opt-In? Werbeanrufe —
Opt-In bei B2C?

**Vorbildlich-Liste:** mindestens 3 gut umgesetzte Bereiche.

---

### AGENT 10: Plattform- & Marktplatz-Recht

**Pflicht-Normen:** EU Digital Services Act (2022/2065), EU Data Act (2023/2854),
P2B Regulation (EU 2019/1150).

**Wann anwendbar:** Wenn die App Plattform-Charakter hat (Marketplace, UGC,
Vermittlung).

**Pruefungsfragen:** Notice-and-Action-Mechanismus (DSA)? Vertrauenswuerdige
Hinweisgeber? Transparency-Reports? Data Act — User-Datenexport in
maschinenlesbarem Format? Switching-Faciliation? Max. 2 Monate Kuendigungsfrist?

**Vorbildlich-Liste:** mindestens 3 gut umgesetzte Bereiche.

---

### AGENT 11: Barrierefreiheit

**Pflicht-Normen:** EU Web Accessibility Directive 2016/2102, EU Accessibility
Act (EAA / 2019/882), BFSG (DE seit 28.06.2025), Section 508 (US).

**Pruefungsfragen:** WCAG 2.1 AA als Mindeststandard erfuellt? Pruefung mit
Screen-Reader + Keyboard + Zoom? Kleinstunternehmen-Ausnahme greift noch?
Erklaerung zur Barrierefreiheit publiziert? Feedback-Mechanismus eingerichtet?

**Vorbildlich-Liste:** mindestens 3 gut umgesetzte Bereiche.

---

### AGENT 12: Aufsicht & Reporting / Governance

**Pflicht-Normen:** Branche-spezifisch — z.B. BaFin (Finanz), Datenschutz-
Aufsichtsbehoerden, NIS2-Aufsicht.

**Pruefungsfragen:** Meldepflichten an Aufsicht definiert (DSGVO Art. 33 — 72h,
NIS2 — 24h Initial, 72h Update, 1 Monat Final-Report)? DSB benannt + gemeldet?
Verantwortlicher (Art. 4 DSGVO) eindeutig benennbar? Vertretungsregelung bei
Krankheit/Urlaub?

**Vorbildlich-Liste:** mindestens 3 gut umgesetzte Bereiche.

---

## ABSCHLUSSPRUEFUNG DURCH DEN MAIN-AGENT

1. **Deduplizierung** + Norm-Cross-Reference.
2. **Severity-Triage** — Bussgeld-Hoehe x Eintrittswahrscheinlichkeit.
3. **Doppel-Verifikation** — jedes Finding gegen 4 Kriterien (siehe unten).
4. **Monitoring-Liste** kommender Norm-Aenderungen (Datum + Norm + Aktion).

---

## PFLICHT-OUTPUT-TABELLE (am Ende JEDES Audit-Reports)

**ZWINGENDE DOPPELVERIFIKATIONS-REGEL:** Die End-Tabelle enthaelt NUR Findings,
die alle vier Verifikations-Schritte durchlaufen haben:

1. **Erstfund** mit konkreter Datei:Zeile + exaktem Normzitat (§ Abs. S. Nr. /
   Art. Abs. lit.)
2. **Normprueung** — passt die Norm wirklich auf den Sachverhalt? Ausnahmen?
3. **Kompensations-Suche** — gibt es im Code eine Klausel/Logik/Migration, die
   das Finding entkraeftet? Wenn ja: Datei:Zeile + Begruendung warum nicht
   ausreichend.
4. **Nicht-Juristen-Erklaerung** — kann die Erklaerung-Spalte einem Stakeholder
   ohne Jura-Background verstaendlich gemacht werden?

Findings, die nicht alle 4 Schritte durchlaufen haben, kommen **nicht** in die
End-Tabelle. Sie werden — falls inhaltlich relevant — unter einem separaten
Abschnitt "⚠ Hinweise (nicht doppelt verifiziert, vor Sprint-Aufnahme pruefen)"
gelistet, nicht vermischt.

Format ist verbindlich:

```markdown
| # | Severity | Norm | Jurisdiktion | Bereich | Finding | Datei:Zeile | Erklaerung |
|---|----------|------|--------------|---------|---------|-------------|------------|
| C-001 | HIGH | DSGVO Art. 32 / BDSG § 64 | EU/DE | TOM | [Beispiel] | path/file.ts:60 | Was tut/fehlt, Bussgeldhoehe konkret in EUR |
```

**Pflicht-Bloecke direkt unter der Tabelle:**

**Statistik:**
```
CRITICAL: X | HIGH: X | MEDIUM: X | LOW: X | OK/Vorbildlich: X
```

**Top-N Sofort-Massnahmen vor Production:** sortiert nach Bussgeldhoehe x
Eintrittswahrscheinlichkeit.

**Monitoring-Liste gesetzliche Aenderungen 12 Monate:**

| Datum | Norm | Aktion |
|-------|------|--------|
| 02.08.2026 | EU AI Act Hochrisiko | Konformitaetsbewertung |
| 11.12.2027 | EU CRA | Konformitaetserklaerung |

**Vorbildlich-Umgesetzte Bereiche-Liste:** mind. so lang wie Findings.

**⚠ Hinweise (nicht doppelt verifiziert):** Falls vorhanden, separat gelistet.

**Erklaerung-Spalte: Pflicht-Inhalte:**
- Exakte Normzitation
- Konkrete Bussgeldhoehe in EUR/USD (kein "moeglicherweise hoch")
- Fuer Nicht-Juristen verstaendlich
