---
name: audit-ux
description: >
  Fuehrt ein umfassendes UX-/Usability-Audit einer beliebigen Web- oder Mobile-App
  durch. 12 spezialisierte UX-Agenten pruefen Information-Architecture, Mental-Model-
  Match, Stress-Resilienz, Accessibility (WCAG 2.2 AA + EN 301 549 + BFSG), Mobile-
  First, Error-Tolerance, Feedback-Klarheit, Consistency, Microcopy und Onboarding.
  Use this skill whenever the user says "/audit-ux", "UX-Audit", "Usability-Test",
  "UI-Audit", "Heuristic-Evaluation", "Cognitive-Walkthrough", "WCAG-Pruefung",
  "Accessibility-Audit", "User-Journey-Test", "Stress-Test-UX", or asks to evaluate
  UX/usability of any app. Generic version — funktioniert mit beliebigen Personas
  (definierst du am Anfang des Audits). No shortcuts, no efficiency compromises,
  jede Page besucht, jeder Workflow durchlaufen, jede Persona durch jedes Stress-
  Szenario gefuehrt.
---

# audit-ux: Universelles UX-/Usability-Audit

App-agnostische Version. Erkennt Tech-Stack automatisch (Web/Mobile/Native) und
fragt zu Beginn die App-Personas + Stress-Szenarien ab.

## DETECT-Phase (Phase 0, vor Audit-Start)

Der Main-Agent fragt den User zu Beginn:

1. **App-Typ** — Web (responsive)? Mobile (iOS/Android native)? Hybrid (RN/Flutter)?
2. **Personas** (mindestens 3, idealerweise 5): Für jede:
   - Name, Alter, Rolle, Technik-Affinitaet (1-5)
   - Haupt-Use-Case (was tut die Person mit der App?)
   - Stress-Moment (wann ist sie unter Druck und braucht die App schnell?)
3. **Stress-Szenarien** (mindestens 5): konkrete Situationen mit Tageszeit, Druck-
   Quelle, Ziel der Person.
4. **Benchmark-Apps**: 2-3 Konkurrenten, die der User als "Goldstandard" sieht.
5. **Browser-Tool-Verfuegbarkeit** — Playwright? Browser-MCP? Direct-Access?
6. **Stack-Detection** — UI-Framework (React/Vue/Svelte/Angular/Native), CSS-Library
   (Tailwind/Material/Bootstrap/Custom), Form-Lib (RHF/Formik), Toast/Notification-Lib.

Diese Detection liefert die Personen-Liste fuer Agent 1 und die Szenarien-Liste fuer Agent 4.

---

## ANTI-SPAR-PROTOKOLL (NICHT VERHANDELBAR)

**Dieser Skill ist explizit so designt, dass Spar-Strategien VERBOTEN sind. Der
Fokus liegt zu 100 % auf Gruendlichkeit, nicht auf Geschwindigkeit oder Tokens.
Verstoesse machen das Audit wertlos und sind disqualifizierend.**

Folgende Praktiken sind ausdruecklich UNTERSAGT:

1. **Keine Stichproben.** Jede Seite, jedes Modul, jeder Workflow im Pruef-Umfang
   MUSS vollstaendig durchlaufen werden. "3 von 12 Stress-Szenarien" reicht NICHT —
   alle Szenarien mit allen Personas.
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
7. **Keine Vorab-Annahmen.** Frisch klicken, frisch testen, nichts annehmen.
8. **Falsch-Negativ-Vermeidung ist genauso wichtig wie Falsch-Positiv-Vermeidung.**
   Die "Erwartungskonform-OK"-Liste MUSS mindestens so lang sein wie die Findings-Liste.

Verstoesse haben reale Konsequenzen — eine uebersehene UX-Falle bedeutet, der User
bricht ab und der Konkurrent gewinnt. Der Skill optimiert auf **Gruendlichkeit zu 100 %**.

Wenn der Agent in Versuchung ist hier zu sparen: lies diesen Block erneut.

