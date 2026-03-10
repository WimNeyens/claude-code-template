#!/bin/bash
# SessionStart hook — runs at the start of every Claude Code Web session.
# Only executes in remote (web) environments; exits silently for local CLI/VSCode.
#
# PURPOSE:
#   Prepare the environment so Claude can run project tools immediately.
#   Add project-specific dependency installation below as the project grows.
#
# HOW TO EXTEND:
#   Uncomment and adapt the relevant section for your project's tech stack.

set -euo pipefail

# Only run in Claude Code Web (remote) sessions
if [ "${CLAUDE_CODE_REMOTE:-}" != "true" ]; then
  exit 0
fi

echo "=== Session Start Hook ==="
echo "Project dir : ${CLAUDE_PROJECT_DIR:-$(pwd)}"
echo "Date/time   : $(date -u '+%Y-%m-%d %H:%M:%S UTC')"
echo ""

# -------------------------------------------------------
# Git — confirm repo state
# -------------------------------------------------------
echo "--- Git status ---"
git fetch --quiet origin 2>/dev/null || echo "(fetch skipped — no network or credentials)"
git status --short --branch
echo ""

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
