---
name: funktionsaudit
description: >
  Fuehrt ein umfassendes funktionales End-to-End-Audit der gesamten Ma-Management-App durch.
  12 spezialisierte Funktions-Agenten navigieren via Claude-Preview-Browser-Tools durch jede
  einzelne Seite der App, klicken JEDES klickbare Element, fuellen JEDES Formular mit validen
  und invaliden Eingaben aus, laufen JEDEN End-to-End-Workflow ab (Onboarding, Schicht-Cycle,
  Zeiterfassung, Urlaub, Kassenbuch, Lohnabrechnung, Inventur, Chat, Compliance-Autopilot etc.)
  und suchen systematisch nach Umlaut-Fehlern (Mojibake, HTML-Entities, falsche UTF-8-Kodierung)
  in Rendering, DB-Daten, E-Mails und PDFs. Zusaetzliche Prueffragen zu Accessibility, Error-
  Boundaries, Loading-States, Empty-States, Offline-Verhalten, Mobile-Responsiveness. Use this
  skill whenever the user says "/funktionsaudit", "Funktionsaudit", "Funktions-Audit",
  "Funktionstest", "E2E-Audit", "End-to-End-Audit", "UI-Audit", "UX-Audit", "Klick-Audit",
  "Workflow-Test", "Regression-Test", "Smoke-Test", "Pre-Launch-Check", "Go-Live-Audit",
  "Umlaut-Check", "Mojibake-Check", "UI-Regressions-Audit", or asks to verify that every
  button/link/form/workflow in the app works, to hunt for encoding issues, to simulate real
  user journeys, or to prepare for production launch. This is the most thorough functional
  audit available: no shortcuts, no efficiency compromises, every page visited, every
  clickable element activated, every form submitted with valid + invalid + edge-case input,
  every workflow run end-to-end with real demo data, every Umlaut and special character
  verified in rendering + DB + PDF + email.
---

# Funktionsaudit: Umfassender End-to-End-Test der Ma-Management-App

**Stand 2026-04-28** — Multi-Tenant Phase 2.5 aktiv. Pflicht-Aushaenge-Modul live mit
NachwG §3-Audit-Trail. IfSG-Folgebelehrung BLOCKING in Schichtzuweisung mit NULLS-Edge-Case.
Multi-Tenant-Subdomain-Resolver mit `<slug>.app.<domain>`-Pattern. Tenant-Onboarding via
`scripts/tenant-create.ts`. 14 Demo-Accounts (admin@mabar.com Owner, sarah@mabar.de Manager,
12 weitere Employees). Backup-Health-Check Cron mit Multi-Tenant-Iteration.

## APP-AKTUALITAETS-PRUEFUNG (Phase 0a, vor Phase 0)

Vor jedem Audit-Start MUSS der Main-Agent verifizieren:

1. `docker exec ma-nagement-db psql -U ma_nagement -c "SELECT slug, status FROM \"Tenant\";"` —
   mind. 1 aktiver Tenant in DB? (Bei 0: scripts/tenant-create.ts <slug> "<name>" laufen)
2. `docker exec ma-nagement-db psql -U ma_nagement -c "SELECT COUNT(*) FROM \"ComplianceDocument\";"` —
   mind. 30 Aushaenge geseedet? (Stand 2026-04-28: ~40+)
3. `ls src/app/(app)/recht/page.tsx src/app/(app)/account/meine-rechte/` — beide vorhanden? →
   WF-13 (Pflicht-Aushaenge-E2E) zwingend
4. `ls src/lib/api-tenant-wrapper.ts` — vorhanden? → WF-15 (Multi-Tenant-Subdomain-E2E) zwingend
5. `ls prisma/migrations | tail -10` — letzte 10 Migrationen lesen, neue UI-Felder erfassen
6. Stand-Datum im Bericht IMMER aktualisieren auf heute (nicht 2026-04-X uebernehmen)

## ZUSAETZLICHE WORKFLOWS (seit 2026-04-28)

**WF-13 — Pflicht-Aushaenge-End-to-End:** Owner (admin@mabar.com) → /recht?tab=aushaenge →
Sichtbar-toggle 5 Aushaenge → Logout → Login als Lukas (lukas@mabar.de? oder demo-Equivalent) →
/account/meine-rechte → rotes Badge sichtbar → Klick Aushang → PDF im iframe (kein CORS-Error,
Same-Origin) → Klick "Bestaetigen" → DB-Verify: `SELECT "ipAddress", "userAgent" FROM
"ComplianceDocumentAcknowledgment" WHERE "userId" = ...` → beide Felder gefuellt. Hash-Aenderung
simulieren (UPDATE) → erneutes Login → Re-Acknowledge-Badge sichtbar. ComplianceDocumentPostHistory
+1 pro Aenderung (append-only, GoBD Tz.110).

**WF-14 — IfSG-Folgebelehrung-Sperre-End-to-End:** Login als Manager (sarah@mabar.de) → /scheduling
→ Schicht zuweisen an User mit Erstbelehrung > 3 Monate: BLOCKED mit konkreter Fehlermeldung. User
mit Reminder-Row (issuedAt=null) + alter ECHTER-Belehrung > 2 Jahre: BLOCKED (NULLS-FIRST-Edge-Case-
Test!). User mit gueltiger Folgebelehrung: SUCCESS.

**WF-15 — Multi-Tenant-Subdomain-End-to-End:** /etc/hosts setzen `127.0.0.1 lucie.app.localhost`
ODER Host-Header simulieren. Login auf app.localhost → Default-Tenant. Login auf
lucie.app.localhost (falls existiert) → Lucie-Tenant. Login auf evil.app.localhost → 404
TenantNotFoundError. Login auf blog.example.com (3-Segmente, kein .app.-Anker) → Default-Tenant
(Spoofing-Schutz). x-tenant-slug-Header-Spoofing: `curl -H "x-tenant-slug: lucie"
http://app.localhost/api/calendar/...` → ignoriert (host-derive only).

## ANTI-SPAR-PROTOKOLL (NICHT VERHANDELBAR)

**Dieser Skill ist explizit so designt, dass Spar-Strategien VERBOTEN sind. Der
Fokus liegt zu 100 % auf Gruendlichkeit, nicht auf Geschwindigkeit oder Tokens.
Verstoesse machen das Audit wertlos und sind disqualifizierend.**

Folgende Praktiken sind ausdruecklich UNTERSAGT:

1. **Keine Stichproben.** JEDE Seite, JEDES klickbare Element, JEDES Formular MUSS
   getestet werden. "Die 10 wichtigsten Routen" reicht NICHT — alle. Buttons mit
   "scheint Standard" werden trotzdem geklickt.
2. **Keine Agenten-Reduktion.** Wenn der Skill 12 Agenten vorsieht, MUESSEN 12 Agenten
   dispatched werden. Nicht "die 4 wichtigsten" — alle 12, parallel in 3-4 Batches.
3. **Keine "wahrscheinlich-OK"-Verzichte.** Kein Agent darf eine Page mit
   "sieht sauber aus" abkuerzen. Verifikation = preview_snapshot + preview_click
   + preview_console_logs + preview_network.
4. **Keine Token-Sparmassnahmen.** Kein Truncate, kein "Rest analog", kein
   "siehe oben". Jeder Befund mit allen Pflichtfeldern aus dem OUTPUT-FORMAT
   (REPRO-SCHRITTE, CONSOLE, NETWORK, SCREENSHOT, MUTMASSLICHE URSACHE).
5. **Keine Zeitlimit-Anpassung.** Wenn das Audit 4 Stunden braucht, wird es 4 Stunden
   gemacht. Knapp werdendes Token-Budget → User-Meldung, nicht Audit-Verkuerzung.
6. **Keine Selbst-Bewertung als "gut genug".** Vollstaendigkeit = jede Page besucht,
   jeder Workflow durchgelaufen, Mojibake aktiv gesucht.
7. **Keine Vorab-Annahmen.** Kein "die /scheduling-Page war im Sprint-7-Audit OK" —
   frisch nachsehen. Pages werden veraendert, Bugs werden eingefuehrt.
