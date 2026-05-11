---
name: securityaudit
description: >
  Fuehrt ein umfassendes informationssicherheitliches Audit der gesamten Ma-nagement Codebase
  durch. 12 spezialisierte Security-Agenten pruefen 200+ Angriffsvektoren gegen OWASP Top 10
  (2025), OWASP ASVS 5.0, CWE Top 25 (2025), OWASP API Security Top 10 (2023), BSI
  IT-Grundschutz, NIS2, CRA, DSGVO Art. 32 (TOM) mit dreifacher Verifikation und Proof-of-Concept
  fuer jedes Finding. Use this skill whenever the user says "/securityaudit", "Securityaudit",
  "Security-Audit", "Sicherheitsaudit", "Sicherheitspruefung", "Pentest", "Penetrationstest",
  "Schwachstellenanalyse", "Vulnerability Assessment", "IT-Sicherheitspruefung", "CVE-Check",
  "OWASP-Audit", "ASVS-Pruefung", "BSI-Check", or asks to check the app for vulnerabilities,
  security flaws, injection attacks, authentication bypass, authorization issues, IDOR, BOLA,
  SSRF, XSS, CSRF, SQL injection, file upload vulnerabilities, cryptographic failures,
  insecure deserialization, supply chain attacks, or any specific CVE. Also trigger when the
  user mentions NIS2, CRA (Cyber Resilience Act), ISO 27001, or any specific attack technique
  in the context of auditing the codebase. This is the most thorough security audit available:
  no shortcuts, no efficiency compromises, every file read completely, every path traced end
  to end, every input sink verified against every taint source, every attack vector rebuilt
  as a concrete proof-of-concept.
---

# Securityaudit: Umfassendes informationssicherheitliches Audit

**Stand 2026-04-28** — Multi-Tenant Phase 2.5 aktiviert. Aktuelle Pflichtdateien
(Subdomain-Resolver, withSystemRLS, DANGER_SYSTEM_MODELS, validateEnterpriseDatabaseUrl,
SYSTEM_TENANT_SENTINEL, assertManagerOwnsEmployee) und Audit-Lessons-Learned aus
heutigem Round-2-Audit (NULLS-FIRST-Bypass-Klasse, Multi-Tenant-Composite-Unique-Keys,
Mixed-Schema-$transaction) sind eingearbeitet.

## APP-AKTUALITAETS-PRUEFUNG (Phase 0a, vor Audit-Start)

Vor jedem Audit-Start MUSS der Main-Agent verifizieren:

1. `git log --since="14 days ago" --oneline | wc -l` — bei > 20 Commits: alle
   Stand-Datum-Verweise im Skill als "veraltet" betrachten, frische Recherche pflicht
2. `ls prisma/migrations | tail -10` — letzte 10 Migrationen lesen, neue Models/Spalten
   in Audit aufnehmen (insb. Multi-Tenant-Constraints, neue PII-Felder)
3. `ls src/lib/api-tenant-wrapper.ts src/lib/tenant-bootstrap.ts 2>/dev/null` — wenn
   beide existieren: Multi-Tenant Phase 2 aktiv → Agent 13 (Multi-Tenant-Bridge)
   ZWINGEND
4. `ls src/actions/compliance-documents.actions.ts 2>/dev/null` — wenn vorhanden:
   Pflicht-Aushaenge-Modul aktiv → Agent 4 (Crypto/PII) und Agent 7 (Audit-Trail)
   muessen withSystemRLS-Coverage und IP/UA-Persistenz pruefen
5. `git rev-parse HEAD` — exakter Commit-Hash am Audit-Start dokumentieren
6. `cat .env | grep ENTERPRISE_DB_HOSTNAME_ALLOWLIST` — wenn nicht gesetzt UND
   Multi-Tenant Phase 2 aktiv: Agent 9 (Infrastruktur) Production-Blocker

## ANTI-SPAR-PROTOKOLL (NICHT VERHANDELBAR)

**Dieser Skill ist explizit so designt, dass Spar-Strategien VERBOTEN sind. Der
Fokus liegt zu 100 % auf Gruendlichkeit, nicht auf Geschwindigkeit oder Tokens.
Verstoesse machen das Audit wertlos und sind disqualifizierend.**

Folgende Praktiken sind ausdruecklich UNTERSAGT:

1. **Keine Stichproben.** Jede Datei im Pruef-Umfang MUSS vollstaendig gelesen werden.
   "5 von 30 Dateien repraesentativ" ist NICHT erlaubt — alle 30 lesen, kein `head -n`,
   kein `Read offset/limit` zur Token-Ersparnis, ausser Datei > 2000 Zeilen + dann
   alle Bloecke nacheinander.
2. **Keine Agenten-Reduktion.** Wenn der Skill 12 Agenten vorsieht, MUESSEN 12 Agenten
   dispatched werden. Nicht "die 4 wichtigsten" — alle 12, parallel in 3-4 Batches.
3. **Keine "wahrscheinlich-OK"-Verzichte.** Kein Agent darf eine Pruefung mit
   "sieht auf den ersten Blick gut aus" abkuerzen. Verifikation = Code-Zitat
   mit Datei:Zeile.
4. **Keine Token-Sparmassnahmen.** Kein Truncate von Outputs, kein "Rest analog",
   kein "siehe oben". Jeder Befund vollstaendig dokumentiert mit allen Pflichtfeldern
   aus dem OUTPUT-FORMAT.
5. **Keine Zeitlimit-Anpassung.** Wenn das Audit 4 Stunden braucht, darf der Main-Agent
   nicht nach 30 Minuten "aus Zeitgruenden" beenden. Wird das Token-Budget knapp,
   wird das dem User gemeldet — nicht das Audit verkuerzt.
6. **Keine Selbst-Bewertung als "gut genug".** Der Skill definiert die Vollstaendigkeits-
   Kriterien (Pflichtdateien-Liste, Pruefungsfragen, Geprueft-aber-sauber-Liste).
   Der Agent erfuellt sie oder das Audit ist nicht abgeschlossen.
7. **Keine Vorab-Annahmen.** Wenn der Skill sagt "lies Datei X vollstaendig", reicht
   nicht der Verweis auf Memory/Caches frueherer Audits. Frisch lesen, aktueller Stand.
8. **Falsch-Negativ-Vermeidung ist genauso wichtig wie Falsch-Positiv-Vermeidung.**
   Die "Geprueft-aber-sauber"-Liste MUSS mindestens so lang sein wie die Findings-Liste.

Verstoesse haben reale Konsequenzen — diese Audits laufen auf produktive Software, die
echte Menschen und echte Daten betrifft. Ein uebersehenes Finding kann zu DSGVO-
Bussgeld bis 20 Mio EUR, unbegrenzter Owner-Haftung, RCE in Production oder Owner-Abbruch
fuehren. Der Skill optimiert auf **Gruendlichkeit zu 100 %**.

Wenn der Agent in Versuchung ist hier zu sparen: lies diesen Block erneut.

---

## GRUNDSAETZLICHE ANWEISUNGEN

Du fuehrst ein Security-Audit auf dem Niveau eines zertifizierten Penetrationstesters (OSCP/OSWE/CEH) in Kombination mit einem Senior-Application-Security-Engineer durch. Dieses Audit simuliert die Arbeit eines spezialisierten Red-Team + Blue-Team + Compliance-Teams mit Expertise in 12 Sicherheitsdomaenen.

**KRITISCHE REGEL: Effizienz mit Zeit oder Tokens ist absolut fehl am Platz.** Diese App verarbeitet hochsensible Daten (PII nach Art. 9 DSGVO, Gesundheitsdaten, Finanzdaten, TSE-Kassendaten, Lohnabrechnungen). Ein einziger unentdeckter Fehler kann zu: Datenabfluss mit DSGVO-Bussgeld bis 20 Mio EUR / 4% Jahresumsatz, Strafverfahren nach Paragraf 202a-c, 303a-b StGB, Schadensersatz nach Art. 82 DSGVO, NIS2-Strafen bis 10 Mio EUR / 2% Jahresumsatz, vollstaendigem Reputationsverlust und Betriebsaufgabe fuehren.

**Jede Zeile Code, die sicherheitsrelevant ist, MUSS gelesen und analysiert werden. Kein Ueberfliegen, kein Zusammenfassen, kein Abkuerzen. Kein "looks fine" ohne Zeilenverweis. Keine pauschalen Aussagen.**

**DREIFACHE VERIFIKATION:** Jedes Finding durchlaeuft drei Pruefungsrunden:
1. **Erstfund:** Agent identifiziert potenzielle Schwachstelle mit CWE-Klassifikation, OWASP-Zuordnung und ersten IoC-Zeilen
2. **Exploit-Verifikation:** Agent rekonstruiert den exakten Angriffspfad (Taint-Source bis Sink) und skizziert einen konkreten Proof-of-Concept (Request, Payload, Bedingungen)
3. **Kompensations-Pruefung:** Agent sucht explizit nach kompensierenden Kontrollen (Middleware-Guard, Zod-Schema, RLS-Policy, Rate-Limit, CSP, fail2ban, etc.) die das Finding entkraeften koennten und zeigt Zeilennachweis, falls eine gefunden wird

**FALSCH-POSITIV-VERMEIDUNG:** Ein Finding wird NUR gemeldet, wenn:
- Die Schwachstelle durch eine konkrete Dateipfad:Zeile belegt ist
- Der exakte Taint-Flow (User-Input zu anfaelliger Funktion) rekonstruiert wurde
- KEINE kompensierende Kontrolle im Code gefunden wurde und die Suche nach Kompensation dokumentiert ist
- Die Ausnutzung mindestens skizziert (als PoC) werden kann theoretische Bedenken ohne Angriffspfad sind HINWEIS, kein Finding

**FALSCH-NEGATIV-VERMEIDUNG:** Jeder Agent pflegt eine explizite "Geprueft-aber-sauber"-Liste. Diese muss mindestens so lang sein wie die Findings-Liste. Wenn ein Agent nur wenige Findings hat, muss die "Geprueft-aber-sauber"-Liste dicht bevoelkert sein.

**OUTPUT-FORMAT pro Finding:**

```
FINDING [AGENT-XX-YY]
SEVERITY: CRITICAL | HIGH | MEDIUM | LOW | INFO
CVSS: X.Y (AV:N/AC:L/PR:N/UI:N/S:U/C:H/I:H/A:H) Vector begruenden
OWASP: A0X:2025 [Kategorie]
CWE: CWE-XXX [Name]
ASVS: V5.0 Vx.y.z Level [1|2|3]
DATEI: [Pfad:Zeile ggf. mehrere, alle aufzaehlen]
IST-ZUSTAND: [Was der Code tut, mit Code-Zitat <=15 Woerter]
ANGRIFFSPFAD: [Taint-Source bis Sink, konkret]
PROOF-OF-CONCEPT: [curl/Request/Payload-Beispiel]
IMPACT: [Was der Angreifer erreichen kann: RCE, Data Leak, AuthN-Bypass, DoS, ...]
RECHTSFOLGE: [DSGVO-Bussgeld, StGB, NIS2, ...]
FIX: [Konkreter Code-Vorschlag, gepatchte Version]
VERIFIKATION: [Bestaetigung des Angriffs + Ausschluss-Suche fuer Kompensation]
REGRESSIONS-TEST: [Konkreter Testfall, der die Luecke nach Fix verhindert]
```

