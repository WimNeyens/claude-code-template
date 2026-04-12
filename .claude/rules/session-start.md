# Session Start

## Current branch

**Always** show the current branch in the first reply. Use the branch name from the SessionStart hook's git status (the line starting with `##`).

- On a feature branch: `Branch: \`feature/some-task\`` (informational, no action needed)
- On main: show the branch **and** a branching prompt (see below)

## Branching prompt (main only)

When the session started on `main`, add a branching choice after the branch line:

1. Continue work on an existing branch (list them if any exist)
2. Create a new feature branch (suggest a name once the task is known)
3. Proceed on `main` anyway (explicit override, rare)

Do this even when the user's opening message is unrelated to editing files.

## Open tasks prompt

When the SessionStart hook reports an "Open tasks (TASKS.md)" block, list those open tasks to the user in the first reply — after the branch info. If the user picks one to work on and is on main, derive a short branch name from it and offer that name as option 2 of the branching prompt.

If the hook does not include an open-tasks block, skip this step silently.

> Note: the exact heading the hook prints lives in `.claude/hooks/session-start.sh`. Match on intent ("there are open tasks listed"), not on the literal string, so the rule and the hook can evolve independently.

Note: tasks and memory are different. `TASKS.md` is a backlog of work to do in this project; memory (`MEMORY.md`) captures how to collaborate with the user. Do not conflate them.

## Template promotion prompt

When a useful rule, workflow, or convention emerges during a session — something the user confirms they want to apply going forward — ask whether it should be promoted into the template itself (a file under `.claude/rules/`, `.claude/commands/`, `CLAUDE.md`, or similar) rather than only saved to per-project memory.

The reasoning: memory is private to one project and one user. The template is the mechanism for spreading best practices to every new project cloned from it. If a rule is good enough to remember, it is usually good enough to encode in the repo.

Apply this whenever:

- The user corrects your behavior in a way that should persist
- The user confirms a non-obvious approach that others would benefit from
- A new tool, hook, or workflow step is introduced
- You are about to save a feedback or project memory that is not user-specific

One-line prompt is enough: "Should this go in the template as a rule, or keep it as project memory only?"

## Pull before branching

When creating a new branch mid-session — especially after a PR was just merged on GitHub — always
run `git switch main && git pull` before `git switch -c <new-branch>`. The merge commit is created
on the remote and the local main does not auto-update. Branching off stale main risks conflicts
later.

This is a mechanical step. Do not ask the user — just do it.
