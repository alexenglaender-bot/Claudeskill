---
name: uiaudit
description: >
  Fuehrt ein umfassendes User-Experience-Audit der Ma-Management-App aus der
  Perspektive echter Gastro-Nutzer durch. 12 spezialisierte UX-Agenten navigieren
  systematisch durch jede Seite und jeden Workflow und bewerten: ist das UI
  konterintuitiv oder zu komplex? Sind wesentliche Informationen auf einen Blick
  sichtbar? Sind Funktionen dort, wo man sie erwartet? Ist die Sprache
  verstaendlich? Funktionieren kritische Ablaeufe auch unter Zeitdruck? Sind die
  Einstellungen ausreichend anpassbar? Besonderer Fokus liegt auf Zielgruppen-
  Diversitaet der Gastronomie: Owner (Mitte 40-60), Kueche (oft Mitte 50+,
  teilweise nicht-Muttersprachler), Service (17-30, schnelle Bedienung),
  Buchhaltung (50+, praezise). Use this skill whenever the user says "/uiaudit",
  "UI-Audit", "UX-Audit", "Usability-Test", "User-Experience-Audit",
  "Konterintuition-Check", "Klarheits-Audit", "Verstaendlichkeits-Audit",
  "Stress-Test-UX", "Informations-Hierarchie", or asks whether the app is
  intuitive, too complex, fits mental models, works under pressure, works for
  older users. This is the most thorough UX audit available: every page
  evaluated against user expectation, every workflow simulated under stress,
  every setting asked "kann das ein 55-Jaehriger nach 5 min Einarbeitung?".
---

# UI/UX-Audit: Umfassendes User-Experience-Audit der Ma-Management-App

**Stand 2026-04-28** — Multi-Tenant Phase 2.5 + Multi-Restaurant-Memberships (Organization
mit 1+ Restaurants, area_manager-Rolle), Pflicht-Aushaenge-Modul (40+ Aushaenge unter
/recht?tab=aushaenge + MA-View /account/meine-rechte), Compliance-Autopilot-Widget am
Dashboard, Schwerbehindertenquote-Tracker. 14 Demo-Accounts.

## APP-AKTUALITAETS-PRUEFUNG (Phase 0a, vor Audit-Start)

Vor jedem Audit-Start MUSS der Main-Agent verifizieren:

1. `ls src/app/(app)/recht/page.tsx src/app/(app)/account/meine-rechte/` — Pflicht-Aushaenge-
   Modul aktiv? → Persona-3-Test (Gueler) auf MA-View pflicht
2. `grep "area_manager" src/lib/roles.ts` — Multi-Restaurant-area_manager-Rolle definiert?
   → Persona-5 (Marcus Bauer) Tests pflicht
3. `docker exec ma-nagement-db psql -U ma_nagement -c "SELECT COUNT(*) FROM \"Restaurant\";"` —
   bei mind. 2 Restaurants im Default-Tenant: Multi-Restaurant-Switcher-Tests pflicht
4. `ls src/components/compliance/` — Components fuer Pflicht-Aushaenge-Modul vorhanden?
5. Stand-Datum aktualisieren auf heute

## ZWEI ZUSAETZLICHE PERSONAS (seit 2026-04-28)

### Persona 4: Reinhard Lohrmann — Buchhalter (Steuerberater-Portal)
- 62 Jahre, Steuerberatungs-Buero, Kunde von Tanjas Cafe seit 8 Jahren
- Windows-PC + DATEV Unternehmen Online + Outlook
- Erwartet ASCII-DATEV-Format, keine Excel-Macros, keine Mojibake-Umlaute
- **Killer-Moment:** Quartalsabschluss 31.03., 23:30 Uhr — DATEV-Datei laedt nicht oder
  enthaelt `Ã¤`-Mojibake → DATEV-Import bricht → Tanja kriegt panischen Anruf

### Persona 5: Marcus Bauer — Bezirksleiter (area_manager)
- 35 Jahre, BWL-Studium, betreut "Cafe Roma" (3 Standorte: HD-Sued, HD-Mitte, MA-Quad)
- iPad Pro + iPhone 16, beide neu
- Will VERGLEICHENDE Sicht: "Welche Standorte sind unterbesetzt?"
- **Killer-Moment:** Montagmorgen 7:00 Uhr, schaut auf Compliance-Status aller 3 Restaurants —
  wenn er pro Restaurant separat einloggen muss, bricht er nach 2 Wochen ab und wechselt zu
  Personio.

**Jedes Finding wird ab 2026-04-28 gegen ALLE 5 Personas evaluiert.** Multi-Restaurant-
Funktionen: Marcus Bauer ist staerkster Beurteiler. Steuerberater-Portal: Reinhard Lohrmann.

## ANTI-SPAR-PROTOKOLL (NICHT VERHANDELBAR)

**Dieser Skill ist explizit so designt, dass Spar-Strategien VERBOTEN sind. Der
Fokus liegt zu 100 % auf Gruendlichkeit, nicht auf Geschwindigkeit oder Tokens.
Verstoesse machen das Audit wertlos und sind disqualifizierend.**

Folgende Praktiken sind ausdruecklich UNTERSAGT:

1. **Keine Stichproben.** Jede Seite, jedes Modul, jeder Workflow im Pruef-Umfang
   MUSS vollstaendig durchlaufen werden. "3 von 12 Stress-Szenarien" reicht NICHT —
   alle 12 simulieren, mit allen 5 Personas.
2. **Keine Agenten-Reduktion.** Wenn der Skill 12 Agenten vorsieht, MUESSEN 12 Agenten
   dispatched werden. Nicht "die 4 wichtigsten" — alle 12, parallel in 3-4 Batches.
3. **Keine "wahrscheinlich-OK"-Verzichte.** Kein Agent darf einen Workflow mit
   "wirkt intuitiv" abkuerzen. Verifikation = konkrete Klick-Sequenz + Screenshot.
4. **Keine Token-Sparmassnahmen.** Kein Truncate, kein "Rest analog", kein
   "siehe oben". Jeder Befund mit allen Pflichtfeldern aus dem OUTPUT-FORMAT.
5. **Keine Zeitlimit-Anpassung.** Wenn das Audit 3 Stunden braucht, wird es 3 Stunden
   gemacht. Knapp werdendes Token-Budget → User-Meldung, nicht Audit-Verkuerzung.
6. **Keine Selbst-Bewertung als "gut genug".** Der Skill definiert Vollstaendigkeit
   (Personas-Coverage, Stress-Szenarien, Erwartungskonform-OK-Liste). Erfuellen
   oder Audit ist nicht abgeschlossen.
7. **Keine Vorab-Annahmen.** Kein "der Owner-Wizard war doch in Sprint 8 fertig" —
   frisch nachsehen. Skills altern, Code altert, Personas-Bedarf aendert sich.
8. **Falsch-Negativ-Vermeidung ist genauso wichtig wie Falsch-Positiv-Vermeidung.**
   Die "Erwartungskonform-OK"-Liste MUSS mindestens so lang sein wie die Findings-Liste.

Verstoesse haben reale Konsequenzen — eine uebersehene UX-Falle bei Freitag-19:30-Stress
bedeutet, der Gastro-Betreiber bricht den Test ab und der Konkurrent gewinnt den Lead.
Der Skill optimiert auf **Gruendlichkeit zu 100 %**.

Wenn der Agent in Versuchung ist hier zu sparen: lies diesen Block erneut.

