# Getting started: Claude Code CLI

Audience: Developer

The CLI surface gives Claude full access to your local filesystem, MCP servers, and git hooks. It is the most capable surface and the one to use when committing, running tests, or working with tools outside the repository.

---

## Prerequisites

Install these before starting:

| Tool | Verify |
|---|---|
| Git | `git --version` |
| Git LFS | `git lfs version` |
| Node.js LTS | `node --version` |
| GitHub CLI | `gh --version` |
| Claude account | [claude.ai](https://claude.ai) |

---

## Install Claude Code

**macOS / Linux / WSL — recommended (auto-updates):**

```bash
curl -fsSL https://claude.ai/install.sh | bash
```

**Windows PowerShell — recommended (auto-updates):**

```powershell
irm https://claude.ai/install.ps1 | iex
```

**Alternative — npm (does not auto-update):**

```bash
npm install -g @anthropic-ai/claude-code
```

Verify: `claude --version`

Log in:

```bash
claude login
```

---

## Common setup (all surfaces)

Follow [SETUP.md](../SETUP.md) for:

- **Phase 0** — Secure your GitHub account (2FA, secret scanning, push protection, Dependabot)
- **Phase 1** — Create the GitHub repository
- **Phase 2** — Clone the repo locally

These phases apply to all surfaces. Complete them before the CLI-specific steps below.

---

## CLI-specific setup

### Activate git hooks (once per clone)

```bash
git config core.hooksPath .githooks
```

This enables:
- `pre-commit` — blocks commits containing secret patterns
- `commit-msg` — enforces ≤ 50-char subject lines with no trailing period

### Configure MCP servers

MCP servers extend Claude with external tools (filesystem access, GitHub API, databases, etc.).

```bash
cp .claude/settings.local.json.example .claude/settings.local.json
```

Edit `settings.local.json` to add your GitHub personal access token and any local paths. This file is gitignored — never commit it.

### Machine-specific Claude instructions (optional)

Create `CLAUDE.local.md` in the project root for overrides that apply only to your machine (personal preferences, local paths, shortcuts). This file is gitignored.

### Start a session

```bash
cd your-project
claude
```

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

Run `/memory` in any session to see all loaded instructions, including auto-saved notes from previous sessions.

---

## CLI-only capabilities

| Feature | CLI | VS Code | Web |
|---|---|---|---|
| Full filesystem MCP access | Yes | Yes | Repo only |
| `pre-commit` / `commit-msg` hooks | Yes | Yes | No |
| `settings.local.json` MCP config | Yes | Yes | No |
| `CLAUDE.local.md` overrides | Yes | Yes | No |
| Persistent local state between sessions | Yes | Yes | No |

The CLI and VS Code Extension are equivalent in capability. Web sessions are scoped to the connected repository and do not persist local state.

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
