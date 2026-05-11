---
name: audit-security
description: >
  Fuehrt ein umfassendes informationssicherheitliches Audit einer beliebigen Codebase
  durch (web-app, mobile, backend, infra). 12 spezialisierte Security-Agenten pruefen
  200+ Angriffsvektoren gegen OWASP Top 10 (2025), OWASP ASVS 5.0, CWE Top 25 (2025),
  OWASP API Security Top 10 (2023), NIST SP 800-53, NIS2 mit dreifacher Verifikation
  und Proof-of-Concept fuer jedes Finding. Use this skill whenever the user says
  "/audit-security", "Security-Audit", "Pentest", "Penetrationstest",
  "Schwachstellenanalyse", "Vulnerability Assessment", "Code-Security-Review",
  "OWASP-Check", "ASVS-Pruefung", or asks to audit any app for security
  vulnerabilities (injection, auth bypass, IDOR, SSRF, XSS, CSRF, SQL-i, crypto
  failures, supply-chain, RCE). Generic version — works on ANY tech stack
  (Node/Python/Go/Java/Rust/PHP, REST/GraphQL/gRPC, SQL/NoSQL). No shortcuts,
  no efficiency compromises, every relevant file read completely, every input
  sink verified against every taint source.
---

# audit-security: Universelles Informationssicherheits-Audit

Stack-agnostische Version. Erkennt Tech-Stack automatisch aus Projekt-Indikatoren
(package.json / pyproject.toml / go.mod / Cargo.toml / composer.json / build.gradle)
und passt Pruefumfang entsprechend an.

## DETECT-Phase (Phase 0, vor Audit-Start)

Vor jedem Audit-Start MUSS der Main-Agent verifizieren:

1. **Stack-Detection** — welche Sprache(n), welche Frameworks?
   - `ls package.json pyproject.toml go.mod Cargo.toml composer.json pom.xml`
   - Frameworks aus Manifest: Next.js / Express / FastAPI / Django / Spring / Gin / etc.
2. **DB-Detection** — welche Datenbank(en) und welche ORMs/Query-Builder?
   - Prisma, TypeORM, SQLAlchemy, Django ORM, GORM, Diesel, Eloquent, ...
   - Native Driver mit Raw-SQL?
3. **Auth-Detection** — welcher Auth-Stack?
   - NextAuth, Passport, Lucia, Clerk, Auth0, Firebase Auth, Cognito, Keycloak, ...
   - Eigener JWT-/Session-Code?
4. **Crypto-Detection** — was wird verschluesselt, wie?
   - Native crypto / libsodium / WebCrypto / OS-Keychain / KMS?
5. **Deployment-Detection** — wo laeuft das?
   - Vercel / AWS / GCP / Azure / Fly / Render / Self-hosted / K8s?
   - Container? Docker / Podman? Multi-Tenancy aktiv?
6. **Git-Recency** — wie aktiv ist die Codebase?
   - `git log --since="30 days ago" --oneline | wc -l`

Diese Detection liefert die Liste der **anwendbaren Agenten** und die **Pflicht-Dateien**.

---

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
echte Menschen und echte Daten betrifft. Ein uebersehenes Finding kann zu Datenverlust,
Strafzahlung, Reputationsverlust oder Personenschaden fuehren. Der Skill optimiert auf
**Gruendlichkeit zu 100 %**.

Wenn der Agent in Versuchung ist hier zu sparen: lies diesen Block erneut.

---

## GRUNDSAETZLICHE ANWEISUNGEN

Du fuehrst ein Security-Audit auf dem Niveau eines zertifizierten Penetrationstesters
(OSCP/OSWE/CEH) in Kombination mit einem Senior-Application-Security-Engineer durch.
Dieses Audit simuliert die Arbeit eines Red-Team + Blue-Team + Compliance-Teams mit
Expertise in 12 Sicherheitsdomaenen.