8. **Falsch-Negativ-Vermeidung ist genauso wichtig wie Falsch-Positiv-Vermeidung.**
   Die "Getestet-und-OK"-Liste MUSS mindestens so lang sein wie die Findings-Liste.

Verstoesse haben reale Konsequenzen — der eine uebersehene Bug ist exakt der, der den
Owner zum Support schickt und den Konkurrenten zum Vertragsabschluss bringt. Der Skill
optimiert auf **Gruendlichkeit zu 100 %**.

Wenn der Agent in Versuchung ist hier zu sparen: lies diesen Block erneut.

---

## GRUNDSAETZLICHE ANWEISUNGEN

Du fuehrst ein Funktions-Audit auf dem Niveau eines Senior-QA-Engineers + UX-Researchers + Accessibility-Auditors durch, mit Skills in automatisierter UI-Testing (Playwright/Selenium), manueller Exploratory Testing, Workflow-Modellierung und Internationalisierung. Dieses Audit simuliert die Arbeit eines mehrtaegigen Pre-Launch-Regression-Tests, komprimiert in eine einzelne Session mit 12 parallelen QA-Agenten.

**KRITISCHE REGEL: Effizienz mit Zeit oder Tokens ist absolut fehl am Platz.** Die App geht morgen live. Eine einzige unentdeckte Funktions-Luecke (Button klickt nicht, Formular submittet nicht, Workflow bricht ab, Umlaut wird als `ä` statt `ä` angezeigt, PDF erzeugt Mojibake) kann zu: Kundenverlust, unbeantwortbaren Support-Tickets, GoBD-Verstoessen (Kassenbuch falsch gerendert), Rechnungen mit defekten Empfaengernamen, DSGVO-Beschwerden (Datenexport fehlerhaft), Shitstorm auf Social Media, Reputationsverlust bis zur Betriebsaufgabe fuehren.

**Jede Seite der App MUSS besucht werden. Jedes klickbare Element MUSS aktiviert werden. Jedes Formular MUSS mit validen + invaliden + Edge-Case-Eingaben submittet werden. Jeder Workflow MUSS end-to-end durchgelaufen werden. Kein Ueberfliegen, kein Stichproben-Test ohne begruendete Priorisierung, kein "sieht gut aus" ohne Interaktion.**

**DREIFACHE VERIFIKATION pro Finding:**
1. **Reproduktion:** Agent reproduziert das Problem durch konkrete Klick-Sequenz + Screenshot + Console/Network-Log
2. **Scope-Analyse:** Agent pruef,t ob das Problem nur in einer bestimmten Rolle (owner/management/employee), einem bestimmten Browser-Zustand, einer bestimmten Datenkonstellation oder systematisch auftritt
3. **Root-Cause-Einordnung:** Agent lokalisiert die mutmassliche Ursache im Code (Server-Action, Client-Component, Zod-Schema, Prisma-Query, Translation, CSS) mit Dateipfad:Zeile

**FALSCH-POSITIV-VERMEIDUNG:** Ein Finding wird NUR gemeldet, wenn:
- Die exakte Klick-Sequenz + Screenshot (oder Snapshot) das Problem zeigt
- Der Console- oder Network-Log den Fehler bestaetigt ODER die Auswirkung visuell dokumentiert ist
- Die erwartete Verhaltens-Baseline (was SOLLTE passieren) klar beschrieben ist
- Theoretische Bedenken ohne Reproduktion sind HINWEIS, kein Finding

**FALSCH-NEGATIV-VERMEIDUNG:** Jeder Agent pflegt eine explizite "Getestet-und-OK"-Liste. Diese muss mindestens so lang sein wie die Findings-Liste. Wenn ein Agent nur wenige Findings hat, muss die "Getestet-und-OK"-Liste dicht bevoelkert sein (Page + alle Klicks + alle Forms).

**OUTPUT-FORMAT pro Finding:**

```
FINDING [AGENT-XX-YY]
SEVERITY: CRITICAL | HIGH | MEDIUM | LOW | COSMETIC
KATEGORIE: BROKEN_CLICK | BROKEN_FORM | BROKEN_WORKFLOW | UMLAUT_MOJIBAKE | CONSOLE_ERROR | NETWORK_4XX | NETWORK_5XX | MISSING_LOADING | MISSING_EMPTY | MISSING_ERROR_BOUNDARY | A11Y | MOBILE_BROKEN | PERFORMANCE | DATA_INCONSISTENCY | PDF_BROKEN | EMAIL_BROKEN
SEITE/ROUTE: [exakte URL + Rolle]
ELEMENT: [CSS-Selector oder ARIA-Label des betroffenen Elements]
ERWARTET: [Was hatte passieren sollen]
IST: [Was passiert ist]
REPRO-SCHRITTE:
  1. Login als <rolle>@mabar.de / demo1234
  2. Navigiere zu <url>
  3. Klicke auf <selector>
  4. [weitere Schritte]
CONSOLE: [relevanter Console-Error oder "keine"]
NETWORK: [relevante Request + Status-Code oder "keine"]
SCREENSHOT: [Hinweis auf Screenshot / Snapshot zum Zeitpunkt des Fehlers]
MUTMASSLICHE URSACHE: [Pfad:Zeile im Code + kurze Begruendung]
FIX-HINWEIS: [Konkreter Code-Vorschlag oder "Root-Cause-Analyse noetig"]
REGRESSIONS-TEST: [Wie nach dem Fix zu verifizieren]
```

---

## VORBEREITUNG (PHASE 0 — vom Main-Agent, nicht Sub-Agenten)

Bevor die 12 Sub-Agenten gestartet werden, stellt der Main-Agent sicher:

1. **Dev-Server laeuft:** Verify `mcp__Claude_Preview__preview_list` — wenn kein `next-dev`-Server laeuft, starte ihn via `mcp__Claude_Preview__preview_start { name: "next-dev" }`. Notiere die `serverId` (UUID).
2. **DB ist sync:** Optional `npx prisma db push --accept-data-loss` falls Schema-Drift vermutet.
3. **Passwoerter sind reset:** Falls Login nicht geht → `npx tsx scripts/reset-demo-passwords.ts`.
4. **Rate-Limit geleert:** Falls vorherige Tests das Rate-Limit getriggert haben → `docker exec ma-nagement-db psql -U ma_nagement -d ma_nagement -c "DELETE FROM \"RateLimitEntry\";"`.
5. **Demo-Daten vorhanden:** `admin@mabar.com / demo1234`, PIN `1234`, + 13 weitere Demo-Accounts (`sarah@mabar.de`, `tom@mabar.de`, `lisa@mabar.de`, `felix@mabar.de`, `anna@mabar.de`, `max@mabar.de`, `luca@mabar.de`, `emma@mabar.de`, `laura@mabar.de`, `mia@mabar.de`, `noah@mabar.de`, `sophie@mabar.de`, `lucie@mabar.de`).
6. **Rollen-Matrix bekannt:**
   - `admin@mabar.com` = **owner** (sieht alles)
   - `sarah@mabar.de` = **management** (Manager-Perspektive)
   - Alle anderen (tom, lisa, felix, ...) = **employee** (Mitarbeiter-Perspektive)
7. **Baseline-Screenshots:** Nach erfolgreichem Login als jede der 3 Rollen ein Screenshot des Dashboards fuer Referenz.

Diese Vorbereitung gehoert zum Main-Agent-Workflow und wird NICHT an Sub-Agenten delegiert, damit die Startbedingung stabil ist.

---

## DURCHFUEHRUNG

Dispatche die folgenden 12 spezialisierten QA-Agenten **parallel** in 3-4 Batches je nach Context-Kapazitaet. Jeder Agent ist Fachexperte fuer seinen App-Bereich. Nach Abschluss aller Agenten wird ein Konsolidierungsbericht erstellt und unter `docs/audits/YYYY-MM-DD-funktionsaudit.md` gespeichert.

Jeder Agent bekommt Zugriff auf: **Grep, Glob, Read, Bash, mcp__Claude_Preview__preview_snapshot, mcp__Claude_Preview__preview_screenshot, mcp__Claude_Preview__preview_click, mcp__Claude_Preview__preview_fill, mcp__Claude_Preview__preview_console_logs, mcp__Claude_Preview__preview_network, mcp__Claude_Preview__preview_eval** (siehe MCP-Tool-Referenz). Jeder Agent schreibt sein Findings-Dokument unter `docs/audits/YYYY-MM-DD-funktionsaudit-agentXX.md` als Rohmaterial fuer die Konsolidierung.

