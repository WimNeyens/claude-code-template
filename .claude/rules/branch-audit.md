# Branch Audit

Rules for auditing branches before recommending deletion, merge, or other lifecycle actions. The failure this prevents: recommending deletion based purely on git-mechanical signals (no unique commits, strict ancestor of main, `[gone]` upstream) while missing intent signals that the branch is an intentional bookmark for paused or future work.

## When this applies

- Any time you produce a list of branches recommended for deletion.
- Branch cleanup conversations ("I want to clean up branches", "are there stale branches", "what can I delete").
- After a fetch/prune that surfaces `[gone]` upstreams.
- Before responding to "is this branch safe to delete".

## Mandatory cross-check

For every branch in a deletion candidate list, perform both checks before presenting the recommendation:

1. **Git mechanical check** — fetch+prune, then verify against `origin/main`:
   - Unique commits (`git log origin/main..<branch>`)
   - Unique files (`git diff --diff-filter=A --name-only origin/main <branch>`)
   - Last-commit date (`git log -1 --format='%ai %h %s' <branch>`)

2. **Intent check** — scan for signals that the branch is intentional:
   - Loaded `MEMORY.md` entries that name the branch by name
   - Memory file titles or descriptions that reference work-in-progress on that branch
   - Gitignored sibling folders that pair with the branch (e.g. `_inbox/<topic>/` matching `feature/<topic>-doc`)
   - Recent conversation context where the user has named the branch as ongoing work
   - The branch name itself encoding a persistent initiative (vs. a transient chore)

A branch can have **zero unique commits and still be intentional**. The actual work-in-progress often lives in gitignored locations (`_inbox/`, `_outbox/`) and never appears in git history. "Strict ancestor of main" or "no unique commits" is necessary but not sufficient grounds for deletion.

## Presenting the recommendation

When presenting deletion candidates:

- Frame the verdict as "based on git state" so the user can overlay their own intent.
- For any branch that triggered an intent signal, default to **keep** and surface the signal explicitly: "memory references this branch as <X>, defaulting to keep".
- Never present a single-column "delete these" list — always present a table with the reasoning per branch, so the user can override individual rows.
- Confirm before executing any deletion, even when the user has broadly authorized cleanup.

## What this rule does NOT cover

- Merge, rebase, or cherry-pick decisions — separate concerns with their own trade-offs.
- Remote branches that the user has explicitly named (their explicit naming is itself an intent signal).
- Active branches with uncommitted working-tree changes — those need WIP-handling, not audit.
