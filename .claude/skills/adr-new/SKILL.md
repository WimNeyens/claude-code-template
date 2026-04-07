---
description: Scaffold a new Architecture Decision Record in docs/adr/. Use when the user says "new ADR", "record this decision", "write an ADR for X", or wants to document an architectural choice.
---

# New ADR

Create a new Architecture Decision Record under `docs/adr/` following the template in `.claude/rules/documentation.md`.

## Steps

1. **Determine the next ADR number.** List `docs/adr/` and find the highest existing `ADR-NNN-*.md`. Use the next integer, zero-padded to 3 digits. If the directory is empty or missing, start at `001`.

2. **Get the title and context.** If the user already described the decision, derive a short kebab-case title from it. Otherwise ask: what decision, what forced it, what alternatives were considered, what was chosen, what are the consequences.

3. **Write the file** at `docs/adr/ADR-<NNN>-<kebab-title>.md` using this exact structure (matches `.claude/rules/documentation.md`):

   ```markdown
   # ADR-<NNN>: <Title>

   **Date:** <YYYY-MM-DD>
   **Status:** Proposed

   ## Context
   <What situation or problem forced a decision? Include constraints and alternatives considered.>

   ## Decision
   <What was decided? Be specific.>

   ## Consequences
   <Trade-offs, risks, follow-on actions. Both positive and negative.>
   ```

4. **Confirm and link.** Tell the user the path and offer to add a one-line entry in `references/decisions-log.md` pointing to the new ADR.

## Notes

- Status starts as `Proposed`. Only the user marks it `Accepted`.
- Do not invent context — if you don't know why the decision was made, ask.
- One ADR per decision. If the user is describing two decisions, create two files.
