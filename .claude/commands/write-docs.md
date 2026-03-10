Write technical documentation for the user's chosen subject, following the standards in `.claude/rules/documentation.md`.

## How to use this command

Run `/write-docs` and immediately follow it with what you want documented. Examples:

```
/write-docs runbook for the payment service
/write-docs ADR for switching from REST to GraphQL
/write-docs API reference for the auth endpoints
/write-docs data flow diagram for the order pipeline
/write-docs L1 support guide for common login issues
/write-docs onboarding guide for new backend engineers
```

If you run `/write-docs` without arguments, ask the user:
1. What they want documented (subject and scope)
2. Who the audience is (Developer / Ops-L2 / L1 Support / Stakeholder)
3. What doc type to produce (runbook, ADR, API reference, diagram, guide, other)

## Steps

1. **Read before writing** — read every source file relevant to the subject: code, configs, existing docs, schemas, CI workflows. Do not invent details.

2. **Clarify audience and type** — if not provided, ask. Use the audience levels and document templates defined in `.claude/rules/documentation.md`.

3. **Draft the document** — follow the appropriate template from the rules file. Use Mermaid for any diagrams.

4. **Show the draft** — present the full draft and ask the user to confirm, request changes, or approve.

5. **Write the file** — save to the correct location:
   - ADRs → `docs/adr/ADR-<number>-<slug>.md`
   - Runbooks → `docs/runbooks/<slug>.md`
   - API docs → `docs/api/<slug>.md`
   - Guides and other → `docs/<slug>.md`
   Create the target directory if it does not exist.

6. **Do not commit automatically** — leave committing to the user or `/commit-message`.
