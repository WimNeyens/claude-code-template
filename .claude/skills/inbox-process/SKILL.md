---
description: Walk _inbox/, classify each item, and propose a destination in the project (docs/, references/, .claude/, etc.). Use when the user says "process inbox", "clean up _inbox", "file the inbox", or drops new material there.
---

# Process Inbox

`_inbox/` is a drop zone for unfiled material. This skill walks it, proposes a destination for each item based on the project's knowledge layout, and (with the user's approval) moves or transforms each item to its permanent home.

## Steps

1. **List the inbox.** `ls _inbox/` and ignore `README.md` (it's the inbox's own doc, not content).

2. **For each item, classify it.** Read enough of the file to decide which bucket it belongs in. Use the project's knowledge layout from `CLAUDE.md`:

   | If the item is... | Destination |
   |---|---|
   | An external link, doc, dashboard, or tool reference | `references/sources.md`, `tools.md`, `research.md`, or `people.md` |
   | A project term, acronym, or codename | `references/glossary.md` (add an entry) |
   | A small decision or rationale | `references/decisions-log.md` |
   | An architectural decision with context + alternatives | `docs/adr/` (use the `adr-new` skill) |
   | A runbook or operational procedure | `docs/runbooks/` |
   | An investigation, finding, or trade-off study | `docs/analysis/` |
   | A reusable code snippet or pattern | `_outbox/<lang>/` (see `.claude/rules/outbox-capture.md`) |
   | A SKILL.md or skill bundle | `.claude/skills/<name>/` |
   | A custom slash command | `.claude/commands/` |
   | A topic-specific rule for Claude | `.claude/rules/` |
   | An image or diagram | `assets/screenshots/` (or commit via Git LFS if large) |
   | Raw notes the user clearly wants kept verbatim | `docs/analysis/notes-<topic>.md` |

3. **Present a plan.** Before moving anything, show the user a numbered table: item → proposed destination → one-line reason. Group items, don't dump 30 separate questions.

4. **Get approval, then act.** For each approved item:
   - If it's a *file move*: copy to destination, then delete from `_inbox/` (delete is destructive — confirm if not already covered by the plan approval).
   - If it's a *transformation* (e.g., zip → installed skill, link → entry in `references/sources.md`): perform the transform, then delete the original.
   - If it's *ambiguous* or the user said "leave it": skip. Do not silently move things.

5. **Report.** List what was filed where, and what (if anything) is left in `_inbox/` and why.

## Notes

- Never delete items the user hasn't approved.
- Never chain destructive ops with safe ops in a single bash command (the harness blocks the whole chain on a denial).
- If an item is a zip or archive, extract to a temp folder under `_inbox/` first, classify the contents, then clean up both the temp folder and the original archive together at the end.
- If you encounter something you cannot classify, ask the user — do not guess.
