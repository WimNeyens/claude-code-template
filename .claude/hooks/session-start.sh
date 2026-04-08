#!/bin/bash
# SessionStart hook — runs at the start of every Claude Code session.
#
# PURPOSE:
#   1. Surface git state (branch, status) so Claude can confirm the workspace.
#   2. Warn when the session starts on main so Claude asks before editing.
#   3. In remote (web) sessions only, install project dependencies.
#
# HOW TO EXTEND:
#   Uncomment the relevant dep-install block in the REMOTE-ONLY section below.

set -euo pipefail

# -------------------------------------------------------
# Always-run: git state and branch-choice prompt
# -------------------------------------------------------
echo "=== Session Start ==="
echo "Project dir : ${CLAUDE_PROJECT_DIR:-$(pwd)}"
echo "Date/time   : $(date -u '+%Y-%m-%d %H:%M:%S UTC')"
echo ""

echo "--- Git status ---"
git status --short --branch 2>/dev/null || { echo "(not a git repo — skipping)"; exit 0; }
echo ""

CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD 2>/dev/null || echo "")

if [ -f "TASKS.md" ]; then
  OPEN_TASKS=$(grep -E '^\s*-\s*\[ \]' TASKS.md || true)
  if [ -n "$OPEN_TASKS" ]; then
    # The "Open tasks" heading below is the source of truth — .claude/rules/session-start.md
    # tells Claude to look for this section. Do not rename without updating the rule.
    echo "--- Open tasks (TASKS.md) ---"
    echo "$OPEN_TASKS"
    echo ""
    echo "Claude: surface these to the user before the branching prompt."
    echo "If the user picks one, suggest a feature branch name derived from it."
    echo ""
  fi
fi

if [ "$CURRENT_BRANCH" = "main" ] || [ "$CURRENT_BRANCH" = "master" ]; then
  echo "--- ACTION REQUIRED: session started on $CURRENT_BRANCH ---"
  echo "Per CLAUDE.md, changes must not be committed directly to $CURRENT_BRANCH."
  echo "Before the first edit of this session, Claude MUST ask the user:"
  echo "  1. Continue work on an existing branch? (list below)"
  echo "  2. Create a new feature branch? (suggest a name based on the task)"
  echo "  3. Proceed on $CURRENT_BRANCH anyway? (explicit override — rare)"
  echo ""
  echo "Existing local branches (other than $CURRENT_BRANCH):"
  git for-each-ref --sort=-committerdate --format='  %(refname:short)  (last commit: %(committerdate:relative))' refs/heads/ \
    | grep -v "  $CURRENT_BRANCH  " | head -10 || echo "  (none)"
  echo ""
fi

# -------------------------------------------------------
# Remote-only: project dependency installation
# -------------------------------------------------------
if [ "${CLAUDE_CODE_REMOTE:-}" != "true" ]; then
  echo "=== Session ready (local) ==="
  exit 0
fi

git fetch --quiet origin 2>/dev/null || echo "(fetch skipped — no network or credentials)"

# -------------------------------------------------------
# ADD PROJECT-SPECIFIC SETUP BELOW
# -------------------------------------------------------
# Uncomment the block that matches your project's stack.
# You can have multiple blocks if the project uses several ecosystems.

# --- Node.js / npm ---
# if [ -f "package.json" ]; then
#   echo "--- Installing npm dependencies ---"
#   npm install
#   echo "npm install complete"
# fi

# --- Node.js / pnpm ---
# if [ -f "pnpm-lock.yaml" ]; then
#   echo "--- Installing pnpm dependencies ---"
#   corepack enable pnpm
#   pnpm install
#   echo "pnpm install complete"
# fi

# --- Python / pip ---
# if [ -f "requirements.txt" ]; then
#   echo "--- Installing Python dependencies ---"
#   pip install -r requirements.txt --quiet
#   echo "pip install complete"
# fi

# --- Python / Poetry ---
# if [ -f "pyproject.toml" ]; then
#   echo "--- Installing Poetry dependencies ---"
#   pip install poetry --quiet
#   poetry install --no-interaction
#   echo "poetry install complete"
# fi

# --- Environment variables ---
# Persist any required env vars for the session using $CLAUDE_ENV_FILE:
# echo 'export MY_VAR="value"' >> "$CLAUDE_ENV_FILE"

echo "=== Session ready ==="
