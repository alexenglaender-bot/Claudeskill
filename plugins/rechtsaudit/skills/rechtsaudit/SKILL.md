---
name: rechtsaudit
description: >
  Fuehrt ein umfassendes rechtswissenschaftliches Compliance-Audit der gesamten Ma-nagement
  Codebase durch. 12 spezialisierte Agenten pruefen 80+ Normen mit doppelter Verifikation.
  Use this skill whenever the user says "/rechtsaudit", "Rechtsaudit", "legal audit",
  "Compliance-Audit", "rechtliche Pruefung", "Normen pruefen", or asks to check the app
  against German labor law, tax law, data protection, food safety, or any other legal domain.
  Also trigger when the user mentions GoBD, DSGVO, ArbZG, or any specific German legal norm
  in the context of auditing the codebase. This is the most thorough legal audit available —
  no shortcuts, no efficiency compromises, every file read completely.
---

# Rechtsaudit — Umfassendes rechtswissenschaftliches Compliance-Audit

**Stand 2026-04-28** — Multi-Tenant Phase 2.5, Pflicht-Aushaenge-Modul live, NachwG §3-Audit-Trail
mit IP+UA, IfSG-§43-Folgebelehrung-2-Jahres-Sperre BLOCKING in Schichtzuweisung,
Compliance-Autopilot mit ~25 Warnungen (RDG §2/§5-klassifiziert), Schwerbehindertenquote-Tracker
nach §159 SGB IX.

## APP-AKTUALITAETS-PRUEFUNG (Phase 0a, vor Audit-Start)

Vor jedem Audit-Start MUSS der Main-Agent verifizieren:

1. `ls src/actions/compliance-documents.actions.ts src/lib/compliance-documents-seed.ts` — wenn
   beide existieren: Pflicht-Aushaenge-Modul aktiv → Agent 4 (Datenschutz) muss alle 14+
   Pflicht-Aushang-Slugs verifizieren (juschg, agg, lmiv-allergen-merkblatt, arbzg, mutterschutz,
   jarbschg, mindestlohn, milog-aufbewahrung, dguv-204-001, brandschutzordnung-teil-a,
   notruftafel-arbeitsstaette, betrvg, sgb9-ausweis, schwarzarbg, ifsg-taetigkeitsverbot,
   gefstoffv-reinigungsmittel, gefaehrdung-mutterschutz-gastro, haccp-hygieneplan,
   haccp-schaedlingsbekaempfung, arbzg-nachtarbeit-info, betrvg-90-info-checkliste)
2. `ls deploy/templates/vvt-vorlage.md deploy/templates/dsfa-quickfill-vorlage.md
   docs/compliance/ai-act-konformitaet.md docs/security/vulnerability-disclosure-policy.md` —
   alle 4 vorhanden? Falls nicht: Agent 9 (SaaS-Produktrecht) Production-Blocker
3. `ls prisma/migrations | tail -10` — letzte 10 Migrationen lesen, neue rechtlich relevante
   Felder erfassen (User.isDemo, RestaurantMembership.inklusivLohn,
   Restaurant.kasseElsterMeldungConfirmed, ComplianceDocumentAcknowledgment.ipAddress/userAgent)
4. `ls src/actions/schwerbehinderten-quote.actions.ts` — wenn vorhanden: §159 SGB IX-Tracker
   aktiv → Agent 5 (SGB IV) prueft Ausgleichsabgabe-Berechnung (SchwbAV §1-Staffelung)
5. `git rev-parse HEAD` — exakter Commit-Hash am Audit-Start dokumentieren
6. Stand-Datum im Bericht IMMER aktualisieren auf heute (nicht 2026-04-X uebernehmen)

## ANTI-SPAR-PROTOKOLL (NICHT VERHANDELBAR)

**Dieser Skill ist explizit so designt, dass Spar-Strategien VERBOTEN sind. Der
Fokus liegt zu 100 % auf Gruendlichkeit, nicht auf Geschwindigkeit oder Tokens.
Verstoesse machen das Audit wertlos und sind disqualifizierend.**

Folgende Praktiken sind ausdruecklich UNTERSAGT:

1. **Keine Stichproben.** Jede rechtlich relevante Datei MUSS vollstaendig gelesen
   werden. "5 von 12 Server-Actions" reicht NICHT — alle 12. Norm-Beleg ohne
   Code-Sichtung ist ungueltig.
2. **Keine Agenten-Reduktion.** Wenn der Skill 12 Agenten vorsieht, MUESSEN 12 Agenten
   dispatched werden. Nicht "die 4 wichtigsten" — alle 12, parallel in 3-4 Batches.
3. **Keine "wahrscheinlich-OK"-Verzichte.** Kein Agent darf eine Norm-Pruefung mit
   "wird so passen" abkuerzen. Verifikation = exakte Normzitation (§ Abs. S. Nr.) +
   Code-Zitat mit Datei:Zeile.
4. **Keine Token-Sparmassnahmen.** Kein Truncate, kein "Rest analog", kein
   "siehe oben". Jeder Befund mit allen Pflichtfeldern aus dem OUTPUT-FORMAT
   (Norm, IST, SOLL, RECHTSFOLGE, FIX, VERIFIKATION).
5. **Keine Zeitlimit-Anpassung.** Wenn das Audit 5 Stunden braucht, wird es 5 Stunden
   gemacht. Knapp werdendes Token-Budget → User-Meldung, nicht Audit-Verkuerzung.
