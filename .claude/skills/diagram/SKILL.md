---
description: Scaffold a Mermaid diagram (sequence, flowchart, ER, state) into a Markdown file. Use when the user says "draw a diagram", "sequence diagram", "flowchart", "visualize this flow", or asks for a Mermaid block.
---

# Diagram

Generate a Mermaid diagram block and insert it into a target Markdown file, following the documentation rule that Mermaid is the project default (`.claude/rules/documentation.md`).

## Steps

1. **Clarify what to draw.** If the user hasn't specified, ask two questions: (a) which diagram type — `sequenceDiagram`, `flowchart`, `erDiagram`, `stateDiagram-v2`, or `classDiagram`, and (b) what the diagram should show. Do not invent participants or entities.

2. **Pick the target file.** If the user names one, use it. Otherwise suggest: an existing doc under `docs/`, or a new file like `docs/diagrams/<short-name>.md`. Confirm before creating a new file.

3. **Write a one-paragraph preamble** in plain English above the diagram explaining what it shows — required by `.claude/rules/documentation.md`.

4. **Emit the Mermaid block** inside a fenced ```` ```mermaid ```` code block. Keep labels short. Do not add styling unless asked.

5. **Confirm render path.** Mention that GitHub renders Mermaid natively in Markdown — no extra tooling required.

## Notes

- Prefer `sequenceDiagram` for request/response flows, `flowchart` for decisions and data movement, `erDiagram` for schemas, `stateDiagram-v2` for lifecycles.
- One diagram per block. If the user describes two flows, make two blocks with separate preambles.
- Do not embed secrets, real usernames, or internal hostnames in labels — use placeholders.