---

## DURCHFUEHRUNG

Dispatche die folgenden 12 spezialisierten Agenten **parallel** in 3-4 Batches je nach Context-Kapazitaet. Jeder Agent ist Fachexperte fuer seine Sicherheitsdomaene. Nach Abschluss aller Agenten wird ein Konsolidierungsbericht erstellt und unter `docs/audits/YYYY-MM-DD-securityaudit.md` gespeichert.

Die Agenten-Reihenfolge ist bewusst gewaehlt: Erst externe Angriffsoberflaeche (AuthN, AuthZ, Injection), dann Crypto/Daten, dann Infrastruktur, dann Supply Chain, zuletzt Compliance und Governance.

**Wichtig zur Agenten-Ausstattung:** Jeder Agent bekommt Zugriff auf Grep, Glob, Read, Bash. Jeder Agent liest seine Pflichtdateien VOLLSTAENDIG (nicht nur Greps). Jeder Agent schreibt sein Findings-Dokument unter `docs/audits/YYYY-MM-DD-securityaudit-agentXX.md` als Rohmaterial fuer die Konsolidierung.

---

### AGENT 1: Authentifizierung & Session Management (OWASP A07:2025)

**Kritikalitaet:** Alle Findings in diesem Agenten haben mindestens HIGH-Severity wegen der unmittelbaren Bedrohung der gesamten App.

**Zu pruefende Dateien (VOLLSTAENDIG lesen):**
- `src/lib/auth.ts` Primaere Auth-Logik
- `src/lib/auth.config.ts` NextAuth-Provider-Konfiguration
- `src/lib/auth.edge.ts` Edge-Runtime-Variante
- `src/app/api/auth/[...nextauth]/route.ts` NextAuth-Route-Handler
- `src/middleware.ts` Request-Level-Auth, CVE-2025-29927 Pruefung
- `src/lib/password.ts` Password-Hashing (bcrypt + Pepper + SHA-256-Pre)
- `src/lib/password-validation.ts` Passwort-Staerke
- `src/lib/password-reset.ts` Token-Generierung/Validierung
- `src/actions/password-reset.actions.ts` Reset-Workflow
- `src/actions/auth.actions.ts` Login/Logout/Session
- `src/lib/two-factor.ts` TOTP-Generierung, atomare Replay-Protection
- `src/actions/two-factor.actions.ts` 2FA-Setup/-Enforcement
- `src/lib/session-manager.ts` Session-Lifecycle
- `src/lib/rate-limit.ts` IP+E-Mail-basiertes Rate-Limiting
- `src/lib/safe-compare.ts` Timing-safe-Vergleiche
- `src/lib/guards.ts` Auth-Guards, Role-Checks
- `src/components/account/two-factor-setup.tsx` 2FA-UI
- `src/components/terminal/pin-pad.tsx` PIN-Eingabe
- `src/components/employees/pin-form.tsx` PIN-Management
- `prisma/schema.prisma` Models: User, Session, RateLimitEntry
- `deploy/fail2ban/filter.d/ma-nagement.conf`
- `deploy/fail2ban/filter.d/ma-nagement-login.conf`
- `deploy/fail2ban/jail.local`

**Zu pruefende Standards/Schwachstellen:**
- OWASP ASVS 5.0 V6 (Authentication), V7 (Session Management)
- CWE-287 (Improper Authentication), CWE-307 (Improper Restriction of Excessive Auth Attempts), CWE-384 (Session Fixation), CWE-521 (Weak Password), CWE-613 (Insufficient Session Expiration), CWE-640 (Weak Password Recovery)
- CVE-2025-29927 Next.js Middleware Bypass via x-middleware-subrequest Header
- OWASP Authentication Cheat Sheet
- OWASP Session Management Cheat Sheet
- NIST SP 800-63B Digital Identity Guidelines

**Pruefungsfragen (jede einzeln beantworten, nicht pauschal):**
1. NEXTAUTH_SECRET: Wird das Fehlen in Production erzwungen (process.exit/throw)? Mindestlaenge 32 Bytes?
2. JWT-Algorithmus: Festverdrahtet auf JWE (A256CBC-HS512 oder vergleichbar)? Kein "alg: none" moeglich? Kein RS256/HS256-Confusion?
3. Session-Cookies: HttpOnly + Secure (production) + SameSite=Lax/Strict? __Host-Prefix?
4. Session-Lifetime: maxAge vs. updateAge vs. Idle-Timeout alle konsistent? Idle-Timeout serverseitig erzwungen?
5. Session-Revalidation: Wird bei Password-Aenderung/Deaktivierung die Session ungueltig? In welchem Intervall (30s vs 2min)?
6. Password-Hashing: bcrypt >=12 Rounds ODER Argon2id? SHA-256-Pre-Hash (gegen 72-Byte-Limit)? Pepper aus ENV, nicht im Repo?
7. Pepper-Rotation: Wird PASSWORD_PEPPER_PREVIOUS unterstuetzt? Gibt es Re-Hash-auf-Login?
8. Dummy-Hash: Wird bei unbekannter E-Mail trotzdem ein bcrypt-Vergleich gemacht (Timing-Equalization)?
9. Login-Rate-Limit: 5 Versuche pro E-Mail + 20 pro IP? Exponentieller Backoff? Fail2ban-Pattern greift?
10. 2FA-TOTP: HMAC-SHA1 (RFC 6238)? 30s-Fenster? Toleranz +/-1 Schritt? Replay-Protection via twoFactorLastUsedStep?
11. 2FA-Race-Condition: Check+Update in prisma.transaction()?
12. 2FA-Brute-Force: Rate-Limit auf 2FA-Code-Eingabe? Separate vom Login-Rate-Limit?
13. 2FA-Enumeration: Verraet die twoFactorRequired-Response, dass E-Mail+Password korrekt waren?
14. 2FA-Backup-Codes: Existieren? Einmalig verwendbar? bcrypt-gehasht? Rate-limitiert?
15. PIN (Terminal): Mindestlaenge 4? Lockout nach N Fehlversuchen? PIN im Klartext NIRGENDS?
16. Password-Reset-Token: crypto.randomBytes(32)? Einmalig? Ablauf <60 min? An E-Mail-Besitz gebunden?
17. Password-Reset-Flow: Verhindert User-Enumeration? Gleiche Response bei bekannt/unbekannt?
18. Password-Reset-Invalidierung: Invalidiert alle aktiven Sessions nach Reset?
19. CVE-2025-29927 Middleware Bypass: Ist next@16.x >= 16.0.7 ODER wird x-middleware-subrequest-Header explizit blockiert?
20. Middleware Auth-Bypass: Pruefen OB secret-Leakage, OB Fall-Through bei fehlendem Token, OB Regex-Bypass bei Path-Matching.
21. Remember-Me: Wenn ja, getrennte Cookie-Lifetime? Konto-Kompromittierung loggt alle Remember-Me-Sessions aus?
22. Account-Lockout: Nach Schwelle? Unlock via E-Mail?
23. OAuth/SSO (falls vorhanden): State-Parameter? PKCE? Nonce?
24. WebAuthn (falls vorhanden): Authenticator-Bindung? Discoverable Credentials?

**Geprueft-aber-sauber-Liste:** Dokumentiere mindestens 15 explizit gepruefte Punkte die sicher waren, mit Datei:Zeile-Verweis.

---

### AGENT 2: Autorisierung & Access Control (OWASP A01:2025, IDOR/BOLA)

**Kritikalitaet:** OWASP A01 #1-Risiko weltweit. In Multi-Tenant-SaaS die groesste Existenzgefahr.

**Zu pruefende Dateien (VOLLSTAENDIG lesen):**
- `src/lib/roles.ts` Rollen-Definitionen, Capability-Matrix
- `src/lib/tenant.ts` Tenant-Kontext, Org/Restaurant-Scoping
- `src/lib/guards.ts` Tenant-Boundary-Enforcement, requireRole/requireOwner
- `src/lib/prisma-rls.ts` Core RLS-Enforcement (withRLS, setRLS)
- `src/middleware.ts` Route-Guards
- `deploy/postgres/rls-policies.sql` PostgreSQL-RLS-Policies
- `deploy/postgres/init.sql` DB-User-Rechte (app_user nicht superuser)
- `src/actions/role.actions.ts` Role-CRUD
- **Stichprobenartig 15 Server-Actions** aus `src/actions/*.ts` (pruefen: auth check vor Datenzugriff, ownership check bei params.id, tenant-scoping):
  - `user.actions.ts`, `shift-crud.actions.ts`, `shift-assignment.actions.ts`, `vacation.actions.ts`, `sick-leave.actions.ts`, `cash-entry.actions.ts`, `invoice.actions.ts`, `outgoing-invoice.actions.ts`, `employee-documents.actions.ts`, `chat.actions.ts`, `shift-marketplace.actions.ts`, `data-breach.actions.ts`, `audit-log.actions.ts`, `settings.actions.ts`, `gdpr.actions.ts`
- **Alle 21 API-Routen** (`src/app/api/**/route.ts`) jede einzeln:
  - Auth via getServerSession? ODER Token-basiert (signiert)?
  - Tenant-Kontext gesetzt? Cross-Tenant-Leak moeglich?
- `src/app/api/uploads/[filename]/route.ts` und alle 10 Upload-Routen Ownership-Check VOR Datei-Auslieferung?
- `prisma/schema.prisma` Organization, Restaurant, RestaurantMembership

**Zu pruefende Standards/Schwachstellen:**
- OWASP API Security Top 10 (2023) API1 Broken Object Level Authorization (BOLA)
- OWASP API3 Broken Object Property Level Authorization (Mass Assignment + Excessive Data Exposure)
- CWE-284 (Improper Access Control), CWE-285 (Improper Authorization), CWE-639 (Authorization Bypass Through User-Controlled Key), CWE-863 (Incorrect Authorization)
- OWASP IDOR Cheat Sheet
- PostgreSQL RLS Bypass-Pattern (superuser, thread-local, infinite loop, app_user-Mismatch)