6. **Keine Selbst-Bewertung als "gut genug".** Vollstaendigkeit = jede Norm aus dem
   Pruef-Umfang behandelt, kompensierende Kontrollen explizit geprueft, OK-Liste
   bevoelkert.
7. **Keine Vorab-Annahmen.** Kein "BUrlG haben wir letztes Sprint geprueft" — frisch
   nachsehen. Recht aendert sich (EU AI Act, CRA, E-Rechnung, Pay-Transparency).
8. **Falsch-Negativ-Vermeidung ist genauso wichtig wie Falsch-Positiv-Vermeidung.**
   Die "Vorbildlich/OK"-Liste MUSS mindestens so lang sein wie die Findings-Liste.

Verstoesse haben reale Konsequenzen — uebersehene Norm bedeutet Bussgeld oder Owner-
Haftung. DSGVO bis 20 Mio EUR, GoBD bis 10 Mio EUR, NachwG bis 2.000 EUR pro Fall,
IfSG bis 25.000 EUR. Der Skill optimiert auf **Gruendlichkeit zu 100 %**.

Wenn der Agent in Versuchung ist hier zu sparen: lies diesen Block erneut.

---

## GRUNDSAETZLICHE ANWEISUNGEN

Du fuehrst ein rechtswissenschaftliches Audit auf hoechstem Niveau durch. Dieses Audit simuliert die Arbeit eines spezialisierten Fachanwalts-Teams mit Expertise in 12 Rechtsgebieten.

**KRITISCHE REGEL: Effizienz mit Zeit oder Tokens ist absolut fehl am Platz.** Diese App wird in Zukunft echte Rechtsberatung leisten. Fehler haben massive adverse Folgen — von Bussgeldern bis Haftung. Jede Zeile Code, die rechtliche Relevanz hat, MUSS gelesen und verstanden werden. Kein Ueberfliegen, kein Zusammenfassen, kein Abkuerzen.

**DOPPELTE VERIFIKATION:** Jedes Finding durchlaeuft zwei Pruefungsrunden:
1. **Erstfund:** Agent identifiziert potenzielle Rechtswidrigkeit mit Normzitat
2. **Verifikation:** Separater Schritt prueft: Stimmt die Norm? Ist der Sachverhalt korrekt? Gibt es eine Ausnahme/Rechtfertigung im Code?

**FALSCH-POSITIV-VERMEIDUNG:** Ein Finding wird NUR gemeldet, wenn:
- Die relevante Norm korrekt zitiert ist (Paragraph, Absatz, Satz, Nummer)
- Der Code tatsaechlich gegen diese Norm verstoesst (nicht nur theoretisch)
- Keine kompensierende Kontrolle im Code existiert, die das Finding entkraeftet

**OUTPUT-FORMAT pro Finding:**
```
FINDING [AGENT-XX]
SEVERITY: CRITICAL | HIGH | MEDIUM | LOW | HINWEIS
NORM: [exaktes Zitat mit §, Abs., S., Nr.]
DATEI: [Pfad:Zeile]
IST-ZUSTAND: [Was der Code tut]
SOLL-ZUSTAND: [Was die Norm verlangt]
RECHTSFOLGE: [Bussgeld/Strafe bei Verstoss]
FIX: [Konkreter Code-Vorschlag]
VERIFIKATION: [Bestaetigung + Ausschluss von Kompensation]
```

---

## DURCHFUEHRUNG

Dispatche die folgenden 12 spezialisierten Agenten **parallel** (in 3-4 Batches je nach Context-Kapazitaet). Jeder Agent ist Fachexperte fuer sein Rechtsgebiet. Nach Abschluss aller Agenten wird ein Konsolidierungsbericht erstellt und unter `docs/audits/YYYY-MM-DD-rechtsaudit.md` gespeichert.

---

### AGENT 1: Arbeitszeitrecht (ArbZG, JArbSchG, MuSchG, BEEG, MuSchArbV)

**Zu pruefende Dateien:**
- `src/actions/time-entry.actions.ts` — Vollstaendig lesen
- `src/actions/shift-crud.actions.ts` — Vollstaendig lesen
- `src/actions/shift-bulk.actions.ts` — Vollstaendig lesen
- `src/actions/shift-assignment.actions.ts` — Vollstaendig lesen
- `src/actions/muschg-jarbschg.actions.ts` — Vollstaendig lesen
- `src/lib/work-time-rules.ts` — Vollstaendig lesen
- `src/lib/break-rules.ts` — Vollstaendig lesen
- `src/lib/shift-compliance.ts` — Vollstaendig lesen
- `src/lib/compliance.ts` — Arbeitszeit-relevante Abschnitte
- `src/actions/compliance-autopilot.actions.ts` — ArbZG/JArbSchG/MuSchG-Warnungen
- `prisma/schema.prisma` — Modelle: Shift, TimeEntry, BreakEntry, RestDayCompensation

**Zu pruefende Normen:**
- ArbZG §2-§7, §9-§11, §16, §22-§23
- JArbSchG §8, §11-§19, §47
- KindArbSchV (Kinderarbeitsschutzverordnung) — Kinder unter 15 in Familienbetrieben
- MuSchG §3-§4, §6, §9-§13, §27
- MuSchArbV — Gastro-spezifische Gefaehrdungsbeurteilung (heisse Kueche, Heben schwerer Toepfe, chemische Reinigungsmittel, Rutschgefahr)
- BEEG §15-§16, §18

