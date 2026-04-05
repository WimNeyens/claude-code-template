# Project Name

> Replace this line with a one-sentence description of your project.

---

## What's in this template

A production-ready scaffold for GitHub projects with Claude Code integration built in from day one.

| Area | What's included |
|---|---|
| **AI integration** | `CLAUDE.md` project constitution, standing rules, slash commands, skills, MCP config |
| **Git guardrails** | Pre-commit secret scanner, commit-msg length enforcer, branch naming conventions |
| **GitHub automation** | CI pipeline, weekly Claude Code docs monitor, Dependabot, CodeQL static analysis |
| **Security** | Secret scanning, push protection, vulnerability policy, `.gitignore` for credentials |
| **Documentation** | Concepts guide, setup walkthrough, ADR / runbook / API doc templates |
| **Binary files** | `.gitattributes` routes images, fonts, and videos through Git LFS automatically |
| **Editor config** | `.editorconfig` and `.vscode/settings.json` for consistent formatting across machines |
| **MCP ready** | `.mcp.json` for project-scoped servers; `settings.local.json` template for local tokens |

---

## Getting Started

See [SETUP.md](SETUP.md) for full setup instructions, including prerequisites, cloning, and tool configuration.

---

## AI-Assisted Development

This repository is configured for use with **Claude Code** across all three surfaces. Pick yours and follow the start guide:

| Surface | Start guide | Quick access |
|---|---|---|
| **Claude Code CLI** | [docs/start-cli.md](docs/start-cli.md) | Run `claude` from the project root |
| **Claude VS Code Extension** | [docs/start-vscode.md](docs/start-vscode.md) | Install `anthropic.claude-code`, open the project folder |
| **Claude Code on the Web** | [docs/start-web.md](docs/start-web.md) | Connect your repo at claude.ai — no install needed |

Claude reads [`CLAUDE.md`](CLAUDE.md) on every session start. That file contains project conventions, access restrictions, and coding guidelines. Update it as the project evolves.

---

## Repository Layout

```
your-project-name/
├── .claude/
│   ├── settings.json          # Shared Claude permissions, env vars, and hooks (committed)
│   ├── settings.local.json    # Machine-specific tokens and MCP servers (gitignored)
│   ├── docs-baseline.hash     # SHA-256 of last-reviewed Claude Code release notes
│   ├── commands/              # Slash commands: /review-code, /commit-message, /pr, /test, /explain, /debug, /write-docs
│   ├── skills/                # Skills: /sync-template (reviews Claude Code docs)
│   ├── rules/                 # Standing instructions: code-style.md, documentation.md
│   └── hooks/
│       └── session-start.sh   # Runs at the start of every Claude session
├── .github/
│   ├── workflows/
│   │   ├── ci.yml             # CI pipeline — runs on every push
│   │   └── claude-docs-watch.yml  # Weekly check for Claude Code doc changes
│   ├── ISSUE_TEMPLATE/        # Bug report and feature request templates
│   ├── pull_request_template.md
│   └── dependabot.yml         # Automated dependency update PRs
├── .githooks/
│   ├── pre-commit             # Blocks commits with secret patterns
│   └── commit-msg             # Enforces commit message format (≤ 50 chars, no period)
├── .vscode/
│   ├── extensions.json        # Recommended VS Code extensions
│   └── settings.json          # Shared editor settings
├── assets/
│   └── screenshots/           # Images and binary files (via Git LFS)
├── docs/
│   ├── adr/                   # Architecture Decision Records
│   ├── api/                   # API reference documentation
│   ├── runbooks/              # Operational runbooks
│   ├── concepts.md            # How repos, branches, environments and Claude Code work
│   ├── setup-guide.md         # How to create a new project from scratch using this template
│   ├── start-cli.md           # Getting started: Claude Code CLI
│   ├── start-vscode.md        # Getting started: Claude Code VS Code Extension
│   └── start-web.md           # Getting started: Claude Code on the Web
├── .gitattributes             # Line ending rules and Git LFS routing
├── .gitignore                 # Files excluded from version control
├── CLAUDE.md                  # AI assistant instructions and project conventions
├── CONTRIBUTING.md            # How to contribute
├── LICENSE                    # License — replace placeholder before publishing
├── README.md                  # This file
├── SECURITY.md                # Vulnerability reporting policy
└── SETUP.md                   # How to get started on a new machine
```

---

## Branch Protection

This repository has the following branch protection rules configured on `main`:

- Require a pull request before merging (no direct pushes to `main`)
- Require at least 1 approving review
- Dismiss stale reviews when new commits are pushed
- Require status checks to pass before merging (CI must be green)
- Automatically delete head branches after a PR is merged

All AI-assisted branches follow the pattern `claude/<task-id>-<description>` and are submitted via pull request.

---

## Documentation

| File | Purpose |
|---|---|
| [`CLAUDE.md`](CLAUDE.md) | AI assistant instructions, conventions, and access rules |
| [`CONTRIBUTING.md`](CONTRIBUTING.md) | How to contribute — branch workflow, code standards, PR process |
| [`SECURITY.md`](SECURITY.md) | Vulnerability reporting policy |
| [`SETUP.md`](SETUP.md) | Machine setup guide — prerequisites, clone, MCP servers |
| [`docs/concepts.md`](docs/concepts.md) | How git, branches, environments, and Claude Code work together |
| [`docs/setup-guide.md`](docs/setup-guide.md) | Step-by-step guide for creating a new project from this template |
| [`docs/start-cli.md`](docs/start-cli.md) | Getting started with the Claude Code CLI surface |
| [`docs/start-vscode.md`](docs/start-vscode.md) | Getting started with the Claude Code VS Code Extension |
| [`docs/start-web.md`](docs/start-web.md) | Getting started with Claude Code on the Web |
| [`.claude/rules/documentation.md`](.claude/rules/documentation.md) | Documentation standards — audience levels, templates, style rules |

**Slash commands available in every session:**

| Command | What it does |
|---|---|
| `/review-code` | Reviews current branch changes for correctness, security, and simplicity |
| `/commit-message` | Drafts a commit message from staged/unstaged changes |
| `/pr` | Creates a pull request from the current branch with a drafted description |
| `/test` | Writes tests for new or changed code, matching the project's framework |
| `/explain` | Explains code, files, or architectural patterns in the project |
| `/debug` | Systematically investigates an issue — gather evidence, hypothesise, fix |
| `/write-docs` | Generates runbooks, ADRs, API references, or diagrams |
| `/sync-template` | Reviews Claude Code release notes and updates the template to stay current |

---

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for the full workflow, code standards, and documentation guidelines.