**Jede Zeile Code, die sicherheitsrelevant ist, MUSS gelesen und analysiert werden.
Kein Ueberfliegen, kein Zusammenfassen, kein Abkuerzen. Kein "looks fine" ohne
Zeilenverweis. Keine pauschalen Aussagen.**

**DREIFACHE VERIFIKATION:** Jedes Finding durchlaeuft drei Pruefungsrunden:
1. **Erstfund:** Schwachstelle mit CWE-Klassifikation, OWASP-Zuordnung und IoC-Zeilen
2. **Exploit-Verifikation:** Exakter Angriffspfad (Taint-Source bis Sink), konkreter
   Proof-of-Concept (Request, Payload, Bedingungen)
3. **Kompensations-Pruefung:** Explizite Suche nach kompensierenden Kontrollen
   (Middleware-Guard, Input-Validation, WAF, Rate-Limit, CSP, fail2ban, etc.) mit
   Zeilennachweis falls gefunden

**FALSCH-POSITIV-VERMEIDUNG:** Ein Finding wird NUR gemeldet, wenn:
- Schwachstelle durch konkrete Datei:Zeile belegt ist
- Taint-Flow (User-Input zu Sink) rekonstruiert wurde
- KEINE kompensierende Kontrolle gefunden + Suche dokumentiert
- Ausnutzung mindestens skizziert (PoC) — theoretische Bedenken sind HINWEIS, kein Finding

**FALSCH-NEGATIV-VERMEIDUNG:** "Geprueft-aber-sauber"-Liste pro Agent — mindestens so
lang wie Findings-Liste.

**OUTPUT-FORMAT pro Finding:**

```
FINDING [AGENT-XX-YY]
SEVERITY: CRITICAL | HIGH | MEDIUM | LOW | INFO
CVSS: X.Y (AV:N/AC:L/PR:N/UI:N/S:U/C:H/I:H/A:H)
OWASP: A0X:2025 [Kategorie]
CWE: CWE-XXX [Name]
ASVS: V5.0 Vx.y.z Level [1|2|3]
DATEI: [Pfad:Zeile]
IST-ZUSTAND: [Was der Code tut, mit Code-Zitat <=15 Woerter]
ANGRIFFSPFAD: [Taint-Source bis Sink, konkret]
PROOF-OF-CONCEPT: [curl/Request/Payload]
IMPACT: [RCE / Data-Leak / AuthN-Bypass / DoS / ...]
RECHTSFOLGE: [Bei rechtsrelevanten Findings — sonst leer lassen]
FIX: [Konkreter Code-Vorschlag]
VERIFIKATION: [Bestaetigung + Ausschluss-Suche fuer Kompensation]
REGRESSIONS-TEST: [Konkreter Testfall]
```

---

## DURCHFUEHRUNG

Dispatche die 12 spezialisierten Agenten **parallel** in 3-4 Batches. Jeder Agent ist
Fachexperte fuer seine Domaene, liest seine Pflichtdateien VOLLSTAENDIG und schreibt
`docs/audits/YYYY-MM-DD-audit-security-agentXX.md` als Rohmaterial.

Die Agenten-Reihenfolge: erst externe Angriffsoberflaeche, dann Crypto/Daten, dann
Infrastruktur, dann Supply Chain, zuletzt Compliance.

---

### AGENT 1: Authentifizierung & Session Management

**OWASP A07:2025, ASVS V6/V7.**

**Pflichtdateien (Stack-spezifisch, alle vollstaendig lesen):**
- Auth-Lib (NextAuth/Passport/Lucia/Clerk/eigene): config + callbacks + provider
- Password-Hashing (bcrypt/argon2/scrypt): rounds + pepper + pre-hash
- Session-Manager: lifecycle + revocation
- 2FA/TOTP: secret-storage + replay-protection
- Password-Reset: token-generation + validation + invalidation
- Rate-Limiter: per-IP + per-email/username
- Middleware/Guards: auth-checks pro Route

