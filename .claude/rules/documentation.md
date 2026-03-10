# Documentation Standards

## General Principles

- Write for the intended audience — state it explicitly at the top of every document
- Prefer short sentences and active voice
- Do not document what the code already makes obvious; document *why*, edge cases, and failure modes
- Keep docs in the repo alongside the code they describe — drift is visible in PRs
- Use Mermaid for diagrams (supported natively in GitHub Markdown)

## Audience Levels

Use one of these labels at the top of every document:

| Label | Audience |
|---|---|
| `Audience: Developer` | Engineers familiar with the codebase |
| `Audience: Ops / L2` | Operations staff who run and monitor the system |
| `Audience: L1 Support` | First-line support following a runbook |
| `Audience: Stakeholder` | Non-technical readers needing overview context |

Adjust vocabulary and assumed knowledge accordingly. Never mix audiences in one document — split into separate files if needed.

## Document Types and Templates

### Architecture Decision Record (ADR)

```markdown
# ADR-<number>: <title>

**Date:** YYYY-MM-DD
**Status:** Proposed | Accepted | Deprecated | Superseded by ADR-<n>

## Context
What situation or problem forced a decision?

## Decision
What was decided?

## Consequences
What are the trade-offs, risks, and follow-on actions?
```

Store ADRs in `docs/adr/`.

### Runbook

```markdown
# Runbook: <system or process name>

Audience: Ops / L2
Last reviewed: YYYY-MM-DD

## Overview
One paragraph: what this system does and when this runbook applies.

## Prerequisites
- Access / permissions required
- Tools needed

## Procedures

### <Procedure name>
**When to use:** ...
**Steps:**
1. ...
2. ...
**Expected outcome:** ...

## Common failure modes

### <Symptom>
**Cause:** ...
**Resolution:** ...

## Escalation
When and how to escalate beyond this runbook.
```

Store runbooks in `docs/runbooks/`.

### API Reference

- Document every public endpoint: method, path, auth, request body, response body, error codes
- Include a curl example for each endpoint
- Note rate limits, pagination, and versioning behaviour
- Generate from OpenAPI/AsyncAPI spec where possible; keep the spec as the source of truth

Store API docs in `docs/api/`.

### Data Flow / Sequence Diagram

Use Mermaid `sequenceDiagram` or `flowchart` blocks embedded directly in Markdown.
Always include a plain-English paragraph before the diagram explaining what it shows.

## Style Rules

- Headings: sentence case (`## Common failure modes`, not `## Common Failure Modes`)
- Code blocks: always specify the language (`bash`, `json`, `sql`, etc.)
- Commands the reader should run: use a `bash` code block, one command per block unless they must be chained
- File paths: use backtick inline code (`` `docs/runbooks/` ``)
- Do not use bold for emphasis within a sentence more than once per paragraph
- Spell out abbreviations on first use: "Mean Time To Recovery (MTTR)"

## What to Avoid

- Do not copy-paste code into docs — link to the file and line instead
- Do not include secrets, credentials, or environment-specific values — use placeholders like `<YOUR_API_KEY>`
- Do not let docs describe a future desired state as if it were current — date-stamp aspirational content clearly
- Do not create a doc just to have one — if the code is self-explanatory, a comment suffices
