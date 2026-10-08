# ITPH FBPost Agent

The IT Philippines (ITPH) storytelling agent. Give it a tech topic and it researches the topic, then writes five distinct, ready-to-publish Facebook stories for Filipino readers. Each story comes with a short image teaser and a complete image prompt you can paste into ChatGPT.

**The agent never generates images.** You copy the image prompt you want into ChatGPT (or any image tool).

## What you get for each version

- Who the post is for and why they should care
- A finished Facebook story (about 180–280 words) in the ITPH voice: conversational, grounded in real events, no corporate fluff
- An image teaser of about 35–80 words that keeps the mystery for the caption to answer
- The words to highlight in blue
- A self-contained ChatGPT image prompt: 4:5 vertical, cinematic top 40%, solid black text area below, white text with blue highlights
- Why people would share it and what they'd comment about

Every run also includes a topic assessment (five 1–5 scores) and a verification section with sources and open questions.

## Where it works

| Where | How to get it |
| --- | --- |
| Claude Code in the terminal | Option 1 or 2 below |
| Claude Code in VS Code (and Cursor or other VS Code forks) | Same install. The extension reads the same `~/.claude` folder and plugins as the terminal. |
| Claude Code in the desktop app | Same install |
| Claude Code on the web (claude.ai/code) and cloud sessions | Option 3: add it to your project's `.claude/settings.json` |
| ChatGPT, Claude.ai Projects, Gemini and other tools | Option 4: paste the prompt |

Install once on your computer and `/fbpost` works in the terminal, VS Code and the desktop app. Restart Claude Code (or reload the VS Code window) after installing.

## Install

Pick one option.

### Option 1: Claude Code plugin (recommended)

Inside Claude Code:

```
/plugin marketplace add raketbizdev/itph-fbpost-agent
/plugin install itph-fbpost@itph
```

### Option 2: One-line install script (macOS / Linux)

```bash
curl -fsSL https://raw.githubusercontent.com/raketbizdev/itph-fbpost-agent/main/install.sh | bash
```

This copies the skill and the subagent into `~/.claude/`. Restart Claude Code afterwards. To install from a clone instead, run `git clone https://github.com/raketbizdev/itph-fbpost-agent.git` and then `./itph-fbpost-agent/install.sh`.

Use Option 1 or Option 2, not both, or `/fbpost` will show up twice.

### Option 3: Claude Code on the web, cloud sessions and shared team projects

Cloud sessions don't see what is installed on your computer, so add the plugin to the project instead. Put this in `.claude/settings.json` in your project's repo and commit it:

```json
{
  "extraKnownMarketplaces": {
    "itph": {
      "source": { "source": "github", "repo": "raketbizdev/itph-fbpost-agent" }
    }
  },
  "enabledPlugins": {
    "itph-fbpost@itph": true
  }
}
```

Anyone who opens that project in Claude Code (web, terminal or VS Code) gets `/fbpost`. On their own machines, Claude Code asks them to trust the marketplace the first time.

### Option 4: Outside Claude Code (Claude.ai Projects, ChatGPT custom GPTs, Gemini Gems, other tools)

Paste the contents of [`prompts/itph-storyteller.md`](prompts/itph-storyteller.md) into the custom instructions or system prompt of your project, GPT or Gem. Turn on web search so it can verify facts. Then send messages like `--topic "GCash failed transfers"`.

For tools that read `AGENTS.md` or `SKILL.md` (Codex, Cursor, and others), use [`skills/fbpost/SKILL.md`](skills/fbpost/SKILL.md).

## Use it

```
/fbpost --topic "GCash failed transfers"
/fbpost --topic "Who controls .ph domains?" --language taglish --length short
/fbpost --topic "Why do companies pay for Oracle databases?" --count 3
```

| Flag | Values | Default |
| --- | --- | --- |
| `--topic` | any IT topic | required |
| `--language` | `english`, `taglish` | English with natural Filipino |
| `--length` | `short` (~150–200 words), `standard` (~200–280) | `standard` |
| `--count` | number of versions | `5` |

You can also ask in plain words, for example: "use the itph-storyteller agent to write about PLDT outages", or "here are my Facebook insights for last week's post, what should I change?"

## What's in this repo

| Path | What it is |
| --- | --- |
| `prompts/itph-storyteller.md` | **The source of truth.** The full agent instructions. Edit this file. |
| `skills/fbpost/SKILL.md` | The skill you run as `/fbpost`. Also works in other skill-aware tools (generated) |
| `agents/itph-storyteller.md` | Claude Code subagent (generated) |
| `.claude-plugin/` | Plugin and marketplace manifests |
| `.claude/settings.json` | Turns the plugin on for anyone who opens this repo in Claude Code |
| `install.sh` | Installer into `~/.claude/` |
| `scripts/build.sh` | Regenerates the three generated files from the prompt |

## Changing the agent

1. Edit `prompts/itph-storyteller.md`.
2. Run `./scripts/build.sh`. It regenerates the skill and the subagent.
3. Commit and push. Plugin users get the update with `/plugin marketplace update itph`; script users re-run `install.sh`.

## Ground rules the agent follows

- It works out why the reader should care before it explains any technology.
- It uses real, verifiable events, people and figures, and never makes up victims, quotes or incidents.
- The image teaser keeps the mystery. The caption explains the technology and asks readers for their experience or opinion.
- Commercial fit only guides which topics it picks. It never promises a Meta RPM or earnings figure.
- How much research it can do depends on the web tools and permissions your session has.

## License

MIT. See [LICENSE](LICENSE).