**Pruefungsfragen:**
1. RBAC-Hierarchie: owner > management > employee konsistent erzwungen? Gibt es Rollen-Escalation-Pfade (User kann sich selbst zum Owner machen)?
2. Capability-Check: Pro Action EXPLIZIT requireRole/requireOwner/requirePermission? Oder reicht Session-Check?
3. Tenant-Isolation: JEDE Datenbankabfrage mit organizationId/restaurantId gescoped? Oder existiert eine globale Abfrage ohne Scope?
4. RLS-Policies: Sind sie auf ALLEN multi-tenant-Tabellen aktiviert?
5. RLS-FORCE: FORCE ROW LEVEL SECURITY gesetzt (damit Table-Owner nicht bypassed)?
6. DB-User: Die App verbindet als app_user (nicht als postgres, nicht als superuser, nicht mit BYPASSRLS)?
7. RLS-Context: Wird pro Request ein SET LOCAL app.current_user_id gesetzt? Bei Fehler Fallback auf NULL (DENY-ALL)?
8. RLS-Context-Leak: Wenn eine Connection aus dem Pool wiederverwendet wird wird der RLS-Kontext zurueckgesetzt?
9. IDOR in Server Actions: Fuer jede Action mit input.id wird geprueft, dass die Ressource dem aktuellen User/Tenant gehoert? Mindestens 15 Actions explizit pruefen.
10. Predictable IDs: CUID/UUID v4 statt auto-increment? Oder zusaetzlich Ownership-Check?
11. Mass Assignment: Verwenden Actions Prisma.UserUpdateInput direkt, oder wird via Zod nur auf Whitelist-Felder gemapt?
12. Horizontal Privilege Escalation: Kann User A die Ressourcen von User B sehen durch ID-Manipulation?
13. Vertical Privilege Escalation: Kann employee via Action-Manipulation zu management-Action zugreifen?
14. Upload-Zugriff: Jede Datei hat Ownership-DB-Lookup VOR sendFile? Magic-URL-Pattern sicher gegen Enumeration?
15. Calendar-Token / Steuerberater-Token: Tokens kryptographisch sicher generiert (>=32 Bytes)? Ablauf? Revocation?
16. Cron-Routen: Authentifiziert (HMAC-Signature von Vercel/fly/Caddy)? Oder ungeschuetzt?
17. Demo-Action demo.actions.ts: Ist Demo-Modus sicher isoliert keine Production-Daten zugreifbar?
18. Public Endpoints (equipment-public.actions.ts): Bewusst public? Keine Data-Disclosure?
19. Referer-based Auth: NIRGENDS Referer-Check als einzige Auth-Schicht?
20. Direct URL Access: Koennen authentifizierte User ueber /settings/employees/[id] fremde Employees sehen ohne DB-Check?
21. Query-Parameter-basiert: ?userId=X wird NIRGENDS als Trust-Quelle verwendet (statt Session)?

**PoC-Anforderung:** Fuer JEDES IDOR-Finding muss ein konkreter curl-Request die Ausnutzung demonstrieren.

**Geprueft-aber-sauber-Liste:** Mindestens 20 Endpunkte explizit mit Datei:Zeile.

---

### AGENT 3: Injection & Input Validation (OWASP A03/A05:2025, Prisma-Operator-Injection)

**Kritikalitaet:** CWE-79 (XSS) #1 und CWE-89 (SQL) #2 in CWE Top 25 (2025).

**Zu pruefende Dateien (VOLLSTAENDIG lesen):**
- **ALLE 115 Server-Actions** in `src/actions/*.ts` systematisch durchgrepen auf:
  - prisma.queryRaw, prisma.executeRaw, queryRawUnsafe, executeRawUnsafe
  - findMany, findFirst, updateMany, deleteMany mit User-kontrolliertem where-Objekt (Operator-Injection!)
  - dangerouslySetInnerHTML
  - Dynamische JS-Code-Auswertung: eval, Funktions-Konstruktor, Timer mit String-Arg
  - Shell-Invokationen mit User-Input
  - fs.readFile, fs.writeFile mit User-kontrolliertem Pfad
- `src/lib/prisma.ts` Raw-SQL-Konfiguration
- `src/lib/invoice-parser.ts` Parser-Eingabe
- `src/lib/document-parser.ts` PDF-Parser, XXE-Pruefung
- `src/lib/search-index.ts` Search-Query-Handling
- `src/app/layout.tsx` dangerouslySetInnerHTML Theme-Script
- **Alle Komponenten** mit dangerouslySetInnerHTML via Grep
- **Alle Zod-Schemas** pruefen: .strict() verwendet? passthrough() vermieden? .refine() fuer kritische Pruefungen?

**Zu pruefende Standards/Schwachstellen:**
- OWASP Top 10 A03:2025 (Injection, nun zusammengefasst)
- CWE-89 SQL Injection, CWE-90 LDAP Injection, CWE-77 Command Injection, CWE-78 OS Command Injection, CWE-79 XSS, CWE-91 XML Injection, CWE-943 NoSQL Injection
- Prisma Operator Injection (aikido.dev): password = { not: "" } Bypass
- ReDoS (CWE-1333)
- Prototype Pollution (CWE-1321)
- XXE (CWE-611)

**Pruefungsfragen:**
1. Raw SQL: Existiert queryRawUnsafe oder executeRawUnsafe im Code (nur src/, NICHT src/generated)? Falls ja: Jede Stelle auf parametrisierte Args pruefen.
2. Prisma-Tagged-Template: queryRaw wird mit Prisma.sql oder Template-Literal verwendet (nicht String-Concatenation)?
3. Prisma-Operator-Injection: In findMany/findFirst wird das where-Objekt direkt aus User-Input genommen oder via Zod in feste Shape gemapt?
4. Beispiel-Pattern: prisma.user.findFirst({ where: { email: input.email, password: input.password } }) ist "input.password" ein String oder kann es { not: "" } sein?
5. Zod-Strictness: Verwenden Schemas .strict() oder fallen unbekannte Felder durch? passthrough() nur mit Begruendung?
6. File-Path-Handling: Werden User-Inputs via path.basename() + path.resolve() + Whitelist-Check gegen Path-Traversal geschuetzt?
7. XSS: Jede Verwendung von dangerouslySetInnerHTML einzeln auditieren. src/app/layout.tsx Theme-Script ist statisch und OK. Sonstige Verwendungen muessen DOMPurify-sanitized sein.
8. XSS via href/src: User-kontrollierte URLs in Links und Bildern werden javascript: und data: Schemata blockiert?
9. React-Markdown/Rich-Text: Falls verwendet strict-Mode, kein raw HTML erlaubt?
10. CSV-Injection: Export-Funktionen (datev-export, dsfinvk-export, absence-export, employee-export) werden Formeln mit Prefix-Apostroph oder Tab escaped?
11. Log Injection: Werden User-Inputs vor dem Logging JSON-serialisiert oder Kontrollzeichen escaped? pino/winston strukturiert?
12. Command Injection: Shell-Aufrufe mit User-Input? Falls ja: execFile + Array-Args? Oder sanitization?
13. ReDoS: Alle Regex-Patterns auf katastrophisches Backtracking pruefen: (a+)+, (a|aa)+, (.*a)+ etc. Wird User-Input gegen regex.test() ausgewertet?
14. User-generated Regex: NIRGENDS akzeptiert die App einen User-Regex als Input?
15. Prototype Pollution: Object.assign({}, req.body), Spread {...req.body}, Lodash merge vorhanden? Zod als Filter davor?
16. Deserialization: JSON.parse von User-Input mit reviver? YAML-Parser mit dynamischer Funktion? Safe-Load?
17. XXE: XML-Parser (fuer XRechnung Import?) mit disabled DTD und externe Entities deaktiviert? (libxmljs, fast-xml-parser)
18. SSTI (Server-Side Template Injection): Verwenden Mail-Templates User-Input direkt, oder via Escape-Funktion?
19. CSV-Parsing: Werden hochgeladene CSV-Dateien mit einem Parser gelesen, der Formeln nicht auswertet?
20. PDF-Parser / invoice-parser: Injection-Vektor durch manipulierte PDFs? pdf-parse Bekannte CVEs?

**PoC-Anforderung:** Fuer jedes XSS/SQL-Injection/Operator-Injection-Finding muss ein exploitierbarer Payload gezeigt werden.

**Geprueft-aber-sauber-Liste:** Mindestens 25 Actions + 10 Routen explizit bestaetigt.

---

### AGENT 4: Kryptographie & Secrets Management (OWASP A02:2025)

**Kritikalitaet:** Einmal falsch implementiert = gesamte Datenbank-Verschluesselung nutzlos.

**Zu pruefende Dateien (VOLLSTAENDIG lesen):**
- `src/lib/encryption.ts` AES-GCM-Implementierung
- `src/lib/pii-encryption.ts` PII-spezifische Wrapper
- `src/lib/e2e-crypto.ts` E2E-Chat-Verschluesselung
- `src/actions/e2e-key.actions.ts` E2E-Key-Management
- `src/lib/password.ts` bcrypt + Pepper + Pre-Hash
- `src/lib/safe-compare.ts` timingSafeEqual-Wrapper
- `src/lib/two-factor.ts` TOTP-Secret-Handling
- `src/lib/session-manager.ts` Session-ID-Generierung
- `src/middleware.ts` Secret-Reading
- `.env.example` Erwartete Env-Vars
- `.gitignore` Sicher: .env ausgeschlossen?
- `deploy/encryption-setup.sh` Key-Generierung
- `docs/security/pqc-migration-plan.md` Post-Quantum-Plan
- **Grep-Suche nach** hardcoded Secrets in src/

**Zu pruefende Standards/Schwachstellen:**
- OWASP ASVS 5.0 V11 (Cryptography)
- OWASP Cryptographic Storage Cheat Sheet
- NIST SP 800-38D (AES-GCM), SP 800-132 (KDF)
- RFC 8018 (PBKDF2), RFC 5869 (HKDF), RFC 7914 (scrypt), RFC 9106 (Argon2)
- CWE-327 (Broken/Risky Crypto), CWE-330 (Insufficient Random), CWE-331 (Insufficient Entropy), CWE-338 (Weak PRNG), CWE-759 (Use of One-Way Hash without Salt), CWE-798 (Hardcoded Credentials), CWE-916 (Use of Password Hash With Insufficient Computational Effort)

**Pruefungsfragen:**
1. AES-256-GCM: 12-Byte (96-bit) IV via crypto.randomBytes(12)? NIEMALS statisch, NIEMALS aus Timestamp?
2. IV-Reuse-Risiko: Wie oft wird mit demselben Key verschluesselt? Bei >2^32 Encryptions pro Key = Key-Rotation noetig (NIST 800-38D Limit).
3. IV-Speicherung: IV wird MIT dem Ciphertext gespeichert (prefix oder base64-konkatiniert)?
4. Auth-Tag: 16 Bytes? Wird bei Decryption verifiziert (throw on mismatch)?
5. Key-Derivation: ENCRYPTION_KEY ist 32 Bytes? Aus ENV, nicht aus Passphrase?
6. Falls KDF: scrypt mit N>=2^15 (32768), r=8, p=1? Oder Argon2id? Nicht PBKDF2 mit <600k Iter?
7. AAD (Associated Data): Wird kontext-spezifische AAD verwendet (z.B. User-ID), damit Ciphertext nicht in anderen Kontext umkopiert werden kann?
8. Key-Versionierung: Gibt es Key-Version-Prefix im Ciphertext, um Key-Rotation zu erlauben?
9. bcrypt-Rounds: Mindestens 12? Das Audit erwaehnt 14 bestaetigen.
10. bcrypt 72-Byte-Limit: SHA-256-Pre-Hash davor, damit lange Passwoerter nicht truncated werden?
11. Pepper: PASSWORD_PEPPER aus ENV? Mindestens 32 Bytes? NICHT im Repo?
12. Pepper-Rotation: PASSWORD_PEPPER_PREVIOUS unterstuetzt? Fallback-Verify?
13. PRNG fuer Security: crypto.randomBytes / crypto.randomUUID NIEMALS Math.random?
14. Constant-Time-Compare: Alle Security-Vergleiche (Webhook-Signaturen, Token, PIN-Hashes, HMACs) via crypto.timingSafeEqual?
15. safe-compare.ts: Pruefen ob wrapper wirklich timingSafeEqual verwendet und Buffer-Laengen-Padding vor dem Vergleich macht.
16. TOTP-Secret: crypto.randomBytes(20) = 160 bit (RFC 6238)? Base32-kodiert? AES-GCM-verschluesselt in DB?
17. Session-IDs: crypto.randomBytes(32)? Nicht aus Math.random oder Zeitstempel?
18. Password-Reset-Token: crypto.randomBytes(32), SHA-256-gehasht in DB (damit DB-Dump nicht Klartext-Tokens gibt)?
19. Env-Var-Erzwingung: ENCRYPTION_KEY, PASSWORD_PEPPER, NEXTAUTH_SECRET werfen Error bei Fehlen in Production?
20. Hardcoded Secrets: Grep-Ergebnisse zu password= etc. in src/ manuell pruefen.
21. .env im Git: git log --all --full-history -- .env Wurde .env jemals committed?
22. Client-Side-Secrets: NEXT_PUBLIC_-Variablen pruefen keine Secrets?
23. E2E-Crypto Chat: Libsodium oder Web Crypto API? ECDH + AES-GCM? Forward-Secrecy via Ephemeral-Keys?
24. E2E-Private-Key-Storage: localStorage (XSS-anfaellig!) oder IndexedDB mit WebCrypto-non-extractable-key? Dokumentierter Trade-off?
25. PKI/Zertifikate: Falls verwendet selbstsignierte Certs nur in Dev?
26. Crypto-Library-Versionen: libsodium, node-crypto aktuell?

