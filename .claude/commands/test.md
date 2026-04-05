Write tests for new or changed code on the current branch.

## Steps

1. **Identify what changed** — run `git diff main...HEAD --name-only` to list changed files. If no branch diff exists (e.g., working on main), use `git diff --name-only` and `git diff --cached --name-only` for unstaged/staged changes.

2. **Detect the test framework** — look for existing test files, test directories, and config files (e.g., `jest.config.*`, `pytest.ini`, `pyproject.toml [tool.pytest]`, `*.test.*`, `*_test.*`, `tests/`, `__tests__/`). Match whatever the project already uses.

3. **Read the changed code** — read every changed file to understand what needs testing.

4. **Read existing tests** — find and read tests for the same module or nearby code. Match the project's patterns: file naming, assertion style, setup/teardown, mocking approach.

5. **Write the tests** — for each changed file that has testable logic:
   - Test the happy path (expected inputs produce expected outputs)
   - Test edge cases (empty inputs, nulls, boundary values)
   - Test error cases (invalid inputs, expected failures)
   - Do not test trivial getters/setters, framework internals, or implementation details

6. **Place tests correctly** — follow the project's convention for test file location. If no convention exists, place tests next to the source file as `<filename>.test.<ext>` or in a `tests/` directory mirroring the source structure.

7. **Run the tests** — execute the test suite to confirm the new tests pass. If any fail, fix them.

8. **Show a summary** — list which files were tested, how many tests were added, and any files that were skipped (with a reason).

## Rules

- Never invent a test framework — use what the project already has. If none exists, ask the user which to set up.
- Match the style of existing tests exactly (naming, imports, structure).
- Do not mock what you can call directly. Only mock external services and I/O.
- Each test should test one behaviour. Name it clearly: `test_rejects_empty_input`, not `test1`.
- Do not add test dependencies without asking the user first.
