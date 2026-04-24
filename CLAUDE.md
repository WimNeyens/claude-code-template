# CLAUDE.md

This file provides guidance to AI assistants (Claude and others) when working with this repository.

## Repository Status

This repository is currently in its initial setup phase. No source code, build configuration, or tests exist yet. This file will be updated as the project evolves.

## Git Workflow

### Branching workflow

- **Never commit directly to `main`** — not even small fixes. Every change goes on a feature branch and enters `main` via a pull request. Applies to solo work too.
- Before the first edit in a new task, confirm you are on a feature branch. If on `main`, run `git checkout -b <type>/<short-description>` first.
- Branch name patterns:
  - Feature branches: `feature/<short-description>`
  - Bug fix branches: `fix/<short-description>`
  - Docs-only changes: `docs/<short-description>`
  - AI-assisted branches: `claude/<task-id>-<description>`
- Branches are short-lived and deleted after merge — see `SETUP.md` for the full loop.

### Commit Messages

Use clear, imperative commit messages:

```
Add user authentication module
Fix null pointer in data parser
Refactor database connection pool
```

- First line: concise summary (50 chars or less)
- Body (if needed): explain *why*, not *what*
- Reference issue numbers when applicable: `Fixes #42`

### Pull Requests

- All changes go through pull requests
- PRs should be focused and small — one concern per PR
- Write a clear description explaining what changed and why
- Link to relevant issues

## Development Principles

### Code Quality

- Prefer simple, readable code over clever code
- Do not over-engineer: solve the current problem, not hypothetical future ones
- Avoid premature abstractions — three similar lines of code is better than a premature helper
- Do not add features, refactoring, or "improvements" beyond what was explicitly requested

### Security

- Never commit secrets, credentials, API keys, or tokens
- Validate all external input (user input, API responses, file contents)
- Trust internal framework guarantees; only validate at system boundaries
- Follow OWASP top 10 guidelines
- The pre-commit hook (`.githooks/pre-commit`) blocks common secret patterns at commit time — do not bypass with `--no-verify` unless certain no real secret is present
- MCP tokens belong in `.claude/settings.local.json` (gitignored); use `.claude/settings.local.json.example` as the format reference
- Use `/sandbox` in a session to enable OS-level filesystem and network isolation for bash commands (recommended when working with external web services or untrusted content)

### Testing

- Write tests for new functionality when a test suite exists
- Run the full test suite before committing
- Do not mark tasks complete if tests are failing

### Dependencies

- Minimize new dependencies — evaluate whether the standard library suffices
- Pin dependency versions in lock files
- Document why a non-obvious dependency was added

## Working with AI Assistants

### What AI Assistants Should Do

- Read files before editing them
- Prefer editing existing files over creating new ones
- Keep changes focused and minimal
- Confirm before taking irreversible or high-blast-radius actions (deleting files, force-pushing, dropping data)
- Use the TodoWrite tool to track multi-step tasks
- **Monitor for new tools and workflow steps:** whenever a new tool, dependency, or workflow step is introduced, proactively suggest updating `SETUP.md` to keep the onboarding guide current. Include the update in the same PR as the change that required it.

### What AI Assistants Should Avoid

- Do not read or write files outside of `C:\DEV`
- Do not add docstrings, comments, or type annotations to code that was not changed
- Do not add error handling for scenarios that cannot happen
- Do not create helper utilities for one-time operations
- Do not push to branches other than the designated feature branch
- Do not amend published commits; create new commits instead
- Do not skip pre-commit hooks (`--no-verify`)

### Risky Actions That Require User Confirmation

Before executing any of the following, explicitly describe the action and ask the user to confirm:

- Deleting files or directories
- Force-pushing (`git push --force`)
- Hard-resetting (`git reset --hard`)
- Dropping database tables or data
- Modifying CI/CD pipelines
- Creating or closing issues/PRs on behalf of the user
- Sending messages to external services

## File Structure Conventions

