---
name: audit-qa
description: >
  Fuehrt ein umfassendes funktionales End-to-End-QA-Audit einer beliebigen Web- oder
  Mobile-App durch. 12 spezialisierte QA-Agenten navigieren systematisch durch jede
  Page, klicken JEDES klickbare Element, fuellen JEDES Formular mit validen +
  invaliden + Edge-Case-Eingaben, laufen JEDEN End-to-End-Workflow ab, suchen nach
  Encoding-Fehlern (Mojibake), Console-Errors, Network-Fails, A11y-Verstoessen,
  Mobile-Brueche, Performance-Klippen und Data-Inconsistencies. Use this skill
  whenever the user says "/audit-qa", "QA-Audit", "E2E-Audit", "End-to-End-Audit",
  "Functional-Test", "Klick-Audit", "Regression-Test", "Smoke-Test", "Pre-Launch-
  Check", "Go-Live-Audit", "Mojibake-Check", "Encoding-Check", or asks to verify
  that every button/link/form/workflow in any app works. Generic version — works
  with any Browser-Automation-Tool (Playwright/Browser-MCP/Selenium). No shortcuts,
  no efficiency compromises, jede Page besucht, jeder Workflow durchlaufen.
---

# audit-qa: Universelles funktionales End-to-End-Audit

App-agnostische Version. Erkennt App-Typ + Workflows + Test-Tooling automatisch
oder fragt zu Beginn ab.

## DETECT-Phase (Phase 0, vor Audit-Start)

Der Main-Agent fragt den User zu Beginn:

1. **App-URL + Auth-Daten** — wo laeuft die App, welche Test-Accounts (mind. 2-3
   pro Rolle) sind verfuegbar? Default-Passwoerter? Erforderliche 2FA-Setup?
2. **Browser-Tool** — Playwright? Browser-MCP (Claude-Preview / Claude-in-Chrome)?
   Selenium? Direct-Access?
3. **App-Bereiche** — welche Module/Routen sind im Audit-Umfang? (Standard:
   alle, ausgenommen ist nur was explizit Out-of-Scope ist)
4. **Workflow-Liste** — welche End-to-End-Workflows muessen funktionieren?
   (z.B. "User-Onboarding", "Checkout", "Password-Reset", "Datenexport")
5. **Sprachen** — welche UI-Sprachen werden gerendert? (Mojibake-Tests pro Sprache)
6. **Output-Formate** — generiert die App PDFs, CSV, E-Mails? (Encoding-Tests dort
   ebenfalls noetig)
7. **Tech-Stack** — fuer Mutmassliche-Ursache-Hinweise.

Diese Detection liefert die Workflow-Liste fuer Agent 11 und die Output-Format-
Liste fuer Agent 12.

---

## ANTI-SPAR-PROTOKOLL (NICHT VERHANDELBAR)

**Dieser Skill ist explizit so designt, dass Spar-Strategien VERBOTEN sind. Der
Fokus liegt zu 100 % auf Gruendlichkeit, nicht auf Geschwindigkeit oder Tokens.
Verstoesse machen das Audit wertlos und sind disqualifizierend.**

Folgende Praktiken sind ausdruecklich UNTERSAGT:

1. **Keine Stichproben.** JEDE Page, JEDES klickbare Element, JEDES Formular MUSS
   getestet werden. "Die 10 wichtigsten Routen" reicht NICHT — alle.
2. **Keine Agenten-Reduktion.** 12 Agenten, parallel in 3-4 Batches.
3. **Keine "wahrscheinlich-OK"-Verzichte.** Verifikation = Snapshot + Click +
   Console-Log + Network-Log.
4. **Keine Token-Sparmassnahmen.** Vollstaendige OUTPUT-FORMAT-Felder pro Befund.
5. **Keine Zeitlimit-Anpassung.** Token-Budget knapp → User-Meldung.
6. **Keine Selbst-Bewertung als "gut genug".**
7. **Keine Vorab-Annahmen.** Frisch klicken, frisch testen.
8. **Falsch-Negativ-Vermeidung.** "Getestet-und-OK"-Liste >= Findings-Liste.

Verstoesse haben reale Konsequenzen — der eine uebersehene Bug ist exakt der, der
den User zum Konkurrenten treibt. Der Skill optimiert auf **Gruendlichkeit zu 100 %**.

Wenn der Agent in Versuchung ist hier zu sparen: lies diesen Block erneut.

---

## GRUNDSAETZLICHE ANWEISUNGEN

Du fuehrst ein Funktions-Audit auf dem Niveau eines Senior-QA-Engineers + UX-
Researchers + Accessibility-Auditors durch, mit Skills in automatisierter UI-
Testing (Playwright/Selenium), manueller Exploratory Testing, Workflow-Modellierung
und Internationalisierung. Dieses Audit simuliert einen mehrtaegigen Pre-Launch-
Regression-Test, komprimiert in eine einzelne Session mit 12 parallelen QA-Agenten.

