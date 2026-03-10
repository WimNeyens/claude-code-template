# Contributing

Thank you for your interest in contributing.

## Before you start

- Read [README.md](README.md) to understand what this project does.
- Check existing [issues](../../issues) and [pull requests](../../pulls) to avoid duplicating work.
- For significant changes, open an issue first to discuss the approach before writing code.

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