---

## GRUNDSAETZLICHE ANWEISUNGEN

Du fuehrst ein UX-Audit auf dem Niveau eines Senior-UX-Researchers (IDEO/Nielsen-
Norman-Group-Level) durch. Du kennst die 10 Nielsen-Heuristiken, die 8 Goldenen
Regeln von Shneiderman, das HEART-Framework (Google), die Fitts'sche-Gesetzmaessigkeit
und WCAG 2.2 AA als Mindeststandard.

**Jede gerenderte Seite, jeder interaktive Workflow MUSS aus mindestens einer Persona-
Perspektive durchlaufen werden, mit konkreter Klick-Sequenz. Kein "wirkt sauber" ohne
Snapshot. Kein "intuitiv" ohne A11y-Test.**

**DREIFACHE VERIFIKATION:** Jedes Finding durchlaeuft drei Pruefungsrunden:
1. **Beobachtung:** Was sieht der User? (Snapshot + Screenshot + Klick-Sequenz)
2. **Persona-Mapping:** Welche der definierten Personas erlebt das Problem konkret?
   In welchem Stress-Szenario?
3. **Benchmark-Abgleich:** Wie loest ein vergleichbarer Konkurrent das? (kurz +
   konkret + mit Quelle)

**FALSCH-POSITIV-VERMEIDUNG:** Ein Finding wird NUR gemeldet, wenn:
- Konkrete Persona ist betroffen (kein "Generic-User")
- Konkrete Klick-Sequenz reproduziert das Problem
- Mental-Model-Bruch ist explizit benannt (Erwartung vs. Ist)
- Mindestens 1 Benchmark-Vergleich (oder "kein Benchmark bekannt")

**FALSCH-NEGATIV-VERMEIDUNG:** "Erwartungskonform-OK"-Liste pro Agent — mindestens so
lang wie Findings-Liste. Gute UX-Patterns werden explizit gewuerdigt.

**OUTPUT-FORMAT pro Finding:**

```
FINDING [AGENT-XX-YY]
SEVERITY: CRITICAL | HIGH | MEDIUM | LOW | HINWEIS
KATEGORIE: NAVIGATION | INFO_HIERARCHIE | MENTAL_MODEL | LANGUAGE_BARRIER |
           A11Y | MOBILE | STRESS_RESILIENZ | ERROR_TOLERANCE | FEEDBACK |
           CONSISTENCY | ONBOARDING | DARK_PATTERN
PERSONA: [Name aus User-definierten Personas]
STRESS-SZENARIO: [Konkrete Situation, ggf. Tageszeit]
SEITE/ROUTE: [URL]
ELEMENT: [CSS-Selector / ARIA-Label / Screenshot-Marker]
ERWARTUNG: [Was die Persona erwartet — Mental-Model]
IST: [Was tatsaechlich passiert]
KLICK-SEQUENZ: [Konkrete Reproschritte]
BENCHMARK: [Wie loest Konkurrent X das, oder "kein Benchmark"]
AUFWAND: XS | S | M | L | XL
FIX-VORSCHLAG: [Konkret, mit Microcopy / Layout / Komponente]
```

---

## DURCHFUEHRUNG

Dispatche die 12 spezialisierten UX-Agenten **parallel** in 3-4 Batches. Jeder Agent
ist Fachexperte fuer seine Domaene und schreibt
`docs/audits/YYYY-MM-DD-audit-ux-agentXX.md` als Rohmaterial.

---

### AGENT 1: Persona-Coverage & Mental-Models

**Heuristik 2 (System-Real-World-Match), Heuristik 4 (Consistency & Standards).**

Pruefen, ob die Sprache, Icons, Workflows, Konzepte zu den definierten Personas
passen. Pro Persona durch mindestens 3 typische Workflows fuehren und Mental-Model-
Brueche identifizieren.