**Pruefungsfragen:**
1. Wird die 10h-Tageshoechstgrenze bei Schichtplanung UND Zeiterfassung geprueft?
2. Wird der 24-Wochen-Ausgleichszeitraum korrekt berechnet (§3 S. 2)?
3. Werden Ruhepausen (30min ab 6h, 45min ab 9h) korrekt erzwungen?
4. Wird die 11h-Ruhezeit zwischen Schichten geprueft (§5)?
5. Sind Gastro-Ausnahmen (§10 ArbZG) korrekt implementiert?
6. Wird §11 (Ersatzruhetag bei Sonntagsarbeit) korrekt getrackt?
7. JArbSchG: Wird das absolute Feiertagsarbeitsverbot (§18 Abs. 2) durchgesetzt?
8. JArbSchG: Wird die Nachtruhe (20:00-06:00, Gastro bis 22:00) geprueft?
9. KindArbSchV: Werden Kinder (unter 15) von Jugendlichen (15-17) unterschieden?
10. MuSchG: Werden Schutzfristen automatisch aus ET berechnet?
11. MuSchArbV: Enthaelt die Gefaehrdungsbeurteilung Gastro-spezifische Risiken?
12. BEEG: Wird Teilzeit waehrend Elternzeit (max 32h) begrenzt?
13. Werden ALLE Verstoesse auditiert (logAudit)?

---

### AGENT 2: Urlaubsrecht + Entgeltfortzahlung (BUrlG, EFZG, TzBfG, NachwG, KSchG)

**Zu pruefende Dateien:**
- `src/actions/vacation.actions.ts` — Vollstaendig lesen
- `src/actions/vacation-hinweis.actions.ts` — Vollstaendig lesen
- `src/actions/sick-leave.actions.ts` — Vollstaendig lesen
- `src/actions/contract.actions.ts` — Vollstaendig lesen
- `src/lib/vacation-utils.ts` — Vollstaendig lesen
- `src/actions/compliance-autopilot.actions.ts` — Urlaub/EFZG/TzBfG/KSchG-Warnungen
- `prisma/schema.prisma` — Modelle: VacationRequest, VacationHinweis, SickLeave, User

**Zu pruefende Normen:**
- BUrlG §1-§13 (insbesondere §3, §5, §7, §9, §11)
- EFZG §1, §3, §3a (Fortsetzungserkrankung), §5
- TzBfG §14 (Befristung), §15, §17
- NachwG §2 (Nachweispflicht)
- KSchG §1 (Sozialauswahl), §4 (Klagefrist), §17 (Massenentlassungen)

**Pruefungsfragen:**
1. Mindesturlaub (20 Tage bei 5-Tage-Woche) als Untergrenze erzwungen?
2. Teilurlaub (§5) bei unterjaerigem Ein-/Austritt korrekt (1/12 pro Monat)?
3. Urlaubsuebertragung (§7 Abs. 3) mit 31.03. Verfall korrekt?
4. §9 BUrlG (Krankheit waehrend Urlaub) angerechnet/rueckgebucht?
5. EFZG §3a Fortsetzungserkrankungen erkannt?
6. TzBfG §14 Befristungsmonitoring (max 2 Jahre, 3 Verlaengerungen)?
7. TzBfG §14 Abs. 2 S. 2 Vorbeschaeftigungsverbot?
8. KSchG: Sozialauswahl-Kriterien (Dauer, Alter, Unterhalt, Behinderung) verfuegbar?

---

### AGENT 3: Steuerrecht + TSE + GoBD (AO, UStG, EStG, KassenSichV, DSFinV-K)

**Zu pruefende Dateien:**
- `src/actions/cash-entry.actions.ts` — Vollstaendig (Storno, TSE-Signierung)
- `src/actions/tse.actions.ts`, `src/actions/tse-retry.actions.ts`
- `src/actions/datev-export.actions.ts`, `src/actions/dsfinvk-export.actions.ts`
- `src/actions/tax-advisor.actions.ts`, `src/actions/pos.actions.ts`
- `src/lib/tse/` — Alle Dateien
- `src/lib/tse-vat.ts`, `src/lib/tax-constants.ts`, `src/lib/sachbezug.ts`
- `src/lib/audit.ts` — Hash-Kette
- `prisma/schema.prisma` — CashEntry, PosTransaction, CashDayClose, AuditLog

**Zu pruefende Normen:**
- AO §145-§147a, §158, §379
- KassenSichV §1-§8
- UStG §12 (Steuersaetze), §14/§14a (Rechnungsanforderungen)
- EStG §3 Nr. 51, §3b, §8 Abs. 2 S. 6
- GoBD (2019) Tz. 58-62, 130-145, 164
- DSFinV-K Schnittstellenbeschreibung
- Sachbezugswertverordnung (aktuelle Werte 2026)
- **NEU: §146a Abs. 4 AO — Kassenmeldepflicht (seit 01.07.2025)**: Wird die Registrierung unterstuetzt?
- **NEU: §14 UStG — E-Rechnungspflicht (seit 01.01.2025 Empfang, ab 01.01.2027 Versand)**: XRechnung/ZUGFeRD?