**Pruefungsfragen:** AUTH_SECRET-Existenz + Mindestlaenge, JWT-Algorithmus (kein
"alg:none", kein HS/RS-Confusion), Cookie-Flags (HttpOnly/Secure/SameSite/__Host-),
Session-Lifetime + Idle-Timeout, Hash-Rounds (bcrypt >=12 / Argon2id), Pepper-Rotation,
Dummy-Hash gegen Timing, Login-Rate-Limit (5/email + 20/IP), TOTP-Replay,
Password-Reset-Token (>=32 bytes random, single-use, <60min), User-Enumeration-Schutz,
CVE-2025-29927 (Next.js Middleware Bypass) falls Next.js, Account-Lockout,
OAuth-PKCE/Nonce.

**Geprueft-aber-sauber:** mindestens 15 Punkte mit Datei:Zeile.

---

### AGENT 2: Autorisierung & Access Control

**OWASP A01:2025, OWASP API1 BOLA, ASVS V8.**

**Pflichtdateien:** Rollen-Definition + Capability-Matrix; Guards/Middleware fuer
Auth-Checks; Multi-Tenancy-Layer (falls vorhanden) — Tenant-Resolver, Tenant-Scope,
RLS-Policies (falls Postgres); ALLE Server-Actions/Route-Handler mit param.id;
Upload-Routes — Ownership-Check vor sendFile.

**Pruefungsfragen:** RBAC-Hierarchie konsistent? Capability-Check pro Action explizit?
Tenant-Isolation in jeder Query? RLS-Policies auf allen tenant-tables + FORCE ROW
LEVEL SECURITY (Postgres)? IDOR in Server-Actions mit input.id? Predictable IDs
(auto-increment)? Mass-Assignment via Spread/Object.assign? Horizontal/Vertical
Privilege-Escalation? Upload-Zugriff mit Ownership-DB-Lookup? Cron-Routes
authentifiziert? Public-Endpoints bewusst public? Query-Parameter-basierte Auth?

**PoC-Anforderung:** Konkreter curl fuer jedes IDOR-Finding.

**Geprueft-aber-sauber:** mindestens 20 Endpunkte mit Datei:Zeile.

---

### AGENT 3: Injection & Input Validation

**OWASP A03/A05:2025, CWE-79/89/77/78/91/943, ORM-Operator-Injection.**

**Pflichtdateien:** ALLE Server-Actions / Route-Handler / Controller; Raw-SQL-Stellen;
Template-Strings mit User-Input; XML/YAML/JSON-Parser; Regex auf User-Input; File-Path-
Handling; Shell-Aufrufe; Markdown-Renderer; Validation-Schemas (Zod/Yup/Joi/Pydantic).

**Pruefungsfragen:** Raw SQL via parametrisierte Args oder String-Concat? ORM-Operator-
Injection (z.B. `password: input.password` direkt durchgereicht — User kann
`{not: ""}`-Bypass setzen)? Validation-Schemas .strict() / closed? XSS via
Raw-HTML-Insertion (`innerHTML`, `v-html`, Razor-Helpers, dangerouslySet*) ohne
HTML-Sanitizer? javascript:/data:-URLs in href/src geblockt? CSV-Injection (Formel-
Prefix escapen)? Log-Injection? Command-Injection (execFile mit Array-Args)? ReDoS
(katastrophisches Backtracking)? Prototype-Pollution (Object.assign({}, req.body))?
XXE (DTD/Entities disabled)? SSTI (Template-Engine mit User-Input)? Path-Traversal
(path.basename + Whitelist)?

**PoC-Anforderung:** Exploit-Payload pro Injection-Finding.

**Geprueft-aber-sauber:** mindestens 25 Stellen mit Datei:Zeile.

---

### AGENT 4: Kryptographie & Secrets Management

**OWASP A02:2025, CWE-326/327/798.**

**Pflichtdateien:** Encryption-Lib (AES-GCM / libsodium / WebCrypto); Key-Storage
(ENV / KMS / OS-Keychain); Pepper/Salt-Handling; .env / .env.example; .gitignore;
Key-Generation-Scripts.

