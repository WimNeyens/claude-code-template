# _inbox

Drop zone for unfiled material: pasted notes, exported data, screenshots, meeting transcripts, PDFs, and anything the user wants Claude to read but hasn't yet placed in its permanent home.

## Conventions

- **Raw, not curated.** Don't tidy files here — process them into `docs/`, `data/`, or `references/` and delete the original.
- **No secrets.** Credentials, tokens, and PII do not belong here (or anywhere in the repo). For sensitive drops, create `_inbox/private/` which is gitignored.
- **Date-prefix filenames** when the source time matters: `2026-04-06-stakeholder-notes.md`.

## For AI assistants

- Check this folder when the user references material you can't otherwise locate ("the notes I pasted", "the spec I dropped in").
- Do not auto-read everything here every session — only when relevant to the current task.
- When you process an inbox item into its permanent home, suggest deleting the original to keep the inbox empty.