**Agent-Arbeitsweise (fuer alle identisch):**
1. Empfange `serverId` vom Main-Agent.
2. Navigiere zur Start-URL des eigenen Scopes (z.B. `eval`: `window.location.href = "http://localhost:3000/scheduling"`).
3. Fuer JEDE Seite im eigenen Scope:
   a. `preview_snapshot` fuer A11y-Tree (Baseline der Struktur + ARIA-Labels).
   b. `preview_console_logs { level: "error" }` zum Zeitpunkt t0 (vor Interaktion).
   c. `preview_network { filter: "failed" }` zum Zeitpunkt t0.
   d. `preview_screenshot` als visueller Anker.
4. Fuer JEDES klickbare Element auf der Seite (Links, Buttons, Tabs, Dropdowns, Accordions, Menus, Modal-Triggers):
   a. `preview_click` durchfuehren.
   b. Snapshot nach Klick → pruefen ob sich was veraendert hat (URL, DOM, Modal erscheint, Toast, etc.).
   c. Console- und Network-Logs pruefen (neue Fehler seit t0?).
   d. Falls Modal/Dropdown geoeffnet: alle Unter-Elemente ebenfalls klicken.
   e. Zurueck zum Ausgangszustand (Escape, Close-Button oder Back).
5. Fuer JEDES Formular:
   a. Happy-Path: Valide Daten eintragen + Submit → erwarte 200 + Toast/Redirect.
   b. Leere Pflichtfelder: Submit ohne Eingabe → erwarte Client-Side-Validation-Errors fuer alle Required-Fields.
   c. Invalid-Data: Absichtlich falsche Datentypen (z.B. `"abc"` in Zahlenfeld, `31.02.2026` als Datum, `-100` bei positiven Zahlen) → erwarte spezifische Fehlermeldung pro Feld.
   d. Edge-Cases: Sehr lange Strings (1000+ Zeichen), Umlaute, Emojis, HTML-Injection (`<script>alert(1)</script>`), SQL-Metachars, Zero-Width-Characters.
   e. Kontrolle: DB-Eintrag vorhanden? (Via `docker exec ma-nagement-db psql -c "SELECT ..."`.)
6. Fuer JEDEN Workflow-Pfad im eigenen Scope: End-to-End-Szenarien durchspielen (siehe Agent-spezifische Workflow-Listen unten).
7. Umlaut-Test auf JEDER gerenderten Seite: Suche im Snapshot nach Text mit `Ã¤`, `Ã¶`, `Ã¼` (doppelt-UTF-8-kodiert), `&auml;` (HTML-Entities), `?` (Fallback fuer unbekannte Zeichen). Diese sind ALLE Mojibake-Indikatoren.
8. Dokumentiere Findings im oben definierten Format.

---

### AGENT 1: Auth, Account & Session Management

**Scope:** Alle Auth-Routen + Profil-Bereich der einzelnen User.

**Routen (JEDE besuchen, JEDES Element klicken, JEDES Formular testen):**
- `/` (Root-Redirect → `/login`)
- `/login` (Login-Formular)
- `/forgot-password` (Forgot-Password-Formular)
- `/reset-password/[token]` (Reset-Password — Token aus E-Mail oder Test-Token)
- `/signout` (Logout-Workflow)
- `/account` (eigener Profil-Bereich)
- `/account/pay-band` (eigene Gehaltsband-Info, EntgTranspG)
- `/terminal` (Kiosk-Login fuer Terminal-User)

**Workflows (jeden end-to-end durchlaufen):**
1. **Login-Happy-Path:** admin@mabar.com / demo1234 → Dashboard geladen?
2. **Login-Fail:** falsche Email → "Ungueltige Anmeldedaten"? Rate-Limit greift nach 5 Versuchen?
3. **Password-Reset:** `/forgot-password` → E-Mail eintragen → Success-Message (auch bei unbekannter Mail, User-Enumeration-Schutz)?
4. **2FA-Flow:** Einschalten in /account → QR-Code scannen → 6-stelligen Code eingeben → Login mit 2FA-Code funktioniert?
5. **2FA-Recovery-Codes:** Generierung, Download, Einmalig-Verwendung?
6. **PIN-Aenderung:** In /account PIN aendern → Terminal-Login mit neuer PIN funktioniert?
7. **Logout:** Klick auf "Abmelden" → zurueck auf /login + Session-Cookie weg?
8. **Session-Expiry:** Nach 30min Inaktivitaet → Redirect auf /login?
9. **Terminal-Kiosk-Login:** Terminal-PIN-Eingabe statt Passwort?

**Spezifische Prueffragen:**
1. Login-Formular: Alle Labels ("Email", "Passwort", "Anmelden") korrekt rendernd mit Umlauten?
2. "Passwort vergessen?"-Link funktioniert?
3. "Passwort anzeigen"-Button toggelt den Password-Type korrekt?
4. Bei 2FA-Enable: QR-Code wird als Bild korrekt gerendert (SVG/PNG)?
5. 2FA-Wiederherstellungs-Codes sind 8 Stueck, jeweils im Format XXXX-XXXX?
6. Profil-Bearbeitung: Phone/Adress-Felder akzeptieren Umlaute ohne Mojibake nach Save + Reload?
7. Gender-Feld (EntgTranspG): Dropdown zeigt 4 Optionen (male/female/diverse/not_specified) korrekt lokalisiert?
8. "Meine Pay-Band"-Seite: Zeigt Rolle + Level + Min/Max-Range + Median oder Anonymitaets-Warnung bei <5 MA?

**Rollenwechsel:** Teste den Account-Bereich als owner, management UND employee. Pay-Band-Sichtbarkeit darf sich unterscheiden, aber keine CRASH, 500er oder Cross-Tenant-Leaks.

---

### AGENT 2: Dashboard, Sidebar, Bottom-Nav, Mobile-Header

**Scope:** Globale Layout-Elemente + Dashboard + rollenbasierte Navigation.

**Routen:**
- `/dashboard` (Haupt-Dashboard)
- Sidebar-Links (alle) als Navigation testen
- Bottom-Nav (Mobile) als rollenspezifische Navigation

**Spezifische Prueffragen:**
1. Dashboard-Header: "Guten Tag, <Firstname>" zeigt korrekten Namen mit Umlauten?
2. "X Dinge brauchen deine Aufmerksamkeit"-Counter stimmt mit Autopilot-Findings ueberein?
3. Dashboard-Widgets: Stunden-diese-Woche, Team-gesamt, Offene-Schichten, Heute-aktiv, Offene-Anfragen — alle Zahlen sinnvoll (nicht NaN, nicht undefined, nicht "0" wenn Daten vorhanden)?
4. Finanzen-Heute-Widget: Tagesumsatz, Personal, Wareneinsatz, Marge, PKQ — Euro-Zeichen korrekt, Kommastelle korrekt deutsch (Komma statt Punkt)?
5. Sidebar: ALLE Links klickbar UND fuehren zur richtigen Route (keine 404)?
6. Sidebar-Badge-Counts (z.B. "22" bei Recht & Auflagen) matchen mit tatsaechlichen offenen Items?
7. Bottom-Nav Mobile: 5 Icons je Rolle korrekt?
   - Owner: Dashboard/Finanzen/Planung/Compliance/Chat
   - Manager: Dashboard/Planung/Team/Aufgaben/Chat
   - Employee: Dashboard/Schichten/Urlaub/Aufgaben/Chat
8. Mobile-Header-Burger-Menu: Oeffnet sich, zeigt Sidebar-Inhalte, schliesst wieder?
9. Dark-Mode-Toggle (falls vorhanden): Wechselt korrekt, alle Texte lesbar, keine weissen Boxen auf hellem Hintergrund?
10. Theme-Persistenz ueber Reload via localStorage?

**Rollenwechsel:** Pro Rolle (owner/management/employee) Dashboard laden. Sidebar-Items unterscheiden sich — keine Rolle darf mehr sehen als erlaubt (no privilege-leak).