```
.claude/
  .gitignore                   # Ignores local-only files inside .claude/ (settings.local.json, harvest-queue.md, .DS_Store)
  README.md                    # Index of every command and skill — keep in sync when adding/removing
  commands/                    # Custom slash commands — each .md file becomes a /command
  skills/                      # Skills (newer format) — each SKILL.md becomes a /command with extras
                               # adr-new, avoid-ai-writing, brainstorm, changelog,
                               # consistency-check-docs, diagram, export-prompt, harvest, inbox-process,
                               # release-notes, sync-template
  hooks/                       # Hook scripts (session-start, pre-tool-use)
  rules/                       # Topic-specific instructions
                               # code-style, documentation, goal-driven-execution, harvest-flag,
                               # mental-models, outbox-capture, session-start
  template-baseline.md         # Fork-time snapshot — inherited files, commit SHA, template URL
  harvest-queue.md             # Transient harvest flag queue (gitignored)
  docs-baseline.hash           # SHA-256 of last-reviewed Claude Code release notes
  settings.json                # Shared permissions and hooks
  settings.local.json          # Machine-specific MCP tokens (gitignored — never commit)
  settings.local.json.example  # Template for settings.local.json — committed, no secrets
.githooks/
  pre-commit                   # Blocks commits containing common secret patterns
  commit-msg                   # Enforces subject line ≤ 50 chars, no trailing period
  post-checkout                # Git LFS shim — DO NOT DELETE
  post-commit                  # Git LFS shim — DO NOT DELETE
  post-merge                   # Git LFS shim — DO NOT DELETE
  pre-push                     # Git LFS shim — DO NOT DELETE
                               # LFS shims are required because core.hooksPath = .githooks
                               # overrides the default location where `git lfs install` writes them.
                               # Activate once per machine: git config core.hooksPath .githooks
.github/
  ISSUE_TEMPLATE/              # Bug report and feature request templates
  workflows/
    ci.yml                     # CI pipeline — runs on every push
    codeql.yml                 # Static security analysis — add languages to matrix to activate
    claude-docs-watch.yml      # Weekly check for Claude Code docs changes
    shellcheck.yml             # Lints .claude/hooks/ and .githooks/ on every PR
  dependabot.yml               # Automated dependency update PRs
  pull_request_template.md     # Default PR description template
.vscode/
  extensions.json              # Recommended VS Code extensions
  settings.json                # Shared editor settings
.editorconfig                  # Editor-neutral formatting rules (indentation, line endings)
.gitattributes                 # Line ending rules and Git LFS routing
.gitignore                     # Files excluded from version control
.mcp.json                      # Project-scoped MCP server configuration — ships empty ({}); add servers as needed (no secrets)
_inbox/                        # Drop zone for unfiled material — see _inbox/README.md
_outbox/                       # Outbound drop zone for reusable snippets — see _outbox/README.md
assets/
  screenshots/                 # UI screenshots, diagrams, and visual documentation
docs/
  adr/                         # Architecture Decision Records (ADR-NNN-title.md)
  analysis/                    # Investigations, trade-off studies, findings
  api/                         # API reference documentation
  current-state/               # How things work today (baseline)
  design/                      # Design documents — plans, architecture sketches, mechanism designs
  deliverables/                # Finished artifacts for external audiences
    presentations/             #   Slide decks and talking points
  future-state/                # Target design
  roadmap/                     # Sequencing, phases, milestones
  runbooks/                    # Operational runbooks
  concepts.md                  # How git, branches, environments, and Claude Code work together
  setup-guide.md               # Meta: how to build a new template from scratch
  start-cli.md                 # Getting started: Claude Code CLI
  start-vscode.md              # Getting started: Claude Code VS Code Extension
  start-web.md                 # Getting started: Claude Code on the Web
references/                    # External knowledge pointers and project vocabulary
  README.md                    #   Index for the references/ folder
  sources.md                   #   Authoritative external docs
  tools.md                     #   Dashboards, consoles, portals
  research.md                  #   Articles, posts, papers
  people.md                    #   Stakeholders and contacts
  glossary.md                  #   Project terms, acronyms, codenames
  decisions-log.md             #   Lightweight decision log (sibling to ADRs)
CLAUDE.md                      # Project constitution — read by Claude on every session start
CONTRIBUTING.md                # Contribution guide — GitHub surfaces this before new issues/PRs
LICENSE                        # License — replace placeholder with your chosen license
README.md                      # Project landing page — rendered on the GitHub repo homepage
SECURITY.md                    # Vulnerability reporting policy — GitHub surfaces this in Security tab
SETUP.md                       # Machine setup guide — prerequisites, clone, MCP servers
TASKS.md                       # Lightweight project backlog — surfaced at session start
```

