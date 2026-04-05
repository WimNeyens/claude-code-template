# Getting started: Claude Code VS Code Extension

Audience: Developer

The VS Code Extension embeds Claude directly in the editor. It has the same capability as the CLI — full filesystem access, MCP servers, and git hooks — without switching to a separate terminal.

---

## Prerequisites

Install these before starting:

| Tool | Verify |
|---|---|
| VS Code (latest stable) | `code --version` |
| Git | `git --version` |
| Git LFS | `git lfs version` |
| Node.js LTS | `node --version` |
| GitHub CLI | `gh --version` |
| Claude account | [claude.ai](https://claude.ai) |

---

## Install the extension

**Option 1 — VS Code Marketplace:**

Open VS Code → Extensions sidebar → search `anthropic.claude-code` → Install

**Option 2 — command line:**

```bash
code --install-extension anthropic.claude-code
```

Sign in when prompted. The extension uses your claude.ai account.

---

## Common setup (all surfaces)

Follow [SETUP.md](../SETUP.md) for:

- **Phase 0** — Secure your GitHub account (2FA, secret scanning, push protection, Dependabot)
- **Phase 1** — Create the GitHub repository
- **Phase 2** — Clone the repo locally

These phases apply to all surfaces. Complete them before the VS Code-specific steps below.

---

## VS Code-specific setup

### Open the project folder

```bash
code your-project/
```

VS Code will prompt for **workspace trust** — grant it. Claude requires trusted workspace mode.

### Activate git hooks (once per clone)

Open the integrated terminal (`Ctrl+`` ` or `Cmd+`` `):

```bash
git config core.hooksPath .githooks
```

This enables:
- `pre-commit` — blocks commits containing secret patterns
- `commit-msg` — enforces ≤ 50-char subject lines with no trailing period

### Configure MCP servers

MCP servers extend Claude with external tools (GitHub API, databases, etc.).

```bash
cp .claude/settings.local.json.example .claude/settings.local.json
```

Edit `settings.local.json` to add your GitHub personal access token and any local paths. This file is gitignored — never commit it. The extension reads the same `settings.local.json` as the CLI.

### Machine-specific Claude instructions (optional)

Create `CLAUDE.local.md` in the project root for personal overrides. This file is gitignored.

### Start a session

Click the **Claude icon** in the VS Code sidebar, or use the command palette: `Claude: Open Chat`.

---

## What Claude reads automatically

Every session, Claude loads:

| File | Purpose |
|---|---|
| `CLAUDE.md` | Project conventions, access rules, coding guidelines |
| `.claude/rules/*.md` | Code style, documentation standards |
| `.claude/commands/*.md` | Slash commands: `/review-code`, `/commit-message`, `/write-docs` |
| `.claude/settings.local.json` | MCP servers and machine-specific permissions |
| `CLAUDE.local.md` | Your personal overrides (if it exists) |

Run `/memory` in any session to see all loaded instructions.

---

## VS Code-specific files

| File | What it does |
|---|---|
| `.vscode/settings.json` | Format on save, 2-space indentation, rulers at 100 columns |
| `.vscode/extensions.json` | Recommends `anthropic.claude-code` to teammates on first open |

These are committed to the repo so all contributors get the same editor behaviour.

---

## Capability comparison

| Feature | VS Code | CLI | Web |
|---|---|---|---|
| Full filesystem MCP access | Yes | Yes | Repo only |
| `pre-commit` / `commit-msg` hooks | Yes | Yes | No |
| `settings.local.json` MCP config | Yes | Yes | No |
| `CLAUDE.local.md` overrides | Yes | Yes | No |
| Persistent local state between sessions | Yes | Yes | No |

VS Code Extension and CLI are equivalent in capability.

---

## Slash commands

| Command | What it does |
|---|---|
| `/review-code` | Reviews current branch changes for correctness, security, and simplicity |
| `/commit-message` | Drafts a commit message from staged changes |
| `/pr` | Creates a pull request from the current branch with a drafted description |
| `/test` | Writes tests for new or changed code, matching the project's framework |
| `/explain` | Explains code, files, or architectural patterns in the project |
| `/debug` | Systematically investigates an issue — gather evidence, hypothesise, fix |
| `/write-docs` | Generates runbooks, ADRs, API references, or diagrams |
| `/sync-template` | Reviews Claude Code release notes and updates the template |