---

## GRUNDSAETZLICHE ANWEISUNGEN

Du fuehrst ein UX-Audit auf dem Niveau eines Senior-UX-Researchers (IDEO-Level)
in Kombination mit einem erfahrenen Gastro-Consultant durch. Du hast selbst
10 Jahre in der Gastronomie gearbeitet (vom Ausraeumen der Spuelmaschine bis
zur Betriebsleitung). Du weisst, wie es sich anfuehlt, wenn Freitag 19:30 der
komplette Laden voll ist, die Kasse piept, eine MA ploetzlich krank wird und
die Software genau in diesem Moment zickig reagiert.

**KRITISCHE REGEL: Effizienz mit Zeit oder Tokens ist absolut fehl am Platz.**
Gastro-Betreiber entscheiden sich in den ersten 15 Minuten Nutzung, ob sie bei
der App bleiben oder abbrechen. Eine einzige konterintuitive Platzierung, ein
einziger "Wo ist denn jetzt der Button?"-Moment, eine einzige kryptische
Fehlermeldung kann Kunden verlieren. Jede Seite MUSS in der Rolle eines echten
Nutzers durchgespielt werden. Kein Ueberfliegen, kein "der Entwickler hat sich
schon was dabei gedacht", kein "das ist Standard so".

**Jede Seite und jeder Workflow wird DREIFACH bewertet:** einmal als Owner
(strategisch, Mitte 45, Excel-versiert), einmal als Service-MA (operativ,
schnell, 22), einmal als Kuechenhilfe (50+, tuerkisch als Muttersprache, Handy
mit einer Hand beim Schnippeln bedient). Wenn eine dieser drei Personas
stolpert, ist das ein Finding.

**DREIFACHE VERIFIKATION pro Finding:**
1. **Reproduktion:** Agent dokumentiert die konkrete Klick-Sequenz + Screenshot,
   auf der das UX-Problem sichtbar ist
2. **Persona-Impact:** Agent benennt welche der drei Personas (Owner /
   Service-MA / Kuechenhilfe) am staerksten betroffen sind und warum
3. **Benchmark:** Agent zeigt, wie andere bekannte Apps (Planday, DATEV,
   Personio, Apple Wallet, WhatsApp) dieselbe Situation loesen

**FALSCH-POSITIV-VERMEIDUNG:** Ein Finding wird NUR gemeldet, wenn:
- Eine konkrete Persona nachweislich gestoert wird (nicht "Entwickler-Geschmack")
- Die Klick-Sequenz + Screenshot das Problem zeigt
- Der Fix den Aufwand wert ist (10 h Entwicklung fuer 1 Wort-Aenderung = HINWEIS
  nicht HIGH)

**FALSCH-NEGATIV-VERMEIDUNG:** Jeder Agent pflegt eine "Erwartungskonform-OK"-Liste.
Diese muss mindestens so lang sein wie die Findings-Liste. Gutes UX soll
explizit bestaetigt werden, nicht stillschweigend akzeptiert.

**OUTPUT-FORMAT pro Finding:**

```
FINDING [AGENT-XX-YY]
SEVERITY: CRITICAL | HIGH | MEDIUM | LOW | HINWEIS
KATEGORIE: KONTERINTUITIV | INFO_OVERLOAD | STRESS_FAILURE | FALSCHER_ORT |
  UNVERSTAENDLICH | ALTERSDISKRIMINIEREND | NO_UNDO | FEHLENDES_FEEDBACK |
  INKONSISTENT | MOBILE_BROKEN | NICHT_KONFIGURIERBAR | UNCLEAR_STATE |
  LANGUAGE_BARRIER | COGNITIVE_LOAD | HIDDEN_FUNCTION
SEITE/ROUTE: [exakte URL + Rolle]
ELEMENT: [Selector, ARIA-Label oder Beschreibung]
PERSONA-IMPACT: [Welche Persona — und was fuehlt sie?]
ERWARTUNG: [Was der Nutzer erwartet, basierend auf Mental Model]
IST: [Was tatsaechlich passiert]
BENCHMARK: [Wie andere Apps das loesen, falls bekannt]
STRESS-SZENARIO: [In welchem Gastro-Alltagsmoment wird dieses Problem akut?]
FIX-VORSCHLAG: [Konkreter Umbau — UI-Wireframe als Prosa oder Code-Hinweis]
AUFWAND: [XS (5 min) | S (1 h) | M (halber Tag) | L (1-2 Tage) | XL (Woche)]
PRIORITAET: [Klein-Effekt/Klein-Aufwand = erst / Gross-Effekt/Gross-Aufwand = danach]
```

---

## DIE DREI GASTRO-PERSONAS

Jeder Agent muss pro Finding klar machen, welche dieser drei Personas am
staerksten betroffen ist:

### Persona 1: Tanja Weber — Betriebsinhaberin (Owner)
- 47 Jahre, BWL-Studium, Cafe-Inhaberin seit 12 Jahren mit 14 MA
- Nutzt die App auf MacBook + iPhone 14
- Excel-fit, kennt DATEV, hat schon 2 Personalsysteme ueberlebt
- Ziel: morgens Uebersicht "was ist in der Nacht passiert", Schichtplanung,
  Monatsabschluss
- Frustrationstoleranz: hoch, aber null Zeit fuer Spielereien
- **Killer-Moment:** Steuerberater am Telefon: "schick mir bitte noch eben die
  DATEV-Datei vom Maerz" — wenn Tanja das in >2 Minuten nicht findet, schreit sie

### Persona 2: Lukas Schmidt — Barkeeper/Service (Employee)
- 22 Jahre, Bachelorand, arbeitet 20 h/Woche
- Nutzt nur Android-Phone (Samsung A52, nicht neu)
- Extrem schnell bei Touch-Bedienung, erwartet Swipes + Gestures
- Will morgens sehen "welche Schicht habe ich heute" + einstempeln
- **Killer-Moment:** Im Bus zur Arbeit, 3 Minuten vor Schichtbeginn — merkt dass
  er krank ist, muss sich kurz krankmelden + Kollegen finden, der uebernimmt

### Persona 3: Gueler Oezdemir — Kuechenhilfe (Employee, 50+)
- 58 Jahre, tuerkisch als Muttersprache, Deutsch gut aber nicht perfekt
- Nutzt ein altes iPhone SE, klein
- Vermeidet Tippen, bevorzugt Klicken. Presbyopie: liest kleine Schrift schlecht
- Ziel: am Monatsanfang "wie viele Stunden hab ich letzten Monat gearbeitet"
  sehen. Eigene PIN fuer Kiosk-Terminal beim Dienstbeginn eingeben.
- **Killer-Moment:** Vor dem Arbeitsbeginn, 6:00 Uhr, am Terminal — schafft die
  PIN-Eingabe nicht weil die Ziffer-Buttons zu klein sind und "nochmal" heisst
  komischerweise "erneut versuchen"

---

## KRITISCHE GASTRO-STRESS-SZENARIEN

Jeder Agent MUSS mindestens diese 10 Szenarien explizit abarbeiten (gilt fuer
den eigenen Scope):

