---
description: Audit documentation for consistency with the actual file tree. Reports mismatches as a checklist — does not auto-fix. Use when the user says "consistency check", "doc audit", "are the docs in sync", or after adding/removing commands, skills, or rules.
---

# Consistency Check — Documentation vs Reality Audit

Compare what the documentation claims exists against what actually exists on disk. Report every mismatch so the user can decide what to fix.

## Steps

1. **Inventory the file system.** Use Glob or ls to collect the actual contents of:
   - `.claude/commands/*.md` — each filename minus `.md` = command name
   - `.claude/skills/*/SKILL.md` — each directory name = skill name
   - `.claude/rules/*.md` — each filename
   - `.claude/hooks/*` — each filename
   - Top-level files and directories
   - `docs/` subdirectories and files
   - `references/` files

2. **Audit `.claude/README.md` tables.** Read `.claude/README.md`. For each table (Commands, Skills, Rules, Hooks):
   - Check that every actual file on disk has a corresponding row.
   - Check that every row in the table has a corresponding file on disk.
   - Report mismatches as `MISSING FROM TABLE: <file>` or `TABLE ENTRY WITHOUT FILE: <name>`.

3. **Audit `CLAUDE.md` file tree.** Read the "File Structure Conventions" code block in `CLAUDE.md`. Compare each entry against actual files and directories on disk. Report:
   - Files or directories on disk not represented in the tree.
   - Tree entries that do not exist on disk.

4. **Audit `SETUP.md` repository layout.** Read the "Repository Layout" code block in `SETUP.md`. Same comparison as step 3.

5. **Audit `CONTRIBUTING.md` references.** Read `CONTRIBUTING.md` and extract all file path references (Markdown links and inline code paths). Verify each referenced path exists on disk.

6. **Audit `references/glossary.md` coverage.** Collect terms that appear in skill YAML `description` fields and rule filenames. Check whether each project-specific term has a glossary entry. Skip generic English words; focus on template-specific vocabulary.

7. **Cross-check consistency between index files.** Verify that `.claude/README.md`, `CLAUDE.md`, and `SETUP.md` agree on the same set of commands, skills, rules, and hooks. Report any item that appears in one index but not another.

8. **Present the report.** Output a single checklist grouped by source file:

   ```
   ## Consistency Report

   ### .claude/README.md
   - [ ] Skills table: missing `/new-skill` (exists on disk)
   - [x] Commands table: all entries match disk (11 commands)

   ### CLAUDE.md
   - [ ] File tree: missing `docs/design/` directory
   - [ ] File tree: lists `.claude/rules/old-rule.md` but file does not exist

   ### SETUP.md
   - [ ] Repository layout: missing `references/` directory section

   ### CONTRIBUTING.md
   - [x] All referenced paths exist

   ### references/glossary.md
   - [ ] Term "harvest" used in skills but not defined

   ### Cross-index consistency
   - [ ] Skill `/harvest` in .claude/README.md but missing from SETUP.md
   ```

9. **Do not fix anything.** The report is the deliverable. The user decides what to act on.

## What this skill does NOT do

- No automatic fixes — report only.
- No external fetches — works entirely from local files.
- No git operations — reads the working tree, not git history.
- No session-start cost — loads only when explicitly invoked.