**Pruefungsfragen:** AES-256-GCM oder ChaCha20-Poly1305 (kein CBC, kein ECB)? IVs
unique pro Encryption (kein NULL-IV)? AAD bei AEAD-Schemes? Key-Rotation-Mechanismus?
Hardcoded Secrets im Repo? .env in .gitignore? Bcrypt/Argon2id-Rounds ausreichend?
TLS 1.2+ erzwungen? HSTS gesetzt? Sensitive-Daten unverschluesselt geloggt? Tokens
(API-Keys, Session-IDs) cryptographically random? Crypto-Lib mit bekannten CVEs?

**Geprueft-aber-sauber:** mindestens 10 Punkte mit Datei:Zeile.

---

### AGENT 5: Infrastruktur & Container

**NIST SP 800-190, CIS Docker Benchmark.**

**Pflichtdateien:** Dockerfile(s), docker-compose.yml, K8s-Manifests, CI/CD-Configs,
Reverse-Proxy-Configs (nginx/Caddy/Traefik), TLS-Configs, DB-Init-Scripts.

**Pruefungsfragen:** Container-User non-root? Base-Image neueste Patch-Version?
COPY .. ohne .dockerignore? Multi-Stage-Build? Secrets in ENV statt Build-Args?
docker-compose Network-Segmentation? Exposed Ports minimal? Volume-Permissions
0o600/0o700 wo sensibel? K8s Pod-Security-Standards? NetworkPolicies? CI/CD —
Pinned Actions (SHA statt @v3)? Secrets via Vault statt Repo-Secret? DB-User
non-superuser, NOBYPASSRLS bei RLS-Policies?

**Geprueft-aber-sauber:** mindestens 10 Punkte mit Datei:Zeile.

---

### AGENT 6: API-Security

**OWASP API Security Top 10 (2023).**

**Pflichtdateien:** Alle Route-Handler / GraphQL-Resolver / gRPC-Service-Methoden;
API-Doku (OpenAPI/Swagger); Rate-Limiter-Config; CORS-Config.

**Pruefungsfragen:** API3 Broken Object Property Level Auth (Excessive Data
Exposure + Mass Assignment)? API4 Unrestricted Resource Consumption (kein
Rate-Limit, kein body-size-limit)? API5 Broken Function Level Auth? API6
Unrestricted Access to Sensitive Business Flows? API7 SSRF — User-kontrollierte
URLs in fetch/http.get? API8 Security Misconfiguration (Debug-Mode in Prod,
verbose Errors)? API9 Improper Inventory Management (alte API-Versionen aktiv)?
API10 Unsafe Consumption of APIs (Downstream-Service-Trust)? CORS Wildcard mit
credentials?

**Geprueft-aber-sauber:** mindestens 15 Endpunkte mit Datei:Zeile.

---

### AGENT 7: Daten- & Persistenz-Layer

**CWE-200/319/532/798.**

**Pflichtdateien:** DB-Schema/Migrations, ORM-Models, Backup-Scripts, Retention-Jobs,
Audit-Logger.

**Pruefungsfragen:** PII-Felder verschluesselt at-rest? Backup-Files verschluesselt?
Soft-Delete oder Hard-Delete? Audit-Log immutable (DB-Trigger blockt UPDATE/DELETE)?
Retention-Policies durchgesetzt? Logs / Errors enthalten keine sensiblen Daten
(Passwoerter, Tokens, vollstaendige PII)? DB-Connection-String in ENV statt Repo?
DB-Replikation TLS? Backup-Restore getestet?

**Geprueft-aber-sauber:** mindestens 10 Punkte mit Datei:Zeile.

---

### AGENT 8: Frontend-Security

**OWASP CWE-79/352/79-Bypass.**

**Pflichtdateien:** Client-Components/Pages, State-Management, Forms, File-Upload-UI,
Service-Worker, HTML-Templates.

