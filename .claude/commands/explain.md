Explain code, a file, or an architectural pattern in this project.

## How to use this command

Run `/explain` followed by what you want explained. Examples:

```
/explain src/auth/middleware.ts
/explain how the database connection pool works
/explain the CI pipeline
/explain what happens when a user logs in
```

If run without arguments, ask the user what they want explained.

## Steps

1. **Read the relevant code** — read every file involved. Do not explain from memory or assumptions. If the scope is unclear, ask the user to narrow it.

2. **Identify the audience** — if the user has not said, assume a developer who is new to this part of the codebase but comfortable with the language and framework.

3. **Explain in layers**
   - **One sentence:** what it does and why it exists.
   - **How it works:** walk through the logic step by step. Reference file paths and line numbers so the reader can follow along.
   - **Key decisions:** call out any non-obvious design choices, trade-offs, or constraints. If an ADR exists in `docs/adr/`, link to it.
   - **Connections:** how this code relates to the rest of the system — what calls it, what it calls, what data flows through it.

4. **Use a diagram when it helps** — for data flows, request lifecycles, or multi-component interactions, include a Mermaid diagram. Do not add a diagram for single-file explanations where the code is straightforward.

5. **Keep it honest** — if something looks like a bug, smells wrong, or is confusing for a reason you cannot determine, say so. Do not invent justifications.

## Rules

- Always reference specific file paths and line numbers.
- Do not dump entire files — quote only the relevant lines.
- Adjust depth to scope: a single function gets a short answer; "how does auth work" gets a thorough walkthrough.
- Do not suggest changes — this command is for understanding, not refactoring.