**Geprueft-aber-sauber-Liste:** Mindestens 15 Crypto-Patterns explizit.

---

### AGENT 5: File Upload & Storage Security

**Kritikalitaet:** File-Upload ist haeufig der Angriffsvektor fuer RCE, Stored-XSS, ZIP-Slip.

**Zu pruefende Dateien (VOLLSTAENDIG lesen):**
- `src/app/api/uploads/[filename]/route.ts` Sick-Leave
- `src/app/api/uploads/chat/[filename]/route.ts`
- `src/app/api/uploads/contracts/[filename]/route.ts`
- `src/app/api/uploads/document-scans/[filename]/route.ts`
- `src/app/api/uploads/documents/[filename]/route.ts`
- `src/app/api/uploads/employee-documents/[filename]/route.ts`
- `src/app/api/uploads/invoices/[filename]/route.ts`
- `src/app/api/uploads/muschg-attests/[filename]/route.ts`
- `src/app/api/uploads/profile-pictures/[filename]/route.ts`
- `src/app/api/uploads/sick-leave/[filename]/route.ts`
- **Alle Server Actions mit Upload-Handling**, via Grep nach FormData, File, Buffer.from(await file.arrayBuffer()):
  - `src/actions/profile.actions.ts` (Profile-Picture)
  - `src/actions/sick-leave.actions.ts`
  - `src/actions/contract.actions.ts`
  - `src/actions/employee-documents.actions.ts`
  - `src/actions/document-scan.actions.ts`
  - `src/actions/invoice.actions.ts`
  - `src/actions/muschg-jarbschg.actions.ts`
- `uploads/` Directory-Permissions NIEMALS webroot-zugaenglich
- `next.config.ts` Body-Size-Limit

**Zu pruefende Standards/Schwachstellen:**
- OWASP File Upload Cheat Sheet
- CWE-434 (Unrestricted Upload), CWE-22 (Path Traversal), CWE-23 (Relative Path Traversal), CWE-73 (External Control of File Name or Path), CWE-367 (TOCTOU)
- ZIP-Slip (CVE-2018-1002200 und Varianten)
- Polyglot-Files (JPEG+PHP, PNG+JS)

**Pruefungsfragen:**
1. Filename-Generation: Dateien werden unter crypto.randomBytes(16).toString("hex") gespeichert, nicht unter User-Input-Name?
2. Path-Traversal: basename(input) + resolve(baseDir, filename) + startsWith(baseDir)-Check?
3. Null-Byte-Injection: Wird Null-Byte im Dateinamen rejected (CWE-158)?
4. Magic-Byte-Validation: Fuer jeden erlaubten Typ vollstaendige Signatur:
   - JPEG: FF D8 FF E0/E1/E8/DB (mindestens 4 Bytes, nicht nur 3)
   - PNG: 89 50 4E 47 0D 0A 1A 0A (volle 8 Bytes)
   - WebP: RIFF....WEBP (RIFF + Size + WEBP)
   - PDF: PDF-Magic-Header
   - GIF: GIF87a oder GIF89a (falls erlaubt)
5. MIME-Type-Spoofing: wird content-type-Header IGNORIERT und stattdessen nur Magic-Bytes verwendet?
6. Polyglot-Schutz: Wird bei Images zusaetzlich eine Re-Encoding-Pipeline verwendet (sharp/jimp), damit eingebettete PHP/JS zerstoert wird?
7. SVG-Upload: Erlaubt? Wenn ja: DOMPurify-Sanitization, Script-Tags entfernt? ODER komplett rejected?
8. File-Size-Limit: Pro Upload-Typ eigenes Limit (Profilbild 5MB, PDF 20MB, etc.)? Server-seitig erzwungen (NICHT nur client-seitig)?
9. Next.js-Body-Size: serverActions.bodySizeLimit oder Route-Handler-Limit konfiguriert?
10. Zip-Slip: Bei ZIP-Extraktion (falls vorhanden) werden relative Pfade mit ../ gefiltert?
11. Storage-Location: Uploads LIEGEN OUTSIDE webroot (uploads/ im Root, NICHT in public/)? Werden nur via API mit Auth-Check ausgeliefert?
12. Ownership-Check beim Download: DB-Lookup, dass Ressource-ID zum User/Tenant passt, VOR sendFile?
13. Content-Disposition: Bei Download Content-Disposition: attachment mit sanitizedem Dateinamen? filename*= fuer UTF-8?
14. X-Content-Type-Options: nosniff gesetzt?
15. Content-Type beim Response: Korrekt gesetzt (kein text/html fuer User-Content)?
16. Virus-Scanning: ClamAV oder vergleichbar integriert? Falls nicht: Dokumentiertes Akzeptiertes Risiko?
17. TOCTOU: Wird die Datei zwischen Magic-Byte-Check und fs.writeFile neu gelesen? Oder bleibt Buffer-Referenz?
18. Race-Condition: Zwei gleichzeitige Uploads mit gleichem Filename Collision-Handling?
19. Backward-Compatibility: Alte unverschluesselte Dateien (vor PII-Encryption) wie geregelt? Dokumentiert?
20. Chat-Media-Uploads: Eigene Auth-Pruefung (nur Chat-Teilnehmer)?

**PoC-Anforderung:** Polyglot-Payload oder Path-Traversal-Payload fuer jedes Finding.

**Geprueft-aber-sauber-Liste:** Alle 10 Upload-Routen explizit.

---

### AGENT 6: API-Routen, Webhooks, Rate-Limiting & SSRF-Schutz

**Zu pruefende Dateien (VOLLSTAENDIG lesen):**
- **Alle 21 API-Routen** in `src/app/api/**/route.ts`, Fokus:
  - `src/app/api/cron/*/route.ts` (5 Cron-Routen) Auth-Mechanismus
  - `src/app/api/calendar/[token]/route.ts` Token-Endpoint
  - `src/app/api/steuerberater/[token]/route.ts` Token-Endpoint
  - `src/app/api/temperature/route.ts` IoT-Sensor
  - `src/app/api/reminders/route.ts`, `/shift-reminders/route.ts`
- `src/lib/rate-limit.ts` Rate-Limiting-Implementierung
- `src/lib/sms.ts` Twilio-Webhook falls vorhanden
- `src/lib/pos/*.ts` POS-Integration mit Webhooks
- `src/lib/tse/fiskaly.ts` TSE-Webhook
- `next.config.ts` Rewrites, CORS
- `deploy/Caddyfile` Reverse-Proxy-Config

**Zu pruefende Standards/Schwachstellen:**
- OWASP API Top 10 (2023) alle 10
- CWE-918 SSRF, CWE-770 Allocation without Limit, CWE-799 Improper Control of Interaction Frequency
- CVE-2025-57822 Next.js Middleware SSRF
- Webhook Replay-Attacks

**Pruefungsfragen:**
1. Cron-Authentifizierung: Jede Cron-Route prueft einen shared Secret (via Header) mit timingSafeEqual? Oder ist sie unauthenticated reachable?
2. Cron-Replay: Timestamp + Nonce oder Idempotency-Key?
3. Token-Endpoints (Calendar/Steuerberater): Token >=32 Bytes? Ablaufdatum? Revocation-Moeglichkeit? Gleiche Response bei invalid/expired/not-found (Timing-Attack + User-Enumeration)?
4. Token-Reuse: Tokens werden NIE in URL-Params geloggt (Server-Logs, Browser-History, Referer)? Alternativ: Einmal-Link?
5. SSRF in Uploads: Wird import-from-URL (z.B. Invoice-Import, document-scan) gemacht? Falls ja:
   a) URL-Schema-Whitelist (nur https)?
   b) DNS-Rebinding-Schutz: Hostname aufloesen, IP pruefen, dann Request mit der IP machen (private Netze blockieren)?
   c) Redirects limitiert und nachverfolgt (max 3, kein localhost)?
6. CVE-2025-57822 Next.js SSRF: next@16.x >= 16.0.7? Oder Middleware-Redirect-Handling geprueft?
7. Rate-Limiting pro Endpoint: Login, Password-Reset, 2FA, Upload jeweils eigenes Limit?
8. Rate-Limit-Persistenz: In-Memory oder Redis? Bei Scaling Redis noetig.
9. Rate-Limit-Bypass: X-Forwarded-For vertrauenswuerdig (nur Caddy-Proxy)? In Caddy trusted_proxies konfiguriert?
10. Webhook-Signaturen: POS-Provider, TSE-Fiskaly, SumUp pruefen sie Signaturen? timingSafeEqual? Timestamp-Window 5-10 Min?
11. Webhook-Idempotency: Idempotency-Key-basierte Deduplication?
12. SMS-Provider (Twilio): Inbound-Webhooks? Signatur-Validation?
13. CORS-Konfiguration: next.config oder Caddy setzt Access-Control-Allow-Origin? NICHT Wildcard bei Auth-relevanten Endpoints?
14. OPTIONS-Handling: Preflight korrekt?
15. Request-Size-Limit: next.config.ts serverActions.bodySizeLimit? Oder Body-Parser-Limit?
16. Content-Type-Validation: Server-Actions erwarten application/x-www-form-urlencoded oder multipart andere Content-Types rejected?
17. Caddyfile Security-Headers: HSTS (max-age=31536000, includeSubDomains, preload), X-Content-Type-Options, X-Frame-Options/frame-ancestors, Referrer-Policy?
18. Caddy Rate-Limiting: Zusaetzlich zu App-Level?
19. fail2ban: Aktuelle Pattern, funktionierender jail, Log-Format geprueft?
20. API-Discovery: Gibt es keine NEXT_DATA Leaks fuer API-Struktur?

**PoC-Anforderung:** Curl-Request fuer jedes Cron/Webhook-Finding.

**Geprueft-aber-sauber-Liste:** Alle 21 API-Routen explizit.

---

### AGENT 7: Datenschutz, PII-Handling, Audit-Log & GDPR Art. 32 TOM