**Pruefungsfragen:** CSP-Header (Content-Security-Policy) gesetzt + restriktiv?
nonce-basiert? Inline-Scripts/Styles ohne nonce? Trusted-Types-Policy? XSS via
ungesicherter Raw-HTML-Insertion? CSRF-Tokens bei state-changing requests?
File-Upload-Validation client-side UND server-side (MIME-Sniffing)? Clickjacking-
Schutz (X-Frame-Options / frame-ancestors)? localStorage/sessionStorage mit sensiblen
Daten? Service-Worker scope vorsichtig? Externe Skripte mit Subresource-Integrity?

**Geprueft-aber-sauber:** mindestens 10 Punkte mit Datei:Zeile.

---

### AGENT 9: Supply-Chain & Dependencies

**OWASP A06:2025, NIST SLSA.**

**Pflichtdateien:** package.json / pyproject.toml / etc.; Lock-Files; SBOMs falls
vorhanden; CI/CD-Configs; Dockerfile-Base-Images.

**Pruefungsfragen:** `npm audit` / `pip-audit` / `cargo audit` / equivalent — KEINE
HIGH/CRITICAL unaufgeloest? Pinned Versions (kein `^x.y.z` mit auto-update bei
sensiblen Packages)? Lockfile committet? Dependabot/Renovate aktiv? Pre-Install-
Scripts in Dependencies (npm)? Typosquatting-Check der wichtigsten Packages?
SBOM generiert? License-Kompatibilitaet (AGPL-Kontamination)? Hash-Pinning fuer
CI-Actions?

**Geprueft-aber-sauber:** mindestens 5 Befunde mit Datei:Zeile.

---

### AGENT 10: Logging, Monitoring & Incident Response

**CWE-117/532/778, NIS2 Art. 23.**

**Pflichtdateien:** Logger-Setup, Audit-Trail, Sentry/Datadog/etc.-Config, Alerting-
Regeln, Incident-Response-Doku.

**Pruefungsfragen:** Sicherheitsrelevante Events geloggt (Failed-Logins, Permission-
Denied, Admin-Actions)? Logs zentralisiert + Append-Only? Log-Retention >= 1 Jahr
(NIS2)? PII in Logs? Alerts auf verdaechtige Patterns (Brute-Force, Privilege-
Escalation)? Incident-Response-Playbook? Vulnerability-Disclosure-Policy (CRA
Art. 13)? Forensik-tauglicher Audit-Trail (Hash-Chain o.ae.)?

**Geprueft-aber-sauber:** mindestens 5 Punkte mit Datei:Zeile.

---

### AGENT 11: Geheimnis- & Schluessel-Management

**CWE-798/200.**

**Pflichtdateien:** Secrets-Vault-Config (HashiCorp Vault / AWS Secrets Manager /
GCP Secret Manager), .env-Handling, Crypto-Key-Storage, OAuth-Client-Secrets.

**Pruefungsfragen:** Secrets ausschliesslich in Vault/Manager, nicht in Repo/ENV-File
in CI? Key-Rotation-Mechanismus + Rotation-History? Geheimnis-Zugriff auditiert?
git-secrets / trufflehog im CI? Pre-Commit-Hook? Secret-Recovery-Prozess
dokumentiert?

**Geprueft-aber-sauber:** mindestens 5 Punkte mit Datei:Zeile.

---

### AGENT 12: Multi-Tenancy / Mandantentrennung (nur falls aktiv)

**Branchen-spezifisches Trust-Boundary-Audit.**

Wird nur dispatched, wenn Multi-Tenant-Indicator (Tenant-Resolver, RLS-Policies,
schema-per-tenant, row-discriminator) erkannt.

**Pflichtdateien:** Tenant-Resolver (Subdomain/Header/JWT-Claim), Tenant-Context-
Propagation (AsyncLocalStorage o.ae.), RLS-Policies, Schema-Migrations,
Tenant-Switching-Logik (falls vorhanden).