| # | Szenario | Zeit-Druck | Mental-Load |
|---|----------|-----------:|------------:|
| S1 | Freitag 19:30, 3 Tische gleichzeitig, MA-X meldet sich krank | 30 sek | hoch |
| S2 | Monatsletzter, Steuerberater-Call, DATEV-Datei versenden | 2 min | mittel |
| S3 | Neue MA-Einarbeitung, PIN + IfSG + Vertrag in 10 min | 10 min | hoch |
| S4 | Montag 9:00, 12 Urlaubsantraege vom Wochenende sichten | 5 min/Antrag | mittel |
| S5 | Abendgeschaeft, Kassensturz + Tagesabschluss | 15 min | mittel |
| S6 | Ehemalige Mitarbeiterin fordert DSGVO-Export an | 5 min | niedrig |
| S7 | Arbeitsunfall (Kueche, Schnitt), BGN-Meldung binnen 3 Tagen | 30 min | hoch |
| S8 | Wareneingang, LKW steht, Lieferschein + Temperatur erfassen | 60 sek | mittel |
| S9 | Manager-Vertretung: Kollege ist krank, muss Schichtplan sehen koennen | 30 sek | hoch |
| S10 | Terminal-Einstempeln bei Schichtwechsel (5 MA in 2 min) | 60 sek total | niedrig-MA, hoch-Warteschlange |

---

## VORBEREITUNG (PHASE 0 — vom Main-Agent)

Identisch zum Funktionsaudit:
1. `mcp__Claude_Preview__preview_list` — `next-dev`-Server laeuft? Sonst starten.
2. Demo-Passwoerter ok? Sonst `npx tsx scripts/reset-demo-passwords.ts`
3. Rate-Limit leer? `DELETE FROM "RateLimitEntry"` falls Tests gebremst werden.
4. Demo-Accounts bereit: `admin@mabar.com/demo1234` (owner), `sarah@mabar.de`
   (management), `tom@mabar.de` (employee), PIN `1234`.
5. Baseline-Snapshot jeder Rolle.

---

## DURCHFUEHRUNG

12 spezialisierte UX-Agenten werden **parallel** dispatched. Jeder schreibt
sein Rohmaterial nach `docs/audits/YYYY-MM-DD-uiaudit-agentXX.md`. Nach
Abschluss: Konsolidierungsbericht unter `docs/audits/YYYY-MM-DD-uiaudit.md`.

Jeder Agent bekommt Zugriff auf Grep, Glob, Read, Bash und die Preview-Browser-
Tools (preview_snapshot, preview_screenshot, preview_click, preview_fill,
preview_console_logs, preview_network, preview_eval).

---

### AGENT 1: Erste-Kontakt-Klarheit & Dashboard-Ersteindruck

**Die Grundfrage:** Kann ein Gastro-Owner der die App zum ersten Mal oeffnet
innerhalb von 60 Sekunden erkennen, welche 3 Dinge heute wichtig sind?

**Scope:**
- `/login` (Erster Touchpoint)
- `/dashboard` (primaerer Landing-Point fuer jede Rolle)
- Onboarding-Tour, Empty-States, Welcome-Banner
- Sidebar-Top-Level-Navigation (erster Blick, bevor man klickt)

**Konkrete Pruefungsfragen (Persona Tanja Weber, 1. Login):**
1. Nach dem Login: was sieht Tanja ZUERST? Was ZIEHT ihren Blick?
2. Ist die Reihenfolge der Widgets an wichtigsten Business-Zahlen orientiert?
   (Umsatz > Personalkosten > Offene Schichten > Compliance-Warnungen)
3. Gibt es einen "Du hast X wichtige Aufgaben heute"-Counter der tatsaechlich
   umsetzbar ist? Oder ist "22 Dinge brauchen Aufmerksamkeit" ueberwaeltigend?
