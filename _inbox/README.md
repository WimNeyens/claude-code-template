# _inbox

Drop zone for unfiled material: pasted notes, exported data, screenshots, meeting transcripts, PDFs, and anything the user wants Claude to read but hasn't yet placed in its permanent home.

## Conventions

- **Raw, not curated.** Don't tidy files here — process them into `docs/`, `data/`, or `references/` and delete the original.
- **Entire folder is gitignored.** Only `README.md` and the empty subfolder scaffolding (`.gitkeep` files) are tracked. Anything you drop in stays local.
- **Default subfolders:** `private/` (sensitive material), `images/` (screenshots, diagrams), `files/` (PDFs, exports, misc). Use them or drop directly into `_inbox/` — both work.
- **Date-prefix filenames** when the source time matters: `2026-04-06-stakeholder-notes.md`.

## For AI assistants

- Check this folder **and all its subfolders** (`private/`, `images/`, `files/`, plus any others) when the user references material you can't otherwise locate ("the notes I pasted", "the spec I dropped in", "the screenshot").
- Do not auto-read everything here every session — only when relevant to the current task.
- When you process an inbox item into its permanent home, suggest deleting the original to keep the inbox empty.
