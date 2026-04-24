# Goal-Driven Execution

Transform imperative tasks into verifiable goals. Strong success criteria let you loop independently; weak criteria ("make it work") require constant clarification.

Attribution: distilled from Andrej Karpathy's observations on LLM coding pitfalls.

## The reframe

Before starting non-trivial work, rewrite the request as a goal with a check:

| Imperative | Verifiable goal |
|---|---|
| "Add validation" | "Write tests for invalid inputs, then make them pass" |
| "Fix the bug" | "Write a test that reproduces it, then make it pass" |
| "Refactor X" | "Keep the existing test suite green before and after" |
| "Make the UI work" | "Open the page in a browser and confirm the golden path plus one edge case" |

The verification can be a test, a command whose exit code matters, a visible behavior in a browser, or a grep that should return nothing — whatever is cheap and unambiguous.

## Plan format for multi-step work

For tasks with more than one step, state the plan as numbered steps each paired with a check:

```
1. <step> → verify: <check>
2. <step> → verify: <check>
3. <step> → verify: <check>
```

Share this plan before executing. If you cannot name a verify step for an item, the step is too vague — split it or ask.

## When to apply

- Any bug fix, feature, or refactor where "done" is not self-evident from the diff.
- Tasks the user framed vaguely ("clean this up", "make it faster").
- Work you expect to iterate on — the verify step is what lets you know when to stop.

## When it is overkill

- Trivial edits: typos, renames, one-line config changes, obvious formatting fixes.
- Exploratory questions ("what does this do?") — the goal is understanding, not a deliverable.
- Work the user has already scoped tightly ("change line 42 to X").

Use judgment. The rule exists to prevent under-specified loops, not to add ceremony to simple tasks.

## Relation to other rules

- `mental-models.md` — Intent model: this rule operationalizes "am I solving the stated task or the underlying goal?" by forcing a verify step.
- Testing guidance in `CLAUDE.md` — when a test suite exists, prefer tests as the verification.