4. Gibt es Empty-States bei leerer DB die den Nutzer anleiten ("Lege deinen
   ersten MA an") oder nur langweilige "Keine Daten"-Spruchbaender?
5. Ist das Dashboard visuell beruhigend (wichtige Zahlen gross + farbig) oder
   eine Tabellen-Wuestenei?
6. Ist der Begruessungstext ("Guten Morgen, Tanja") personalisiert und richtet
   sich nach Tageszeit (morgens/mittags/abends)?

**Konkrete Pruefungsfragen (Persona Gueler Oezdemir, 6:00 Uhr, Terminal):**
1. Ist der Terminal-Kiosk-Modus auf Anhieb erkennbar als "das ist mein
   Terminal, nicht der Manager-Bereich"?
2. Klarer "Einstempeln"-Button vs. "Ausstempeln" — keine Verwechslung?
3. Bei Login-Fehler: lesbare Schrift + deutlich? Oder klein + grau?

**Dashboard-Heuristiken:**
- 5-Second-Test: Nach 5 sec Blick — was hat der Nutzer mitgenommen?
- 3-Click-Rule: Kommt er zu jeder Hauptfunktion in max 3 Klicks?
- Fitts-Law: Sind die wichtigsten Klick-Ziele gross und zentral?

**Benchmark-Apps:** Personio-Dashboard, Planday-Overview, Revolut-Business-App.

---

### AGENT 2: Informations-Hierarchie & Seiten-Dichte

**Die Grundfrage:** Ueberlaedt eine Seite den Nutzer mit zu vielen
Informationen, oder sind die 3-5 wichtigsten Dinge visuell dominant?

**Scope:**
- Alle Uebersichts-Seiten: `/dashboard`, `/staff`, `/scheduling`, `/recht`,
  `/finanzen`, `/warenwirtschaft`, `/settings`
- Detail-Seiten: `/staff/[id]`, `/scheduling/[id]`, `/arbeitsschutz/unfaelle/[id]`
- Modals & Dialogs

**Pruefungsfragen:**
1. **Kognitive Last**: Zaehle die informationstragenden Elemente auf jeder Seite.
   >12 = Overload. Pro Seite sollten 3-5 Elemente dominieren, alles andere
   hierarchisch untergeordnet sein.
2. **Visuelle Hierarchie**: Groesse + Farbe + Position signalisieren Wichtigkeit.
   Ist die groesste Zahl auf der Seite auch die wichtigste?
3. **Gestalt-Prinzipien**: Werden zusammengehoerige Infos gruppiert? Trennung
   durch Whitespace statt Linien?
4. **Progressive Disclosure**: Werden Details bei Bedarf sichtbar (Accordion,
   Drill-Down) statt alles auf einmal?
5. **Dichte-Matrix erstellen**: Pro Seite: welche Info ist absolut noetig? Welche
   nice-to-have? Welche koennte weg oder in Detail-View?

**Spezifische Hotspots:**
- Dashboard mit 10+ Widgets — wirklich alle relevant?
- Recht-Autopilot mit 22 offenen Warnungen — ist das Priorisierung oder Panik?
- Employee-Detail-View mit 7 Tabs — alles auf Blick-1 noetig?
- Kassenbuch-Liste mit 50 Spalten — was braucht ein Barkeeper wirklich?

**Anti-Pattern zu jagen:**
- Wand aus Zahlen ohne Kontext
- Farben ohne Bedeutungszuordnung
- Badge-Count ohne Klickmoeglichkeit
- Grafiken, die nicht interaktiv sind

---

### AGENT 3: Stress-Resilienz & Zeitdruck-Workflows

**Die Grundfrage:** Funktionieren die 10 kritischsten Workflows auch wenn der
Nutzer gestresst ist, eine Hand am Menue, die andere am Handy?

**Scope:**
- Die 10 Stress-Szenarien S1-S10 aus der Einleitung
- Kassenbuch, Terminal, Krankmeldung, Ausschreibung einer Schicht

**Methodik:** Fuer jedes der 10 Szenarien:
1. Stoppe die Zeit: wie lange von "App offen" bis "Aktion fertig"?
2. Zaehle die Klicks.
3. Zaehle die Mental-Load-Punkte (wie viele Entscheidungen muss der Nutzer
   treffen?).
4. Simuliere eine Unterbrechung (Anruf, Gast): kommt der Nutzer an die Stelle
   zurueck, wo er war?
5. Teste mit einer Hand (simuliert: nur Daumen auf dem Phone, linke Hand haelt
   Tablett).

**Benchmark (bekannte Zeiten):**
- WhatsApp Nachricht: 10 sec von Screen-On bis "Nachricht gesendet"
- Apple Pay: 3 sec von Screen-On bis "Payment success"
- Uber Eats: 40 sec von App-Oeffnen bis "Bestellung abgeschickt"
- Planday Clock-in: 5 sec

**Findings-Beispiele:**
- "Krankmeldung" braucht 8 Klicks + Attest-Upload (UX-F03 HIGH)
- Tagesabschluss-Dialog hat 14 Felder die alle Pflicht sind (UX-F05 MEDIUM)
- Schicht ausschreiben fuehrt ueber 3 verschiedene Dialoge (UX-F01 HIGH)

**Anti-Pattern:**
- Pflichtfelder die nicht erklaert sind
- Multi-Step-Wizards ohne Progress-Indikator
- Dialoge die sich schliessen wenn man zur Seite scrollt
- "Bist du sicher?"-Dialog nach jedem Klick

---

### AGENT 4: Terminal-Kiosk-Usability (Physischer Zugang, schnelle Bedienung)

**Die Grundfrage:** Kann Gueler Oezdemir, 58, um 6:00 Uhr morgens vor dem
Schichtbeginn ihre PIN eingeben ohne zu kaempfen?

**Scope:**
- `/terminal` (Kiosk-Modus)
- PIN-Pad (pin-pad.tsx + pin-form.tsx)
- Stempel-UI (Einstempeln/Pause/Ausstempeln)
- Fehlermeldungen bei falscher PIN

**Pruefungsfragen:**
1. **Touch-Target-Groesse**: Jeder PIN-Button mindestens 56x56px auf dem kleinsten
   getesteten Display (iPhone SE = 320x568)? Apple-Human-Interface-Guidelines
   fordern 44pt, Material Design 48dp.
2. **Visueller Feedback pro Tastendruck**: Ripple, Farbaenderung, haptisches
   Feedback via vibrate API?
3. **Fehler-Behandlung bei falscher PIN**: Nur rote Umrandung? Oder auch Text?
   Wie viele Versuche bis Lockout? Wird der Lockout-Timer sichtbar?
4. **Schrift-Lesbarkeit**: Namen der MA (Auswahl) in welcher Groesse? Sans-Serif
   >18pt fuer Presbyopie?
5. **Sprach-Umschaltung**: Kann der Terminal-Screen auf TR/PL/EN umgeschaltet
   werden? (UX-140 i18n Vorbereitung)
6. **Foto + Name**: Fuer Wiedererkennung — alle MA mit Foto oder nur Namen?
7. **Dauer bis Fenster schliesst nach Einstempeln**: 12 sec Auto-Reset
   (UX-509 Fix) — noch OK, oder zu lang/kurz?
8. **Fallback fuer Geraete ohne Touchscreen** (USB-Keyboard am Raspi-Kassen-
   Tablet)?

**Szenarien zu durchlaufen:**
- Schichtwechsel 14:00 Uhr: 5 MA wollen gleichzeitig einstempeln in 2 min
- 22:30 Uhr: letzte MA stempelt mit muede + Handschuh aus
- Jemand will sich irren und erwischt die falsche Person

**Benchmark:** Supermarkt-Kassen-Scanner, ATM-PIN-Eingabe, Hotel-Tuerkarten-
Terminal, Zeiterfassung Planday Kiosk.

---

### AGENT 5: Mental Model & Informationsarchitektur

**Die Grundfrage:** Finden Nutzer Funktionen dort wo sie sie erwarten, ODER
muessen sie raten / suchen / den Support fragen?

**Scope:**
- Navigation (Sidebar, Bottom-Nav, Mobile-Header)
- Suche (falls vorhanden)
- Breadcrumbs, Back-Navigation
- Modal-Positionen

**Methodik: Card-Sorting simulieren**
Gib einer Persona (im Agenten-Head) diese 20 Fragen und pruefe, ob sie die
richtige Seite in max 2 Klicks findet:

1. "Ich will meinen Urlaub beantragen" → Persona-Antwort vs. App-Realitaet
2. "Ich will sehen wer heute da ist" → ?
3. "Ich will eine Rechnung hochladen" → ?
4. "Ich will die Kasse am Ende des Tages abschliessen" → ?
5. "Ich will einen Mitarbeiter entlassen" → ?
6. "Ich will einem neuen MA ein Passwort zusenden" → ?
7. "Ich will meine Gehaltsabrechnung vom Maerz sehen" → ?
8. "Ich will sehen, wer mich in den letzten 7 Tagen gerade kontaktiert hat" → ?
9. "Ich will einen Wareneingang aus dem Metro-Einkauf buchen" → ?
10. "Ich will den Allergen-Aushang fuer heute drucken" → ?
11. "Ich will Feiertage fuer naechstes Jahr hinzufuegen" → ?
12. "Ich will meine eigene PIN aendern" → ?
13. "Ich will sehen, welche Mitarbeiter wegen Krankheit nicht da sind" → ?
14. "Ich will einen Arbeitsunfall melden" → ?
15. "Ich will meinen Steuerberater-Zugang widerrufen" → ?
16. "Ich will sehen, wieviel Trinkgeld diesen Monat zusammenkam" → ?
17. "Ich will die letzten Chat-Nachrichten lesen" → ?
18. "Ich will die Sofortmeldung fuer einen neuen MA abgeben" → ?
19. "Ich will Pausen-Erinnerungen einstellen" → ?
20. "Ich will alle Daten meiner Organisation exportieren" → ?

Fuer jeden Fall: stimmt der Ort in der App mit der Nutzer-Erwartung ueberein?

**Anti-Pattern zu finden:**
- Funktion unter seltsamer Kategorie versteckt (z.B. "Ausweisbelehrung" unter
  "Einstellungen" statt "Mitarbeiter")
- Synonyme verwirren (Mitarbeiter vs. Personal vs. Team-Mitglied)
- Doppelte Wege (zwei verschiedene Seiten fuer die gleiche Funktion)
- Dead-End-Seiten ohne klaren Weg vorwaerts

---

### AGENT 6: Sprache, Fachbegriffe & Tonalitaet

**Die Grundfrage:** Versteht jemand ohne BWL/Jura-Studium was da steht, und
fuehlt er sich nicht dumm gemacht?

**Scope:**
- Alle UI-Labels, Ueberschriften, Button-Texte
- Fehlermeldungen, Validation-Texte
- Tooltips, Help-Boxes
- E-Mail-Templates, Push-Notifications

**Pruefungsfragen:**
1. **Fachjargon-Audit**: Werden Begriffe wie "Tenant", "Entity", "Validation",
   "Schema-Drift", "Idempotenz" im UI verwendet? Die sollten durch Alltags-
   Sprache ersetzt werden.
2. **§-Referenzen**: Werden Paragraphen (`§146a AO`, `§3b EStG`) direkt im UI
   angezeigt oder im Tooltip erklaert? Owner-Seiten duerfen das, Mitarbeiter-
   Seiten nicht.
3. **Konsistente Terminologie**: "Mitarbeiter" vs. "MA" vs. "Personal" — ein
   Wort durchgaengig benutzen.
4. **Klare Call-to-Actions**: Buttons heissen "Antrag stellen", nicht "OK". Oder
   "Urlaub jetzt eintragen", nicht "Absenden".
5. **Tonalitaet**: Freundlich, nicht kuehl. "Herzlich willkommen!" vs. "Login
   erfolgreich.".
6. **Fehlermeldungen**: Erklaeren was los ist + was zu tun ist. "Bitte waehle
   ein Datum in der Zukunft" statt "Invalid date".
7. **Positivformulierungen**: "Pause gestartet" statt "Du hast noch keine
   Arbeitszeit erfasst".
8. **Duzen vs. Siezen**: konsistent? Wer duzt wen? Owner darf Mitarbeiter duzen.
   App darf alle duzen (Social-Apps-Konvention), aber dann durchgaengig.

**Rechtliche Begriffe (sensibles Thema):**
- "IfSG-Sperre" vs. "Gesundheitliches Taetigkeitsverbot" — letzteres ist
  verstaendlicher
- "Schwerbehindertenausweis" vs. "Nachweis einer Behinderung" — erster korrekt
- "TSE-Signatur" vs. "Finanzamt-Kassensiegel" — Diskussion noetig

**Tonalitaet bei kritischen Fehlern:**
- "Etwas ist schief gelaufen, wir schauen uns das an" statt "Internal Server
  Error 500"
- "Deine Sitzung ist abgelaufen" statt "JWT expired"

**Tooltips-Audit:**
- Wird Hover nicht auf Touch-Screens getriggert — gibt es Tap-Tooltips (Info-
  Icon)?
- Tooltip-Text > 200 Zeichen = kein Tooltip mehr, sondern Help-Box.

---

### AGENT 7: Barrierefreiheit fuer aeltere Nutzer & Motorisch Eingeschraenkte

**Die Grundfrage:** Kann Gueler (58, Presbyopie, arabisches Tastaturlayout auf
ihrem iPhone) die App fluessig nutzen, oder kaempft sie ab Seite 1?

**Scope:**
- Alle mobile-facing-Seiten (Employee-Views, Terminal, my-shifts)
- Schrift-Groessen, Farbkontraste, Touch-Targets
- Fokus-Management bei Screenreader (VoiceOver iOS, TalkBack Android)

**Pruefungsfragen:**
1. **Schriftgroesse**: UI-Text minimum 14px (bevorzugt 16px), Body-Text 16px,
   Headlines 20px+. Auf welchen Seiten ist < 14px?
2. **Zeilenhoehe**: 1.5x Schriftgroesse (Blocksatz vermeiden)
3. **Kontrast-Ratio**: WCAG AA verlangt 4.5:1 fuer normalen Text, 3:1 fuer
   grosse Texte. Graue Labels (`text-foreground-muted`) — welcher Kontrast?
4. **Touch-Targets**: Minimum 44x44pt (Apple HIG), 48x48dp (Material). Icons
   ohne Label duerfen nicht < 48x48px sein.
5. **Farbe als einzige Info**: Sind wichtige Infos nur ueber Farbe kodiert
   (z.B. Rot = kritisch)? Daltonisten (8% der Maenner) sehen das nicht. Braucht
   zusaetzliche Symbole (!, X, ✓).
6. **Klick-Fokus**: Fokussierte Elemente mit sichtbarem Rahmen (nicht
   `outline: none` ohne Ersatz).
7. **Keyboard-Navigation**: Kann man die ganze App per Tab durchsteppen? Logische
   Reihenfolge?
8. **Screenreader-Labels**: `aria-label`, `role="button"` etc. fuer Icons ohne
   Text?
9. **Skip-to-Content-Link**: Fuer Screenreader-Nutzer?
10. **Timeouts**: Session-Timeout 30 min = stressig fuer aeltere Nutzer. Ist das
    konfigurierbar oder gibt es Warnung "Du wirst gleich abgemeldet"?
11. **Auto-Focus nach Klick**: Wenn ein Modal oeffnet, springt der Fokus in
    das erste Feld?
12. **Motorische Einschraenkung**: Lange Klicks, Doppelklicks, Hover-Menus —
    alles vermeiden.

**Tools:**
- Lighthouse Accessibility-Audit (Chrome DevTools)
- axe DevTools
- Wave (WebAIM)
- `preview_eval`: getComputedStyle() fuer Font-Size + Contrast

**Benchmark:** Apple Notes (gross, lesbar, einfach), WhatsApp (Alt-Persona-
optimiert), Sparkasse-Banking-App (mit Einschraenkungen: gute Praktiken).

---

### AGENT 8: Fehler-Toleranz, Undo, Recovery & Datensicherheit

**Die Grundfrage:** Was passiert, wenn der Nutzer sich vertippt? Versehentlich
geloescht? Formular abgeschickt mit falschen Daten?

**Scope:**
- Alle destruktiven Aktionen (Loeschen, Stornieren, Deaktivieren)
- Formulare (Autosave, Draft)
- Navigation (Back, Zurueck, Browser-Back)

**Pruefungsfragen:**
1. **Destruktive Aktionen**: Gibt es einen Confirmation-Dialog? Ist er klar
   beschriftet ("Wirklich loeschen? Das kann nicht rueckgaengig gemacht werden")
   oder nur "OK"/"Abbrechen"?
2. **Undo-Moeglichkeit**: Nach "gelöscht!"-Toast: gibts 10 sec-Undo-Button
   (Gmail-Style)? Oder wirklich weg?
3. **Autosave**: Langes Formular ausgefuellt — Browser stuerzt ab. Kommt der
   Inhalt zurueck?
4. **Confirm before leave**: "Sie haben ungespeicherte Aenderungen" — greift das?
5. **Input-Validation**: Ist Validierung client-side UND server-side? Wartet der
   Nutzer 3 sec fuer einen Server-Fehler bei falschem Datum, oder sieht er das
   sofort?
6. **Fuzzy-Eingaben**: Datum in verschiedenen Formaten akzeptieren (31.12.2026
   vs. 31/12/2026 vs. 2026-12-31)?
7. **Copy-Paste-Handling**: IBAN mit Leerzeichen kopiert aus der Bank — wird
   akzeptiert? Umformatiert?
8. **Session-Ablauf mitten im Formular**: Wird das eingetippte gespeichert?
   Weiterleitung auf Login + Redirect zurueck?
9. **Drag&Drop-Undo**: Bei Schicht-Drag: kann man den Drop rueckgaengig machen?
10. **Netzwerk-Abbruch**: Formular submittet waehrend WLAN weg — was passiert?
    Retry-Logik? "Offline — wird synchronisiert"?

**Anti-Pattern:**
- Delete-Button direkt neben Save-Button
- Confirmation-Dialog der zu leicht mit "Enter" bestaetigt wird
- Kein optischer Unterschied zwischen Haupt-CTA und Gefahren-Aktion
- 15-min-Session-Timeout ohne Warnung mitten in der Formular-Eingabe

---

### AGENT 9: Feedback, Status-Klarheit & Loading-States

**Die Grundfrage:** Weiss der Nutzer IMMER was gerade passiert? Dass etwas
laeuft, dass es fertig ist, dass es funktioniert hat?

**Scope:**
- Toast-Nachrichten, Banners
- Loading-Skeletons, Spinner
- Success/Error-Indikatoren
- Badge-Counts, Status-Pills

**Pruefungsfragen:**
1. **Loading-States**: Wenn ein Button geklickt wird — wird er deaktiviert +
   Spinner? Oder "klickt man 5x und kriegt 5x die Aktion"?
2. **Optimistic Updates**: Bei Toggle-Actions (MA aktivieren/deaktivieren): wird
   die UI sofort geaendert oder nach 2 sec Server-Roundtrip?
3. **Toast-Dauer**: Success-Toast 3 sec, Error-Toast 6 sec (Richtwert).
   Unterschiedliche Farben?
4. **Toast-Position**: Unten rechts (Desktop-Standard) oder oben (mobile
   besser)? Mit Close-Button?
5. **Skelett-Loaders**: Bei langen Tabellen (Schichten-Liste) werden Skeleton-
   Rows gezeigt oder leere Flaeche?
6. **Badge-Counts aktuell**: Wenn eine Warnung abgearbeitet wird, sinkt der
   Badge sofort oder erst beim naechsten Refresh?
7. **Unsaved-Changes-Indikator**: In Formularen: gibt es einen Hinweis "nicht
   gespeichert" (z.B. Title-Pattern `* Settings — Ma-Management`)?
8. **Network-Status**: Wird angezeigt wenn offline (Banner oben)?
9. **Progress-Bars**: Bei laengeren Operationen (PDF-Export 10 sec) — Progress
   oder nur Spinner?
10. **Empty-State-Qualitaet**: "Noch keine Schichten? Lege deine erste Schicht
    an!" mit CTA-Button vs. "Keine Daten vorhanden".

**Anti-Pattern:**
- Endloses Spinning ohne Abbruch-Moeglichkeit
- "Wurde gespeichert" ohne dass sich die Seite aendert
- Tausende Toasts stapeln sich untereinander
- Form-Submit-Button ohne Disabled-State

---

### AGENT 10: Konsistenz & Design-System-Audit

**Die Grundfrage:** Wirkt die App wie aus einem Guss, oder merkt man, dass sie
von 5 Leuten ueber 3 Jahre zusammengebaut wurde?

**Scope:**
- Komponenten-Konsistenz ueber alle Seiten
- Farben, Spacings, Typographie
- Icon-Set, Illustrations-Stil

**Pruefungsfragen:**
1. **Button-Styles**: Wie viele verschiedene Button-Varianten gibt es? Ein
   Primary-Button sollte auf allen Seiten gleich aussehen.
2. **Card-Layout**: Header + Content + Footer konsistent? Oder 3 verschiedene
   Card-Patterns?
3. **Tabellen**: Zebra-Streifen? Hover-Effekt? Mobile-View? Einheitlich?
4. **Icon-Set**: Nur Lucide? Oder gemischt mit Heroicons + Material-Icons?
   Groesse konsistent (z.B. 16px fuer Inline, 20px fuer Buttons)?
5. **Farben-Palette**: Semantic Colors (success/warning/danger/info) konsistent
   verwendet?
6. **Spacing-Raster**: 4px-Raster (Tailwind) konsistent? Oder willkuerliche
   margins?
7. **Typography-Scale**: Wie viele Schriftgroessen werden verwendet? >5 ist zu
   viel.
8. **Radius-Werte**: Rounded-Corners einheitlich (z.B. 4px small, 8px medium,
   12px large)?
9. **Schatten**: Shadow-Layer-System (sm/md/lg) oder wahlloses box-shadow?
10. **Form-Elemente**: Input-Labels immer ueber oder links von Input? Hints
    immer darunter?

**Tools:**
- `preview_eval`: Alle Button-Klassen einsammeln + vergleichen
- Visual-Regression-Check: Dashboard-Screenshot vs. Settings-Screenshot
- Figma/Storybook wenn vorhanden: Komponenten-Bibliothek pruefen

**Anti-Pattern:**
- Eine Datepicker-Component auf Seite A, andere auf Seite B
- Scrollable Tabs auf Mobile anders als Desktop
- Plain-HTML-Select statt Custom-Dropdown (keine Konsistenz)

---

### AGENT 11: Mobile-First, Ein-Hand-Bedienung & Scroll-Verhalten

**Die Grundfrage:** Kann Lukas (22, Samsung A52) im Bus zur Arbeit mit einer
Hand alle wichtigen Funktionen nutzen? Funktionieren die Seiten OHNE
horizontales Scrollen?

**Scope:**
- Alle employee-facing Seiten
- Bottom-Nav, Mobile-Header
- Modals, Dialogs, Formulare auf kleinem Viewport

**Pruefungsfragen:**
1. **Viewport-Tests**: Seiten bei 320px (iPhone SE), 390px (iPhone 12), 428px
   (iPhone Pro Max). Horizontale Scrollbars? Uebersprudelnde Tabellen?
2. **Bottom-Nav-Reichweite**: Alle 5 Bottom-Nav-Items in Daumen-Reichweite bei
   Ein-Hand-Bedienung? Obere Header-Buttons braucht 2 Haende — das ist
   akzeptabel, aber kritische Aktionen gehoeren nach unten.
3. **Modal-Position**: Bottom-Sheets auf mobile (statt zentrierte Modals)?
4. **Tabellen auf Mobile**: Responsive Card-Layouts statt gequetschte Tabellen?
5. **Swipe-Gesten**: Swipe zum Loeschen? Zum Tab-Wechsel? Zum Zurueck-Navigieren?
6. **Virtuelle Keyboard**: Wenn Tastatur aufgeht — verdeckt sie das aktive
   Formular-Feld? Autoscrollt der Container?
7. **Tap vs. Long-Press**: Tap = Primary-Action, Long-Press = Context-Menu.
   Konsistent?
8. **iOS Safe-Areas**: Padding fuer Notch + Home-Indicator?
9. **PWA-Readiness**: Home-Screen-Install-Prompt? Offline-Funktionalitaet?
10. **Orientation**: Funktioniert Landscape? Lock-on-Portrait wo sinnvoll?

**Konkrete Tests:**
- Schicht ansehen und bestaetigen auf iPhone SE — 1 Hand?
- Urlaubsantrag stellen auf Mobile — ohne horizontal scroll?
- Chat-Nachricht lesen + antworten mit Daumen?

**Benchmark:** Instagram, WhatsApp, Telegram — perfekte Ein-Hand-Bedienung.

---

### AGENT 12: Einstellungen & Konfigurierbarkeit

**Die Grundfrage:** Kann ein Betrieb die App an seine spezifischen Beduerfnisse
anpassen, oder muessen alle Kunden in die gleiche Schablone?

**Scope:**
- `/settings` alle Unterseiten
- Per-Organisation konfigurierbare Defaults
- Admin-Workflows fuer Setup

**Pruefungsfragen:**
1. **Betriebstyp-Flexibilitaet**: Ist die App nur fuer Cafés oder auch fuer
   Restaurant / Bar / Hotel / Foodtruck / Catering? Jeder Betriebstyp hat
   eigene Begriffe (Tisch vs. Zimmer, Kellner vs. Zimmermaedchen).
2. **Bundeslaender-Feiertage**: 16 Bundeslaender — alle Feiertage korrekt hinter-
   legt? Regionale Besonderheiten (z.B. Heilige Drei Koenige nur in BW/BY/ST)?
3. **Tarifvertraege**: MTV Gastro BW ist drin — andere (NRW, Bayern)?
4. **Rollen-Erweiterung**: Kann ein Betrieb eigene Rollen anlegen (Schichtleiter,
   Azubi, Praktikant) oder sind sie fix?
5. **Custom-Zuschlaege**: Wenn ein Betrieb einen Weihnachtsbonus zahlen will —
   wo konfiguriert man das?
6. **Benachrichtigungs-Einstellungen**: Pro Event-Typ (Schicht, Urlaub, Chat) —
   E-Mail/Push/SMS separat?
7. **Business-Hours**: Nachtgastronomie (20:00-04:00) — wird das als
   "Ueberstunde" oder "Nachtschicht" gewertet?
8. **Feiertage anderer Kulturen**: Fuer muslimische MA (Ramadan, Eid), fuer
   juedische (Rosh Hashana) — zumindest optional eintragbar?
9. **i18n**: Terminal-Sprach-Umschaltung TR/PL/EN vorbereitet? (siehe
   Grossprojekt #189)
10. **Branding**: Logo-Upload, Primaer-Farbe, Slogan pro Betrieb?
11. **Feature-Flags**: Kann ein Betrieb "Wir nutzen keinen Chat" einstellen
    und die Chat-Navigation verschwindet?
12. **Import/Export**: Kann ein Betrieb seinen Schichtplan als Excel importieren
    statt jede Schicht manuell anzulegen?

**Benchmark:** Notion (extrem konfigurierbar), Slack (Workspaces + Channels),
Shopify (Theme + Apps + Channels).

**Anti-Pattern:**
- Hardcoded-Texte die wie konfigurierbar aussehen
- "Custom"-Felder die nur der Support aktivieren kann
- Einstellungen vergraben unter 5 Klicks

---

## PHASE 2: QUERSCHNITTS-SZENARIO-TEST (nach allen 12 Agenten)

Der Main-Agent durchlaeuft nach den 12 Agenten selbst die 10 Gastro-Stress-
Szenarien S1-S10 end-to-end mit echter Zeitnahme. Jedes Szenario bekommt:
- Zeit: gemessen in Sekunden
- Klicks: gezaehlt
- Mental-Load: Anzahl Entscheidungen
- Aha-Momente: ueberraschende gute Losungen
- Stolperfallen: wo haenge ich?

Das ergibt die **Stress-Matrix** im Abschlussbericht.

---

## PHASE 3: PERSONA-WALKTHROUGHS

Der Main-Agent durchlaeuft die App als jede der 3 Personas mit einem
"First-Day-of-Work"-Szenario:

### Tanja-Walkthrough (Owner, Erster Tag nach Kauf)
1. App-Onboarding: Laedt sie durch einen Wizard oder steht sie nackt im
   Dashboard?
2. Erste MA anlegen: wie lange?
3. Erste Schicht erstellen: wie lange?
4. Erste Kassenbuch-Eintrag: wie lange?
5. Am Abend: versteht sie was sie heute gemacht hat?

### Lukas-Walkthrough (Neue Schichtkraft, First Day)
1. Onboarding-Mail erhalten, erste Anmeldung
2. Eigene erste Schicht finden
3. Krankheits-Szenario am naechsten Tag
4. Chat an den Manager
5. Gehalts-Check am Monatsende

### Gueler-Walkthrough (Kueche, Erster Tag)
1. Onboarding durch Tanja (PIN + IfSG erklaert)
2. Am Morgen: Terminal-Einstempeln
3. Mittagspause: Ausstempeln fuer Pause, wieder rein
4. Am Abend: Ausstempeln
5. Am Monatsende: Stundenueberblick

Jeder Walkthrough gibt einen **Happy-Path-Score**: wie reibungslos lief es?
1-5 Sterne. Unter 4 Sterne = Arbeit noetig.

---

## PHASE 4: 5-SECOND-TESTS

Fuer jede der 12 Haupt-Seiten: 5-Sekunden-Snapshot, dann Frage an "fiktiven
Tester": Was hast du gesehen? Was kannst du hier tun? Wie wichtig ist das hier?

Jede unklare Antwort = Finding in der Informationshierarchie.

---

## KONSOLIDIERUNG

Nach Abschluss aller 12 Agenten + Phase 2-4:

1. **Deduplizierung**: Findings aus mehreren Agenten zusammenfuehren
2. **Severity-Rescoring nach Impact x Effort Matrix**:
   - **QUICK WIN**: Kleiner Aufwand + Grosser Effekt (zuerst!)
   - **BIG BET**: Grosser Aufwand + Grosser Effekt (Roadmap)
   - **FILLER**: Kleiner Aufwand + Kleiner Effekt (Sprint-Ende)
   - **AVOID**: Grosser Aufwand + Kleiner Effekt (TODO-Grab)
3. **Personas-Matrix**: pro Finding — wen trifft's?
4. **Stress-Matrix**: pro Szenario S1-S10 — wie ist die aktuelle Performance?
5. **5-Star-Bewertung pro Hauptbereich**: Dashboard, Schichtplanung, Zeiterfassung,
   Abwesenheiten, Personal, Finanzen, Recht, Einstellungen, Chat, Terminal
6. **Top-10-Sofortmassnahmen** (Priorisiert nach Quick-Wins)
7. **Top-5-Big-Bets** (Grosse Umbauten die sich lohnen)

**Konsolidierungsbericht:** `docs/audits/YYYY-MM-DD-uiaudit.md`

---

## ABSCHLUSS-TABELLE (zwingender Output)

Am Ende des Main-Agent-Berichts steht eine Tabelle nach diesem Muster:

```markdown
## 🎯 UX-Findings (sortiert nach Quick-Win-Prioritaet)

| # | Sev | Kategorie | Seite | Persona | Ist | Soll | Effort | Impact |
|---|-----|-----------|-------|---------|-----|------|--------|--------|
| 1 | 🔴 CRITICAL | STRESS_FAILURE | /sick-leave | Lukas | 8 Klicks + Upload = 2 min | 3 Klicks = 30 sec | M | ★★★★★ |
| 2 | 🟠 HIGH | ALTERSDISKRIMINIEREND | /terminal | Gueler | PIN-Buttons 40x40px | 56x56px | S | ★★★★☆ |
| 3 | 🟡 MEDIUM | INFO_OVERLOAD | /dashboard | Tanja | 14 Widgets | 5 Core + 9 drill-down | L | ★★★☆☆ |
| … | … | … | … | … | … | … | … | … |
```

Plus die **Stress-Szenario-Tabelle**:

```markdown
## ⏱️ Stress-Szenarien

| # | Szenario | Ist-Zeit | Ziel-Zeit | Klicks | Stolperfallen |
|---|----------|---------:|----------:|-------:|---------------|
| S1 | Freitag 19:30, MA-Ausfall | 4:30 min | 0:30 min | 18 | Schicht ausschreiben dauert 3 Modals |
| S2 | DATEV-Datei fuer StB | 1:20 min | 0:30 min | 6 | Export-Button gut versteckt |
| … | … | … | … | … | … |
```

Plus **Persona-Ampel**:

```markdown
## 👥 Persona-Ampeln

| Persona | Gesamt | Dashboard | Terminal | Chat | Einstellungen |
|---------|--------|-----------|----------|------|---------------|
| Tanja (Owner) | 🟡 3.5★ | 🟢 4★ | 🟢 4★ | 🟢 5★ | 🟡 3★ |
| Lukas (Service) | 🟢 4.0★ | 🟢 4★ | 🟢 5★ | 🟢 5★ | 🟡 3★ |
| Gueler (50+ Kueche) | 🟡 3.0★ | 🟡 3★ | 🟠 2★ | 🟡 3★ | 🔴 1★ |
```

Eine Persona < 3★ bei einem Hauptbereich = Pflicht-Sprint vor Go-Live.

---

## WICHTIGE UX-PRINZIPIEN, DIE DU KENNEN SOLLST

1. **Nielsen's 10 Heuristics** — Visibility, Match, Freedom, Consistency,
   Error Prevention, Recognition, Flexibility, Aesthetic, Error Recovery, Help.
2. **Fitts's Law** — Ziele nah am aktuellen Mauszeiger + gross sind schneller
   erreichbar. → Kritische Buttons unten rechts (Desktop) bzw. Daumenzone
   (Mobile).
3. **Hick's Law** — Entscheidungszeit waechst logarithmisch mit Anzahl Optionen.
   → 5-10 Menuepunkte sind OK, 20+ ist zu viel.
4. **Miller's Rule** — Menschen halten 7±2 Items im Kurzzeitgedaechtnis. Mehr
   als 9 Optionen brauchen Gruppierung.
5. **Peak-End-Rule** — Nutzer erinnern sich an den emotionalen Hoehepunkt und
   das Ende. → Letzter Schritt eines Workflows muss sich gut anfuehlen.
6. **von Restorff** — Was hervorsticht wird erinnert. → Primary-CTA visuell
   dominant machen, nicht in der Masse versenken.
7. **Zeigarnik-Effekt** — Unerledigte Tasks belasten. → Sichtbare Badges/
   Counter fuer offene Dinge sind gut, wenn sie actionable sind.

---

## BENCHMARK-APPS (fuer Vergleich in Findings)

- **Planday** (Gastro-Schichtplaner) — direkter Wettbewerb, gleiche Sprache
- **Personio** (HR) — gutes Design, mehr Features
- **Revolut Business** (Finanz) — Mobile-First-Referenz
- **WhatsApp / Signal** — Chat-UX-Gold-Standard
- **Apple Notes** — Einfachheit, Lesbarkeit
- **Notion** — Konfigurierbarkeit
- **DATEV Unternehmen online** — Steuer-UX (zum Abgucken waere aber auch eher
  zum Abgrenzen, DATEV ist bekannt fuer schlechte UX)
- **Shopify** — Setup-Wizard, Empty-States, Onboarding
- **Stripe Dashboard** — Daten-Dichte + Lesbarkeit

---

## MERKE: TONALITAET DES BERICHTS

Der Bericht soll **konstruktiv** sein, nicht schimpfend. Ein Entwickler soll
ihn lesen und denken "das sind gute Punkte, die packe ich an", nicht "jetzt
motzt der Berater wieder rum". Fuer jeden Kritikpunkt: Fix-Vorschlag mit
konkreten Wireframe-Prosa oder Code-Hinweisen. Ein Audit ohne Loesungen ist
nur Jammern.

---

## PFLICHT-OUTPUT-TABELLE (am Ende JEDES Audit-Reports)

**ZWINGENDE DOPPELVERIFIKATIONS-REGEL:** Die End-Tabelle enthaelt NUR Findings,
die alle vier Verifikations-Schritte durchlaufen haben:

1. **Persona-Zuordnung** — welche der 5 Personas (Tanja/Lukas/Gueler/Reinhard/Marcus)
   ist konkret betroffen und in welchem Stress-Szenario?
2. **Mental-Model-Bruch** — Erwartung vs. Ist explizit gegenuebergestellt, mit
   konkreter Klick-Sequenz / Screen-Beleg
3. **Benchmark-Abgleich** — gibt es eine bessere Loesung in Planday/Personio/DATEV/
   Apple/WhatsApp? Wenn ja, kurzer Vergleich; wenn nein, explizit "kein Benchmark"
4. **Nicht-UX-Profi-Erklaerung** — was fuehlt der User konkret? (Frust, Verwirrung,
   Abbruch) + Aufwand-Kategorie XS/S/M/L/XL fuer Behebung

Findings, die nicht alle 4 Schritte durchlaufen haben, kommen **nicht** in die
End-Tabelle. Sie werden — falls inhaltlich relevant — unter einem separaten
Abschnitt "⚠ Hinweise (nicht doppelt verifiziert, vor Sprint-Aufnahme pruefen)"
gelistet, nicht vermischt.

Jeder finale Audit-Bericht MUSS am Ende eine Markdown-Tabelle im **/tabelle**-Skill-Format
enthalten. Format ist verbindlich:

```markdown
| # | Severity | Persona | Kategorie | Seite | Element | Problem | Erklaerung |
|---|----------|---------|-----------|-------|---------|---------|-----------|
| UX-001 | HIGH | Marcus Bauer (area_manager) | KEIN_RESTAURANT_SWITCHER | /dashboard | Top-Nav | Sieht nur 1 Restaurant gleichzeitig | Marcus betreut 3 Standorte und erwartet eine Vergleichs-Sicht (Compliance-Score per Standort). Aktuell muss er pro Restaurant separat einloggen → bricht nach 2 Wochen ab. Aufwand: M (halber Tag — Restaurant-Switcher in Sidebar). |
| UX-002 | MEDIUM | Gueler (Kueche, 58) | LANGUAGE_BARRIER | /account/meine-rechte | "Bestaetigen" Button | Versteht das Wort nicht | Gueler ist tuerkische Muttersprachlerin und 58. "Bestaetigen" ist juristisches Vokabular. Besser: "Gelesen" mit Haken-Icon + tooltip mit voller Erklaerung. |
```

PFLICHT: Direkt unter der Tabelle 5 Bloecke:

**Statistik:**
```
CRITICAL: X | HIGH: X | MEDIUM: X | LOW: X | HINWEIS: X
```

**Persona-Verteilung:**
| Persona | CRIT | HIGH | MED | LOW |
|---------|------|------|-----|-----|
| Tanja (Owner) | X | X | X | X |
| Lukas (Service) | X | X | X | X |
| Gueler (Kueche, 58) | X | X | X | X |
| Reinhard (Buchhalter) | X | X | X | X |
| Marcus (area_manager) | X | X | X | X |

**Stress-Szenarien-Pass/Fail:** Tabelle der ~13 Stress-Szenarien mit ✅/❌-Ergebnis.

**Top-10 Sofort-Massnahmen sortiert nach Effekt-zu-Aufwand:**

**Erwartungskonform-OK-Liste:** mind. so lang wie Findings — Lobenswerte UI-Patterns
explizit benennen.

**Erklaerung-Spalte: Pflicht-Inhalte:**
- Welche Persona ist betroffen (eine der 5) UND was fuehlt sie konkret?
- Welcher Mental-Model-Bruch? (Erwartung vs. Ist)
- Konkreter Stress-Szenario-Anker (Freitag 19:30 / Montagmorgen / 31.03. 22:00 Uhr)
- Aufwand-Kategorie XS/S/M/L/XL
- Optional: Benchmark-Vergleich (Planday/Personio/DATEV/Apple/WhatsApp)
