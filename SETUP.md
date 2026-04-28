# Development Environment Setup

**Audience:** someone who has cloned this template (or a project created from it) and wants to run it locally.
For instructions on **building this template from scratch**, see [`docs/setup-guide.md`](docs/setup-guide.md).

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

**Windows — try winget first, fall back to the MSI:**

```powershell
# Run from an elevated PowerShell (Run as Administrator)
winget install --id GitHub.cli -e --source winget
```

If winget fails (common on corporate machines), download the MSI directly:

1. Open https://github.com/cli/cli/releases/latest
2. Scroll past the release notes to the **Assets** section (collapsed — click to expand)
3. Download `gh_<version>_windows_amd64.msi`
4. Double-click to install

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

**Windows winget troubleshooting** (skip if you used the MSI):

- *Installer exit code 1603* — the MSI needs Administrator rights. Re-run from an elevated PowerShell.
- *`0x8a15000f : Data required by the source is missing`* — winget's source index is unreachable. Try `winget source reset --force` then `winget source update`. If that still fails on a corporate machine, it is almost always enterprise policy, a proxy, or TLS inspection blocking winget's CDN endpoints (`cdn.winget.microsoft.com`, `storeedgefd.dsx.mp.microsoft.com`). Diagnose with:
  ```powershell
  # Enterprise policy check
  reg query "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppInstaller" 2>$null
  # Reachability check
  Test-NetConnection cdn.winget.microsoft.com -Port 443
  ```
  On a restricted network, just use the MSI download above — it is served from GitHub's CDN, which is typically already allowed since `git clone` works.

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

### 5. Python tooling: uv (optional)