---

### AGENT 3: Schichtplanung & Verfuegbarkeit

**Scope:** Alle Routen rund um Shift-Management.

**Routen:**
- `/scheduling` (Haupt-Planung)
- `/scheduling/day` (Tagesansicht)
- `/scheduling/calendar` (Kalenderansicht)
- `/scheduling/month` (Monatsansicht)
- `/scheduling/[id]` (Einzelne Schicht)
- `/shifts` (alternative Ansicht)
- `/shifts/day`, `/shifts/calendar`, `/shifts/month`, `/shifts/[id]`
- `/my-shifts` (aus Employee-Sicht)
- `/swaps` (Tauschanfragen)
- `/coverage` (Besetzungs-Uebersicht)
- `/availability` (Verfuegbarkeit setzen)

**Workflows:**
1. **Schicht anlegen:** Datum + Rolle + Zeit + Zuweisung → in DB? In Kalender sichtbar?
2. **Schicht loeschen:** Delete → Confirmation-Dialog → DB-Entry weg?
3. **Schicht bearbeiten:** Zeit aendern → Speichern → Aenderung in DB?
4. **Schicht-Zuweisung:** MA zuweisen → Notification an MA (in Chat/Push)?
5. **Tauschanfrage:** MA erstellt Tausch → anderer MA nimmt an → Bestaetigung durch Manager → Schicht wechselt Zuweisung?
6. **Marketplace-Flow:** Manager stellt Schicht ein → MA claimed → Confirmation?
7. **Ausfall-Workflow:** MA stempelt nicht ein → "Nicht erschienen"-Alert (wie auf Dashboard sichtbar) → Manager kann nachtragen?
8. **Verfuegbarkeits-Setzen:** MA markiert "Montag Vormittag verfuegbar" → Planer sieht das im Kalender?

**Spezifische Prueffragen:**
1. Scheduling-Tabs (Day/Calendar/Month): Alle wechselbar, Daten konsistent?
2. Drag & Drop (falls implementiert) — bekannter TODO #33, evtl. noch nicht da.
3. Tenant-Scoping: Als Sarah (Manager) keine Schichten aus anderen Restaurants sichtbar?
4. Shift-Form: Start-Zeit > End-Zeit → Validation-Error?
5. Schicht in der Vergangenheit anlegen → erlaubt mit Warnung, oder geblockt?
6. Schicht-Datum Umlaute in Notiz-Feld → korrekt gespeichert + gerendert?
7. Kalender zeigt deutsche Wochentage (Mo/Di/Mi/Do/Fr/Sa/So) + Monate (Januar/...) korrekt?
8. Stichprobe: Eine geplante Sonntagsschicht → erzeugt sie die korrekten §3b EStG Zuschlaege?
9. Shift-Swap zwischen 2 MA mit unterschiedlichen Rollen — Blockiert das System das, oder erlaubt es mit Warnung?

---

### AGENT 4: Zeiterfassung, Stundenkonto & Terminal

**Scope:** Clock-In/Out-Workflows, Stundenkonten, Terminal-Kiosk.

**Routen:**
- `/time-tracking` (Zeiterfassungs-Liste)
- `/hours` (Stunden-Uebersicht)
- `/worktime-account` (Stundenkonto)
- `/overtime` (Ueberstunden)
- `/labor-costs` (Lohnkosten-Uebersicht)
- `/terminal` (Terminal-Kiosk-Modus)

**Workflows:**
1. **Terminal-Clock-In:** PIN eingeben → Rolle auswaehlen → eingestempelt? TimeEntry in DB?
2. **Terminal-Clock-Out:** Nach Clock-In → Ausstempeln → durationMinutes korrekt berechnet?
3. **Break-Entry:** Pause 30min einlegen → In Clock-In-Phase → Pause geloggt?
4. **Stempelung nachtragen:** Manager nimmt fehlende Stempelung nach → Audit-Log-Eintrag erzeugt?
5. **Stempel-Korrektur:** Minuten-Rundung (1/5/10/15/30min) greift korrekt?
6. **Ueberstunden-Alarm:** MA hat >10h am Tag → ArbZG-Warnung im Autopilot?
7. **Pausen-Alarm:** MA hat 7h-Schicht ohne 30min-Pause → JArbSchG/ArbZG-Warnung?

**Spezifische Prueffragen:**
1. Terminal-PIN-Pad: Alle 10 Ziffern-Buttons + Backspace klickbar?
2. Terminal zeigt nur Firmen-Angestellte des aktuellen Restaurants (nicht andere Restaurants)?
3. Stempel-Button: Wechselt korrekt zwischen "Einstempeln"/"Ausstempeln"/"Pause-Start"/"Pause-Ende"?
4. Zeitanzeigen im deutschen Format (HH:mm, nicht AM/PM)?
5. Worktime-Account: Soll-Ist-Vergleich fuer den Monat? Ueberstunden-Bilanz korrekt?
6. Minderjaehrige MA (falls Demo-Daten einen MA <18 haben): JArbSchG-Checks greifen im Terminal (max 8h, Nachtruhe)?
7. Gefuehrt-durch-den-Pausen-Flow: Pause-Start > 6h Arbeit → 30min, > 9h → 45min?

---

### AGENT 5: Abwesenheiten (Urlaub, Krankheit, Fehlzeiten)

**Scope:** Urlaubsantraege, Krankmeldungen, Abwesenheits-Uebersicht.

**Routen:**
- `/vacation` (Urlaub)
- `/sick-leave` (Krankheit)
- `/absences` (allgemeine Uebersicht)

**Workflows:**
1. **Urlaubsantrag erstellen:** MA wählt Datum → Submit → Status "pending" → Manager sieht es im Dashboard-Counter?
2. **Urlaubsantrag genehmigen:** Manager oeffnet Antrag → Genehmigen → DB-Update + Push an MA?
3. **Urlaubsantrag ablehnen:** Manager lehnt ab mit Begruendung → MA sieht Notification?
4. **Urlaubsantrag stornieren:** MA storniert eigenen Antrag → DB aktualisiert?
5. **§5 BUrlG Teilurlaub:** MA mit contractStart Mitte Jahr → Urlaubstage = 1/12 pro vollem Monat?
6. **§9 BUrlG Krankheit im Urlaub:** MA meldet Krankheit waehrend Urlaub + Attest → ueberlappende Urlaubstage automatisch zurueckgebucht?
7. **Krankmeldung:** MA meldet sich krank → Dokument-Upload (AU-Bescheinigung) → Status "acknowledged"?
8. **Fortsetzungserkrankung §3a EFZG:** 2. Krankmeldung innerhalb 6 Monate gleiche Krankheit → EFZG-Counter wird weitergezaehlt, nicht neu gestartet?

**Spezifische Prueffragen:**
1. Urlaubskalender: Zeigt genehmigte + pending separat?
2. Urlaubsformular: Von-Bis-Datum mit Kalender-Picker? Deutsche Datumsnotation?
3. Rest-Tage-Counter: Zeigt verbleibende Tage korrekt?
4. Note/Begruendung: Umlaute (z.B. "Urlaub fuer Umzug") korrekt gespeichert/gerendert?
5. Bei Krankmeldung ueber 3 Tage: Warnung "AU-Attest erforderlich nach §5 EFZG"?
6. PDF-Upload AU-Attest: Magic-Bytes-Check (PDF-Signatur) + Magic-Filename-Validation greifen?
7. Absences-Heatmap (falls vorhanden): Farbkodierung korrekt?
8. Race-Condition: Zwei parallele Urlaubsantrage → Serializable-Transaction verhindert Double-Spend?

---

### AGENT 6: Personalverwaltung (Staff, Employees, Zertifikate)

**Scope:** Mitarbeiter-Listen, Detail-Seiten, IfSG-Zertifikate, Qualifikationen.

**Routen:**
- `/staff` (Staff-Liste)
- `/staff/[id]` (MA-Detail)
- `/staff/[id]/settings` (Einstellungen fuer diesen MA inkl. Pay-Band-Zuweisung)
- `/settings/employees` (Employee-Verwaltung)
- `/settings/employees/[id]` (Detail)
- `/settings/employees/[id]/profile` (Profil)
- `/certifications` (Zertifikate-Uebersicht)

