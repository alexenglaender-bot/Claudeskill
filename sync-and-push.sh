#!/usr/bin/env bash
# Master-Geraet-Sync-Script.
# Kopiert die aktuelle Version aller 8 Skills aus ~/.claude/skills/ in das
# Plugin-Repo und pusht zu GitHub. Auf den anderen Geraeten dann nur noch
# `/plugin marketplace update Claudeskill` + `/plugin update <name>@Claudeskill`.

set -euo pipefail

SKILLS=(
  securityaudit
  uiaudit
  rechtsaudit
  funktionsaudit
  audit-security
  audit-ux
  audit-qa
  audit-compliance
)

PLUGIN_ROOT="$(cd "$(dirname "$0")" && pwd)"
SOURCE_ROOT="${HOME}/.claude/skills"

echo "== Sync ${#SKILLS[@]} skills from ${SOURCE_ROOT} into ${PLUGIN_ROOT} =="

for skill in "${SKILLS[@]}"; do
  src="${SOURCE_ROOT}/${skill}/SKILL.md"
  dst="${PLUGIN_ROOT}/plugins/${skill}/skills/${skill}/SKILL.md"
  if [[ ! -f "$src" ]]; then
    echo "  ⚠ ${skill}: source missing (${src}) — skipped"
    continue
  fi
  mkdir -p "$(dirname "$dst")"
  cp "$src" "$dst"
  echo "  ✓ ${skill}"
done

echo
echo "== Git status =="
cd "${PLUGIN_ROOT}"
git status --short

if [[ -z "$(git status --porcelain)" ]]; then
  echo
  echo "Keine Aenderungen — nichts zu pushen."
  exit 0
fi

echo
read -r -p "Commit-Message [skill update]: " COMMIT_MSG
COMMIT_MSG="${COMMIT_MSG:-skill update}"

git add -A
git commit -m "${COMMIT_MSG}"
git push origin main

echo
echo "== ✓ Gepusht — andere Geraete jetzt aktualisieren =="
echo "Im Claude-Code-Prompt:"
echo "  /plugin marketplace update Claudeskill"
echo "  /plugin update <name>@Claudeskill   (fuer jeden geaenderten Skill)"
