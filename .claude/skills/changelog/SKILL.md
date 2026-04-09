---
description: Generate or update CHANGELOG.md from git history between two refs. Use when the user says "update changelog", "changelog since v1.2", "what changed", or is preparing a release.
---

# Changelog

Produce a Keep a Changelog-formatted entry from `git log` output between two refs (or since the last tag), and append it to `CHANGELOG.md` at the repo root.

## Steps

1. **Determine the range.**
   - If the user gave two refs (`v1.2.0..HEAD`), use them.
   - Otherwise, use `git describe --tags --abbrev=0` to find the last tag and range from there to `HEAD`.
   - If there are no tags, range from the first commit to `HEAD` and note it as the initial entry.

2. **Collect commits** with `git log --pretty=format:"%h %s" <range>`. Read the output — do not invent entries.

3. **Group commits** into Keep a Changelog categories based on commit subjects and bodies: **Added**, **Changed**, **Deprecated**, **Removed**, **Fixed**, **Security**. Skip categories with no entries. Merge commits and trivial chores (typo fixes, lint) can be omitted.

4. **Draft the entry** in this shape:

   ```markdown
   ## [<version>] - <YYYY-MM-DD>

   ### Added
   - <short, user-facing description> (<short-sha>)

   ### Fixed
   - ...
   ```

   Ask the user for `<version>` if not given. Use today's date.

5. **Update `CHANGELOG.md`.**
   - If the file does not exist, create it with the Keep a Changelog header (`# Changelog` + link to https://keepachangelog.com/en/1.1.0/) and the new entry under it.
   - If it exists, insert the new entry below the header and above the previous most-recent entry.

6. **Show the diff** and confirm with the user before committing. Do not commit on their behalf unless asked.

## Notes

- User-facing language only — translate "refactor internal helper" into something a reader of the changelog cares about, or drop it.
- Do not include commit author names or internal ticket IDs unless the project already does.
- One entry per release. If the user asks for notes across multiple releases, run the skill once per range.
