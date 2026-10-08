#!/usr/bin/env bash
# Installs the fbpost skill (run it as /fbpost) and the itph-storyteller agent
# into ~/.claude so they work in every Claude Code project: terminal, VS Code and desktop app.
set -euo pipefail

REPO_RAW="${ITPH_REPO_RAW:-https://raw.githubusercontent.com/raketbizdev/itph-fbpost-agent/main}"
DEST="${CLAUDE_CONFIG_DIR:-$HOME/.claude}"
HERE="$(cd "$(dirname "${BASH_SOURCE[0]:-$0}")" 2>/dev/null && pwd || echo "")"

mkdir -p "$DEST/agents" "$DEST/skills/fbpost"

fetch() { # $1 = repo path, $2 = destination
  if [ -n "$HERE" ] && [ -f "$HERE/$1" ]; then
    cp "$HERE/$1" "$2"
  else
    curl -fsSL "$REPO_RAW/$1" -o "$2"
  fi
}

fetch agents/itph-storyteller.md  "$DEST/agents/itph-storyteller.md"
fetch skills/fbpost/SKILL.md      "$DEST/skills/fbpost/SKILL.md"

# Older versions installed a separate command; it would duplicate /fbpost.
if [ -f "$DEST/commands/fbpost.md" ]; then
  mv "$DEST/commands/fbpost.md" "$DEST/commands/fbpost.md.bak"
  echo "Moved old $DEST/commands/fbpost.md to fbpost.md.bak"
fi

echo "Installed into $DEST. Restart Claude Code, then run: /fbpost --topic \"GCash failed transfers\""