**Zu pruefende Dateien (VOLLSTAENDIG lesen):**
- `src/lib/audit.ts` Audit-Log-Implementierung + Hash-Kette
- `src/actions/audit-log.actions.ts`, `src/actions/audit-export.actions.ts`
- `src/actions/gdpr.actions.ts` Datenportabilitaet Art. 20, Loeschung Art. 17
- `src/actions/data-breach.actions.ts` Meldung Art. 33
- `src/actions/retention.actions.ts` Loeschkonzept
- `src/lib/retention.ts`
- `src/lib/pii-encryption.ts` Welche Felder verschluesselt?
- `src/components/onboarding/dsgvo-consent-dialog.tsx`
- `src/components/account/gdpr-section.tsx`, `data-correction-form.tsx`
- `prisma/schema.prisma` Modelle: AuditLog, TimeEntryAudit, DataBreach, ConsentLog, User, RestaurantMembership
- `docs/compliance/incident-response-plan.md`

**Zu pruefende Standards/Schwachstellen:**
- DSGVO Art. 5 (Grundsaetze), Art. 25 (Privacy by Design/Default), Art. 32 (TOM), Art. 33 (Meldepflicht 72h), Art. 34 (Betroffenen-Notification), Art. 17 (Loeschung), Art. 20 (Portabilitaet)
- BDSG Paragraf 26 (Beschaeftigtendatenschutz)
- CWE-312 (Cleartext Storage of Sensitive Information), CWE-313 (Cleartext Storage in File/ENV), CWE-532 (Insertion of Sensitive Information into Log File), CWE-359 (Exposure of Private Information)
- GoBD Hash-Kette Manipulationsschutz

**Pruefungsfragen:**
1. PII-Felder-Inventar: Welche Felder im Schema sind PII (taxId, IBAN, SSN, 2FA-Secret, POS-Keys, Telefonnummer, Adresse)?
2. Verschluesselung-at-Rest: Sind sie via AES-GCM verschluesselt ODER liegen im Klartext?
3. Verschluesselung-in-Transit: TLS 1.2+ via Caddy? Internal DB-TLS?
4. Verschluesselung-in-Logs: PII NIEMALS in audit.ts, error-logger.ts, Sentry?
5. Sentry-Konfiguration: beforeSend-Hook filtert PII? DSN im Client nicht exposed?
6. Audit-Hash-Kette: SHA-256? previousHash + entryHash Verkettung lueckenlos? Genesis-Hash definiert?
7. Audit-Manipulation: AuditLog-Table hat Trigger gegen UPDATE/DELETE? Oder RLS-Policy, die DENY?
8. Audit-Vollstaendigkeit: JEDE sicherheitsrelevante Aenderung (Login, 2FA-Enable, Role-Change, Data-Export, Data-Breach) wird via logAudit() erfasst (nicht direkt prisma.auditLog.create)?
9. Soft-Delete: deletedAt auf allen Models mit GoBD-Relevanz?
10. Hard-Delete: Gibt es Pfade, die echte DELETE-Statements absetzen? Nur nach 10-Jahres-Frist?
11. Retention-Jobs: Cron retention.actions.ts laeuft? Dokumentierter Loeschplan pro Datentyp?
12. Data Subject Requests:
    a) Art. 15 (Auskunft) Liefert gdpr.actions.ts ALLE gespeicherten Felder?
    b) Art. 17 (Loeschung) Soft-Delete genug? Oder echte Anonymisierung noetig?
    c) Art. 20 (Portabilitaet) Maschinenlesbares Format (JSON/CSV)?
13. Data-Breach Art. 33: Wird binnen 72h eine Meldung (Template) generiert? Welche Behoerden?
14. Drittlandtransfer: Twilio (US), Fiskaly (DE), SumUp (IRL), Sentry (US) Standard Contractual Clauses (SCC) dokumentiert?
15. Consent-Log: ConsentLog-Model trackt Einwilligung mit Version + Timestamp + IP?
16. Cookie-Banner / TDDDG Paragraf 25: Nur technisch notwendige Cookies ohne Einwilligung; Analytics nur nach Opt-In?
17. Privacy by Default: Neue User haben per Default restriktivste Einstellungen?
18. Employee-Permissions: Employees koennen andere Employee-Profile sehen? Bewusstes Akzeptiertes Risiko (dokumentiert in Audit-2026-03-31)?
19. GoBD-Hash-Kette Brechbarkeit: Wenn jemand DB-Admin ist kann er AuditLog-Zeilen entfernen und Hashes neu berechnen? Forensik-Pfad?
20. Backup-Verschluesselung: litestream-Backups verschluesselt (AES-256) mit separatem Key?

**Geprueft-aber-sauber-Liste:** Alle PII-Felder explizit mit Status.

---

### AGENT 8: Frontend-, Session- und Browser-Sicherheit (CSP, CSRF, XSS, Clickjacking)

**Zu pruefende Dateien (VOLLSTAENDIG lesen):**
- `next.config.ts` Security-Headers, CSP
- `src/middleware.ts` Headers-Setup
- `deploy/Caddyfile` Zusaetzliche Header vom Reverse-Proxy
- `src/app/layout.tsx` Head-Tags, Nonce-Propagierung
- **Alle Komponenten** mit localStorage via Grep
- `src/lib/e2e-crypto.ts` Client-Key-Storage
- `src/components/settings/chat-e2e-settings-form.tsx`
- `src/components/ui/theme-provider.tsx` localStorage theme
- **Alle Forms** unprotected actions?

**Zu pruefende Standards/Schwachstellen:**
- OWASP Secure Headers Project
- CWE-1021 (Clickjacking), CWE-79 (XSS), CWE-352 (CSRF), CWE-1275 (Sensitive Cookie Without SameSite)
- CSP Level 3
- CVE-2025-29927 (Next.js Middleware Bypass)

**Pruefungsfragen:**
1. CSP Header vorhanden? In next.config.ts, middleware.ts oder Caddyfile?
2. CSP-Strictness: default-src 'self'? script-src mit nonce + strict-dynamic? object-src 'none'? base-uri 'self'? form-action 'self'?
3. CSP-Nonce: Nonce pro Request generiert via crypto.randomBytes/randomUUID? In middleware, via getCspHeader oder aehnlich?
4. CSP-unsafe-inline: NIEMALS im Production-CSP?
5. CSP-unsafe-eval: Nur in Development (React DevTools)?
6. Report-URI: CSP-Verletzungen gemeldet (report-uri oder Reporting API)?
7. HSTS: max-age=31536000; includeSubDomains; preload? Im Caddyfile?
8. X-Frame-Options: SAMEORIGIN oder DENY? Alternativ frame-ancestors in CSP?
9. X-Content-Type-Options: nosniff?
10. Referrer-Policy: strict-origin-when-cross-origin oder strenger?
11. Permissions-Policy: camera=(), microphone=(), geolocation=(...) GPS nur wenn benoetigt?
12. Cookie-Flags: NextAuth Cookies mit HttpOnly, Secure, SameSite=Strict/Lax?
13. __Host- / __Secure- Cookie-Prefix fuer Session-Cookies?
14. CSRF-Schutz Server Actions: Next.js prueft Origin == Host? serverActions.allowedOrigins gesetzt bei Custom-Domains?
15. Clickjacking: Login-Seite Frame-Protection? Kritische Actions mit CSRF-Token (redundant zu Server Actions)?
16. localStorage Inventar: Was wird dort gespeichert? Sensitiv?
    a) Theme OK
    b) E2E-Private-Key XSS-Risiko, dokumentiert
    c) Andere? Pruefen.
17. E2E-Key-Storage: Wird IndexedDB mit nicht-extrahierbarem CryptoKey verwendet statt localStorage? Falls nicht: Dokumentierter Trade-off.
18. XSS in User-Inputs: Rendern die Components User-Inputs direkt als JSX-Text (React escape) ODER dangerouslySetInnerHTML?
19. Unvalidated Redirects: router.push(input.returnUrl) White-list auf gleiche Origin?
20. Open Redirect in Auth-Flow: ?callbackUrl=http://evil.com in NextAuth via useCallbackUrl geprueft?
21. React-Key-Attacks: User-kontrollierte key-Props auf Listen Rendering-Inconsistency?
22. Service-Worker / PWA: Nur https? Scope korrekt?

**Geprueft-aber-sauber-Liste:** Alle Header + localStorage-Keys + Redirect-Pfade.

---

### AGENT 9: Infrastruktur, Docker, Datenbank & Deployment-Haertung

**Zu pruefende Dateien (VOLLSTAENDIG lesen):**
- `Dockerfile` Multi-Stage, non-root user, minimal base
- `docker-compose.yml` + `docker-compose.dev.yml` Port-Expose, Volumes, Secrets
- `deploy/Caddyfile` TLS-Config, Header, trusted_proxies
- `deploy/postgres/init.sql` DB-User-Erstellung, Permissions
- `deploy/postgres/rls-policies.sql` RLS-Policies
- `deploy/litestream.yml` Backup-Encryption
- `deploy/fail2ban/*` Patterns + Jail
- `deploy/encryption-setup.sh` Key-Erstellung
- `.env.example` Gesamte Liste der Env-Vars
- `deploy/SECURITY.md`, `deploy/PENTEST-GUIDE.md`, `deploy/INFRASTRUCTURE.md`
- `next.config.ts` Production-Flags
- `.github/workflows/security.yml` (und deploy/.github/workflows/security.yml) CI-Security-Checks

**Zu pruefende Standards/Schwachstellen:**
- CIS Docker Benchmark v1.6
- CIS PostgreSQL Benchmark
- CIS Debian/Ubuntu Benchmark
- Mozilla SSL Configuration Generator (Modern)
- OWASP Docker Security Cheat Sheet
- CWE-250 (Execution with Unnecessary Privileges), CWE-732 (Incorrect Permission Assignment)

**Pruefungsfragen:**
1. Dockerfile: USER node (non-root)? HEALTHCHECK? Minimal Base (alpine/distroless)? Keine unnoetigen Tools?
2. Multi-Stage-Build: Build-Stage separat, final Image enthaelt keine Dev-Deps, keinen Source, nur .next/+public+runtime?
3. COPY --chown korrekt? Secrets nicht via COPY . .?
4. .dockerignore vorhanden .env, .git, node_modules, docs ausgeschlossen?
5. docker-compose: Keine Ports auf 0.0.0.0, nur localhost-bound oder hinter Caddy?
6. Docker-Secrets: Via env_file oder Docker-Secrets, NICHT via --env-file im Compose committed?
7. Volumes: uploads/ als persistenter Volume? DB-Volume separat?
8. Caddy: TLS 1.2 und 1.3 only (kein 1.0/1.1)? Moderne Cipher-Suites?
9. Caddy: HTTP zu HTTPS Redirect? HSTS preload?
10. Caddy: trusted_proxies aktiv, damit X-Forwarded-For nicht manipulierbar?
11. Caddy: Security-Headers (siehe Agent 8) an allen Locations?
12. PostgreSQL: Laeuft als non-root? Pg_hba.conf keine trust-Methode?
13. PostgreSQL: TLS fuer Client-Verbindungen? scram-sha-256?
14. PostgreSQL: Separater app_user mit minimalen Rechten (nur SELECT/INSERT/UPDATE/DELETE auf App-Tables, keine BYPASSRLS)?
15. PostgreSQL: RLS-Policies FORCE gesetzt? Gibt es Tables ohne RLS mit PII?
16. Backups: litestream verschluesselt? Separater Key (nicht gleicher wie ENCRYPTION_KEY)?
17. Backup-Restoration: Getestet? RTO/RPO dokumentiert?
18. Off-site-Backups: Vorhanden?
19. fail2ban: Jail aktiv? Pattern matched gegen echte Logs? Ban-Dauer angemessen (24h fuer Login)?
20. CI-Security-Workflow: npm audit --audit-level=high? Fail bei high/critical? Lockfile-integrity-Check?
21. CI-Secrets: GitHub-Secrets nicht in Logs leaken? GITHUB_TOKEN minimal-scoped?
22. Dependency-Scanning: Dependabot/Renovate aktiv? Falls nicht: manueller Rhythmus?
23. SBOM: deploy/sbom.json vorhanden, regelmaessig regeneriert (CRA Art. 13)?
24. Container-Scanning: Trivy/Grype/Snyk gegen Image?
25. Runtime-Security: Read-only Root-FS? Capability-Drop? seccomp/apparmor?