**Pruefungsfragen (erweitert):**
1. Werden ALLE Kassenbewegungen mit TSE signiert?
2. Ist Storno korrekt als neuer Eintrag (nicht Loeschung)?
3. USt-Saetze korrekt (In-Haus 19%, Ausser-Haus 7%)?
4. Sachbezugswerte 2026 korrekt (Essen 4,13 EUR, Unterkunft 265 EUR)?
5. §3b EStG SFN-Zuschlaege korrekt (Nacht 25/40%, So 50%, Feiertag 125/150%)?
6. Hash-Kette lueckenlos und manipulationssicher?
7. DSFinV-K Exportformate normkonform?
8. DATEV-Kontenzuordnung korrekt?
9. 10-Jahres-Aufbewahrungsfristen eingehalten?
10. **NEU: Wird Kassenmeldepflicht (§146a Abs. 4) unterstuetzt/dokumentiert?**
11. **NEU: Kann die App E-Rechnungen empfangen (XRechnung/ZUGFeRD)?**
12. Demo-Modus: Koennen Demo-Signaturen mit echten vermischt werden?

---

### AGENT 4: Datenschutzrecht (DSGVO, BDSG, TDDDG)

**Zu pruefende Dateien:**
- `src/actions/gdpr.actions.ts`, `src/actions/retention.actions.ts`
- `src/actions/gps-consent.actions.ts`, `src/actions/data-breach.actions.ts`
- `src/lib/pii-encryption.ts`, `src/lib/encryption.ts`
- `src/components/onboarding/dsgvo-consent-dialog.tsx`
- `src/components/account/gdpr-section.tsx`
- `src/middleware.ts` — Security Headers, CSP
- `prisma/schema.prisma` — ConsentLog, DataBreach, User, UserSession

**Zu pruefende Normen:**
- DSGVO Art. 5-7, 9, 12-22, 25, 28, 30, 32-35, 44-49, 83
- BDSG §22, §26
- TDDDG §25 (Endeinrichtungen: Cookies, localStorage)
- **NEU: DSK-Positivliste fuer DSFA** — systematische Ueberwachung, Gesundheitsdaten, Scoring

**Pruefungsfragen (erweitert):**
1. Fuer JEDE Verarbeitung Rechtsgrundlage dokumentiert?
2. Einwilligung korrekt (freiwillig, informiert, granular)?
3. GPS: BDSG §26 + Einwilligung korrekt?
4. Art. 9-Daten verschluesselt und zugangsbeschraenkt?
5. Art. 15-22 Betroffenenrechte funktional?
6. Aufbewahrungsfristen durchgesetzt?
7. AES-256-GCM korrekt (unique IVs, Key-Rotation)?
8. Art. 33 Meldepflicht (72h) unterstuetzt?
9. Drittlandtransfers dokumentiert? (Twilio/US!)
10. Privacy by Design umgesetzt (Datenminimierung)?
11. **NEU: Wird Kunden eine vorgefertigte DSFA-Vorlage bereitgestellt?**
12. **NEU: TDDDG §25 — Werden localStorage-Zugriffe konsentiert?**

---

### AGENT 5: Sozialversicherungsrecht (SGB IV, MiLoG, AAG)

**Zu pruefende Dateien:**
- `src/actions/sofortmeldung.actions.ts`
- `src/lib/compliance.ts` — Minijob/Werkstudent/Kurzfristige
- `src/lib/payroll-data.ts`
- `src/actions/compliance-autopilot.actions.ts` — SV-Warnungen
- `prisma/schema.prisma` — Sofortmeldung, User

**Zu pruefende Normen:**
- SGB IV §7, §8 (Minijob 520 EUR), §8a, §28a Abs. 4 (Sofortmeldung)
- MiLoG §1, §2, §17 (Dokumentationspflicht)
- AAG (U1/U2 Umlagen)
- **NEU: SchwarzArbG §2a (seit 01.01.2026)** — Mitfuehrungspflicht Ausweis, schriftliche Belehrung vor Arbeitsantritt

**Pruefungsfragen (erweitert):**
1. 520-EUR-Grenze korrekt berechnet (inkl. Einmalzahlungen)?
2. Berufsmaessigkeit bei kurzfristiger Beschaeftigung geprueft?
3. Sofortmeldung rechtzeitig generiert?
4. Mindestlohn als Untergrenze erzwungen?
5. Werkstudenten: 20h/Woche waehrend Vorlesungszeit?
6. **NEU: SchwarzArbG §2a — Wird die Ausweismitfuehrungspflicht-Belehrung getrackt?**
7. **NEU: Wird eine Vorlage fuer die §2a-Belehrung bereitgestellt?**

---

### AGENT 6: Gastaettenrecht + Lebensmittelrecht (GastG, IfSG, LMIV, HACCP)

**Zu pruefende Dateien:**
- `src/actions/ifsg.actions.ts`, `src/actions/haccp.actions.ts`
- `src/actions/inventory.actions.ts` — Allergen-Abschnitte
- `src/actions/goods-receipt.actions.ts`, `src/actions/waste.actions.ts`
- `src/lib/temperature-presets.ts`, `src/lib/sperrzeiten.ts`
- `src/lib/inventory-constants.ts`
- `prisma/schema.prisma` — Alle HACCP/Inventory Modelle