**Jede Seite der App MUSS besucht werden. Jedes klickbare Element MUSS aktiviert
werden. Jedes Formular MUSS mit validen + invaliden + Edge-Case-Eingaben submittet
werden. Jeder Workflow MUSS end-to-end durchgelaufen werden. Kein Ueberfliegen,
kein Stichproben-Test, kein "sieht gut aus" ohne Interaktion.**

**DREIFACHE VERIFIKATION pro Finding:**
1. **Reproduktion:** Klick-Sequenz + Snapshot + Console/Network-Log
2. **Scope-Analyse:** Bug systematisch, oder rollenspezifisch / browserspezifisch /
   datenspezifisch? Mit Beleg
3. **Root-Cause-Einordnung:** Mutmassliche Ursache mit Datei:Zeile lokalisiert

**FALSCH-POSITIV-VERMEIDUNG:** Ein Finding wird NUR gemeldet, wenn:
- Klick-Sequenz + Snapshot + Console/Network-Log das Problem zeigen
- Erwartete Baseline (was SOLLTE passieren) klar beschrieben ist

**FALSCH-NEGATIV-VERMEIDUNG:** "Getestet-und-OK"-Liste pro Agent — mindestens so
lang wie Findings-Liste.

**OUTPUT-FORMAT pro Finding:**

```
FINDING [AGENT-XX-YY]
SEVERITY: CRITICAL | HIGH | MEDIUM | LOW | COSMETIC
KATEGORIE: BROKEN_CLICK | BROKEN_FORM | BROKEN_WORKFLOW | UMLAUT_MOJIBAKE |
           CONSOLE_ERROR | NETWORK_4XX | NETWORK_5XX | MISSING_LOADING |
           MISSING_EMPTY | MISSING_ERROR_BOUNDARY | A11Y | MOBILE_BROKEN |
           PERFORMANCE | DATA_INCONSISTENCY | PDF_BROKEN | EMAIL_BROKEN
SEITE/ROUTE: [URL + Rolle]
ELEMENT: [CSS-Selector / ARIA-Label]
ERWARTET: [Was haette passieren sollen]
IST: [Was passiert ist]
REPRO-SCHRITTE:
  1. Login als <rolle>
  2. Navigiere zu <url>
  3. Klicke auf <selector>
CONSOLE: [Relevanter Error oder "keine"]
NETWORK: [Relevanter Request + Status oder "keine"]
SCREENSHOT: [Verweis auf Snapshot]
MUTMASSLICHE URSACHE: [Datei:Zeile + kurze Begruendung]
FIX-HINWEIS: [Konkret oder "Root-Cause-Analyse noetig"]
REGRESSIONS-TEST: [Wie nach Fix verifizieren]
```

---

## DURCHFUEHRUNG

Vorbereitung (Main-Agent, NICHT Sub-Agenten):

1. Browser-Tool verfuegbar? Test-Server laeuft?
2. Test-Accounts mit Demo-Daten vorhanden?
3. Rate-Limit gegebenenfalls geleert?
4. Baseline-Snapshots pro Rolle nach Login.

Dann 12 spezialisierte Agenten **parallel** in 3-4 Batches.

**Agent-Arbeitsweise:**
1. `preview_snapshot` fuer A11y-Tree-Baseline
2. `preview_console_logs` zum Zeitpunkt t0
3. `preview_network` filtered=failed zum Zeitpunkt t0
4. Fuer JEDES klickbares Element: click + post-click snapshot + console/network-delta
5. Fuer JEDES Formular: Happy-Path + Pflichtfeld-Leer + Invalid-Data + Edge-Cases
   (lange Strings, Umlaute, Emojis, HTML/SQL-Injection-Versuche, Zero-Width-Chars)
6. End-to-End-Workflows aus der Workflow-Liste
7. Mojibake-Check pro gerenderter Page: `Ã¤`, `Ã¶`, `Ã¼`, `&auml;`, `?` (Fallback)

---

### AGENT 1: Auth & Onboarding

Login, Logout, Password-Reset, 2FA-Setup, Account-Creation, First-Run-Wizard.

### AGENT 2: Navigation & Layout

Top-Nav, Sidebar, Footer, Mobile-Header, Bottom-Nav, Breadcrumbs. Burger-Menu
Mobile, Theme-Toggle, Sprachumschaltung.

### AGENT 3: Primary-Workflow A

Aus der vom User definierten Workflow-Liste — die kritischsten 2-3 Workflows
end-to-end (z.B. Checkout / Onboarding / Erstes-Item-Anlegen).

### AGENT 4: Primary-Workflow B

Weitere kritische Workflows aus der Liste.

### AGENT 5: Forms & Validation

ALLE Formulare in der App. Pflichtfelder, Inline-Validation, Submit-States,
Server-Validation-Errors, Field-Hints, Disabled-States.

