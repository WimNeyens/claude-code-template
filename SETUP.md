# Development Environment Setup

How to get this repository running on a new machine.
Update this file whenever a new tool, step, or convention is introduced.

---

## Prerequisites

Install the following before cloning the repo.

### 1. Git

```powershell
# Windows — download from https://git-scm.com/download/win
```

```bash
# macOS
brew install git

# Ubuntu / Debian
sudo apt update && sudo apt install git
```

Verify: `git --version`

### 2. Git LFS

This repo uses Git LFS for binary files (images, fonts, design files, videos, archives).

```powershell
# Windows — download from https://git-lfs.com
```

```bash
# macOS
brew install git-lfs

# Ubuntu / Debian
sudo apt install git-lfs
```

After installing, run **once per machine**:

```bash
git lfs install
```

Verify: `git lfs version`

> Without this step, binary files will appear as small text pointer files instead of their actual content.

### 3. GitHub CLI (recommended)

Used for managing pull requests, issues, and branches from the terminal.

```powershell
# Windows
winget install --id GitHub.cli
```

```bash
# macOS
brew install gh

# Ubuntu / Debian
sudo apt install gh
```

Authenticate once:

```bash
gh auth login
# Choose: GitHub.com → HTTPS → Login with browser
```

Verify: `gh --version`

### 4. Node.js LTS (if the project uses JavaScript/TypeScript)

```powershell
# Windows — download from https://nodejs.org (choose LTS)
```

```bash
# macOS
brew install node

# Ubuntu / Debian
curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
sudo apt install nodejs
```

Verify: `node --version` and `npm --version`

### 5. Claude Code CLI

**Recommended — native installer (auto-updates):**

```bash
# macOS / Linux / WSL
curl -fsSL https://claude.ai/install.sh | bash
```

```powershell
# Windows PowerShell
irm https://claude.ai/install.ps1 | iex
```

**Alternative — npm (does not auto-update):**

```bash
npm install -g @anthropic-ai/claude-code
```

Log in: `claude login`

Verify: `claude --version`

---

## Clone the Repository

```bash
git clone https://github.com/YOUR_USERNAME/your-project-name.git
cd your-project-name
git config core.hooksPath .githooks   # activate the pre-commit secret scanner
```

LFS files are fetched automatically during clone if `git lfs install` was run first.

To explicitly pull LFS files after the fact:

```bash
git lfs pull
```

---

## Repository Layout

```
your-project-name/
├── .claude/
│   ├── settings.json              # Shared Claude permissions, env vars, and hooks (committed)
│   ├── settings.local.json        # Machine-specific MCP servers and tokens (gitignored)
│   ├── settings.local.json.example  # Template for settings.local.json — copy and fill in
│   ├── docs-baseline.hash         # SHA-256 of last-reviewed Claude Code release notes
│   ├── commands/
│   │   ├── commit-message.md      # /commit-message slash command
│   │   ├── debug.md               # /debug — systematic issue investigation
│   │   ├── explain.md             # /explain — explain code, files, or architecture
│   │   ├── pr.md                  # /pr — create a pull request from current branch
│   │   ├── review-code.md         # /review-code slash command
│   │   ├── test.md                # /test — write tests for new or changed code
│   │   └── write-docs.md          # /write-docs — generates runbooks, ADRs, API docs
│   ├── skills/
│   │   └── sync-template/
│   │       └── SKILL.md           # /sync-template — reviews Claude Code docs, updates template
│   ├── rules/
│   │   ├── code-style.md          # Code style standards
│   │   └── documentation.md       # Doc standards: audience levels, templates, style rules
│   └── hooks/
│       └── session-start.sh       # Prints git status and context at session start
├── .github/
│   ├── workflows/
│   │   ├── ci.yml                 # CI pipeline — runs on every push
│   │   ├── codeql.yml             # Static analysis — activate by adding languages
│   │   └── claude-docs-watch.yml  # Weekly check for Claude Code doc changes
│   ├── ISSUE_TEMPLATE/
│   │   ├── bug_report.md          # Bug report template
│   │   └── feature_request.md     # Feature request template
│   ├── pull_request_template.md
│   └── dependabot.yml             # Automated dependency update PRs
├── .githooks/
│   ├── pre-commit                 # Blocks commits containing common secret patterns
│   └── commit-msg                 # Enforces subject line length (≤ 50 chars) and format
├── .vscode/
│   ├── extensions.json            # Recommended VS Code extensions
│   └── settings.json              # Shared editor settings
├── assets/
│   └── screenshots/               # Images and binary files (via Git LFS)
├── docs/
│   ├── adr/                       # Architecture Decision Records (ADR-NNN-title.md)
│   ├── api/                       # API reference documentation
│   ├── runbooks/                  # Operational runbooks
│   ├── concepts.md                # How repos, branches, environments and Claude Code work
│   └── setup-guide.md             # How to create a new project from scratch using this template
├── .editorconfig                  # Editor-neutral formatting rules (indentation, line endings)
├── .gitattributes                 # Line ending rules and Git LFS routing
├── .gitignore                     # Files excluded from version control
├── CLAUDE.md                      # Claude Code instructions and project conventions
├── CONTRIBUTING.md                # How to contribute — shown by GitHub before new issues/PRs
├── LICENSE                        # License — replace placeholder with your chosen license
├── SECURITY.md                    # Vulnerability reporting policy
└── SETUP.md                       # This file — how to get started on a new machine
```