**Zu pruefende Normen:**
- IfSG §42, §43, §73
- LMIV Art. 9, Anhang II (14 Allergene), Art. 44
- VO (EG) 852/2004, Anhang II Kapitel IX
- LMHV §3, §4
- GastG §2, §4, §5 + GastStaettenVO (laenderspezifisch)
- HACCP-Konzept nach Codex Alimentarius

**Pruefungsfragen:**
1. IfSG-Erstbelehrungen (3 Monate vor Taetigkeitsbeginn) getrackt?
2. IfSG-Folgebelehrungen (alle 2 Jahre) automatisch ueberwacht?
3. IfSG-Taetigkeitsverbot (§42) bei Schichtzuweisung blockiert?
4. Alle 14 EU-Allergene (LMIV Anhang II) korrekt abgebildet?
5. HACCP-Temperaturgrenzwerte korrekt (Kuehl 2-7°C, TK -18°C)?
6. Wareneingangs-Temperaturen dokumentiert?
7. MHD-Ueberschreitungen gewarnt?
8. Schwund mit Grund dokumentiert (HACCP-Nachweis)?
9. Sperrzeiten pro Bundesland korrekt?

---

### AGENT 7: Handelsrecht + GoBD + Verfahrensdokumentation

**Zu pruefende Dateien:**
- `src/lib/audit.ts` — Hash-Kette mathematisch verifizieren
- `src/actions/audit-export.actions.ts`
- `src/actions/retention.actions.ts`
- `src/lib/calculation-version.ts`
- `prisma/schema.prisma` — AuditLog, InventoryMovement, CashEntry

**Zu pruefende Normen:**
- HGB §238, §239, §257
- GoBD Tz. 58-62, 100-109, 130-145, 164
- AO §90, §146, §147
- EU-Produkthaftungsrichtlinie 2024/2853 (SaaS-Haftung)

**Pruefungsfragen:**
1. Hash-Kette mathematisch korrekt (SHA-256, Verkettung)?
2. AuditLog-Eintraege unmodifizierbar und unloeschbar?
3. InventoryMovements immutable?
4. Korrekturen ueber Gegenbuchungen?
5. 10-Jahres-Aufbewahrungsfristen implementiert?
6. Verfahrensdokumentation vorhanden/generierbar?
7. Berechnungslogik-Aenderungen versioniert?

---

### AGENT 8: Trinkgeld + Zuschlaege + Lohnrecht (EStG, GewO, MTV)

**Zu pruefende Dateien:**
- `src/actions/tip-distribution.actions.ts`
- `src/lib/surcharges/` — Alle Dateien
- `src/actions/mtv-surcharge.actions.ts`
- `src/lib/surcharge.ts`
- `prisma/schema.prisma` — TipPool, TipPoolEntry, SurchargeEntry

**Zu pruefende Normen:**
- EStG §3 Nr. 51, §3b
- GewO §107
- MiLoG §1
- MTV Gastro BW
- SFN-Zuschlaege: Grundlohn-Obergrenze 50 EUR/h

**Pruefungsfragen:**
1. §3 Nr. 51 EStG korrekt (nur freiwilliges Trinkgeld steuerfrei)?
2. Servicegebuehren als lohnsteuerpflichtig markiert?
3. §107 GewO (Gesamtsumme an AN) eingehalten?
4. SFN-Zuschlaege korrekt (Grundlohn max 50 EUR/h)?
5. Steuerfreier Nachtarbeitszeitraum (20:00-06:00) korrekt getrennt?
6. Feiertags-Zuschlaege pro Bundesland korrekt?
7. §3b auf tatsaechlich geleistete Stunden begrenzt?

---

### AGENT 9: SaaS-Produktrecht + EU-Regulierung (NEU)

**Zu pruefende Dateien:**
- `src/app/(app)/impressum/page.tsx` — Impressumspflicht
- `src/app/(app)/datenschutz/page.tsx` — Datenschutzerklaerung
- `src/app/(app)/agb/page.tsx` — AGB
- `src/actions/gdpr.actions.ts` — Datenportabilitaet (EU Data Act)
- `src/actions/export.actions.ts` — Export-Funktionalitaet
- Alle `package.json` + `node_modules/` — Lizenzen (stichprobenartig)
- `docs/production-checklist.md` — CRA Vulnerability Disclosure
- `docs/compliance/` — Alle Compliance-Dokumente

**Zu pruefende Normen:**
- **BGB §327-§327u (Digitale Produkte)**: Updatepflicht, Maengelgewaehrleistung, Vertragsgemaessheit
- **BGB §305-§310 (AGB-Recht)**: Klauselkontrolle, Transparenzgebot, ueberraschende Klauseln
- **DDG §5 (Impressumspflicht)**: Pflichtangaben (Name, Anschrift, E-Mail, Handelsregister, USt-ID)
- **EU Data Act (VO 2023/2854) Art. 23-31**: Max 2 Monate Kuendigung, 30-Tage-Datenexport, maschinenlesbares Format, API-Dokumentation, Switching-Gebuehren-Verbot ab 01.2027
- **CRA (VO 2024/2847) Art. 13-14**: Vulnerability Disclosure Policy, ENISA-Meldepflicht ab 09.2026
- **BFSG (Barrierefreiheitsstaerkungsgesetz)**: WCAG 2.1 AA, Kleinstunternehmen-Ausnahme pruefen
- **EU AI Act Anhang III Nr. 4**: Wenn KI fuer Beschaeftigungsentscheidungen (QuickFill Scheduling)
- **EU Platform Workers Directive (2024/2831)**: Algorithmisches Management, Transparenzpflicht
- **UWG §5 (Irrefuehrende Werbung)**: "GoBD-konform", "DSGVO-konform" als Marketing-Aussagen

