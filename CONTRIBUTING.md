# Contributing

Thank you for your interest in contributing.

## Before you start

- Read [README.md](README.md) to understand what this project does.
- Check existing [issues](../../issues) and [pull requests](../../pulls) to avoid duplicating work.
- For significant changes, open an issue first to discuss the approach before writing code.

## Git basics for new contributors

New to git? This is the minimum you need to work with this project confidently. Five points plus a note on what's mechanics vs convention.

1. Branches are full parallel copies. A branch is a complete working version of the project, forked from main at a point in time — not just a list of changes. You can build, test, and run the code on any branch.
2. Commits live only on the branch you made them on. A commit is a snapshot saved to your current branch. Commits on a feature branch do not affect main.
3. The workflow has four deliberate steps:
   - commit — save changes to your branch, locally
   - push — upload your branch to GitHub (still only the branch, not main)
   - open a pull request — propose merging your branch into main
   - merge the PR — the only step that actually updates main
4. main stays untouched until a PR is merged. You can have many commits, pushes, and PRs in flight — none of it touches main until someone clicks merge.
5. Everyone pulls main; nobody works directly on it. main is the shared stable state — the canonical version everyone builds from. To start new work, pull the latest main to your local machine and branch off it. To pick up other people's merged changes later, pull main again. pull is the mechanical opposite of push (download from the remote instead of upload), but everyone pulls regardless of whether they're developing — it's just how you stay in sync with the remote. Only developers push, and they push to feature branches, never directly to main.

Note on mechanics vs convention. Points 1–4 describe how git actually works. Point 5 and the "never push to main" rule are conventions — team discipline, not git mechanics. Git itself will happily let you commit to main; the discipline is what keeps main stable. Projects often enforce the discipline mechanically via GitHub branch protection rules, which reject direct pushes to main — but that's a GitHub feature layered on top, not git itself.

Why branch locally? Technically, a local commit on main is harmless until you push — git doesn't care. But the moment you want to push, pull, switch contexts, or throw away an experiment, a feature branch makes life dramatically easier. Branching is a two-second habit (git switch -c feature/my-thing) that prevents a lot of future pain.

Session-start helper. This repo ships with a Claude Code session-start hook (.claude/hooks/session-start.sh) that detects when a session has started on main and prompts you to branch off before you make any edits. If you're using Claude Code, you rarely need to remember this discipline — the hook surfaces it for you. (If you're working without Claude Code, you'll still need to remember it yourself.)

Everything else (pull, staging, merge conflicts, remotes, .gitignore, rebase, stash, ...) is vocabulary you'll pick up naturally when a real task demands it.

## Workflow

1. Fork the repository (external contributors) or create a branch (collaborators).
2. Follow the branch naming conventions in [CLAUDE.md — Git Workflow](CLAUDE.md#git-workflow).
3. Make your changes following the code and documentation standards in [CLAUDE.md](CLAUDE.md).
4. Run the full test suite before committing (see [SETUP.md — Build, Test & Lint](SETUP.md#build-test--lint)).
5. Commit with a clear, imperative subject line (50 characters or fewer, no trailing period).
6. Open a pull request using the provided template and link any related issues.

## Code standards

- Follow [`.claude/rules/code-style.md`](.claude/rules/code-style.md).
- Keep PRs focused — one concern per pull request.
- Do not add features, refactoring, or cleanup beyond what was requested.

## Documentation standards

- Follow [`.claude/rules/documentation.md`](.claude/rules/documentation.md).
- Store ADRs in `docs/adr/`, runbooks in `docs/runbooks/`, API docs in `docs/api/`.

## Reporting security issues

See [SECURITY.md](SECURITY.md). Do not open public issues for vulnerabilities.