**Geprueft-aber-sauber-Liste:** Alle Deploy-Dateien explizit.

---

### AGENT 10: Supply Chain, Dependencies & CVE-Scanning

**Kritikalitaet:** OWASP A03:2025 (Software Supply Chain Failures) hoechste Exploitability laut OWASP.

**Zu pruefende Dateien (VOLLSTAENDIG lesen):**
- `package.json` Alle Dependencies + Scripts
- `package-lock.json` via npm ls stichprobenartig
- `deploy/sbom.json` existiert, aktuell?
- `deploy/.github/workflows/security.yml` CI-Checks
- `.npmrc` (falls vorhanden) Registry-Config, ignore-scripts?
- **Kritische Dependency-Analyse:**
  - next-auth@5.0.0-beta.30 Beta! Risiko dokumentieren.
  - next@16.x Welche Minor? CVE-2025-55182/-66478 (React2Shell), CVE-2025-29927 (Middleware Bypass), CVE-2025-57822 (SSRF) gefixt? Minimum 16.0.7.
  - react@19.2.4, react-dom@19.2.4 CVE-2025-55182 gefixt?
  - @prisma/client@7.6.0 aktuell?
  - bcryptjs@3.0.3 (statt native bcrypt) pure-JS, aber 3.x aktuell?
  - zod@^4.3.6 aktuell?
  - nodemailer@^7.0.13 kontinuierlich CVEs, pruefen
  - web-push@^3.6.7
  - jspdf@^4.2.1, exceljs@^4.4.0 Parser-CVEs?
  - @sentry/node@^10.47.0
  - pg@^8.20.0
- **Alle postinstall-Scripts**: npm pkg get scripts pruefen

**Zu pruefende Standards/Schwachstellen:**
- OWASP A03:2025 Software Supply Chain Failures
- CRA (Regulation EU 2024/2847) Art. 13 SBOM
- NTIA Minimum Elements for SBOM
- SLSA Supply Chain Levels for Software Artifacts
- CVE-2025-55182 (React2Shell RCE, CVSS 10.0)
- CVE-2025-66478 (Next.js RSC deserialization RCE, CVSS 10.0)
- CVE-2025-29927 (Next.js Middleware Bypass)
- CVE-2025-57822 (Next.js SSRF)
- Shai-Hulud npm attack (Sept 2025)
- qix/chalk-debug-ansi-styles Compromise (Sept 2025)
- tj-actions/changed-files Compromise (Mar 2025)

**Pruefungsfragen:**
1. next@16.x Version: >= 16.0.7 fuer CVE-2025-55182/66478-Fix?
2. next-auth@5 Beta: Upgrade auf 5.x stable wenn verfuegbar. Falls Beta: dokumentierter Risiko-Akzeptanz.
3. npm audit: Gibt es high/critical Findings? npm audit --audit-level=high?
4. Lockfile-Integritaet: Liefert npm install --package-lock-only Diff? (CI prueft das bereits bestaetigen)
5. Compromised-Packages-Scan: Suchen gegen bekannte kompromittierte Paket/Version-Tupel (chalk 5.3.1, debug 4.4.1, ansi-styles 6.2.2, etc. Shai-Hulud-Liste).
6. postinstall/postuninstall-Scripts in transient Deps? --ignore-scripts aktiv? Oder nur stichprobenartig whitelisted?
7. Registry-Integritaet: registry.npmjs.org? Oder private Mirror?
8. Package-Pinning: Sind alle deps entweder exakte Versionen oder gelockt via package-lock?
9. Dependency-Alter: Welche Deps haben >2 Jahre kein Update?
10. SBOM-Komplettheit: sbom.json enthaelt direct + transitive Deps mit Version und Hash?
11. SBOM-Format: SPDX oder CycloneDX (beide werden von CRA akzeptiert)?
12. Bekannte Vulns in TSE/POS-Libs: Fiskaly-SDK, SumUp-SDK, Twilio-SDK aktuell?
13. PDF-Parser (jspdf, pdf-parse falls verwendet): CVEs? Nutzung in invoice-parser.ts untersuchen.
14. Image-Libs (sharp, jimp falls verwendet): CVEs (sharp hat haufig CVEs)?
15. nodemailer: <7.x Versionen haben CVE-2024-39338 (SSRF) etc. Version bestaetigen.
16. zod@4 (frueher als Major angegeben): Stabil? Breaking Changes ignoriert?
17. Web-Push: VAPID-Keys? Bekannte CVEs?
18. bcryptjs vs bcrypt-native: bcryptjs ist langsamer zu Reihenfolge-Angriffe auf Langsamkeit? Oder reichen 14 Rounds?
19. Dependency-Tree-Duplikate: npm dedupe sauber?
20. Dev-Dependencies leaken nicht in Production Bundle (z.B. prisma-cli, typescript)?

**Konkrete Bash-Kommandos fuer diesen Agenten:**

```
npm audit --json --audit-level=low
npm ls --all --depth=10 | grep -E "(next-auth|next |react |@prisma)"
npm outdated --all
```

**Geprueft-aber-sauber-Liste:** Mindestens 20 Key-Deps mit Version + CVE-Status.

---

### AGENT 11: Logging, Monitoring, Incident Response & NIS2-Compliance

**Zu pruefende Dateien (VOLLSTAENDIG lesen):**
- `src/lib/error-logger.ts` Strukturiertes Logging
- `src/lib/audit.ts` Security-Event-Logging
- `src/lib/health-audit.ts` Health-Checks
- `src/lib/pii-encryption.ts` Werden PII-Filter im Log-Pfad verwendet?
- Sentry-Config (Grep nach @sentry/node Init)
- `docs/compliance/incident-response-plan.md` IR-Plan
- `docs/compliance/nis2-compliance.md` NIS2
- `docs/production-checklist.md`
- `.github/workflows/security.yml` Automatisierte Alerts
- Alle console.log, console.error in src/ (produktive) PII-Risiko

**Zu pruefende Standards/Schwachstellen:**
- NIS2 Umsetzungsgesetz (NIS2UmsG, seit 05.12.2025 in Kraft)
- BSI IT-SiG 2.0
- CRA Art. 13-14 (Vulnerability Disclosure)
- DSGVO Art. 33 (72h-Meldung)
- CWE-117 (Improper Output Neutralization for Logs), CWE-532 (Insertion of Sensitive Info into Log File), CWE-778 (Insufficient Logging)
- OWASP A09:2025 Security Logging and Alerting Failures

**Pruefungsfragen:**
1. Log-Injection: Werden User-Inputs vor Logging via JSON.stringify oder Kontrollzeichen-Escaping sanitiziert?
2. Structured Logging: pino/winston mit JSON-Format? Oder string-basiert (anfaellig fuer Log-Forging)?
3. Log-PII: console.log oder logger.info mit User-Objekten ohne PII-Redaction?
4. Sentry beforeSend: Filtert PII (Email, Token, IBAN)? Sampling-Rate? DSN-Server eingestellt?
5. Sentry Release-Info: Source-Maps hochgeladen, aber nicht oeffentlich?
6. Audit-Log Completeness: Matrix von sicherheitsrelevanten Events und ob logAudit aufgerufen wird:
   - Login (success/failure)
   - 2FA-Enable/Disable
   - Role-Change
   - Password-Change
   - Data-Export
   - Data-Breach-Entry
   - RLS-Escape-Attempt
   - Admin-Action
7. Audit-Log-Retention: 10 Jahre (GoBD)? Wird nicht auto-geloescht?
8. Alerting: Gibt es Alerts bei >N fehlgeschlagenen Logins pro Zeit? Bei neuen User-Creation-Spikes? Bei kritischen Actions?
9. NIS2-Scope: Ist Ma-nagement scope-relevant? (>=50 MA ODER >=10 Mio EUR Umsatz der KUNDEN beachten, nicht nur eigene). Falls im Scope: Registrierung bei BSI bis 06.03.2026 (bereits abgelaufen!)
10. NIS2-24h-Meldung: Gibt es im IR-Plan einen Fluss, damit der Kunde seine NIS2-Pflicht erfuellen kann?
11. DSGVO Art. 33 72h-Meldung: IR-Plan enthaelt Behoerden (LfD BaWue), Template, interne Eskalation?
12. CRA Art. 14 24h-Vulnerability-Reporting an ENISA: Ab 11.09.2026 Pflicht. Plan vorhanden?
13. Vulnerability Disclosure Policy: security.txt unter /.well-known/security.txt?
14. Security.txt Inhalt: Contact, Expires (max 1 Jahr), Encryption (PGP), Preferred-Languages?
15. Bug-Bounty / Responsible-Disclosure: Prozess dokumentiert?
16. Health-Checks: /health endpoint? Liefert keine sensitive Daten (Version, DB-Status ohne Credentials)?
17. Monitoring-Dashboard: Sentry, Uptime, Log-Aggregation?
18. Incident-Response-Uebung: Dokumentiert, wann zuletzt getestet?
19. Business-Continuity: RTO/RPO dokumentiert? Regelmaessige Backup-Restore-Tests?
20. Forensik-Faehigkeit: Wenn ein Breach passiert welche Logs sind verfuegbar? Audit-Log, Access-Log, DB-Audit-Trail?

**Geprueft-aber-sauber-Liste:** Alle Log-Pfade + IR-Plan-Abschnitte.

---

### AGENT 12: Business-Logic-Abuse, Anti-Automation & Missbrauchsszenarien

**Kritikalitaet:** Reine Code-Audits uebersehen Logic-Flaws. Dieser Agent denkt wie ein kreativer Angreifer mit gueltigem Account.

**Zu pruefende Dateien (breit + tief):**
- **Alle Workflows mit Geld/Zeit/Status-Uebergaengen**:
  - `src/actions/tip-distribution.actions.ts` Trinkgeld-Manipulation
  - `src/actions/time-entry.actions.ts` + `time-entry-dispute.actions.ts` Zeit-Falscheingabe
  - `src/actions/cash-entry.actions.ts` Kassenbuch-Storno
  - `src/actions/pos.actions.ts` POS-Transaktionen manipulieren
  - `src/actions/shift-swap.actions.ts` + `swap.actions.ts` Swap-Abuse
  - `src/actions/vacation.actions.ts` Urlaubsberechnung umgehen
  - `src/actions/overtime.actions.ts` Ueberstunden-Manipulation
  - `src/actions/outgoing-invoice.actions.ts` Rechnungsnummern-Luecken
  - `src/actions/tse.actions.ts` TSE-Signatur umgehen?