**Spezialfragen:** Verwendete Fachbegriffe — kennt die Zielgruppe die? (z.B.
"Bestaetigen" vs. "Haken setzen", "Bestaetigung" vs. "Speichern"). Icons —
intuitiv oder nur Insider verstaendlich? Date-Picker — kalendrisch ueblich
fuer die Region? Numerische Formate (Komma/Punkt, Datumsreihenfolge)?

**Erwartungskonform-OK:** mindestens 5 gut umgesetzte Patterns mit Verweis.

---

### AGENT 2: Information Architecture & Navigation

**Heuristik 6 (Recognition over Recall), Card-Sorting-Heuristiken.**

Pruefen: Top-Nav-Struktur logisch? Breadcrumbs vorhanden wo noetig? "Wo bin ich"-
Indikator? Sidebar-Items nach Frequenz/Wichtigkeit geordnet? Search vorhanden bei
> 20 Items? Tiefe (Click-Distance) zu kritischen Features <=3?

**Spezialfragen:** Findet die Persona in <=10 Sekunden die wichtigsten Funktionen?
Erkennt sie aus dem Page-Titel, wo sie ist? Gibt es "Sackgassen"-Pages ohne Exit?

**Erwartungskonform-OK:** mindestens 5 gut umgesetzte Patterns.

---

### AGENT 3: Stress-Resilienz

**Heuristik 10 (Help users recognize, diagnose, recover from errors).**

Durch alle definierten Stress-Szenarien laufen. Pro Szenario die App benutzen und
fragen: Bricht der User ab? Wird er ueberfordert? Gibt es einen "Quick-Action"-
Modus fuer den haeufigsten Use-Case?

**Spezialfragen:** "Notfall-Modus" fuer den haeufigsten Stress-Workflow? Reduzierte
UI-Density unter Stress (kein "Mauerwerk" aus 100 Buttons)? Wiederherstellbarkeit
bei Fehlbedienung (Undo, Confirm-Dialogs)?

**Erwartungskonform-OK:** mindestens 5 gute Stress-resiliente Patterns.

---

### AGENT 4: Microcopy & Language

**WCAG 3.1 (Readable), Cialdini-Prinzipien, Calm-Tech.**

Jede Buttonbeschriftung, jeden Fehler-Text, jede Erklaerung lesen. Fragen: Versteht
die unkundige Persona das? Wie ist der Ton — bevormundend? Drohend? Freundlich?
Konsistent (Du/Sie/wir)? Aktion oder Status im Wording?

**Spezialfragen:** Fehler-Texte nennen Loesung, nicht nur Problem? Empty-States
sind motivierend, nicht entmutigend? Confirm-Dialogs erklaeren Konsequenz konkret
(nicht "Sicher?")?

**Erwartungskonform-OK:** mindestens 5 gute Microcopy-Beispiele.

---

### AGENT 5: Error-Tolerance & Recovery

**Heuristik 5 (Error Prevention), Heuristik 9 (Recovery).**

Pruefen, ob Formulare fehlbedienbar sind: Pflichtfelder klar markiert? Inline-
Validation (nicht erst on-submit)? Datumsformate akzeptierend (12.5. vs. 12.05.2026)?
Numerische Felder mit deutschem/lokalem Format? "Cancel" wo "Submit" ist — also
Confusion-Schutz?

**Spezialfragen:** Undo verfuegbar bei kritischen Aktionen? Auto-Save bei langen
Formularen? Confirm-Dialogs vor destruktiven Aktionen mit konkreter Konsequenz-
Beschreibung?

**Erwartungskonform-OK:** mindestens 5 gute Error-Prevention-Patterns.

---

### AGENT 6: Feedback & Status

**Heuristik 1 (Visibility of System Status).**

Pruefen: Loading-Indicators bei Async-Operations? Toast/Snackbar bei Success
(nicht nur stillschweigend)? Optimistic UI? Progress-Indicators bei mehrstufigen
Workflows? Saving-Indicator?