---

## Install Git Hooks

This repo ships two hooks in `.githooks/`:

| Hook | What it does |
|------|-------------|
| `pre-commit` | Blocks commits containing common secret patterns (API keys, tokens, passwords) |
| `commit-msg` | Enforces subject line ≤ 50 characters, no trailing period, blank line before body |

Run once after cloning:

```bash
git config core.hooksPath .githooks
```

From now on every `git commit` in this repo runs both hooks automatically.

To bypass a confirmed false positive:

```bash
git commit --no-verify
```

Only bypass when you are certain no real secret is present and the commit message deviation is intentional (e.g., a merge commit with a long auto-generated subject).

---

## MCP Server Setup (Claude Code CLI + VSCode)

MCP servers give Claude access to local files and the GitHub API. They are machine-specific and stored in `.claude/settings.local.json` (gitignored — never committed).

> **Note:** `.mcp.json` at the repo root is intentionally empty. It is the place for project-scoped MCP servers that the whole team shares (no secrets). Add servers here only when a project-scoped MCP server is needed. Machine-specific servers with tokens go in `.claude/settings.local.json` instead.

Copy the example and fill in your values:

```bash
cp .claude/settings.local.json.example .claude/settings.local.json
# Then open it and replace the placeholders
code .claude/settings.local.json
```

Replace:
- `/path/to/this/repo` with the actual path to this repo on your machine
- `your-fine-grained-token-here` with a GitHub fine-grained PAT (see `docs/setup-guide.md` Phase 7)

### Adapting permissions for your stack

`.claude/settings.json` ships with pre-approved permissions for **Node.js** (`npm`) and **Python** (`pip`, `pytest`). If your project uses a different stack, add the relevant commands to the `"allow"` list:

| Stack | Commands to add |
|---|---|
| Go | `Bash(go build *)`, `Bash(go test *)`, `Bash(go run *)`, `Bash(go mod *)` |
| Rust | `Bash(cargo build *)`, `Bash(cargo test *)`, `Bash(cargo run *)`, `Bash(cargo clippy *)` |
| .NET | `Bash(dotnet build *)`, `Bash(dotnet test *)`, `Bash(dotnet run *)` |
| Ruby | `Bash(bundle install *)`, `Bash(bundle exec *)`, `Bash(rake *)` |

Remove permissions for stacks you do not use to keep the allow-list focused.

---

## Git LFS: Tracked File Types

| Category     | Extensions                                      |
|--------------|-------------------------------------------------|
| Images       | `.bmp` `.png` `.jpg` `.jpeg` `.gif` `.webp` `.svg` `.ico` |
| Documents    | `.pdf`                                          |
| Video        | `.mp4` `.mov`                                   |
| Fonts        | `.ttf` `.woff` `.woff2`                         |
| Archives     | `.zip` `.tar` `.gz`                             |
| Design files | `.psd` `.fig` `.ai` `.sketch`                   |

**Storage limits (GitHub free):** 1 GB storage, 1 GB/month bandwidth.
Monitor: GitHub → Settings → Billing → Git LFS.

---

## Daily Git Workflow

### Branch naming

| Type        | Pattern                           |
|-------------|-----------------------------------|
| Feature     | `feature/<short-description>`     |
| Bug fix     | `fix/<short-description>`         |
| AI-assisted | `claude/<task-id>-<description>`  |

### Create and push a branch

```bash
git checkout -b feature/my-feature
# make changes
git add <files>
git commit -m "Add my feature"
git push -u origin feature/my-feature
```

### Open a pull request

```bash
gh pr create --title "Add my feature" --body "Description of what and why"
```

### Merged branch cleanup

Enable **"Automatically delete head branches"** in your repo settings (GitHub → Settings → General → scroll to Pull Requests section). Once enabled, GitHub deletes the source branch automatically after a PR is merged.

This is not on by default but is recommended — merged branches serve no purpose since all commits are permanently in `main`.

---

## Build, Test & Lint

> Update this section once project tooling is configured.

```bash
# Install dependencies
# (command here)

# Run tests
# (command here)

# Build
# (command here)

# Lint / format
# (command here)
```

---

## Troubleshooting

### Binary files show as text pointers

You cloned before running `git lfs install`. Fix:

```bash
git lfs install
git lfs pull
```

### LFS quota exceeded

GitHub → Settings → Billing → Git LFS.
Options: purchase additional data packs, clean up old LFS objects, or move large files outside the repo.

### `gh: command not found`

GitHub CLI is optional. Use the GitHub web UI for PRs and issues instead, or install it following the prerequisites above.

### Pre-commit hook is not running

You cloned without activating the hooks directory. Fix:

```bash
git config core.hooksPath .githooks
```

### Pre-commit hook blocked a false positive

A line matched a secret pattern but contains no real secret. Bypass once:

```bash
git commit --no-verify
```

### Commit-msg hook blocked your message

The subject line exceeded 50 characters or had a trailing period. Edit the message and re-commit, or bypass once with `--no-verify` if the exception is intentional (e.g., a long auto-generated merge subject).

### Claude does not read CLAUDE.md

Make sure you are running `claude` from inside the project folder — not a parent directory. Claude reads `CLAUDE.md` from the current working directory.

---

## Updating This Document

When you introduce a new tool, dependency, or workflow step:
1. Add it to the relevant section here.
2. Include install commands for Windows, macOS, and Linux where applicable.
3. Commit the update in the same PR as the change that required it.