- `src/actions/two-factor.actions.ts` 2FA-Disable-Flow
- `src/actions/offboarding.actions.ts` Selbst-Offboarding moeglich?
- `src/actions/demo.actions.ts` Demo-Data-Kreuzkontamination mit echten?
- `src/actions/chat.actions.ts` Selbst-Gespraech, leere Empfaenger-Liste
- `src/actions/announcement.actions.ts` Massenspam
- `src/components/dashboard/compliance-autopilot-widget.tsx` Kann Bedingungen umgangen werden?
- `src/lib/work-time-rules.ts`, `src/lib/break-rules.ts` Off-by-one Exploits?

**Zu pruefende Standards/Schwachstellen:**
- OWASP A04:2025 Insecure Design
- OWASP WSTG-BUSLOGIC (Business Logic Testing)
- CWE-840 (Business Logic Errors), CWE-841 (Improper Enforcement of Behavioral Workflow)

**Pruefungsfragen (kreativ, role-play):**
1. Trinkgeld: Kann ein Mitarbeiter sich selbst mehr zuweisen? Summen manipulieren? Negative Werte?
2. Zeiterfassung: Kann ich meine eigenen TimeEntries retrospektiv editieren? Ueber Zeitzonen-Bug mehr Stunden erzeugen? Dispute nutzen um Managerfreigabe zu umgehen?
3. Kassenbuch: Kann ich einen Storno erzeugen ohne TSE-Signatur? Kann ich Storno-Eintrag selbst stornieren (Rekursion)?
4. POS: Kann ich POS-Transaktion manipulieren nachdem sie in DB ist (Audit-Log-Luecke)?
5. Shift-Swap: Kann ich einen Swap mit mir selbst erzeugen, um Regel-Evaluation auszuloesen (DoS)?
6. Urlaub: Kann ich mehr als mein Kontingent beantragen und approven? Ueber Edit-after-Approve mehr erhalten?
7. Ueberstunden: Kann ich negative Ueberstunden buchen? Oder beliebig viele positive?
8. Rechnungsnummern: Luecken erlaubt? Sequentiell? Kann ich Nummer aendern?
9. TSE: Kann ich einen Eintrag replay-signieren mit altem Timestamp?
10. 2FA-Disable: Erfordert Current-2FA-Code + Password? Oder nur Password?
11. Self-Offboarding: Kann ein User sich selbst deaktivieren? Owner sich selbst?
12. Owner-Transfer: Kann ein Owner den letzten Owner-Status downgraden (Org ohne Owner)?
13. Demo-Daten: Erzeugt demo.actions.ts deterministische Daten, oder koennen demo-IDs mit echten kollidieren?
14. Chat: Empfaenger-Liste kann leer sein? Self-Chat? Broadcast an ganze Org?
15. Announcements: Can-Publish-Rolle strikt? Kein Employee-Publish?
16. Schichtplanung: Kann ich mich selbst zur Schicht zuweisen fuer verbotene Stunden (ArbZG-Umgehung)?
17. MuSchG-Flow: Kann schwangere Mitarbeiterin eigenhaendig Schutzfrist aufheben?
18. Daten-Export: Kann employee Mass-Export aller Employees triggern?
19. Compliance-Autopilot: Kann Dismiss-Pattern permanent werden (Warnung nie wieder)?
20. Auto-Logout: Entsteht beim Logout eine Session, die noch 30s aktiv bleibt (Revalidation-Window)?
21. Concurrency: Zwei Devices gleichzeitig eingeloggt Sessions kollidieren? Race-Conditions auf Counter?
22. Resource Exhaustion: Kann ich beliebig viele Shifts erzeugen? Oder Files hochladen bis Disk voll?
23. Payroll-Report-Generation: Dauert lang + blockiert Event-Loop? DoS moeglich?
24. PDF-Generation (kassenbuch-pdf, schedule-print): kann ich eine massive PDF triggern (10.000 Seiten)?

**PoC-Anforderung:** Fuer jedes Logic-Flaw-Finding ein konkretes Nutzer-Szenario (Schritt-fuer-Schritt).

**Geprueft-aber-sauber-Liste:** Mindestens 15 Workflows explizit durchgespielt.

---

## KONSOLIDIERUNG

Nach Abschluss aller 12 Agenten:

1. **Deduplizierung:** Findings aus mehreren Agenten zusammenfuehren (z.B. localStorage-E2E-Key erscheint in Agent 4 und 8)
2. **CVSS-Neubewertung:** Jeder Finding wird auf CVSS-3.1 rescored, Team-CTO pruefen
3. **Priorisierung:** Sortierung nach CVSS + Exploitability:
   - CRITICAL (CVSS 9.0+): Pre-Auth RCE, Full AuthN-Bypass, Massdata-Leak
   - HIGH (CVSS 7.0-8.9): Post-Auth Priv-Escalation, Single-User-Data-Leak, Persistent XSS
   - MEDIUM (CVSS 4.0-6.9): Information Disclosure, Rate-Limit-Bypass, Low-Impact Logic-Flaw
   - LOW (CVSS 0.1-3.9): Security-Hygiene, Missing-Header, Minor Info-Leak
   - INFO: Hinweis ohne direkten Angriffspfad
4. **Executive Summary:** 1-Seiter fuer Management mit Top-5 Risiken, Deadline-Empfehlungen, NIS2-Status
5. **Detail-Bericht:** Pro Finding vollstaendige Doku nach Output-Format
6. **Remediation-Plan:** Tabelle mit Deadline-Vorschlag (Critical: 24h, High: 7d, Medium: 30d, Low: 90d) und Verantwortlichkeit
7. **Proof-of-Concept-Anhang:** Alle PoCs in einem Abschnitt (curl/Playwright-Scripts)
8. **Regressions-Test-Katalog:** Pro Finding ein Testfall (Jest/Playwright), der die Luecke nach Fix verhindert
9. **NIS2/CRA/DSGVO-Compliance-Matrix:** Welche Findings treffen welche Regulierung? Welche Meldepflichten entstehen?
10. **Vergleich mit letztem Audit** (docs/security/SECURITY-AUDIT-2026-03-31.md): Welche Findings sind noch offen? Welche neu hinzugekommen?

**Der Konsolidierungsbericht wird als docs/audits/YYYY-MM-DD-securityaudit.md gespeichert. Zusaetzlich -findings.md (Tabelle), -pocs.md (Proof-of-Concepts), -regression-tests.md (Testfaelle).**

---

## STANDARDS-REGISTER (200+ Angriffsvektoren)

| Bereich | Standards & CVEs |
|---------|------------------|
| OWASP Top 10 2025 | A01 Broken Access Control, A02 Security Misconfig, A03 Supply Chain Failures, A04 Crypto Failures, A05 Injection, A06 Insecure Design, A07 AuthN Failures, A08 Data Integrity, A09 Logging Failures, A10 Mishandling Exceptions |
| OWASP ASVS 5.0 | V1 Architecture, V2 Auth, V3 Session, V4 Access Control, V5 Validation, V6 Crypto, V7 Errors/Logs, V8 Data Protection, V9 Communications, V10 Malicious Code, V11 Business Logic, V12 Files, V13 API, V14 Config |
| OWASP API Top 10 2023 | API1 BOLA, API2 Auth, API3 Object Property AuthZ, API4 Resource Consumption, API5 Function Level AuthZ, API6 Business Flow, API7 SSRF, API8 Misconfig, API9 Inventory, API10 Unsafe Consumption |
| CWE Top 25 (2025) | CWE-79 XSS, CWE-89 SQLi, CWE-352 CSRF, CWE-862 Missing AuthZ, CWE-787 OOB Write, CWE-306 Missing AuthN, CWE-20 Improper Input, CWE-125 OOB Read, CWE-78 OS Cmd Injection, CWE-862/863 AuthZ, CWE-416 UAF, CWE-22 Path Traversal, CWE-476 NULL deref, CWE-434 Unrestricted Upload, CWE-287 Improper AuthN, CWE-502 Deser, CWE-798 Hardcoded Creds, CWE-918 SSRF, CWE-400 Uncontrolled Resource, CWE-611 XXE, CWE-77 Cmd Injection, CWE-119 Memory Buffer, CWE-120 Buffer Overflow, CWE-269 Improper Privilege Mgmt, CWE-94 Code Injection |
| Next.js CVEs (2025) | CVE-2025-55182/66478 React2Shell RCE, CVE-2025-29927 Middleware Bypass, CVE-2025-57822 SSRF, CVE-2025-55184 DoS, CVE-2025-55183 Source Exposure |
| NextAuth | CVE-2023-48309, next-auth@5 Beta-Risiko |
| Prisma | Operator-Injection (findFirst/findMany), queryRawUnsafe, TypedSQL |
| PostgreSQL | RLS-Bypass (BYPASSRLS, thread-local, app_user), FORCE RLS |
| Crypto | RFC 8452 (GCM-SIV), RFC 9106 (Argon2), NIST 800-38D (GCM-Limits), IV-Reuse, Timing-Attacks |
| HTTP Security | HSTS, CSP Level 3, X-Frame-Options, Permissions-Policy, Referrer-Policy, __Host-/__Secure-Cookie-Prefix, SameSite |
| File Upload | Magic-Bytes (JPEG/PNG/WebP/PDF/SVG), Polyglots, ZIP-Slip, Path-Traversal, Null-Byte |
| Supply Chain | OWASP A03:2025, CRA SBOM (Art. 13-14), SLSA, Shai-Hulud, qix-Compromise, tj-actions-Compromise |
| DE Regulierung | NIS2UmsG (seit 05.12.2025), BSI IT-Grundschutz++/ISO 27001, CRA (seit 10.12.2024, volle Wirkung 11.12.2027), IT-SiG 2.0 |
| DSGVO | Art. 5 (Grundsaetze), Art. 25 (Privacy by Design), Art. 32 TOM, Art. 33 (72h-Meldung), Art. 34 (Betroffenen-Notification), Art. 35 DSFA, Paragrafen 202a-c, 303a-b StGB |
| Webhook | HMAC-Timing-Safe-Compare, Timestamp-Window, Idempotency-Key |
| Session | Cookie-Flags, Session-Fixation, JWT alg-confusion, JWE vs JWS |
| Rate-Limit | Token-Bucket, Leaky-Bucket, Sliding-Window, fail2ban |

---

## ABSCHLUSSPRUEFUNG DURCH DEN MAIN-AGENT

Bevor der Konsolidierungsbericht finalisiert wird, fuehrt der Main-Agent (nicht die Sub-Agenten) eine finale Vier-Augen-Pruefung durch:

1. **Cross-Agent-Korrelation:** Hat Agent 2 (AuthZ) eine Action als "sauber" markiert, die Agent 3 (Injection) als anfaellig identifiziert hat? Konflikt aufloesen.
2. **Blind-Spot-Check:** Jeder Agent benennt EXPLIZIT seinen eigenen Blind-Spot. Der Main-Agent schliesst diese Luecken.
3. **False-Positive-Sanity-Check:** Jedes CRITICAL- und HIGH-Finding wird vom Main-Agent erneut mit dem konkreten Code verifiziert (Datei + Zeile erneut lesen).
4. **Exploit-Chain-Verkettung:** Der Main-Agent versucht, drei Findings niedrigerer Severity zu einer Kill-Chain (CRITICAL) zu kombinieren.
5. **Repo-Vergleich:** Der Main-Agent prueft git log --since="last audit" gegen die Findings wurden die Fixes aus dem letzten Audit tatsaechlich committed?
6. **Multi-Tenant-Defense-in-Depth:** Wenn Agent 13 (Multi-Tenant-Bridge) ein Finding meldet, MUSS der Main-Agent pruefen, ob bereits eine analoge Klasse von Findings in fruehere Audits aufgetaucht ist (NULLS-FIRST-Bypass-Klasse, Composite-Unique-Multi-Tenant-Klasse, Mixed-Schema-$transaction-Klasse) — und systematisch alle Vorkommen im Code suchen statt nur das gemeldete.

