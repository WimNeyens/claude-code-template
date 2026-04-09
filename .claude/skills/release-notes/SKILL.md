---
description: Draft human-facing release notes from git history, grouped by theme. Use when the user says "release notes", "what's new", "draft the release", or is publishing a GitHub Release.
---

# Release Notes

Draft prose release notes suitable for a GitHub Release description. Unlike `/changelog` (which produces Keep a Changelog entries), this skill is human-facing — grouped by theme and written for readers who do not read commit logs.

## Steps

1. **Determine the range.** Same as `/changelog`: two refs if given, else last tag to `HEAD`.

2. **Collect commits** with `git log --pretty=format:"%h %s%n%b" <range>`. Read bodies too — the "why" often lives there.

3. **Group by theme, not by commit type.** Example themes: "Performance", "Security", "Developer experience", "New integrations", "Bug fixes". Drop themes with nothing worth saying.

4. **Draft each section as prose**, two to four sentences per item. Lead with the user benefit, not the implementation. Link to PRs or issues when they add context (`owner/repo#123`).

5. **Add a "Highlights" lead-in** at the top — one paragraph naming the two or three things a reader should care about most. Skip if the release is a pure bug-fix release.

6. **Show the draft** and ask the user to approve or edit before publishing. Do not call `gh release create` without explicit confirmation.

## Notes

- Tone: confident and plain. No marketing fluff, no emojis unless the project already uses them.
- Credit external contributors by GitHub handle when the commit is not from a maintainer.
- Breaking changes get their own section at the top — never buried.
- If the user wants both a CHANGELOG entry and release notes, run `/changelog` first, then this skill; the release notes can reference the changelog.