**Spezialfragen:** Reagiert UI < 100 ms auf jeden Klick (sonst Loading-State)?
Toast-Texte konkret ("3 Schichten gespeichert" vs. "Erfolgreich")? Stille
Fehler — Action ohne Feedback?

**Erwartungskonform-OK:** mindestens 5 gute Feedback-Patterns.

---

### AGENT 7: Consistency

**Heuristik 4 (Consistency & Standards).**

Pruefen: Buttons konsistent (primary/secondary/destructive Farben)? Submit-Button-
Position konsistent (immer rechts unten)? Form-Layouts konsistent? Loading-
Indikatoren konsistent? Toast-Position konsistent?

**Spezialfragen:** Verwendet die App ueberall dasselbe Date-Picker-Widget? Dieselbe
Dropdown-Komponente? Dieselbe Modal-Struktur?

**Erwartungskonform-OK:** mindestens 5 gut konsistente Bereiche.

---

### AGENT 8: Accessibility (WCAG 2.2 AA + BFSG)

**WCAG 2.2 AA, EN 301 549, BFSG (DE).**

Pruefen: Alt-Text auf allen Bildern? Kontrast >= 4.5:1 (Text), 3:1 (UI-Elements)?
Keyboard-Navigation moeglich (Tab-Order, Focus-Indikator)? Screen-Reader-Labels
(aria-label, aria-labelledby)? Skip-Links? Form-Labels mit `for=`-Attribut?

**Spezialfragen:** Touch-Targets >= 44x44 px? Zoom auf 200 % ohne Layoutbruch?
Reduce-Motion respektiert? Dark-Mode-Kontraste OK?

**Erwartungskonform-OK:** mindestens 5 a11y-gut-umgesetzte Stellen.

---

### AGENT 9: Mobile-First

**Mobile-Heuristiken (Touch-Targets, Thumb-Zones).**

Pruefen: Touch-Targets >= 44px? Critical actions in Thumb-Zone (unterer Bildschirm)?
Mobile-Header nicht ueberladen? Bottom-Nav mit max. 5 Items? Swipe-Gesten konsistent?
Forms mit korrekten Inputmodes (numeric, email, tel)?

**Spezialfragen:** Funktioniert die App im Landscape-Modus? Mit Software-Keyboard?
Bei kleinen Bildschirmen (320px)? Performance auf Low-End-Devices?

**Erwartungskonform-OK:** mindestens 5 mobile-optimierte Patterns.

---

### AGENT 10: Onboarding & First-Run

**Don't-Make-Me-Think (Krug), Progressive Disclosure.**

Pruefen: Empty-States explizit (nicht weisse Seite)? Tutorials/Tooltips bei
Erstnutzung? "Skip"-Option vorhanden? Progressive Disclosure (nicht 100 Features
auf einmal)? Erfolgserlebnisse fruehzeitig?

**Spezialfragen:** Welcher Workflow ist beim ersten Login der erste Touch? Wird die
Persona dort abgeholt? Time-to-First-Value?

**Erwartungskonform-OK:** mindestens 3 gute Onboarding-Patterns.

---

### AGENT 11: Settings & Customization

**Heuristik 7 (Flexibility & Efficiency of Use).**

Pruefen: Settings vorhanden fuer relevante Praeferenzen? Wo erwartet (Profile-Menu
oben rechts)? Suchbar bei vielen Settings? Reset-to-Default verfuegbar?
Default-Werte sinnvoll?

**Spezialfragen:** Theme-Auswahl (Light/Dark/System)? Font-Size? Sprachauswahl?
Notification-Praeferenzen? Datenexport-Option?

**Erwartungskonform-OK:** mindestens 3 gute Settings-Patterns.

---

### AGENT 12: Dark-Patterns & Ethical UX

**Brignull's Dark-Pattern-Liste, EU-DSA Art. 25.**

Pruefen: Confirmshaming ("Nein danke, ich verzichte auf das Angebot")? Roach-Motel
(einfach rein, schwer raus)? Hidden Costs? Disguised Ads? Forced Continuity (Auto-
Renewal ohne Reminder)? Sneak-into-Basket?