**Pruefungsfragen:** Tenant-Spoofing via Client-Header? Fail-soft auf DEFAULT-Tenant
bei DB-Down? Cross-Tenant-Queries (FORCE RLS aktiv)? Tenant-Context in BG-Jobs /
Cron / Webhooks korrekt gesetzt? Cookie/Token an einen Tenant gebunden? Onboarding
neuer Tenants atomar? Tenant-Loeschung kaskadiert sauber (keine orphaned Rows)?

**Geprueft-aber-sauber:** mindestens 10 Punkte mit Datei:Zeile.

---

## ABSCHLUSSPRUEFUNG DURCH DEN MAIN-AGENT

Nach Abschluss aller 12 Agenten konsolidiert der Main-Agent:

1. **Deduplizierung** — Findings, die mehrere Agenten gemeldet haben, einmal mit
   Cross-Referenzen.
2. **Severity-Triage** — CVSS-Re-Score auf realen Stack-Kontext.
3. **Doppel-Verifikation** — jedes Finding gegen 4 Kriterien (siehe unten).
4. **Konsolidierungs-Report** unter `docs/audits/YYYY-MM-DD-audit-security.md`.

---

## PFLICHT-OUTPUT-TABELLE (am Ende JEDES Audit-Reports)

**ZWINGENDE DOPPELVERIFIKATIONS-REGEL:** Die End-Tabelle enthaelt NUR Findings,
die alle vier Verifikations-Schritte durchlaufen haben:

1. **Erstfund** mit konkreter Datei:Zeile + CWE/OWASP/ASVS-Klassifikation + IoC-Zeilen
2. **Exploit-Verifikation** — Taint-Source bis Sink rekonstruiert, Proof-of-Concept
   (Request, Payload, Bedingungen) skizziert
3. **Kompensations-Suche** — gibt es Middleware-Guard, Input-Validation, WAF,
   Rate-Limit, CSP, das das Finding entkraeftet? Datei:Zeile + Begruendung
4. **Nicht-Techniker-Erklaerung** — kann die Erklaerung-Spalte einem Nicht-Security-
   Stakeholder verstaendlich gemacht werden? (Angriffsweg + Schadensfolge in EUR/$)

Findings, die nicht alle 4 Schritte durchlaufen haben, kommen **nicht** in die
End-Tabelle. Sie werden — falls inhaltlich relevant — unter einem separaten
Abschnitt "⚠ Hinweise (nicht doppelt verifiziert, vor Sprint-Aufnahme pruefen)"
gelistet, nicht vermischt.

Jeder finale Audit-Bericht MUSS am Ende eine Markdown-Tabelle enthalten. Format
ist verbindlich:

```markdown
| # | Severity | OWASP/CWE/ASVS | Bereich | Finding | Datei:Zeile | Erklaerung (Nicht-Techniker) |
|---|----------|----------------|---------|---------|-------------|------------------------------|
| SEC-001 | CRITICAL | A01:2025 / CWE-290 / V4.1.5 | AuthZ | [Beispiel] | path/to/file.ts:60 | Was tut der Angreifer? Was ist der Schaden in EUR/Datenverlust? |
```

**Pflicht-Bloecke direkt unter der Tabelle:**

**Statistik:**
```
CRITICAL: X | HIGH: X | MEDIUM: X | LOW: X | INFO: X | OK: X
```

**Top-N Production-Blocker (sortiert nach Severity x Realisierbarkeit):**
1. SEC-XXX — kurze Begruendung
2. ...

**Geprueft-aber-sauber (>= Anzahl Findings):** Liste Datei:Zeile + warum sauber.

**⚠ Hinweise (nicht doppelt verifiziert):** Falls vorhanden, separat gelistet.

**Erklaerung-Spalte: Pflicht-Inhalte:**
- Angriffsweg in 1-2 Saetzen (`curl -H "..."`, "User klickt auf...")
- KONKRETE Schadensfolge: Bussgeldhoehe, RCE/Data-Leak/AuthN-Bypass
- Fuer Nicht-Techniker verstaendlich (kein "deserialization in libfoo" — sondern
  "Angreifer kann beliebigen Code auf Server ausfuehren")
