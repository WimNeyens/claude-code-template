# _outbox

Outbound drop zone for **reusable building blocks** discovered or produced during work on this project: code snippets, functions, helper scripts, regexes, config fragments, and prose notes about any of the above.

This is the outbound twin of `_inbox/`. Where `_inbox/` is a staging area for raw material coming *into* the project, `_outbox/` is a staging area for generic material going *out* — eventually harvested into a global, cross-project library.

## Conventions

- **Kept, not consumed.** Unlike `_inbox/`, items here are not deleted after processing. A future harvester script will sweep every project's `_outbox/` and build the global library.
- **Only mature material.** Nothing broken or speculative lives here. If a captured snippet is later found to be wrong and is reworked, the copy here is updated in the same pass.
- **Language-agnostic.** Subfolders (`powershell/`, `bash/`, `python/`, `sql/`, `config/`, `notes/`, ...) are created lazily — only when the first snippet of that kind is captured. The template ships empty.
- **No secrets, no project-specific identifiers.** Snippets must be generalizable. For machine-only material, use `_outbox/private/` (gitignored).

## Filename convention

`<category>_<descriptive-name>.<ext>`

- **Category first** so a-z sorting groups related snippets: `ad`, `http`, `fs`, `git`, `json`, `csv`, `net`, `crypto`, `process`, ...
- **Descriptive name** uses the target language's native idiom (e.g. PowerShell `Verb-Noun`).
- **Correct extension is mandatory** so VS Code highlights syntax on open.
- **No dates in filenames** — they break a-z grouping. Dates live in the in-file header.
- **No maturity tags** (`.draft`, `.tested`). The archive is mature by construction.
- **Collisions**: add a short qualifier, not a version number (`ad_Get-User.ps1` → `ad_Get-User-Azure.ps1`).

## Header block

Every captured file starts with a short header, adapted to the language's comment syntax:

```
Source project: <repo name>
Captured: YYYY-MM-DD
Purpose: <one line>
Reusable because: <why this is library-worthy>
Dependencies: <modules/tools needed, or "none">
```

## For AI assistants

See `.claude/rules/outbox-capture.md` for when to capture, when to skip, and how to keep the archive mature.