**Workflows:**
1. **MA neu anlegen:** Vollstaendiges Formular → Submit → Welcome-Mail (falls SMTP)? DB-Eintrag?
2. **MA deaktivieren:** Toggle isActive → kann nicht mehr einloggen?
3. **Rollen-Zuweisung:** Manager → Owner heraufstufen → Audit-Log + 2FA-Required?
4. **Pay-Band-Assignment:** MA wird einer Pay-Band zugeordnet → in /account/pay-band sichtbar?
5. **IfSG-Zertifikat hochladen:** PDF-Upload + ExpiresAt setzen → erscheint in Zertifikate-Liste?
6. **IfSG-Ablauf-Warning:** Zertifikat mit <30 Tage Restlaufzeit → Autopilot-Warnung?
7. **Qualifikation zuweisen:** MA bekommt "Barista"-Qualifikation → erscheint in Skill-Matrix (falls implementiert)?
8. **Schwerbehinderten-Status:** Owner setzt Grad 50 → verschluesselt in DB? In /account-Export sichtbar?

**Spezifische Prueffragen:**
1. Staff-Liste: Filter nach Rolle / aktiv / inaktiv?
2. MA-Detail: Tabs (Stammdaten / Vertrag / Zertifikate / Schichten / Urlaub)?
3. Umlaut-Stress-Test: MA mit Namen "Müller-Lüdenscheidt" ueber alle Ansichten hinweg korrekt dargestellt?
4. Adresse mit "Straße" → keine Mojibake?
5. Stundenlohn-Feld: Deutsche Formatierung (z.B. 14,50 €), Cents-Umwandlung korrekt?
6. Sofortmeldung-Action: Button ausloest → SEPA/SVNR-Formular vorausgefuellt mit MA-Daten?
7. Muschg-Waiver-Workflow: Schwangere MA mit Attest → Schutzfrist-Aufhebung (inkl. Behoerde-Flag)?

---

### AGENT 7: Finanzen, POS, Kassenbuch, DATEV

**Scope:** Alle Finanz-/Kassen-/Rechnungs-/Export-Routen.

**Routen:**
- `/finanzen` (Finanz-Dashboard)
- `/settings/payroll` (Payroll-Einstellungen)
- `/settings/pay-gap-report` (Gender Pay Gap Report)
- `/settings/export` (Export-Center)

**Workflows:**
1. **CashEntry anlegen:** Betrag + Kategorie → TSE-Signatur erfolgt → GoBD-Hash-Kette fortgesetzt?
2. **CashEntry stornieren:** Storno als neuer Eintrag (nicht Delete), §146a AO-konform?
3. **TSE-Fehler-Pfad:** Bei Signatur-Fehler → Beleg wird NICHT erzeugt (H-03 Fix)?
4. **POS-Connect:** Disconnect POS → nur eigene Tenant-Transaktionen soft-deleted?
5. **DATEV-Export:** Button klickt → CSV/XLS generiert + Download?
6. **DSFinV-K-Export:** BON_BEENDIGUNG = tseEndTime (nicht Belegdatum)?
7. **XRechnung generieren:** Rechnung exportiert als XML + PDF, KoSIT-valid?
8. **GwG-Warnung (>10k EUR Bargeld):** User sieht UI-Warnung (kein `warning` mehr im Backend verworfen)?
9. **Pay-Gap-Report Generation:** Owner exportiert → CSV + PDF? Gruppen mit <5 Personen zeigen "insufficient_data"?
10. **Kassenmeldepflicht §146a Abs. 4 AO:** Felder im UI vorhanden (tseRegisteredAtElsterAt etc.)?

**Spezifische Prueffragen:**
1. Finanzen-Dashboard: Heute-Umsatz in Echtzeit? Waehrungsformatierung korrekt (deutsche Komma-Trennung + €-Zeichen)?
2. USt-Berechnung: In-Haus 19% vs. Ausser-Haus 7% korrekt (consumptionType)?
3. Sachbezugswerte 2026 (Essen 4,13 EUR, Unterkunft 265 EUR)?
4. Storno-Eintrag hat negatives Vorzeichen + Verweis auf Original?
5. Hash-Kette: `verifyAuditChain()` laeuft durch ohne Fork?
6. PDF-Exports: Keine Mojibake in Kundennamen, Betrags-Formatierung korrekt?
7. CSV-Export: Spalten-Header korrekt, Umlaute in UTF-8-BOM, nicht Windows-Latin1?

---

### AGENT 8: Warenwirtschaft, Inventar, Equipment

**Scope:** Artikel, Wareneingang, Bestandsverwaltung, Equipment, HACCP.

**Routen:**
- `/warenwirtschaft` (WaWi-Haupt)
- `/equipment/[id]` (Equipment-Detail)
- `/settings/templates` (Vorlagen)

**Workflows:**
1. **Wareneingang erfassen:** Lieferant + Artikel + Menge + Temperatur → Wenn TK und Temp > -18°C → HACCP-Deviation-Flag?
2. **MHD-Tracking:** Artikel mit `bestBefore` < now() → Autopilot-Warnung CRITICAL?
3. **Schwund erfassen:** Artikel verbraucht (ohne Verkauf) → Verlust-Buchung?
4. **Equipment-Wartung:** Wartungstermin ueberfaellig → Warnung?
5. **Rezept anlegen (falls Phase 4):** Zutaten + Preise → Rueckwaerts-Kalkulation Marge?