**Spezialfragen:** Datenexport-Funktion versteckt? Account-Loeschung erschwert?
Manipulative Texte (Knappheits-Banner, Countdown ohne Realitaetsbezug)?

**Erwartungskonform-OK:** mindestens 3 ethisch saubere Patterns.

---

## ABSCHLUSSPRUEFUNG DURCH DEN MAIN-AGENT

1. **Persona-Verteilungs-Matrix** — pro Persona Anzahl Findings nach Severity.
2. **Stress-Szenarien-Pass/Fail-Tabelle** — Tabelle pro Szenario mit Ergebnis.
3. **Top-10 Sofort-Massnahmen** — sortiert nach Effekt-zu-Aufwand.
4. **Doppel-Verifikation** — jedes Finding gegen 4 Kriterien.

---

## PFLICHT-OUTPUT-TABELLE (am Ende JEDES Audit-Reports)

**ZWINGENDE DOPPELVERIFIKATIONS-REGEL:** Die End-Tabelle enthaelt NUR Findings,
die alle vier Verifikations-Schritte durchlaufen haben:

1. **Persona-Zuordnung** — welche der definierten Personas ist konkret betroffen
   und in welchem Stress-Szenario?
2. **Mental-Model-Bruch** — Erwartung vs. Ist explizit gegenuebergestellt, mit
   konkreter Klick-Sequenz / Screen-Beleg
3. **Benchmark-Abgleich** — gibt es eine bessere Loesung in einer Konkurrenz-App?
   Wenn ja, kurzer Vergleich; wenn nein, explizit "kein Benchmark"
4. **Nicht-UX-Profi-Erklaerung** — was fuehlt der User konkret? (Frust, Verwirrung,
   Abbruch) + Aufwand-Kategorie XS/S/M/L/XL fuer Behebung

Findings, die nicht alle 4 Schritte durchlaufen haben, kommen **nicht** in die
End-Tabelle. Sie werden — falls inhaltlich relevant — unter einem separaten
Abschnitt "⚠ Hinweise (nicht doppelt verifiziert, vor Sprint-Aufnahme pruefen)"
gelistet, nicht vermischt.

Format ist verbindlich:

```markdown
| # | Severity | Persona | Kategorie | Seite | Element | Problem | Erklaerung |
|---|----------|---------|-----------|-------|---------|---------|------------|
| UX-001 | HIGH | [Persona-Name] | MENTAL_MODEL | /dashboard | Top-Nav | [Was] | Was fuehlt die Persona, welcher Stress-Anker, welcher Aufwand? |
```

**Pflicht-Bloecke direkt unter der Tabelle:**

**Statistik:**
```
CRITICAL: X | HIGH: X | MEDIUM: X | LOW: X | HINWEIS: X
```

**Persona-Verteilung:**

| Persona | CRIT | HIGH | MED | LOW |
|---------|------|------|-----|-----|
| Persona 1 | X | X | X | X |
| Persona 2 | X | X | X | X |
| ... | | | | |

**Stress-Szenarien-Pass/Fail:** Tabelle aller definierten Szenarien mit ✅/⚠/❌.

**Top-10 Sofort-Massnahmen sortiert nach Effekt-zu-Aufwand:**

**Erwartungskonform-OK-Liste:** mind. so lang wie Findings — lobenswerte
UI-Patterns explizit benennen.

**⚠ Hinweise (nicht doppelt verifiziert):** Falls vorhanden, separat gelistet.

**Erklaerung-Spalte: Pflicht-Inhalte:**
- Welche Persona ist betroffen UND was fuehlt sie konkret?
- Welcher Mental-Model-Bruch? (Erwartung vs. Ist)
- Konkreter Stress-Szenario-Anker
- Aufwand-Kategorie XS/S/M/L/XL
- Optional: Benchmark-Vergleich