### Knowledge layout

Non-code knowledge lives in three places. Check them in this order when the user references material you don't immediately see:

1. **`references/glossary.md`** — first stop for any unfamiliar term, acronym, or codename the user uses. Consult before asking for clarification.
2. **`references/`** (other files) — external links (`sources.md`, `tools.md`, `research.md`), contacts (`people.md`), and small decisions (`decisions-log.md`). Prefer these over web search for authoritative docs.
3. **`_inbox/`** — raw drops the user pasted but hasn't filed. Entirely gitignored except for the README and subfolder scaffolding. Check it **and all subfolders** (`private/`, `images/`, `files/`, plus any others) when the user mentions material you can't otherwise locate ("the notes I dropped in", "the screenshot"). Do not read every file automatically; only when relevant. When you process an inbox item into its permanent home (`docs/`, `references/`, etc.), suggest deleting the original.
4. **`_outbox/`** — outbound twin of `_inbox/`. Reusable snippets captured during this project's work, staged for a future global library harvester. Unlike `_inbox/`, items here are kept, not deleted. See `.claude/rules/outbox-capture.md` for when and how to capture.

When you learn a new project term, propose adding it to `references/glossary.md`. When you discover a useful external resource, propose adding it to the appropriate `references/*.md` file.

### Custom Commands and Skills

`.claude/commands/*.md` files become `/slash-commands` in Claude Code sessions. Use them for repeatable workflows like code review, commit message drafting, or project-specific tasks. See existing commands for examples.

`.claude/skills/<name>/SKILL.md` is the newer format with additional capabilities: YAML frontmatter for auto-invocation and argument passing, supporting files (templates, scripts, examples) in the same directory, and subagent execution. Both formats work — use commands for simple prompt templates, skills when you need the extra features.

### Rules

`.claude/rules/*.md` files provide topic-specific instructions. Claude reads all rule files at session start. Use them for detailed standards (code style, security, testing) to keep `CLAUDE.md` focused on high-level guidance.

### Images and Binary Files

Two options are configured — choose based on context:

| Situation | Use |
|---|---|
| A few images (< ~10), each under ~500 KB | **Commit directly** — simple, no extra tooling |
| Many images, large files, or videos | **Git LFS** — keeps repo history lean |

**Git LFS setup** (one-time, per machine):

```bash
# Install: https://git-lfs.com
git lfs install
```

`.gitattributes` is already configured to route images, documents, videos, fonts, archives, and design files through LFS automatically once it is installed. See `.gitattributes` for the full list.

**AI assistant guidance:** When a user asks to add an image or screenshot, suggest:
- Direct commit if it is a single file or a small set of small images
- Git LFS if there are many files, files are large (> 500 KB each), or videos are involved

## Commands

*(This section will be updated once build tooling is configured.)*

Once tooling is in place, document the standard commands here, for example:

```bash
# Install dependencies
# (command here)

# Run tests
# (command here)

# Build the project
# (command here)

# Lint / format
# (command here)
```

## Updating This File

Keep this file current as the project grows. When adding a new major component, workflow, or convention, update the relevant section. AI assistants should update CLAUDE.md as part of any PR that introduces a new pattern or tool.
