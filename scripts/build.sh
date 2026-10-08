#!/usr/bin/env bash
# Regenerates the command, agent and skill files from prompts/itph-storyteller.md.
# Edit the prompt, then run: ./scripts/build.sh
set -euo pipefail
cd "$(dirname "$0")/.."

SRC=prompts/itph-storyteller.md
DESC="Researches an IT topic and writes 5 distinct ITPH-style Facebook stories for Filipino readers, each with an image teaser and a copy/paste ChatGPT image prompt. Does not generate images."

{
  cat <<EOF
---
description: $DESC
argument-hint: --topic "GCash failed transfers" [--language english|taglish] [--length short|standard] [--count 5]
---

EOF
  cat "$SRC"
  cat <<'EOF'

---

## This request

$ARGUMENTS
EOF
} > commands/fbpost.md

{
  cat <<EOF
---
name: itph-storyteller
description: $DESC Use for ITPH Facebook posts, IT edutainment stories, image teasers, or analysing Facebook post performance.
tools: WebSearch, WebFetch, Read, Write
---

EOF
  cat "$SRC"
} > agents/itph-storyteller.md

{
  cat <<EOF
---
name: fbpost
description: $DESC Use when the user asks for ITPH / IT Philippines Facebook posts, IT storytelling, image teasers or image prompts, or wants post insights analysed.
---

EOF
  cat "$SRC"
} > skills/fbpost/SKILL.md

echo "Built commands/fbpost.md, agents/itph-storyteller.md, skills/fbpost/SKILL.md"
