# `.claude/` — Commands, Skills, Rules, Hooks

Index of everything Claude Code loads from this directory. **Keep in sync** when adding or removing entries.

## Commands (`.claude/commands/`)

Slash commands. Each `.md` file becomes `/<filename>` in a session.

| Command | Purpose |
|---|---|
| `/commit-message` | Drafts a commit message from current staged/unstaged changes |
| `/debug` | Systematic issue investigation — gather evidence, hypothesize, fix |
| `/explain` | Explains code, files, or architectural patterns in the project |
| `/pr` | Creates a pull request from the current branch with a drafted description |
| `/review-code` | Reviews current branch changes for correctness, security, and simplicity |
| `/security-audit` | Runs a security audit — config, secrets, dependencies, CI, OWASP patterns |
| `/task-add` | Appends a new task to `TASKS.md` |
| `/task-done` | Marks a task complete in `TASKS.md` |
| `/task-list` | Lists open tasks from `TASKS.md` |
| `/test` | Writes tests for new or changed code, matching the project's framework |
| `/write-docs` | Generates runbooks, ADRs, API references, or diagrams |

## Skills (`.claude/skills/`)

Newer format with YAML frontmatter, supporting files, and subagent execution. Each `<name>/SKILL.md` becomes `/<name>`.

| Skill | Purpose |
|---|---|
| `/adr-new` | Scaffolds a new Architecture Decision Record in `docs/adr/` |
| `/avoid-ai-writing` | Audits and rewrites prose to remove AI writing tells |
| `/brainstorm` | Structured pre-planning conversation for vague or ambiguous tasks |
| `/changelog` | Generates or updates `CHANGELOG.md` from git history (Keep a Changelog format) |
| `/consistency-check` | Audits documentation files against the actual file tree; reports mismatches |
| `/diagram` | Scaffolds a Mermaid diagram (sequence, flowchart, ER, state) into a Markdown file |
| `/harvest` | Audits spin-off project for template-worthy changes; generates paste-prompts for transfer |
| `/inbox-process` | Walks `_inbox/`, classifies items, and proposes filing destinations |
| `/release-notes` | Drafts human-facing release notes from git history, grouped by theme |
| `/sync-template` | Reviews Claude Code release notes and updates the template to stay current |

## Optional upstream skill packs

Anthropic ships maintained skill packs for common document formats. Enable the ones you need — do not copy them into this template.

| Pack | What it does |
|---|---|
| `pdf` | Read, extract, and fill PDF files |
| `docx` | Create and edit Word documents |
| `xlsx` | Create and edit Excel spreadsheets |
| `pptx` | Create and edit PowerPoint presentations |

These auto-trigger by filename or user intent once enabled in your Claude Code installation. See the official skills catalog for installation details.

## Rules (`.claude/rules/`)

Topic-specific instructions. Claude reads all rule files at session start.

| File | Topic |
|---|---|
| `code-style.md` | Indentation, comments, abstractions, validation boundaries |
| `documentation.md` | Audience levels, doc types, templates, style rules |
| `mental-models.md` | Calibration framework — domain, context, intent, trust/handoff |
| `harvest-flag.md` | Conversational flagging — bookmarks items for next `/harvest` audit |
| `outbox-capture.md` | When and how to save reusable snippets to `_outbox/` |
| `session-start.md` | First-reply behavior — open tasks, branching prompt, template promotion |

## Hooks (`.claude/hooks/`)

Shell scripts the Claude Code harness invokes around tool calls and session events.

| File | Trigger | Purpose |
|---|---|---|
| `session-start.sh` | `SessionStart` | Prints git status, open tasks (`TASKS.md`), and warns when on `main` |
| `pre-tool-use.sh` | `PreToolUse` | Defense-in-depth: blocks secret reads, external fetches, and `rm -r*` |

> **Defense-in-depth note.** The deny rules in `settings.json` (curl, secret reads, `rm -rf`) are intentionally **mirrored** in `pre-tool-use.sh`. The `deny` list uses prefix-glob matching and misses edge cases like `rm -rfv`, `&&`-chained commands, and quoted variants — the hook catches those with regex. **If you remove a rule from one layer, remove it from the other.** JSON has no comment syntax, so this contract lives here rather than inline.

## Settings

| File | Committed? | Purpose |
|---|---|---|
| `settings.json` | Yes | Shared permissions, env vars, hook wiring |
| `settings.local.json` | No (gitignored) | Machine-specific MCP tokens |
| `settings.local.json.example` | Yes | Format reference for `settings.local.json` |
