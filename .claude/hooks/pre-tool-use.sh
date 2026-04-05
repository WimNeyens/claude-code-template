#!/usr/bin/env bash
# PreToolUse hook — defense-in-depth guardrail.
# Blocks dangerous operations even if deny rules are bypassed.
# Fires before every tool call, including in --dangerously-skip-permissions mode.
set -euo pipefail

# The hook receives tool name and input as JSON on stdin.
INPUT=$(cat)
TOOL_NAME=$(echo "$INPUT" | jq -r '.tool_name // empty' 2>/dev/null || true)
TOOL_INPUT=$(echo "$INPUT" | jq -r '.tool_input // empty' 2>/dev/null || true)

# --- Block reading secrets and credentials ---
if [ "$TOOL_NAME" = "Read" ] || [ "$TOOL_NAME" = "read" ]; then
  FILE_PATH=$(echo "$TOOL_INPUT" | jq -r '.file_path // empty' 2>/dev/null || true)
  if echo "$FILE_PATH" | grep -qiE '(\.env($|\.)|\.ssh/|\.pem$|\.key$|\.pfx$|\.p12$|credentials|secrets)'; then
    echo "BLOCKED: Reading sensitive file: $FILE_PATH" >&2
    exit 2
  fi
fi

# --- Block fetching external content (prompt injection vector) ---
if [ "$TOOL_NAME" = "Bash" ] || [ "$TOOL_NAME" = "bash" ]; then
  COMMAND=$(echo "$TOOL_INPUT" | jq -r '.command // empty' 2>/dev/null || true)
  if echo "$COMMAND" | grep -qiE '^\s*(curl|wget|fetch)\s'; then
    echo "BLOCKED: External fetch command: $COMMAND" >&2
    echo "Use WebFetch or ask the user to run this command manually." >&2
    exit 2
  fi
fi
