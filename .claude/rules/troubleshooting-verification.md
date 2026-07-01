# Troubleshooting Verification

Always-on discipline for investigation work. The `/troubleshooting` skill holds the full method; this rule is the part that applies to every session, whether or not the skill is invoked.

## The rule

Verify the identity of every entity before you build analysis on it. A wrong assumption made early — a misidentified process, driver, vendor, or version — silently corrupts every conclusion that follows.

- **Identify before you use.** Name the processes, drivers, services, files, and versions in play. Nothing enters the reasoning unlisted.
- **Verify against an authoritative source.** Confirm attribution from a strong identifier (Authenticode signer, service/instance name, vendor documentation, direct tool output) — never from a filename prefix, folder location, or proximity.
- **State what you cannot verify.** If you don't know where to confirm something, or it is behind a paywall/login, say so plainly and name what would confirm it. Do not fill the gap with a plausible guess stated as fact.
- **Re-verify on every new finding.** Each newly surfaced entity is identified and verified before it feeds the next step — not after the conclusion is written.
- **Cross-check the workspace first.** Before asserting a claim the existing files could answer or contradict, search them.
- **Verifying is necessary but not sufficient.** Getting an identification right once does not make it stick. A correct call that lives only in the conversation still fails if the artifacts keep asserting the wrong one — the fix has to land in every file (see next bullet).
- **When correcting, fix the artifacts — not just the chat.** Drop to Unknown, name the check that settles it, then sweep every file (`grep` the workspace) and correct each instance; purge the wrong label so it cannot coexist with the right one. A correction that lives only in the conversation is lost — the stale files become the source of truth for the next session and re-seed the error. Never replace one unverified explanation with another.

No margin for error in troubleshooting: an unverified attribution never becomes a stated fact, and a correction is not done until every artifact reflects it.

## Related

- `.claude/skills/troubleshooting/SKILL.md` — the full step-by-step method and attribution ladder.
- `.claude/rules/mental-models.md` — keeps the Domain and Context models calibrated.
- Deliverable hygiene: delivered docs state current confirmed truth plus live caveats; correction history goes in the changelog, not the document.