---

## AGENT 13 — MULTI-TENANT-BRIDGE & PHASE-2-AKTIVIERUNG (Stand 2026-04-28)

**Kritikalitaet:** Eigene Domain seit Multi-Tenant Phase 2.5. Cross-Tenant-Bugs sind Existenzgefahr (DSGVO Art. 32 Bussgeld bis 20 Mio EUR).

**Zu pruefende Pflichtdateien (VOLLSTAENDIG lesen):**
- `src/lib/tenant-bootstrap.ts` (TenantNotFoundError, TenantSystemError, resolveTenantContext, resolveTenantFromRequest)
- `src/lib/api-tenant-wrapper.ts` (withApiTenant)
- `src/lib/tenant-context.ts` (AsyncLocalStorage, runWithTenant, resolveTenantSlugFromHost)
- `src/lib/prisma.ts` (DANGER_SYSTEM_MODELS, getTenantClient, validateEnterpriseDatabaseUrl, wrapTransactionTx, tenantClientCache)
- `src/lib/prisma-rls.ts` (withRLS, withSystemRLS, forEachTenantInCron)
- `src/lib/idempotency.ts` (SYSTEM_TENANT_SENTINEL "__system__")
- `src/middleware.ts` (matcher, resolveTenantFromHost)
- `src/app/(app)/layout.tsx` (runWithTenant + TenantNotFoundError-Handling)
- ALLE `src/app/api/**/route.ts` — withApiTenant-Wrapper-Coverage
- `prisma/schema.prisma` (Tenant, BackupLog, ComplianceDocument-Familie, Multi-Tenant-Constraints)
- `deploy/postgres/rls-policies.sql`
- `deploy/Caddyfile` (strict_sni_host, header_up -X-Tenant-Slug)
- `.env` (ENTERPRISE_DB_HOSTNAME_ALLOWLIST)

**Pruefungsfragen:**
1. Wird der Tenant-Slug aus `host`-Header derived (nicht aus Client-`x-tenant-slug`)? api-tenant-wrapper Z.~75
2. Wird TenantNotFoundError als 404, TenantSystemError als 503 gehandhabt (nicht silent Default-Fallback)? layout.tsx + api-tenant-wrapper.ts
3. extractSchemaFromUrl: Komma-Listen explizit abgelehnt? `^[a-zA-Z_][a-zA-Z0-9_]*$`?
4. validateEnterpriseDatabaseUrl: Hardcoded Deny-Liste fuer Loopback (127.x, ::1), Link-Local (169.254.0.0/16), IPv6-Link-Local (fe80::/10), Metadata-IPs (169.254.169.254, metadata.google.internal)?
5. validateEnterpriseDatabaseUrl: IPv6-Bracket-Notation `[::1]` wird normalisiert vor Comparison?
6. Multi-Tenant-Composite-Unique-Keys: Bei Tabellen mit User-Bezug (z.B. ComplianceDocumentAcknowledgment) — enthaelt der Unique-Key restaurantId? Oder blockiert er Multi-Tenant-User?
7. Mixed-Schema-$transaction: wrapTransactionTx wirft bei DANGER_SYSTEM_MODELS in Tenant-tx?
8. NULLS-FIRST-Default-Bypass: Bei `findFirst({ orderBy: { date: "desc" }})` mit Reminder-Rows (issuedAt=null) — wird `nulls: "last"` ODER `where: { date: { not: null } }` gesetzt?
9. SYSTEM_TENANT_SENTINEL: IdempotencyKey nutzt "__system__" statt NULL fuer System-Cron-Events?
10. CHECK-Constraint Tenant.slug `!~ '^__'` aktiv (verhindert dass realer Slug "__system__" angelegt wird)?
11. forEachTenantInCron: nutzt `systemPrisma.tenant.findMany` statt `prisma.restaurant.findMany`?
12. forEachTenantInCron: Production-Fail-loud bei leerer Tenant-Tabelle (triggerSecurityAlert eventType="missing_tenant_table")?
13. Caddyfile: `strict_sni_host on` aktiv (Host-Header-Spoofing-Schutz am Reverse-Proxy)?
14. Caddyfile: `header_up -X-Tenant-Slug` strippt client-side Header?
15. Sentinel-Test rls-coverage.test.ts: deckt alle tenant-scoped Models ab (Read aus prisma.schema)?
16. ENV ENTERPRISE_DB_HOSTNAME_ALLOWLIST: gesetzt in Production?
17. resolveTenantSlugFromHost: mind. 4 Segmente + Anker `parts[1] === "app"`? Reservierte Subdomains (app/www/admin/api/static/cdn/mail/smtp/ftp)?
18. tenantClientCache: globalThis-Cache (Hot-Reload-safe)? LRU-Eviction mit $disconnect()?
19. Compliance-Documents-Familie: alle Posts/History/Acks-Zugriffe via withSystemRLS gewrappt?
20. Per-Tenant-Filesystem-Isolation: uploads/<slug>/<file> oder shared mit Ownership-Check?
21. Layout-Bridge `(app)/layout.tsx` ruft `runWithTenant(ctx, fn)` UM `auth()` (sodass auth() im richtigen Schema laeuft)?
22. API-Routes: alle 21+ Routes mit withApiTenant gewrappt? Ausnahmen (auth/health/csp-report) explizit dokumentiert?
23. Sub-Action `confirmFolgebelehrung` (oder vergleichbare) — loadTargetMembership-Pre-Check vor dem Write?
24. PIN-Lockout-Bucket: pro `(managerId, userId)` statt nur `userId`? Sonst DoS gegen Service-MA.
25. Audit-Log Client-IP: rightmost X-Forwarded-For (statt hardcoded "terminal" oder erstem-XFF)?

**Geprueft-aber-sauber-Liste:** Mind. 25 Multi-Tenant-Patterns explizit (Subdomain-Resolver, withApiTenant-Coverage, withSystemRLS-Coverage, NULLS-Defaults, Composite-Keys, Mixed-Schema-Throw, etc.)

---

## META-ANWEISUNG: VERHALTEN BEI UNSICHERHEIT

Wenn ein Agent sich unsicher ist, ob ein Pattern eine Schwachstelle ist:
1. NIEMALS stillschweigend als "OK" markieren
2. Als "HINWEIS" mit dem Titel "Verifikation empfohlen" dokumentieren
3. Explizit die Daten sammeln, die eine Entscheidung erlauben wuerden (fehlende Doku, Runtime-Verhalten, Production-Config)
4. Empfehlung geben, welche weitere Pruefung (manueller Pentest, Code-Review durch Dritten, Runtime-Tracing) den Zweifel aufloesen koennte

Das Audit endet NIEMALS mit "alles sauber" es endet mit einer vollstaendigen Liste aller gepruften Patterns + einer klaren Aussage, welche nicht abschliessend bewertet werden konnten.

Denke daran: Die Codebase lebt. Morgen kann ein neuer Commit die heutige "sauber"-Einschaetzung brechen. Dieses Audit ist ein Snapshot dokumentiere den exakten Git-Commit-Hash zu Beginn des Audits.

---

## PFLICHT-OUTPUT-TABELLE (am Ende JEDES Audit-Reports)

**ZWINGENDE DOPPELVERIFIKATIONS-REGEL:** Die End-Tabelle enthaelt NUR Findings,
die alle vier Verifikations-Schritte durchlaufen haben:

1. **Erstfund** mit konkreter Datei:Zeile + CWE/OWASP/ASVS-Klassifikation + IoC-Zeilen
2. **Exploit-Verifikation** — Taint-Source bis Sink rekonstruiert, Proof-of-Concept
   (Request, Payload, Bedingungen) skizziert
3. **Kompensations-Suche** — gibt es Middleware-Guard, Zod-Schema, RLS-Policy,
   Rate-Limit, CSP, fail2ban, die das Finding entkraeften? Datei:Zeile + Begruendung
4. **Nicht-Techniker-Erklaerung** — kann die Erklaerung-Spalte einem Owner ohne
   Security-Background verstaendlich gemacht werden? (Angriffsweg + Schadensfolge in EUR)

Findings, die nicht alle 4 Schritte durchlaufen haben, kommen **nicht** in die
End-Tabelle. Sie werden — falls inhaltlich relevant — unter einem separaten
Abschnitt "⚠ Hinweise (nicht doppelt verifiziert, vor Sprint-Aufnahme pruefen)"
gelistet, nicht vermischt.

Jeder finale Audit-Bericht MUSS am Ende eine Markdown-Tabelle im **/tabelle**-Skill-Format
enthalten — explizit nach den narrativen Sektionen, kompakt und Nicht-Techniker-tauglich.
Format ist verbindlich:

```markdown
| # | Severity | OWASP/CWE/ASVS | Bereich | Finding | Datei:Zeile | Erklaerung |
|---|----------|----------------|---------|---------|-------------|-----------|
| SEC-001 | CRITICAL | A01:2025 / CWE-290 / V4.1.5 | AuthZ | Tenant-Spoofing via x-tenant-slug | src/lib/api-tenant-wrapper.ts:60 | Angreifer mit Login in Tenant A schickt curl -H "x-tenant-slug: tenant-b" → liest fremde Daten. Schaden: DSGVO Art. 32 Bussgeld bis 20 Mio EUR + Reputationsverlust. |
| SEC-002 | HIGH | A04:2025 / CWE-636 / V14.2 | Tenant-Bridge | Fail-soft auf DEFAULT bei DB-Down | src/lib/tenant-bootstrap.ts:80 | DB transient down → ALLE Anfragen landen in Default-Schema. Cross-Tenant-Inserts irreversibel. |
```

PFLICHT: Direkt unter der Tabelle 3 Bloecke:

**Statistik:**
```
CRITICAL: X | HIGH: X | MEDIUM: X | LOW: X | INFO: X | OK: X
```

**Top-N Production-Blocker (sortiert):**
1. SEC-XXX — kurze Begruendung warum Production-Blocker
2. ...

**Geprueft-aber-sauber (>= Anzahl Findings):** Liste Datei:Zeile + warum sauber.

Die Tabelle erscheint AM ENDE des Audit-Reports — nicht in der Mitte, nicht zwischen
narrativen Sektionen. Sie ist die EINZIGE Quelle die fuer Triage/Sprint-Planung
verwendet wird; alle anderen Sektionen sind Beleg-Material.

**Erklaerung-Spalte: Pflicht-Inhalte:**
- Angriffsweg in 1-2 Saetzen (Was tut der Angreifer? — `curl -H "..."`, "Manager A klickt...")
- KONKRETE Schadensfolge: Bussgeldhoehe, RCE/Data-Leak/AuthN-Bypass, Strafe
- Fuer Nicht-Techniker verstaendlich (kein "CVE-XYZ deserialization in libfoo" — sondern "Angreifer kann beliebigen Code auf Server ausfuehren")
