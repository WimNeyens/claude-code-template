Mark a task as complete in `TASKS.md`.

Arguments: a substring matching the task to complete (case-insensitive).

Steps:
1. Read `TASKS.md`.
2. Find open tasks (`- [ ]`) whose text contains the argument (case-insensitive).
3. If exactly one match, change `[ ]` to `[x]` on that line and confirm.
4. If multiple matches, list them and ask the user which to mark.
5. If no match, say so and list current open tasks.

Do not commit.
