Run a security audit of this project. Investigate systematically — do not guess.

## Steps

1. **Check Claude Code configuration**
   - Read `.claude/settings.json` — verify deny rules cover: force-push, hard-reset, rm -rf, curl/wget, reading .env/.ssh/.pem/.key files
   - Verify `PreToolUse` hook exists and blocks sensitive file reads and external fetches
   - Verify `ConfigChange` hook blocks settings modifications during sessions
   - Check `.claude/settings.local.json.example` contains no real tokens
   - Check `.mcp.json` contains no secrets
   - Confirm `.gitignore` excludes `settings.local.json`, `CLAUDE.local.md`, `.env`, `.env.*`, `*.key`, `*.pem`

2. **Check git hooks**
   - Read `.githooks/pre-commit` — verify secret pattern list covers AWS keys, GitHub PATs, Slack tokens, Google API keys, JWTs, PEM keys, connection strings, generic password/secret/api-key assignments
   - Read `.githooks/commit-msg` — verify format enforcement is active
   - Run `git config core.hooksPath` to confirm hooks are activated on this machine

3. **Scan for hardcoded secrets**
   - Search the entire repo for patterns: API keys, tokens, passwords, connection strings, private keys
   - Use the same patterns from `.githooks/pre-commit` plus any additional ones
   - Check all file types, not just code — YAML, JSON, Markdown, shell scripts
   - Report any findings with file path and line number

4. **Check dependencies** (if applicable)
   - If `package.json` exists: run `npm audit` and report vulnerabilities
   - If `requirements.txt` or `pyproject.toml` exists: run `pip audit` (if installed) or flag that it should be
   - If `go.mod` exists: run `govulncheck` (if installed) or flag it
   - Check that `.github/dependabot.yml` is configured for the project's package ecosystem

5. **Check GitHub Actions security**
   - Read all files in `.github/workflows/`
   - Verify actions are pinned to specific versions (not `@main` or `@latest`)
   - Check for dangerous patterns: `pull_request_target` with checkout of PR head, `${{ github.event.issue.body }}` in run steps (injection risk)
   - Verify permissions are scoped narrowly (not `permissions: write-all`)

6. **Check for OWASP Top 10 patterns** (if source code exists)
   - Search for SQL string concatenation / template literals in queries
   - Search for `innerHTML`, `dangerouslySetInnerHTML`, `eval()`, `exec()`, unsanitised user input in templates
   - Search for hardcoded CORS `*` origins
   - Search for disabled CSRF protection
   - Report findings with file, line, and severity

7. **Trail of Bits skills** (if installed)
   If the Trail of Bits skills plugin is available (`trailofbits/skills`), suggest running these for deeper analysis:
   - `audit-context-building` — build security context
   - `insecure-defaults` — find insecure configurations
   - `supply-chain-risk-auditor` — audit dependency risks
   - `differential-review` — security-focused code review

   If not installed, note that it is available at https://github.com/trailofbits/skills

8. **Present a report**

   Format the report as:

   ```
   ## Security Audit Report — [date]

   ### Configuration
   - [PASS/FAIL] Deny rules: ...
   - [PASS/FAIL] PreToolUse hook: ...
   - [PASS/FAIL] Git hooks active: ...
   - [PASS/FAIL] No secrets in committed files: ...

   ### Secrets Scan
   - [PASS/FAIL] No hardcoded secrets found
   - (list any findings)

   ### Dependencies
   - [PASS/FAIL] No known vulnerabilities / [N vulnerabilities found]

   ### CI/CD
   - [PASS/FAIL] Actions pinned to versions: ...
   - [PASS/FAIL] No injection patterns: ...

   ### Code (OWASP)
   - [PASS/FAIL] No SQL injection patterns: ...
   - [PASS/FAIL] No XSS patterns: ...
   - (list any findings)

   ### Recommendations
   1. ...
   2. ...
   ```

## Rules

- Do not modify any files — this command is read-only.
- Report what you find honestly, including things that are already good.
- If no source code exists yet (template-only repo), skip steps 4 and 6 and note that they will apply once code is added.
- Do not run external tools that are not already installed — flag them as recommendations instead.