**Pruefungsfragen:**
1. Impressum vollstaendig nach DDG §5?
2. AGB: Klauselkontrolle — ueberraschende Klauseln (§305c BGB)?
3. AGB: Haftungsbeschraenkung bei Kardinalpflichten zulaessig (§307 BGB)?
4. BGB §327e: Werden Updates/Bugfixes als Vertragspflicht dokumentiert?
5. EU Data Act: Kann der Kunde ALLE Daten in 30 Tagen exportieren?
6. EU Data Act: Gibt es API-Dokumentation fuer Switching?
7. EU Data Act: Max 2 Monate Vertragskuendigung in AGB?
8. CRA: Vulnerability Disclosure Policy vorhanden?
9. BFSG: Greift die Kleinstunternehmen-Ausnahme noch?
10. QuickFill: Art. 22 DSGVO — automatisierte Einzelentscheidung?
11. Platform Workers Directive: Sehen MA die Scoring-Kriterien?
12. UWG: Sind Compliance-Claims ("GoBD-konform") rechtlich abgesichert?
13. Open-Source-Lizenzen: AGPL/GPL-Kontamination in Dependencies?

---

### AGENT 10: Erweiterte Arbeitsschutzvorschriften (NEU)

**Zu pruefende Dateien:**
- `src/actions/user.actions.ts` — Mitarbeiterstammdaten
- `src/actions/compliance-autopilot.actions.ts` — Alle Schutzstatus-Pruefungen
- `src/actions/offboarding.actions.ts` — Kuendigung/Abmahnung
- `prisma/schema.prisma` — User (alle schutzrelevanten Felder)

**Zu pruefende Normen:**
- **SGB IX §154-§159, §163, §168-§175 (Schwerbehindertenrecht)**: 5%-Quote, Ausgleichsabgabe, besonderer Kuendigungsschutz (Integrationsamt), Zusatzurlaub 5 Tage, Anzeigepflicht bis 31. Maerz
- **AGG §1-§3, §7, §15 (Gleichbehandlung)**: Diskriminierungsfreie Schichtplanung, Stellenausschreibungen
- **AUeG §1, §1b, §8, §9, §11 (Arbeitnehmerueberlassung)**: 18-Monate-Hoechstdauer, Equal Pay nach 9 Monaten
- **EntgTranspG / EU Pay Transparency (2023/970)**: Auskunftsanspruch, Gender Pay Gap, Transposition bis 06.2026
- **ASiG + DGUV Vorschrift 2 (reformiert 01.01.2026)**: Betriebsarzt-Einsatzzeiten, Fachkraft fuer Arbeitssicherheit
- **SGB VII §193 + DGUV Vorschrift 1**: BGN-Unfallmeldung bei 3+ Tagen Arbeitsunfaehigkeit
- **BetrVG §87 Abs. 1 Nr. 6, §90**: Mitbestimmung bei technischer Ueberwachung + Information bei neuer Technologie

**Pruefungsfragen:**
1. SGB IX: Wird der Schwerbehindertenstatus (GdB, Gleichstellung) im User-Modell gespeichert?
2. SGB IX: Wird die 5%-Quote berechnet?
3. SGB IX: Wird der besondere Kuendigungsschutz (Integrationsamt) erzwungen?
4. SGB IX: Werden die 5 Zusatzurlaubstage automatisch angerechnet?
5. AGG: Ist die Schichtplanung diskriminierungsfrei (keine Benachteiligung nach Geschlecht, Alter, Religion)?
6. AUeG: Werden Leiharbeitnehmer von regulaeren AN unterschieden?
7. AUeG: Wird die 18-Monate-Hoechstdauer getrackt?
8. EntgTranspG: Sind Gehaltsranges pro Position speicherbar?
9. EntgTranspG: Kann ein Gender Pay Gap Report generiert werden?
10. ASiG: Werden Betriebsarzt-Termine getrackt?
11. SGB VII: Werden Arbeitsunfaelle erfasst und BGN-Meldungen unterstuetzt?
12. BetrVG §90: Gibt es ein "Betriebsrats-Informationspaket" fuer die App-Einfuehrung?

---

### AGENT 11: E-Rechnung + Kassenmeldepflicht + Zahlungsverkehr (NEU)

**Zu pruefende Dateien:**
- `src/actions/invoice.actions.ts` — Eingangsrechnungen
- `src/actions/cash-entry.actions.ts` — Kassenbuch
- `src/actions/pos.actions.ts` — POS-Transaktionen
- `src/lib/invoice-parser.ts` — Rechnungsverarbeitung
- `src/lib/tse/` — TSE-Integration
- `prisma/schema.prisma` — IncomingInvoice, PosTransaction

**Zu pruefende Normen:**
- **§14 UStG (neu) + EN 16931 + Wachstumschancengesetz**: E-Rechnungspflicht — Empfang seit 01.01.2025, Versand ab 01.01.2027 fuer >800K EUR Umsatz
- **§146a Abs. 4 AO + Kassenmeldeverordnung**: Kassenmeldepflicht seit 01.07.2025 — Registrierung ueber "Mein ELSTER"
- **ZAG (Zahlungsdiensteaufsichtsgesetz)**: Falls die App tatsaechliche Zahlungsabwicklung vornimmt
- **PSD2 (Zahlungsdiensterichtlinie)**: Starke Kundenauthentifizierung bei Zahlungen
- **GwG §2, §10-§17 (Geldwaeschegesetz)**: Bargeldintensive Branche — Verdachtsmeldungen >10.000 EUR

