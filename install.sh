#!/usr/bin/env bash
# Installs the /fbpost command, the itph-storyteller agent and the fbpost skill
# into ~/.claude so they work in every Claude Code project.
set -euo pipefail

REPO_RAW="${ITPH_REPO_RAW:-https://raw.githubusercontent.com/raketbizdev/itph-fbpost-agent/main}"
DEST="${CLAUDE_CONFIG_DIR:-$HOME/.claude}"
HERE="$(cd "$(dirname "${BASH_SOURCE[0]:-$0}")" 2>/dev/null && pwd || echo "")"

mkdir -p "$DEST/commands" "$DEST/agents" "$DEST/skills/fbpost"

fetch() { # $1 = repo path, $2 = destination
  if [ -n "$HERE" ] && [ -f "$HERE/$1" ]; then
    cp "$HERE/$1" "$2"
  else
    curl -fsSL "$REPO_RAW/$1" -o "$2"
  fi
}

fetch commands/fbpost.md          "$DEST/commands/fbpost.md"
fetch agents/itph-storyteller.md  "$DEST/agents/itph-storyteller.md"
fetch skills/fbpost/SKILL.md      "$DEST/skills/fbpost/SKILL.md"

echo "Installed into $DEST. Restart Claude Code, then run: /fbpost --topic \"GCash failed transfers\""