If your project uses Python — or you want to install Python-based CLI tools globally — `uv` is the modern toolchain manager from [Astral](https://docs.astral.sh/uv/) (same team behind `ruff`). One Rust binary replaces `pip`, `pipx`, `virtualenv`, and `pyenv`, runs 10–100× faster than the originals, and manages Python interpreter versions itself.

```powershell
# Windows
winget install --id=astral-sh.uv -e
```

```bash
# macOS
brew install uv

# Linux
curl -LsSf https://astral.sh/uv/install.sh | sh
```

Verify: `uv --version`

Common commands:

```bash
uv tool install <package>     # install a Python CLI in an isolated env (replaces pipx)
uv tool list                  # list installed tools
uv tool uninstall <package>   # clean removal
uv venv && uv pip install -r requirements.txt   # create venv + install deps
uvx <package>                 # run a tool one-off without installing (replaces pipx run)
uv python install 3.13        # install a specific Python version (replaces pyenv install)
```

Skip if your project does not use Python and you do not need Python CLI tools.

### 6. jq (required by Claude hooks)

The `pre-tool-use.sh` hook parses tool input as JSON. Without `jq`, the secret-read and external-fetch guardrails fall back to a degraded mode and emit a warning at every tool call.

```powershell
# Windows
winget install --id stedolan.jq -e
```

```bash
# macOS
brew install jq

# Ubuntu / Debian
sudo apt install jq
```

Verify: `jq --version`

### 7. Claude Code CLI

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

## Post-Clone GitHub Settings

GitHub template repositories copy **files only** — not repo settings, branch protection rules, secrets, labels, or webhooks. After creating a new repo from this template, apply the following settings manually in the GitHub web UI:

| Setting | Where | Why |
|---|---|---|
| **Automatically delete head branches** | Settings → General → Pull Requests | Keeps the branch list clean; merged branches serve no purpose once their commits are in `main`. |
| **Branch protection rule on `main`** | Settings → Branches → Add branch ruleset | Server-side enforcement of "never commit to `main`". Without this, the rule lives only in `CLAUDE.md` and is convention-only. |

### Branch protection — recommended ruleset

Apply these to `main` (Settings → Branches → Add branch ruleset → Target branch: `main`):

- **Require a pull request before merging** — block direct pushes
- **Require approvals: 1** (or 0 for solo work, but keep the PR requirement)
- **Dismiss stale pull request approvals when new commits are pushed**
- **Require status checks to pass before merging** — select `ci` and `shellcheck` once they have run at least once
- **Require linear history** — no merge commits, keeps `git log` readable
- **Block force pushes**
- **Restrict deletions**

This makes the "feature branches only" rule from `CLAUDE.md` enforced server-side, not just by AI politeness.

---

## Repository Layout

```
your-project-name/
├── .claude/
│   ├── .gitignore                 # Ignores local-only files inside .claude/ (settings.local.json, harvest-queue.md, .DS_Store)
│   ├── settings.json              # Shared Claude permissions, env vars, and hooks (committed)
│   ├── settings.local.json        # Machine-specific MCP servers and tokens (gitignored)
│   ├── settings.local.json.example  # Template for settings.local.json — copy and fill in
│   ├── docs-baseline.hash         # SHA-256 of last-reviewed Claude Code release notes
│   ├── README.md                  # Index of every command and skill (keep in sync when adding/removing)
│   ├── commands/
│   │   ├── commit-message.md      # /commit-message — drafts a commit message from current changes
│   │   ├── debug.md               # /debug — systematic issue investigation
│   │   ├── explain.md             # /explain — explain code, files, or architecture
│   │   ├── pr.md                  # /pr — create a pull request from current branch
│   │   ├── review-code.md         # /review-code — review current branch changes
│   │   ├── security-audit.md      # /security-audit — run a security audit of the project
│   │   ├── task-add.md            # /task-add — append a new task to TASKS.md
│   │   ├── task-done.md           # /task-done — mark a task complete in TASKS.md
│   │   ├── task-list.md           # /task-list — show open tasks from TASKS.md
│   │   ├── test.md                # /test — write tests for new or changed code
│   │   └── write-docs.md          # /write-docs — generates runbooks, ADRs, API docs
│   ├── skills/
│   │   ├── adr-new/SKILL.md       # /adr-new — scaffold a new ADR in docs/adr/
│   │   ├── avoid-ai-writing/SKILL.md  # /avoid-ai-writing — audit prose for AI tells
│   │   ├── brainstorm/SKILL.md    # /brainstorm — pre-planning conversation for vague tasks
│   │   ├── changelog/SKILL.md     # /changelog — generate or update CHANGELOG.md from git history
│   │   ├── consistency-check-docs/SKILL.md # /consistency-check-docs — audit docs against actual file tree
│   │   ├── diagram/SKILL.md       # /diagram — scaffold a Mermaid diagram into a Markdown file
│   │   ├── export-prompt/SKILL.md # /export-prompt — export prompts/plans to cross-project library
│   │   ├── harvest/SKILL.md       # /harvest — audit spin-off for template-worthy changes
│   │   ├── inbox-process/SKILL.md # /inbox-process — walk _inbox/ and propose filing
│   │   ├── release-notes/SKILL.md # /release-notes — draft human-facing release notes from git history
│   │   └── sync-template/SKILL.md # /sync-template — reviews Claude Code docs, updates template
│   ├── rules/
│   │   ├── code-style.md          # Code style standards
│   │   ├── documentation.md       # Doc standards: audience levels, templates, style rules
│   │   ├── goal-driven-execution.md # Reframe imperative tasks as verifiable goals
│   │   ├── harvest-flag.md        # Conversational flagging — bookmarks items for next /harvest audit
│   │   ├── mental-models.md       # Calibration framework for collaboration
│   │   ├── outbox-capture.md      # When to save snippets to _outbox/
│   │   └── session-start.md       # First-reply behavior (open tasks, branching prompt)
│   ├── template-baseline.md       # Fork-time snapshot — inherited files, commit SHA, template URL
│   ├── harvest-queue.md           # Transient harvest flag queue (gitignored)
│   └── hooks/
│       ├── pre-tool-use.sh        # Blocks secrets, external fetches, rm -r* (defense-in-depth)
│       └── session-start.sh       # Prints git status, open tasks, and branch warnings
├── .github/
│   ├── workflows/
│   │   ├── ci.yml                 # CI pipeline — runs on every push
│   │   ├── codeql.yml             # Static analysis — activate by adding languages
│   │   ├── claude-docs-watch.yml  # Weekly check for Claude Code doc changes
│   │   └── shellcheck.yml         # Lints .claude/hooks/ and .githooks/ on every PR
│   ├── ISSUE_TEMPLATE/
│   │   ├── bug_report.md          # Bug report template
│   │   └── feature_request.md     # Feature request template
│   ├── pull_request_template.md
│   └── dependabot.yml             # Automated dependency update PRs
├── .githooks/
│   ├── pre-commit                 # Blocks commits containing common secret patterns
│   ├── commit-msg                 # Enforces subject line length (≤ 50 chars) and format
│   ├── post-checkout              # Git LFS shim — required because core.hooksPath = .githooks
│   ├── post-commit                # Git LFS shim
│   ├── post-merge                 # Git LFS shim
│   └── pre-push                   # Git LFS shim
├── .vscode/
│   ├── extensions.json            # Recommended VS Code extensions
│   └── settings.json              # Shared editor settings
├── _inbox/                        # Drop zone for unfiled material (notes, exports, screenshots)
├── _outbox/                       # Outbound drop zone for reusable snippets — future library harvester sweeps this
├── assets/
│   └── screenshots/               # Images and binary files (via Git LFS)
├── docs/
│   ├── adr/                       # Architecture Decision Records (ADR-NNN-title.md)
│   ├── analysis/                  # Investigations, trade-off studies, findings
│   ├── api/                       # API reference documentation
│   ├── current-state/             # How things work today (baseline)
│   ├── design/                    # Design documents — plans, architecture sketches, mechanism designs
│   ├── deliverables/              # Finished artifacts for external audiences
│   │   └── presentations/         #   Slide decks and talking points
│   ├── future-state/              # Target design
│   ├── roadmap/                   # Sequencing, phases, milestones
│   ├── runbooks/                  # Operational runbooks
│   ├── concepts.md                # How repos, branches, environments and Claude Code work
│   ├── setup-guide.md             # How to create a new project from scratch using this template
│   ├── start-cli.md               # Getting started: Claude Code CLI
│   ├── start-vscode.md            # Getting started: Claude Code VS Code Extension
│   └── start-web.md               # Getting started: Claude Code on the Web
├── references/                    # External knowledge pointers and project vocabulary
│   ├── README.md                  #   Index for the references/ folder
│   ├── sources.md                 #   Authoritative external docs
│   ├── tools.md                   #   Dashboards, consoles, portals
│   ├── research.md                #   Articles, posts, papers
│   ├── people.md                  #   Stakeholders and contacts
│   ├── glossary.md                #   Project terms, acronyms, codenames
│   └── decisions-log.md           #   Lightweight decision log (sibling to ADRs)
├── .editorconfig                  # Editor-neutral formatting rules (indentation, line endings)
├── .gitattributes                 # Line ending rules and Git LFS routing
├── .gitignore                     # Files excluded from version control
├── .mcp.json                      # Project-scoped MCP servers — ships empty, add as needed (no secrets)
├── CLAUDE.md                      # Claude Code instructions and project conventions
├── CONTRIBUTING.md                # How to contribute — shown by GitHub before new issues/PRs
├── LICENSE                        # License — replace placeholder with your chosen license
├── README.md                      # Project overview — what it is and how to run it
├── SECURITY.md                    # Vulnerability reporting policy
├── TASKS.md                       # Lightweight project backlog — surfaced at session start
└── SETUP.md                       # This file — how to get started on a new machine
```

---

## Install Git Hooks

This repo ships these hooks in `.githooks/`:

| Hook | What it does |
|------|-------------|
| `pre-commit` | Blocks commits containing common secret patterns (API keys, tokens, passwords) |
| `commit-msg` | Enforces subject line ≤ 50 characters, no trailing period, blank line before body |
| `post-checkout`, `post-commit`, `post-merge`, `pre-push` | Git LFS shims. Required because setting `core.hooksPath = .githooks` overrides the default location where `git lfs install` writes its hooks. **Do not delete** — without them, LFS tracking silently breaks. |

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

> **Golden rule:** never commit directly to `main`. Every change — even a one-line fix — goes on a feature branch and enters `main` via a pull request. This holds for solo work too; it keeps `main` always-deployable and gives you a built-in chance to review your own diff.

### The loop at a glance

```
main  ●──────●──────●──────●   always-deployable, protected
       \           /
        ●────●────●            feature/<name> — short-lived, deleted after merge
```

1. Start from an up-to-date `main`: `git checkout main && git pull`
2. Create a branch: `git checkout -b feature/<name>`
3. Commit small logical changes on the branch
4. Push the branch: `git push -u origin feature/<name>`
5. Open a PR into `main` (use `/pr` or `gh pr create`)
6. Merge via the PR (review, CI, discussion all happen here)
7. Delete the branch (GitHub can do this automatically — see below)
8. Back to step 1 for the next change

### How branches isolate work

Checking out a branch swaps your working directory to that branch's state — you can build, run, and test it as if it were the only version of the code. `main` on disk is unaffected until you switch back. This is why branches are the right place for experimental or in-progress work: nothing you do there can break `main`.

Two practical notes:
- Commit or `git stash` before switching branches, or Git will refuse the switch.
- Need two branches checked out at once (e.g. to compare running versions)? Use `git worktree add <path> <branch>` — it gives you a second working directory without disturbing the first.

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