**Pruefungsfragen:**
1. Kann die App E-Rechnungen im XRechnung/ZUGFeRD-Format empfangen?
2. Kann die App E-Rechnungen im EN 16931-Format senden?
3. Wird die Kassenmeldepflicht (Registrierung bei Finanzamt) dokumentiert/unterstuetzt?
4. Falls Zahlungen abgewickelt werden: ZAG-Lizenz erforderlich?
5. Werden hohe Bareinnahmen (>10.000 EUR) gewarnt (GwG analog)?

---

### AGENT 12: RDG/StBerG — Compliance-Autopilot Klassifizierung (NEU)

**Zu pruefende Dateien:**
- `src/actions/compliance-autopilot.actions.ts` — ALLE 20+ Pruefungen einzeln klassifizieren
- `src/lib/compliance.ts` — Alle Compliance-Checks
- `src/lib/compliance-legal-info.ts` — Rechtsgrundlagen-Mapping
- `src/components/dashboard/compliance-autopilot-widget.tsx` — UI-Darstellung

**Zu pruefende Normen:**
- **RDG §2 Abs. 1 (erlaubnispflichtige Rechtsdienstleistung)**: "jede Taetigkeit in konkreten fremden Angelegenheiten, sobald sie eine rechtliche Pruefung des Einzelfalls erfordert"
- **RDG §5 Abs. 1 (erlaubte Nebenleistung)**: Rechtsdienstleistung als Nebenleistung zum Hauptberuf — "zum Berufs- oder Taetigkeitsbild gehoerend"
- **RDG §6 (unentgeltliche Rechtsdienstleistung)**: Erlaubt wenn nicht gewerbsmaessig
- **StBerG §5 (Befugnis zu beschraenkter Hilfe)**: Buchfuehrungshilfe erlaubt, Steuerberatung nicht
- **UWG §5 Abs. 1 (irrefuehrende geschaeftliche Handlung)**: Compliance-Versprechen die nicht eingehalten werden

**METHODIK — Jede Compliance-Autopilot-Warnung einzeln klassifizieren:**

Fuer JEDE automatisierte Pruefung im Compliance-Autopilot:
1. Was genau prueft die Funktion?
2. Ist die Pruefung eine **faktische Datenverarbeitung** (z.B. "IfSG-Zertifikat laeuft am TT.MM.JJJJ ab") → ERLAUBT
3. Oder eine **rechtliche Bewertung** (z.B. "Dieser Vertrag wird kraft Gesetzes unbefristet") → PROBLEMATISCH
4. Oder eine **Handlungsempfehlung** (z.B. "Sie muessen jetzt X tun, sonst droht Y") → GRENZBEREICH
5. Klassifizierung: FAKTISCH | NEBENLEISTUNG | RECHTSBERATUNG

**Pruefungsfragen:**
1. Gibt es Pruefungen die als "rechtsverbindlich" dargestellt werden?
2. Gibt es Pruefungen die konkrete Rechtsfolgen aussprechen ("Vertrag ist unwirksam")?
3. Ist der Disclaimer ("kein Ersatz fuer Rechtsberatung") an JEDER Stelle sichtbar?
4. Werden Steuerberechnungen als "Schaetzungen" oder als "verbindlich" dargestellt?
5. Koennte ein Nutzer sich auf die Compliance-Pruefung verlassen und deshalb keinen Anwalt konsultieren?
6. Wird zwischen Information und Beratung klar getrennt?

---

## KONSOLIDIERUNG

Nach Abschluss aller 12 Agenten:

1. **Deduplizierung:** Findings aus mehreren Agenten zusammenfuehren
2. **Priorisierung:** Sortierung nach Rechtsfolge:
   - CRITICAL: Straftat, Bussgeld >25.000 EUR, DSGVO-Verstoss
   - HIGH: OWi, Vertragsrisiko, Haftung
   - MEDIUM: Compliance-Luecke, Best Practice
   - LOW: Optimierungspotenzial
   - HINWEIS: Zukuenftige Aenderung, Monitoring
3. **Gesamtbericht:** Tabelle aller Findings mit Severity, Norm, Fix-Aufwand
4. **Statistik:** Anzahl Findings pro Rechtsgebiet, pro Severity
5. **Sofort-Massnahmen:** Top 10 Fixes die vor Probebetrieb erledigt werden MUESSEN
6. **Monitoring-Liste:** Normen die in den naechsten 12 Monaten Aenderungen erfahren

**Der Konsolidierungsbericht wird als `docs/audits/YYYY-MM-DD-rechtsaudit.md` gespeichert.**

---

## NORMEN-REGISTER (80+ Normen)

