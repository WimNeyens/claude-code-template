---
description: Review Claude Code release notes and update this template for new features, deprecations, or changed best practices. Run after the claude-docs-update issue is opened, or any time you want to check if the template is current.
---

# Sync Template with Claude Code Docs

Review the Claude Code release notes and update this project template — including all setup guides — to reflect new features, deprecations, and best-practice changes.

## Steps

1. **Fetch the release notes**
   Use WebFetch to get `https://docs.anthropic.com/en/release-notes/claude-code`.

2. **Read the current template**
   Read these files in parallel:
   - `docs/concepts.md`
   - `docs/setup-guide.md`
   - `SETUP.md`
   - `README.md`
   - `CLAUDE.md`
   - `.claude/settings.json`
   - `.claude/rules/code-style.md`
   - `.claude/rules/documentation.md`
   - `.claude/docs-baseline.hash` (to see when baseline was last set)

3. **Identify gaps** — compare the release notes against the template and flag:
   - New features or settings not documented in `docs/concepts.md` or `docs/setup-guide.md`
   - New hook events, tool types, or permission patterns the template should reflect
   - New slash command, skill, or MCP patterns worth adopting
   - Deprecated features still present or recommended in the template
   - Updated defaults or best practices (env vars, settings keys, workflow patterns)
   - Security or permission recommendations that changed

4. **Present a summary** — show the user a clear list of what changed and what updates are recommended, grouped by file. Be specific: name the section and line, not just the file.

5. **Ask which updates to apply** — do not make changes without user confirmation.

6. **Apply approved updates** — edit only the files that need updating. For every substantive change to a template file (`.claude/settings.json`, `CLAUDE.md`, `docs/concepts.md`), also update the corresponding sections in the setup guides:
   - `docs/setup-guide.md` — the step-by-step walkthrough; update the relevant Phase/Step
   - `SETUP.md` — the repo layout section if new files or directories were added
   - `README.md` — the layout diagram and documentation/commands tables if relevant

7. **Reset the baseline**
   Fetch the release notes page again and compute its SHA-256 hash:
   ```bash
   curl -sL "https://docs.anthropic.com/en/release-notes/claude-code" | sha256sum | cut -d' ' -f1
   ```
   Write the resulting hash (single line, no trailing whitespace) to `.claude/docs-baseline.hash`.

8. **Commit**
   Stage and commit all changed files with the message:
   ```
   Sync template with Claude Code release notes
   ```

9. **Close the tracking issue** (if one is open)
   If there is an open GitHub issue labelled `claude-docs-update`, close it with a comment summarising what was updated.