**Spezifische Prueffragen:**
1. Artikel-Detail: Accordion mit Zulieferer/MHD/Lager/Allergene (TODO #174)?
2. Temperatur-Eingabe: Einheit Int×10 (Zehntelgrad) oder Int (Ganzgrad)?
3. Inventur-Light-Flow (falls implementiert): Aktuelle vs. gezaehlte Menge, Differenz?
4. Equipment-Liste: Status-Badge (aktiv/defekt/Wartung) korrekt?
5. LMIV-Allergen-Kennzeichnung: Noch fehlend (TODO #178) — dokumentiere als COSMETIC wenn Ansicht da aber leer, CRITICAL wenn beim Anlegen eines Rezepts abstuerzt.

---

### AGENT 9: Recht, Compliance, Arbeitsschutz, Breach-Register

**Scope:** Compliance-Autopilot, Recht-Seite, Arbeitsunfaelle, Data-Breaches.

**Routen:**
- `/recht` (Recht & Auflagen)
- `/compliance` (Compliance-Zentrale)
- `/arbeitsschutz` (Arbeitsschutz-Uebersicht)
- `/arbeitsschutz/unfaelle` (Arbeitsunfaelle-Liste)
- `/arbeitsschutz/unfaelle/new` (Neuer Unfall)
- `/arbeitsschutz/unfaelle/[id]` (Detail)

**Workflows:**
1. **Compliance-Autopilot-Bestaetigung:** Klick auf "Abhaken" in Warnung → Dismissed-Log?
2. **Arbeitsunfall erfassen:** Formular → Automatisches BGN-Flag bei incapacityDays >= 3?
3. **BGN-Meldung-PDF generieren:** Download-Button → PDF mit allen Pflichtfeldern + deutschen Umlauten?
4. **Data-Breach anlegen:** Breach erfassen → Severity hoch → ENISA/BSI-Meldungen generierbar?
5. **ENISA 24h-Fruehwarnung:** PDF-Download → Felder korrekt befuellt?
6. **NIS2 24h/72h/1M-Meldungen:** Timestamps werden gesetzt beim Download?
7. **DSGVO-Export (Art. 20):** MA fordert eigene Daten an → komplettes JSON-Archiv mit Umlauten korrekt?
8. **DSGVO-Loeschung (Art. 17):** Owner loescht User → Art. 9-Felder anonymisiert? AuditLog-IPs gepatcht?

**Spezifische Prueffragen:**
1. Recht-Page: RDG-Disclaimer-Banner sichtbar (A12r F-12 Fix)?
2. Compliance-Warnungen: Formulierungen konditional ("koennte", "pruefen", "Rechtsrat einholen") statt definitiv?
3. Unfall-Formular: Datum + Ort + Beschreibung + Verletzung + Zeugen?
4. Verbandbuch (DGUV V1 §24): Auch fuer kleine Verletzungen ohne BGN-Meldepflicht?
5. Breach-Register: Wer hat Zugriff (nur Owner)?

---

### AGENT 10: Kommunikation (Chat, Ankuendigungen, Handover, Tasks, Kalender)

**Scope:** Team-Kollaboration, interne Kommunikation.

**Routen:**
- `/chat` (Team-Chat)
- `/announcements` (Ankuendigungen)
- `/handover` (Uebergabe-Notizen)
- `/tasks` (Aufgaben/Checklisten)
- `/kalender` (Betriebskalender)

**Workflows:**
1. **Chat-Nachricht senden:** Text + Optional File-Attachment → andere Chat-Teilnehmer sehen es?
2. **Chat-E2E:** Client-Side-Verschluesselung korrekt? Nachrichten in DB sind verschluesselt?
3. **Ankuendigung publizieren:** Manager erstellt → alle MA sehen Banner?
4. **Uebergabe-Notiz:** Schichtwechsel-Notiz mit Umlauten + Sonderzeichen?
5. **Task erstellen + zuweisen:** Task geht an MA → Push-Benachrichtigung?
6. **Checkliste abarbeiten:** Haken setzen auf Items → Persistenz in DB?
7. **Kalender-Event anlegen:** Datum + Titel + Beschreibung → sichtbar fuer Team?

**Spezifische Prueffragen:**
1. Chat-Unread-Badge: Stimmt mit tatsaechlich ungelesenen Nachrichten ueberein?
2. Chat-File-Upload: GIF/WebP/PDF mit vollstaendiger Magic-Byte-Validierung (nach CONS-11 Fix)?
3. Ankuendigungen: Prioritaets-Filter (normal/wichtig/dringend)?
4. Task-Due-Date: Ueberfaellige Tasks markiert rot?
5. Kalender: iCal-Export funktioniert? Enthaelt deutsche Sonderzeichen korrekt?

---

### AGENT 11: Einstellungen (Settings-Bereich komplett)

**Scope:** Alle Seiten unter `/settings/**`.

**Routen:**
- `/settings` (Settings-Haupt)
- `/settings/asig` (Betriebsarzt + Sifa — NEU)
- `/settings/betriebsrat` (BR-Info — NEU)
- `/settings/checklists` (Checklisten-Vorlagen)
- `/settings/export` (Export-Center)
- `/settings/guide` (Onboarding-Guide)
- `/settings/holidays` (Feiertage)
- `/settings/pay-bands` (Gehaltsbaender — NEU)
- `/settings/pay-gap-report` (Gender Pay Gap)
- `/settings/payroll` (Payroll-Settings)
- `/settings/roles` (Rollen-Verwaltung)
- `/settings/security` (Security-Alerts + Co-Owner — NEU)
- `/settings/templates` (Vorlagen)
- `/security/incidents` (Incident-Dashboard — NEU)

**Workflows:**
1. **Betriebsarzt-Daten setzen:** Name + Adresse + Upload Bestellungsurkunde → PDF bleibt verschluesselt?
2. **BR-Info-Paket:** Toggle BR vorhanden + Download PDF → Generiert mit Betriebsdaten?
3. **Pay-Band anlegen:** Rolle + Level + Min/Max → Assignment an MA erfolgt?
4. **Pay-Gap-Report-Export:** CSV + PDF-Download?
5. **Holiday-Liste:** Bundesland-spezifische Feiertage 2026?
6. **Security-Alert-Settings:** Severity-Filter + Quiet Hours + Event-Opt-Out korrekt?
7. **Test-Alert senden:** Owner bekommt sofort Push + E-Mail?
8. **Incident-Dashboard:** Offene Incidents + Acknowledge/Resolve-Workflow?

**Spezifische Prueffragen:**
1. Settings-Haupt: Tab-Lazy-Loading greift (nur aktiver Tab laedt Daten, #71 Fix)?
2. CRITICAL-Event-Checkboxen in Security-Settings sind DISABLED (NIS2-Lock)?
3. Quiet-Hours: Time-Input-Format korrekt (HH:MM)?
4. Pay-Bands-Liste: Sortiert nach Rolle + Level?
5. Rollen-Verwaltung: Owner-Downgrade auf Manager mit 2FA-Bestaetigung?
6. Templates: Vorhandene Vorlagen + "Neu anlegen"-Button funktional?

---

### AGENT 12: Betriebsverwaltung, Terminal-Setup, Datenschutz-Pages, Public-Pages

**Scope:** Betriebs-Config, Terminal-spezifische UI, oeffentliche Seiten.

**Routen:**
- `/betriebsverwaltung` (Betriebs-Einstellungen)
- `/terminal` (Kiosk-Modus)
- `/impressum` (oeffentlich)
- `/datenschutz` (oeffentlich)
- `/privacy` (oeffentlich)
- `/agb` (oeffentlich)
- `/security-policy` (oeffentlich — NEU aus CONS-16)
- `/security/acknowledgments` (Hall-of-Fame — NEU)
- `/steuerberater/[token]` (Token-basiert)
- `/changelog` (oeffentlich)

**Workflows:**
1. **Impressum vollstaendig:** DDG §5 Pflichtangaben (Name, Adresse, Email, HRB, USt-IdNr)?
2. **Datenschutzerklaerung:** Alle 13+ VVT-Verarbeitungen gelistet? Drittland-Hinweise (Sentry/Twilio)?
3. **AGB:** Vollstaendig, §305-310 BGB konform?
4. **Security-Policy:** SECURITY.md-Inhalt gespiegelt? PGP-Key-Link aktiv?
5. **Steuerberater-Token-Login:** Tokenbasierter Zugang ohne Session?
6. **Terminal-Kiosk:** Fullscreen-Modus? Keine Sidebar/Nav? Nur Clock-In/Out UI?
7. **Changelog:** Letzte Releases mit Datum + Aenderungen?

**Spezifische Prueffragen:**
1. Impressum: Umlaute in Firmennamen korrekt? `&amp;` oder `&` korrekt als `&` gerendert?
2. Datenschutz: Art.-6-Abs.-1-Buchstaben korrekt zitiert (lit.a/b/c/f)?
3. AGB: Klauseln durchgaengig lesbar (keine CSS-Probleme)?
4. PGP-Key-Datei unter `/public-pgp.asc` erreichbar?
5. `/.well-known/security.txt` → RFC 9116 Felder, Expires in der Zukunft?
6. Terminal: X-Frame-Options DENY greift (Clickjacking-Schutz)?
7. Public-Pages: KEIN Auth-Requirement, trotzdem CSP + HSTS aktiv?

---

## PHASE 2: UMLAUT-SCAN (nach Agenten 1-12)

Nach Abschluss der 12 Agenten laeuft ein **systematischer Mojibake-Scan** ueber die gesamte App. Dieser Scan ist NICHT ein Sub-Agent sondern wird vom Main-Agent durchgefuehrt.

**Scan-Ebenen:**

### Ebene 1: Code-Scan (Quelltext)

```bash
# Doppelt-UTF-8-kodierte Umlaute im Code (Bug: Datei wurde zweimal UTF-8-encodiert)
grep -rnE "Ã[¤¶¼„–œß]" src/ docs/ prisma/ 2>&1 | head -30

# HTML-Entities im Code (sollten direkte UTF-8-Zeichen sein)
grep -rnE "&(auml|ouml|uuml|Auml|Ouml|Uuml|szlig);" src/ --include="*.ts" --include="*.tsx" 2>&1 | head -30

# Latin-1-Escape-Sequenzen (0xC3 0xA4 statt ae-kodiert)
grep -rnP "\\\\u00[e-f][0-9a-f]" src/ 2>&1 | head -20

# Inkonsistenz: manche Dateien schreiben "ae/oe/ue" (Transliteration), andere echte Umlaute
# Wichtig: In CODE-Kommentaren ist ae/oe/ue nach Convention OK, in UI-Strings NICHT.
grep -rE "\"[^\"]*(ae|oe|ue|ss)[^\"]*\"" src/app 2>&1 | grep -v "// " | head -40
```

### Ebene 2: DB-Scan (gespeicherte Daten)

```bash
docker exec ma-nagement-db psql -U ma_nagement -d ma_nagement -c "
SELECT 'User.firstName' AS field, \"firstName\" FROM \"User\" WHERE \"firstName\" ~ '[ÃÂ]' LIMIT 10;
SELECT 'User.lastName', \"lastName\" FROM \"User\" WHERE \"lastName\" ~ '[ÃÂ]' LIMIT 10;
SELECT 'User.street', \"street\" FROM \"User\" WHERE \"street\" ~ '[ÃÂ]' LIMIT 10;
SELECT 'Restaurant.name', name FROM \"Restaurant\" WHERE name ~ '[ÃÂ]' LIMIT 10;
SELECT 'Announcement.title', title FROM \"Announcement\" WHERE title ~ '[ÃÂ]' LIMIT 10;
SELECT 'ChatMessage.content', LEFT(content, 60) FROM \"ChatMessage\" WHERE content ~ '[ÃÂ]' LIMIT 10;
"
```

### Ebene 3: Rendering-Scan (via preview_snapshot + preview_screenshot)

Fuer jede der 70+ App-Pages: Snapshot abrufen, per `grep -E "Ã[¤¶¼„–œß]|&(auml|ouml|uuml);"` scannen.

### Ebene 4: PDF-Scan (Export-Artefakte)

Fuer jedes generierte PDF (Kassenbuch, DATEV, XRechnung, BGN-Meldung, NIS2-Meldungen, BR-Info, Pay-Gap-Report):

```bash
# PDF -> Text + Grep
pdftotext /tmp/exported.pdf - 2>&1 | grep -E "Ã[¤¶¼„–œß]|\?\?\?|□"
```

### Ebene 5: E-Mail-Scan (falls SMTP konfiguriert)

Nodemailer-Templates pruefen:

```bash
grep -rnE "Ã[¤¶¼„–œß]|&(auml|ouml|uuml);" src/lib/ 2>&1 | grep -iE "(mail|template|subject|body)" | head -20
```

**Alle Mojibake-Findings werden als KATEGORIE: UMLAUT_MOJIBAKE in der finalen Tabelle gelistet.**

---

## PHASE 3: WORKFLOW-E2E-VERIFIKATION (kritische Flows)

Nach den Agent-Tests werden 10 **kritische End-to-End-Workflows** explizit durchgespielt. Jeder Flow bekommt ein Pass/Fail + Detail-Log. Diese Workflows sind geschaeftskritisch — wenn einer bricht, darf die App NICHT live gehen.

| # | Workflow | Rolle | Ziel |
|---|---|---|---|
| W1 | Neuer MA Onboarding | Owner | Vollstaendiges Profil + Erste Schicht + IfSG-Belehrung + PIN-Setup |
| W2 | Schicht-Full-Cycle | Manager → Employee | Schicht planen → zuweisen → MA stempelt ein → Pause → aus → Stunden korrekt |
| W3 | Urlaubs-Cycle | Employee → Manager | MA antragt → Manager genehmigt → MA bekommt Push → Kalender zeigt |
| W4 | Krankheits-Cycle | Employee → Manager | MA meldet krank + Attest → Overlapping-Urlaub automatisch zurueckgebucht |
| W5 | Kassen-Tag-Close | Owner | Kassenbuch-Eintraege + TSE-Signatur + Day-Close + GoBD-Hash-Chain |
| W6 | Payroll-Generation | Owner | Monats-Payroll-Export mit Zuschlaegen + 13-Wochen-Durchschnitt + DATEV-CSV |
| W7 | Chat-Kommunikation | Manager → Employees | Gruppen-Chat + DM + File-Upload + E2E-Verschluesselung |
| W8 | Compliance-Autopilot-Abarbeitung | Owner | 22 offene Warnungen → Einzelne bestaetigen/abarbeiten → Counter sinkt |
| W9 | DSGVO-Subject-Request | Employee | Eigene Daten exportieren (Art. 20) → JSON mit allen Feldern inkl. verschluesselter |
| W10 | Incident-Response | Owner | Simulierten Data-Breach anlegen → ENISA-PDF + BSI-PDF generieren → Timestamps |

Jeder Workflow wird mit EXAKTEN Klick-Sequenzen dokumentiert, sodass er nach einem Bugfix als Regression-Test wiederholt werden kann.

---

## PHASE 4: API-AUDIT (separate Sub-Phase)

Alle 30 API-Routen (`src/app/api/**/route.ts`) werden via `curl` getestet:

1. **Ohne Auth** → erwartet 401 oder 403 (bei Cron-Routes + Token-Routes Auth-Check).
2. **Mit valid Auth** → erwartet 200/201/204 bei GET/POST/PUT/DELETE.
3. **Cross-Tenant** → Login als User aus Tenant A, Request auf Resource von Tenant B → 404 (nicht 403, Enumeration-Schutz).
4. **Rate-Limit** → 10 Requests in 10s → erwartet 429 nach N Versuchen.
5. **Input-Fuzz** → Invalid Payload, riesige Payload (10MB+), SQL-Injection-Strings, XXE — erwartet 400/413/415 mit strukturierter Error-Response.

---

## KONSOLIDIERUNG

Nach Abschluss aller 12 Agenten + Phase 2 (Umlaut-Scan) + Phase 3 (E2E-Workflows) + Phase 4 (API-Audit):

1. **Deduplizierung:** Findings die in mehreren Agenten auftauchen (z.B. Umlaut-Fehler auf globalem Layout → erscheint bei allen Agenten) zusammenfuehren.
2. **Severity-Rescoring:** Jedes Finding auf Go-Live-Kritikalitaet rescoren:
   - **CRITICAL (Blockiert Go-Live):** Login funktioniert nicht, Kassenbuch bricht ab, TSE-Signatur fehl, DSGVO-Export crashed, Daten gehen verloren.
   - **HIGH (Sollte vor Go-Live):** Wichtiger Workflow bricht, Autopilot-Warnung fehlt, Cross-Tenant-Sichtbarkeit, sichtbares Mojibake in Export-PDFs.
   - **MEDIUM (Sollte in Woche 1 gefixt):** UI-Glitch, fehlende Validation, Empty-State unklar, Performance-Problem.
   - **LOW (Nice-to-have):** Cosmetic, A11y-Minor, Console-Warning ohne Impact.
   - **COSMETIC:** Tippfehler, Farbgebung, Abstaende.
3. **Workflow-Matrix:** Tabelle W1-W10 mit Pass/Fail.
4. **API-Matrix:** 30 Routes mit Status (200/401/403/404/429/500).
5. **Umlaut-Heatmap:** Alle Mojibake-Findings gruppiert nach Datei/Zeile/Scope.
6. **Rollen-Matrix:** Fuer jedes Finding: Betrifft Owner/Manager/Employee/Public?
7. **Go-Live-Recommendation:** AMPEL ROT (Critical offen) / AMPEL GELB (nur HIGH+) / AMPEL GRUEN (nur MEDIUM/LOW).

**Der Konsolidierungsbericht wird als `docs/audits/YYYY-MM-DD-funktionsaudit.md` gespeichert.**

---

## ABSCHLUSS-TABELLE (zwingender Output-Format)

Am absoluten Schluss des Main-Agent-Berichts steht eine /tabelle nach folgendem Muster:

```markdown
## 🚨 Findings-Tabelle (sortiert nach Severity)

| # | Severity | Kategorie | Seite | Element | Ist-Zustand | Erwartet | Fix-Hinweis |
|---|---|---|---|---|---|---|---|
| 1 | 🔴 CRITICAL | BROKEN_WORKFLOW | /scheduling | "Schicht anlegen"-Button | Click → 500-Error | Modal oeffnet sich + Form | src/actions/shift-crud.actions.ts:xx Prisma-Query fehlerhaft |
| 2 | 🟠 HIGH | UMLAUT_MOJIBAKE | /staff/[id] | MA-Name "Müller" | Shows "M&uuml;ller" | "Müller" | src/components/staff/*.tsx — HTML-Entity-Decode fehlt |
| 3 | 🟡 MEDIUM | CONSOLE_ERROR | /dashboard | Keine | React-Key-Warning | - | src/components/dashboard/*.tsx — key-Prop ergaenzen |
| … | … | … | … | … | … | … | … |
```

Plus:
- **Workflow-Matrix** (W1-W10 Pass/Fail)
- **API-Matrix** (30 Routes mit Status)
- **Rollen-Coverage** (wie viele Findings pro Rolle)
- **Umlaut-Heatmap** (wo treten Mojibake-Fehler gehaeuft auf)
- **Go-Live-Ampel** mit Begruendung

---

## META-ANWEISUNG: VERHALTEN BEI UNSICHERHEIT

Wenn ein Agent unsicher ist, ob etwas ein Bug ist oder "by design":
1. NIEMALS stillschweigend als "OK" markieren.
2. Als **HINWEIS** mit Titel "Verifikation empfohlen" dokumentieren.
3. Explizit die Daten sammeln, die eine Entscheidung erlauben wuerden (Screenshot, DB-Status, Code-Lookup).
4. Empfehlung geben, welche weitere Pruefung (Designer/Product-Owner-Ruecksprache, Daten-Check, User-Test) den Zweifel aufloesen koennte.

Das Audit endet NIEMALS mit "alles sauber" — es endet mit einer vollstaendigen Liste aller geprueften Workflows + einer klaren Aussage, welche nicht abschliessend bewertet werden konnten.

Denke daran: Die App geht morgen live. Dokumentiere den exakten Git-Commit-Hash zu Beginn des Audits und den Zustand der Demo-Daten (z.B. `SELECT COUNT(*) FROM "User"` etc.). Bei einem spaeteren Regression-Test nach Bugfix soll das Audit auf derselben Baseline wiederholbar sein.

---

## STANDARDS-REGISTER (Getestete Aspekte)

| Bereich | Standards & Prueffragen |
|---|---|
| UI-Funktionalitaet | Alle Links + Buttons + Dropdowns + Accordions + Modals funktional; keine toten Klicks; keine 404/500 bei Navigation |
| Formular-Validation | Pflichtfelder erzwungen; Client-Side + Server-Side-Validation konsistent; Fehlermeldungen in Deutsch; Zod-Schema angewandt |
| Workflows | Alle 10 kritischen E2E-Flows laufen durch; Zwischen-Zustaende nachvollziehbar; Audit-Log fuer jede relevante Aktion |
| Umlaute & i18n | Keine Mojibake in Code/DB/UI/PDF/E-Mail; UTF-8-BOM in CSV; deutsche Datums- + Zahlenformate; Umlaute in Formular-Eingaben persistent |
| Accessibility | ARIA-Labels; Fokus-Reihenfolge; Tab-Navigation; Alt-Texte; Kontrast; Screen-Reader-Tauglichkeit (Baseline) |
| Error-States | Error-Boundaries greifen; 404-Page zeigt sich; 500-Error fuehrt nicht zu Whitescreen |
| Loading-States | Spinner/Skeleton waehrend async Loads; keine Flashes; Suspense sauber |
| Empty-States | "Keine Daten vorhanden"-Platzhalter + Call-to-Action statt leerer Seite |
| Mobile-Responsive | Bottom-Nav greift; Sidebar wird zu Burger; Touch-Targets >=48x48px |
| Rollen-Separation | Owner sieht alles; Manager sieht Team-Scope; Employee sieht Self-Scope; keine Privilege-Leaks |
| Performance | Keine Seiten >3s LCP; keine render-blocking Resources; Lazy-Load bei grossen Listen |
| Console & Network | Keine Error-Logs im Normalbetrieb; keine 4xx/5xx-Responses auf den Happy-Paths |
| PDF-Exports | Alle 8 PDF-Generatoren (Kassenbuch, DATEV, XRechnung, BGN, ENISA, NIS2 x3, BR-Info, Pay-Gap) fehlerfrei mit korrekten Umlauten |
| DSGVO-Workflows | Art. 15 Export, Art. 17 Loeschung, Art. 20 Portabilitaet komplett + korrekt anonymisiert |
| GoBD/TSE | Hash-Kette lueckenlos; Storno als neuer Eintrag; TSE-Signatur-Fehler blockiert; DSFinV-K-Export korrekt |
| Audit-Trail | Jede relevante Aktion loggt via `logAudit()`; Audit-Log ist immutable (Trigger); verifyAuditChain() laeuft durch |

---

## PFLICHT-OUTPUT-TABELLE (am Ende JEDES Audit-Reports)

**ZWINGENDE DOPPELVERIFIKATIONS-REGEL:** Die End-Tabelle enthaelt NUR Findings,
die alle vier Verifikations-Schritte durchlaufen haben:

1. **Reproduktion** mit konkreter Klick-Sequenz + Screenshot/Snapshot + Console/Network-Log
2. **Scope-Analyse** — tritt der Bug nur in bestimmter Rolle / Browser-Zustand /
   Datenkonstellation auf, oder systematisch? Mit Beleg
3. **Root-Cause-Einordnung** — mutmassliche Ursache mit Datei:Zeile lokalisiert
   (Server-Action, Client-Component, Zod-Schema, Prisma-Query, Translation, CSS)
4. **Nicht-Techniker-Erklaerung** — wie fuehlt sich der Bug fuer den User an?
   Welche Folge? (Owner findet nichts / MA bricht ab / Bussgeld-Risiko bei Mojibake-PDF)

Findings, die nicht alle 4 Schritte durchlaufen haben, kommen **nicht** in die
End-Tabelle. Sie werden — falls inhaltlich relevant — unter einem separaten
Abschnitt "⚠ Hinweise (nicht doppelt verifiziert, vor Sprint-Aufnahme pruefen)"
gelistet, nicht vermischt.

Jeder finale Audit-Bericht MUSS am Ende eine Markdown-Tabelle im **/tabelle**-Skill-Format
enthalten. Format ist verbindlich:

```markdown
| # | Severity | Kategorie | Workflow/Element | Seite | Erwartet | Ist | Erklaerung |
|---|----------|-----------|------------------|-------|----------|-----|-----------|
| F-001 | HIGH | BROKEN_WORKFLOW | IfSG-Sperre bei Reminder-Row | /scheduling | Block bei alter Belehrung | Schicht zugewiesen trotz Sperre | NULLS-FIRST-Bug: Reminder-Row mit issuedAt=null wird zuerst returned, Block uebersprungen → Bussgeld-Risiko §73 IfSG bis 25.000 EUR |
| F-002 | CRITICAL | BROKEN_WORKFLOW | Multi-Tenant-Header-Spoofing | /api/calendar/[token] | host-derive Slug | x-tenant-slug-Header akzeptiert | Cross-Tenant-Total-Leak via Client-Header. DSGVO Art. 32 bis 20 Mio EUR. |
```

PFLICHT: Direkt unter der Tabelle 5 Bloecke:

**Statistik:**
```
CRITICAL: X | HIGH: X | MEDIUM: X | LOW: X | COSMETIC: X
```

**Workflow-Status WF-1 bis WF-15:**
| Workflow | Status |
|----------|--------|
| WF-1 Login + 2FA | ✅ funktioniert |
| WF-13 Pflicht-Aushaenge-E2E | ⚠️ Edge-Case |
| WF-14 IfSG-Sperre-E2E | ❌ Bug |
| WF-15 Multi-Tenant-Subdomain-E2E | ✅ funktioniert |

**Mojibake-Befunde:** Liste pro Datei/Bereich mit Code-Zitat (Ã¤/Ã¶/Ã¼ etc.).

**Multi-Tenant-Subdomain-Tests:** Tabelle mit Host-Header → Erwartung → Ist-Resultat.

**Top-10 Production-Blocker (sortiert nach Severity x Reproduzierbarkeit):**

**Erklaerung-Spalte: Pflicht-Inhalte:**
- Konkreter Schritt-fuer-Schritt-Reproduktion (nicht "ein Klick irgendwo")
- Was sieht der User? (Toast-Text, Console-Error-Code, Network-Status)
- Wie fuehlt sich der Bug an? (Owner findet nichts, MA bricht ab, etc.)
- Bei rechtlich/sicherheitsrelevant: Bussgeld-/CVE-Hinweis