| Bereich | Normen |
|---------|--------|
| Arbeitszeit | ArbZG, JArbSchG, KindArbSchV, MuSchG, MuSchArbV, BEEG |
| Urlaub/Entgelt | BUrlG, EFZG, TzBfG, NachwG, KSchG |
| Steuer/Kasse | AO §145-147a, KassenSichV, UStG, EStG, GoBD, DSFinV-K, Sachbezugswertverordnung |
| Datenschutz | DSGVO (25 Artikel), BDSG §22/§26, TDDDG §25 |
| Sozialversicherung | SGB IV §7/§8/§28a, MiLoG, AAG, SchwarzArbG §2a |
| Gastaetten/Lebensmittel | GastG, IfSG §42/§43, LMIV, VO (EG) 852/2004, LMHV, HACCP |
| Handelsrecht | HGB §238/§239/§257, GoBD, EU-Produkthaftungsrichtlinie |
| Trinkgeld/Zuschlaege | EStG §3/§3b, GewO §107, MiLoG §1, MTV |
| SaaS/EU | BGB §305-§327u, DDG §5, EU Data Act, CRA, BFSG, EU AI Act, Platform Workers |
| Arbeitsschutz | SGB IX, AGG, AUeG, EntgTranspG, ASiG, DGUV Vorschrift 2, SGB VII §193, BetrVG §87/§90 |
| E-Rechnung/Zahlungen | §14 UStG (neu), EN 16931, §146a Abs. 4 AO, ZAG, PSD2, GwG |
| Rechtsdienstleistung | RDG §2/§5/§6, StBerG §5, UWG §5 |

---

## PFLICHT-OUTPUT-TABELLE (am Ende JEDES Audit-Reports)

**ZWINGENDE DOPPELVERIFIKATIONS-REGEL:** Die End-Tabelle enthaelt NUR Findings,
die alle vier Verifikations-Schritte durchlaufen haben:

1. **Erstfund** mit konkreter Datei:Zeile + exaktem Normzitat (§ Abs. S. Nr.)
2. **Normprueung** — passt die Norm wirklich auf den Sachverhalt? Ausnahmen?
3. **Kompensations-Suche** — gibt es im Code eine Klausel/Logik/Migration, die das
   Finding entkraeftet? Wenn ja: Datei:Zeile + Begruendung warum nicht ausreichend.
4. **Nicht-Juristen-Erklaerung** — kann die Erklaerung-Spalte einem Owner ohne
   Jura-Background verstaendlich gemacht werden?

Findings, die nicht alle 4 Schritte durchlaufen haben, kommen **nicht** in die
End-Tabelle. Sie werden — falls inhaltlich relevant — unter einem separaten
Abschnitt "⚠ Hinweise (nicht doppelt verifiziert, vor Sprint-Aufnahme pruefen)"
gelistet, nicht vermischt.

Jeder finale Audit-Bericht MUSS am Ende eine Markdown-Tabelle im **/tabelle**-Skill-Format
enthalten — explizit nach den narrativen Sektionen, kompakt und Nicht-Juristen-tauglich.
Format ist verbindlich:

```markdown
| # | Severity | Norm | Bereich | Finding | Datei:Zeile | Erklaerung |
|---|----------|------|---------|---------|-------------|-----------|
| RA-001 | HIGH | DIN 14096 / §39 ArbSchG | Brandschutz | Brandschutzordnung Teil A fehlt als Pflicht-Aushang | src/lib/compliance-documents-seed.ts | Pflicht-Aushang in jedem Gastrobetrieb. §25 ArbSchG Bussgeld bis 25.000 EUR. Bei Personenschaden §229 StGB (fahrlaessige Koerperverletzung). |
| RA-019 | HIGH | §43 Abs. 4 IfSG | IfSG | Folgebelehrung-2-Jahres-Sperre in Schichtzuweisung BLOCKING | src/actions/shift-assignment.actions.ts:118 | Schichtzuweisung muss bei IfSG-Belehrung > 2 Jahre alt blockieren. §73 Abs. 1a Nr. 20 IfSG bis 25.000 EUR. NULLS-FIRST-Default-Bug pruefen (Reminder-Row mit issuedAt=null darf Branch nicht umgehen). |
```

PFLICHT: Direkt unter der Tabelle 4 Bloecke:

**Statistik:**
```
CRITICAL: X | HIGH: X | MEDIUM: X | LOW: X | OK/Vorbildlich: X
```

**Pflicht-Aushaenge-Spezial-Befunde:** wenn Pflicht-Aushaenge-Modul aktiv — Liste der
fehlenden, falsch-klassifizierten oder mit ungenauem Bussgeld-Hinweis versehenen Aushaenge.

**Top-10 Sofort-Massnahmen vor Probebetrieb:** sortiert nach Bussgeldhoehe x Eintrittswahrscheinlichkeit.

**Monitoring-Liste gesetzliche Aenderungen 12 Monate:** Tabelle Datum/Norm/Aktion (z.B.
EU AI Act Hochrisiko-KI ab 02.08.2026, EU CRA ab 11.12.2027, EU Pay Transparency 06.2026,
E-Rechnung Versand-Pflicht 01.01.2027).

**Erklaerung-Spalte: Pflicht-Inhalte:**
- Norm-Zitat mit § + Abs. + S. + Nr. (KEIN "siehe Gesetz" — exakte Zitation)
- KONKRETE Bussgeldhoehe oder Strafe in EUR (kein "moeglicherweise hoch")
- Fuer Nicht-Juristen verstaendlich — was passiert dem Owner real?
- Bei Compliance-Autopilot-Findings: zwingend RDG §2 vs §5-Klassifikation angeben
  ("faktische Datenverarbeitung" vs "rechtliche Bewertung")
