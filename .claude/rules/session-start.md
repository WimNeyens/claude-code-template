# Session Start

## Open tasks prompt

When the SessionStart hook reports an "Open tasks (TASKS.md)" block, list those open tasks to the user in the **very first assistant reply** of the session — *before* the branching prompt. If the user picks one to work on, derive a short branch name from it and offer that name as option 2 of the branching prompt.

If the hook does not include an open-tasks block, skip this step silently.

Note: tasks and memory are different. `TASKS.md` is a backlog of work to do in this project; memory (`MEMORY.md`) captures how to collaborate with the user. Do not conflate them.

## Branching prompt on main

When the SessionStart hook reports that the session started on `main` (look for an "ACTION REQUIRED" block in the SessionStart system reminder), surface the branching choice to the user in the **very first assistant reply** of the session.

Do this even when the user's opening message is unrelated to editing files — a greeting, a question about the repo, a chat about tooling. Do not wait "until the first edit," because a whole conversation can pass before an edit is proposed, and the user deserves to know the repo state up front.

The first reply should offer the three options from `CLAUDE.md`:

1. Continue work on an existing branch (list them if any exist)
2. Create a new feature branch (suggest a name once the task is known)
3. Proceed on `main` anyway (explicit override, rare)

Keep the prompt short. After presenting it, answer whatever else the user asked.

## Template promotion prompt

When a useful rule, workflow, or convention emerges during a session — something the user confirms they want to apply going forward — ask whether it should be promoted into the template itself (a file under `.claude/rules/`, `.claude/commands/`, `CLAUDE.md`, or similar) rather than only saved to per-project memory.

The reasoning: memory is private to one project and one user. The template is the mechanism for spreading best practices to every new project cloned from it. If a rule is good enough to remember, it is usually good enough to encode in the repo.

Apply this whenever:

- The user corrects your behavior in a way that should persist
- The user confirms a non-obvious approach that others would benefit from
- A new tool, hook, or workflow step is introduced
- You are about to save a feedback or project memory that is not user-specific

One-line prompt is enough: "Should this go in the template as a rule, or keep it as project memory only?"
