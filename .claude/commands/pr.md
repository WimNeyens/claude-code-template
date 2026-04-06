Create a pull request from the current branch into main.

## Steps

1. **Understand the changes** — run `git log main..HEAD --oneline` and `git diff main...HEAD` to see every commit and change on this branch. Read all of it before writing anything.

2. **Check branch state** — run `git status` to confirm there are no uncommitted changes. If there are, ask the user whether to commit or stash them first.

3. **Push if needed** — if the branch has not been pushed or is ahead of the remote, push with `git push -u origin HEAD`.

4. **Draft the PR**
   - **Title:** short, imperative, under 70 characters. Use the title for *what*, not *how*.
   - **Summary:** 1–3 bullet points covering what changed and why.
   - **Test plan:** how to verify the changes (automated tests, manual steps, or both).
   - **Related issues:** link any issues. Use `Closes #N` to auto-close on merge.

5. **Show the draft** — present the title, summary, test plan, and linked issues. Ask the user to confirm or adjust before creating.

6. **Create the PR** — use `gh pr create` with the confirmed title and body. Use the pull request template from `.github/pull_request_template.md` as the body structure.

7. **Return the PR URL** so the user can open it directly.

8. **Remind about post-merge cleanup** — end the turn with a one-liner inviting the user to ping you once the PR is merged, so you can run `git checkout main && git pull && git branch -d <branch>` to keep the local workspace tidy. GitHub merges don't notify Claude, so this handoff must be explicit.

## Rules

- Never create the PR without showing the draft first.
- If there is only one commit, use its message as the starting point for the title.
- If there are multiple commits, summarise the overall change — do not list every commit in the title.
- Do not add labels, reviewers, or milestones unless the user asks.