### AGENT 6: Lists & Tables

Pagination, Sorting, Filtering, Search, Bulk-Actions, Empty-States, Loading-States,
Skeleton-UI, Infinite-Scroll, Virtual-Scrolling.

### AGENT 7: Detail-Pages & Modals

Alle Detail-Views, Edit-Modale, Confirm-Dialogs, Side-Slidouts, Drawers, Tooltips.

### AGENT 8: Settings & Profile

User-Profil, Account-Settings, App-Settings, Notification-Preferences, Privacy-
Settings, Datenexport (DSGVO Art. 20), Account-Loeschung (DSGVO Art. 17).

### AGENT 9: Output-Formate (PDF/CSV/Email)

Falls App PDFs/CSVs/E-Mails generiert: Encoding-Check pro Format, Layout-Brueche
bei Umlauten, korrekte Datums-/Zahlenformate, signature/footer korrekt.

### AGENT 10: A11y / Keyboard / Screen-Reader

Tab-Navigation, Focus-Indikatoren, ARIA-Labels, Skip-Links, Heading-Hierarchie,
Image-Alt-Texts, Color-Contrast, Reduce-Motion.

### AGENT 11: Mobile & Responsive

Viewport-Tests bei 320px / 768px / 1024px. Touch-Targets >= 44px. Bottom-Nav.
Hamburger-Menu. Landscape-Modus. Software-Keyboard-Overlay.

### AGENT 12: Performance & Errors

Page-Load-Times > 3s? Console-Errors auf jeder Page? Network-Fails (4xx/5xx)?
JS-Bundle-Size? CLS (Cumulative Layout Shift)? Memory-Leaks bei langer Session?

---

## ABSCHLUSSPRUEFUNG DURCH DEN MAIN-AGENT

1. **Workflow-Pass/Fail-Tabelle** pro Workflow aus der definierten Liste.
2. **Mojibake-Befunde** zusammengefasst nach Datei/Bereich.
3. **Top-10 Production-Blocker** sortiert nach Severity x Reproduzierbarkeit.
4. **Doppel-Verifikation** — jedes Finding gegen 4 Kriterien.

---

## PFLICHT-OUTPUT-TABELLE (am Ende JEDES Audit-Reports)

**ZWINGENDE DOPPELVERIFIKATIONS-REGEL:** Die End-Tabelle enthaelt NUR Findings,
die alle vier Verifikations-Schritte durchlaufen haben:

1. **Reproduktion** mit konkreter Klick-Sequenz + Screenshot/Snapshot + Console/
   Network-Log
2. **Scope-Analyse** — tritt der Bug nur in bestimmter Rolle / Browser-Zustand /
   Datenkonstellation auf, oder systematisch? Mit Beleg
3. **Root-Cause-Einordnung** — mutmassliche Ursache mit Datei:Zeile lokalisiert
4. **Nicht-Techniker-Erklaerung** — wie fuehlt sich der Bug fuer den User an?
   Welche Folge?

Findings, die nicht alle 4 Schritte durchlaufen haben, kommen **nicht** in die
End-Tabelle. Sie werden — falls inhaltlich relevant — unter einem separaten
Abschnitt "⚠ Hinweise (nicht doppelt verifiziert, vor Sprint-Aufnahme pruefen)"
gelistet, nicht vermischt.

Format ist verbindlich:

```markdown
| # | Severity | Kategorie | Workflow/Element | Seite | Erwartet | Ist | Erklaerung |
|---|----------|-----------|------------------|-------|----------|-----|------------|
| F-001 | HIGH | BROKEN_WORKFLOW | [Element] | /route | [Soll] | [Ist] | Wie fuehlt sich Bug an? Welche Folge? |
```

**Pflicht-Bloecke direkt unter der Tabelle:**

**Statistik:**
```
CRITICAL: X | HIGH: X | MEDIUM: X | LOW: X | COSMETIC: X
```

**Workflow-Status:**

| Workflow | Status |
|----------|--------|
| Workflow 1 (z.B. Login + 2FA) | ✅/⚠/❌ |
| Workflow 2 | ✅/⚠/❌ |

**Mojibake-Befunde:** Liste pro Datei/Bereich mit Code-Zitat.

**Top-10 Production-Blocker (sortiert nach Severity x Reproduzierbarkeit):**

**⚠ Hinweise (nicht doppelt verifiziert):** Falls vorhanden, separat gelistet.

**Erklaerung-Spalte: Pflicht-Inhalte:**
- Konkreter Schritt-fuer-Schritt-Reproduktion (nicht "ein Klick irgendwo")
- Was sieht der User? (Toast-Text, Console-Error, Network-Status)
- Wie fuehlt sich der Bug an? (Owner findet nichts, User bricht ab, etc.)
- Bei rechtlich/sicherheitsrelevant: Norm-/CVE-Hinweis
