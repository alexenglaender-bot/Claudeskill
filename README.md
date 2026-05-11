# Claudeskill — Audit-Skills Marketplace

Privater Claude Code Plugin-Marketplace (`alexenglaender-bot/Claudeskill`)
mit 8 Audit-Skills, die zu 100 % auf **Gruendlichkeit** ausgerichtet sind
(kein Sparen mit Agenten, Zeit oder Tokens — Anti-Spar-Protokoll explizit
eingebaut).

## Skills

### Ma-Management-spezifisch (alte, behalten)

| Slash | Was |
|-------|-----|
| `/securityaudit` | Informationssicherheits-Audit mit Ma-Management-Pflichtdateien, Multi-Tenant Phase 2.5 |
| `/uiaudit` | UX-Audit mit Gastro-Personas (Tanja/Lukas/Gueler/Reinhard/Marcus) + Stress-Szenarien |
| `/rechtsaudit` | Rechtsaudit mit 80+ DE/EU-Normen (DSGVO, ArbZG, GoBD, IfSG, MuSchG, ...) |
| `/funktionsaudit` | E2E-Audit mit Browser-MCP, Mojibake-Check, WF-1..15 |

### Generisch (neue, fuer beliebige Apps)

| Slash | Was |
|-------|-----|
| `/audit-security` | Generisches Security-Audit (Node/Python/Go/Java/Rust/PHP, REST/GraphQL/gRPC) |
| `/audit-ux` | Generisches UX-Audit, User definiert Personas + Stress-Szenarien zu Beginn |
| `/audit-qa` | Generisches E2E-Audit, jedes Browser-Automation-Tool |
| `/audit-compliance` | Generisches Compliance-Audit, User definiert Jurisdiktionen + Branche |

Alle 8 Skills haben:

1. **Anti-Spar-Protokoll** am Anfang — Verbot von Stichproben, Agenten-Reduktion,
   Token-Spar-Massnahmen, Zeitlimit-Anpassung, Vorab-Annahmen
2. **Doppel-/Dreifach-Verifikation** pro Finding (Erstfund + Exploit/Norm + Kompensation)
3. **Pflicht-End-Tabelle** mit nur **doppelt verifizierten** Findings, Statistik-
   Zeile, Top-N Production-Blocker, Geprueft-aber-sauber-Liste, separater
   "⚠ Hinweise"-Abschnitt fuer nicht-verifizierte Befunde
4. **Erklaerung-Spalte** in der End-Tabelle fuer Nicht-Techniker/-Juristen/-UX-Profis

## Installation auf einem anderen Geraet

Voraussetzung: Claude Code installiert und du bist auf dem Geraet eingeloggt.

### Schritt 1: Marketplace hinzufuegen

```bash
# Im Claude Code Slash-Prompt:
/plugin marketplace add alexenglaender-bot/Claudeskill
```

### Schritt 2: Bei privatem Repo: GitHub-Token setzen

```bash
# In deiner Shell (.zshrc / .bashrc), permanent:
export GITHUB_TOKEN=ghp_xxxxxxxxxxxxxxxxxxxx

# Token erstellen:
# 1. https://github.com/settings/tokens/new
# 2. Scopes: nur `repo` (private repo read)
# 3. Token kopieren -> in .zshrc/.bashrc setzen
```

Ohne Token wird beim ersten `marketplace add` ein Browser-Auth-Flow gestartet
(funktioniert auch). Mit Token funktionieren spaeter auch Auto-Updates ohne
Interaktion.

### Schritt 3: Plugins aktivieren

```bash
# Im Claude Code Slash-Prompt — alle 8 auf einmal:
/plugin install securityaudit@Claudeskill
/plugin install uiaudit@Claudeskill
/plugin install rechtsaudit@Claudeskill
/plugin install funktionsaudit@Claudeskill
/plugin install audit-security@Claudeskill
/plugin install audit-ux@Claudeskill
/plugin install audit-qa@Claudeskill
/plugin install audit-compliance@Claudeskill
```

Oder nur die generischen, wenn das Geraet nichts mit Ma-Management zu tun hat.

### Schritt 4: Verifikation

```bash
# Im Claude Code Prompt:
/securityaudit

# Sollte mit "ANTI-SPAR-PROTOKOLL"-Block antworten und Audit-Setup starten.
```

## Updates pushen

Auf dem Master-Geraet (wo du Skills aenderst):

```bash
cd ~/audit-skills-plugin
# 1. Skills syncen von ~/.claude/skills/ in das Plugin-Repo
for skill in securityaudit uiaudit rechtsaudit funktionsaudit audit-security audit-ux audit-qa audit-compliance; do
  cp ~/.claude/skills/$skill/SKILL.md plugins/$skill/skills/$skill/SKILL.md
done

# 2. Version-Bump im plugin.json (optional)
# Edit plugins/<name>/.claude-plugin/plugin.json -> "version": "1.0.1"

# 3. Commit + Push
git add -A
git commit -m "skill update: ..."
git push
```

Auf den anderen Geraeten:

```bash
# Im Claude Code Prompt:
/plugin marketplace update Claudeskill
/plugin update securityaudit@Claudeskill   # etc. fuer jeden geupdateten Skill
```

## Repo-Struktur (Referenz)

```
audit-skills-plugin/
├── .claude-plugin/
│   └── marketplace.json
├── plugins/
│   ├── securityaudit/
│   │   ├── .claude-plugin/plugin.json
│   │   └── skills/securityaudit/SKILL.md
│   ├── uiaudit/ ...
│   ├── rechtsaudit/ ...
│   ├── funktionsaudit/ ...
│   ├── audit-security/ ...
│   ├── audit-ux/ ...
│   ├── audit-qa/ ...
│   └── audit-compliance/ ...
└── README.md
```

## Wartung

- Aenderungen ausschliesslich in `~/.claude/skills/<name>/SKILL.md` editieren,
  dann via Sync-Script in das Plugin-Repo kopieren und pushen.
- Wenn du die End-Tabellen-Pflicht oder das Anti-Spar-Protokoll erweiterst,
  musst du es in **allen 8 Skills** synchron halten (oder einen gemeinsamen
  Footer als Referenzdatei `references/anti-spar.md` einbauen).
