# Outbox Capture

`_outbox/` is the outbound twin of `_inbox/`: a per-project staging area where reusable building blocks are saved during normal work, for a future global library harvester to sweep. This rule tells Claude *when* to capture, *when not to*, and *how*.

## When to capture

Offer to save a snippet to `_outbox/` when it meets at least one of:

- Non-trivial logic the user would plausibly want again in another project (auth flow, directory query, retry-with-backoff, parser, data transform, ...).
- Solves a problem that took real effort to figure out — research, trial and error, or wrapping a quirky API or undocumented behavior.
- The user explicitly signals interest: "that's nice", "save that", "I'll want this again", "good one".

## When NOT to capture

- Trivial one-liners and boilerplate that any capable assistant can reproduce on demand.
- Throwaway glue code tightly coupled to this project's files, paths, or data shapes.
- Anything containing secrets, credentials, tokens, internal hostnames, customer names, or other identifiers that cannot be generalized.
- Code you are not confident works. The outbox only holds mature material (see below).

Lean conservative early. The user will calibrate you by accepting or rejecting captures.

## How to capture

1. Write the file to `_outbox/<language-or-tool>/` — create the subfolder if it does not yet exist. The template ships empty on purpose; subfolders appear lazily.
2. Filename: `<category>_<descriptive-name>.<ext>`. Category first (lowercase, short topic tag like `ad`, `http`, `fs`, `git`, `json`). Use the target language's native naming idiom for the descriptive part. Use the correct extension so VS Code applies syntax highlighting. No dates, no maturity tags.
3. Start the file with a short header block, adapted to the language's comment syntax:
   ```
   Source project: <repo name>
   Captured: YYYY-MM-DD
   Purpose: <one line>
   Reusable because: <why this is library-worthy>
   Dependencies: <modules/tools needed, or "none">
   ```
4. Mention the capture briefly in chat: "Saved to `_outbox/<path>` — looks reusable." This gives the user a chance to veto.
5. For multi-file snippets, group them under a single folder named with the same `<category>_<name>` pattern.

## Keep the archive mature

The outbox never holds known-broken code. If a previously captured snippet turns out to be wrong and you rework it during later work, **update the `_outbox/` copy in the same pass**. This property is what replaces explicit maturity tags (`.draft`, `.tested`, etc.) — if it is in the outbox, it is considered working as of the last time it was touched.

If you discover a snippet is broken and cannot fix it in the current session, remove it from the outbox rather than leaving it there with a warning.

## Stay language-agnostic

This is a generic template. Do not pre-create language-specific subfolders, do not favor one language in examples, and do not bake any language's assumptions into the capture workflow. `powershell/`, `bash/`, `python/`, `sql/`, `config/`, `notes/` and any others are all created on first use.

## Out of scope

Harvesting, indexing, categorizing, and cross-project lookup of captured material is a separate future effort. This rule is only about the capture step.
