Systematically debug an issue. Do not guess — investigate.

## How to use this command

Run `/debug` followed by the symptom. Examples:

```
/debug test_login is failing with "connection refused"
/debug the app crashes on startup after upgrading express
/debug API returns 500 on POST /users when email contains a +
/debug build succeeds locally but fails in CI
```

If run without arguments, ask the user to describe the symptom.

## Steps

1. **Reproduce the understanding** — restate the symptom in one sentence to confirm you understand it. Ask for clarification if the description is ambiguous.

2. **Gather evidence** — before forming any hypothesis, collect data:
   - Read the error message, stack trace, or log output the user provided
   - Read the code at the location indicated by the error
   - Check recent changes: `git log --oneline -10` and `git diff` for anything uncommitted
   - If a test is failing, run it and read the full output

3. **Form hypotheses** — list 2–4 plausible causes, ranked by likelihood. For each:
   - State the hypothesis
   - State what evidence supports or contradicts it
   - State how to confirm or rule it out

4. **Investigate top-down** — start with the most likely hypothesis:
   - Read the relevant code paths
   - Check configuration, environment, and dependencies
   - Trace data flow from input to the point of failure
   - If the first hypothesis is ruled out, move to the next

5. **Identify the root cause** — once found, explain:
   - **What** is wrong (the specific line, config, or state)
   - **Why** it causes the symptom (the causal chain)
   - **When** it was introduced, if determinable (`git log`, `git blame`)

6. **Propose a fix** — show the concrete change needed. If there are multiple options, present them with trade-offs and recommend one.

7. **Verify** — after applying the fix, run the failing test or reproduce step to confirm the issue is resolved.

## Rules

- Never jump to a fix without reading the error and the code first.
- Never change code "to see if it helps" — understand the cause, then fix it.
- If you cannot reproduce or find the root cause, say so honestly and suggest what additional information would help.
- Do not widen scope — fix the reported issue, not adjacent code that looks suspicious.
- If the bug is in a dependency, identify the version and check for known issues before attempting a workaround.
