#!/usr/bin/env bash
# PreToolUse hook — defense-in-depth guardrail.
# Fires before every tool call, including in --dangerously-skip-permissions mode.
#
# DEFENSE-IN-DEPTH CONTRACT:
#   The blocks below mirror the deny rules in .claude/settings.json. The deny list
#   uses prefix-glob matching and misses edge cases (rm -rfv, &&-chained commands,
#   quoted variants); this hook catches those with regex. If you change one layer,
#   change the other. See .claude/README.md for the full rationale.
set -euo pipefail

# --- jq dependency check ---
# This hook parses tool input as JSON. Without jq, every guardrail below would
# silently fail-open. We exit 0 (don't block) but warn loudly so the user notices.
if ! command -v jq >/dev/null 2>&1; then
  echo "WARNING: pre-tool-use hook degraded — 'jq' is not installed." >&2
  echo "         Secret-read and external-fetch guardrails are NOT active." >&2
  echo "         Install jq (see SETUP.md) to restore protection." >&2
  exit 0
fi

# The hook receives tool name and input as JSON on stdin.
INPUT=$(cat)
TOOL_NAME=$(echo "$INPUT" | jq -r '.tool_name // empty')
TOOL_INPUT=$(echo "$INPUT" | jq -r '.tool_input // empty')

# --- Block reading secrets and credentials ---
# Mirrors Read(**/.env), Read(**/.ssh/*), Read(**/*.pem), Read(**/*.key) in settings.json.
if [ "$TOOL_NAME" = "Read" ] || [ "$TOOL_NAME" = "read" ]; then
  FILE_PATH=$(echo "$TOOL_INPUT" | jq -r '.file_path // empty')
  if echo "$FILE_PATH" | grep -qiE '(\.env($|\.)|\.ssh/|\.pem$|\.key$|\.pfx$|\.p12$|credentials|secrets)'; then
    echo "BLOCKED: Reading sensitive file: $FILE_PATH" >&2
    exit 2
  fi
fi

# --- Bash command checks ---
if [ "$TOOL_NAME" = "Bash" ] || [ "$TOOL_NAME" = "bash" ]; then
  COMMAND=$(echo "$TOOL_INPUT" | jq -r '.command // empty')

  # Block external fetches (prompt-injection vector).
  # Mirrors Bash(curl *) and Bash(wget *) in settings.json. Catches mid-pipeline
  # uses (e.g. `something | curl ...`) that the prefix glob misses.
  if echo "$COMMAND" | grep -qiE '(^|[ ;&|`(])(curl|wget|fetch)( |$)'; then
    echo "BLOCKED: External fetch command: $COMMAND" >&2
    echo "Use WebFetch or ask the user to run this command manually." >&2
    exit 2
  fi

  # Block recursive rm — catches rm -rf, rm -fr, rm -rfv, rm -Rf, rm --recursive.
  # Mirrors Bash(rm -rf *) in settings.json. The deny rule only catches the literal
  # `rm -rf ` prefix; this regex catches every short-flag combination and the long
  # form. If you legitimately need to recursively delete, do it from a terminal,
  # not from Claude.
  if echo "$COMMAND" | grep -qE '(^|[ ;&|`(])rm[ ]+(-[a-zA-Z]*[rRfF]|--recursive|--force)'; then
    echo "BLOCKED: Recursive rm command: $COMMAND" >&2
    echo "Recursive deletes must be run by the user manually." >&2
    exit 2
  fi
fi
