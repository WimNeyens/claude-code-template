---
description: Evidence-based troubleshooting method. Verify the identity of every entity (process, driver, service, file, version) against an authoritative source before building analysis on it, and re-verify each new finding. Use when investigating system, endpoint, log, performance, or configuration issues.
---

# Troubleshooting

A disciplined method for investigation where a wrong assumption early poisons everything downstream. Core principle: **identify and verify before you build on it** — then repeat for every new finding.

## When to use

- Any system, endpoint, log, performance, or configuration investigation.
- The moment you name a process, driver, service, file, vendor, or version and intend to reason from it.

## When NOT to use

- A one-step, self-evident fix. Don't ceremonialise trivial work.

## The core loop: Identify → Verify → Use

Run this at the **start**, and again on **every new finding** before it feeds the next step.

**0. Prerequisites first.** Before proposing the next step, state what must be true or in place for it to be valid. First things first — don't skip a dependency.

**1. Identify — inventory what you detected.** List every entity in play: processes, drivers, services, files, registry keys, versions, log sources. Name them explicitly. Nothing enters the analysis unlisted.

**2. Verify — check each against an authoritative source.** For every item, confirm its identity/attribution, then tag it:
- **Verified** — confirmed by an authoritative identifier (see ladder below). State the source.
- **Unverified** — assumed but not yet confirmed. Not usable as a fact.
- **Unverifiable** — you cannot confirm it (don't know where to look, or it is paywalled/behind login). **Say so explicitly**, and name what would confirm it.

**3. Gate — do not build on Unverified or Unverifiable items.** If analysis needs one, flag it as a dependency and resolve it first, or carry it as an explicit assumption clearly labelled as such. No margin for error: an unverified attribution never becomes a stated fact.

**4. Iterate.** Each new finding re-enters step 1. Newly surfaced entities get identified and verified *before* they are used — not after the conclusion is written.

## Attribution ladder (strongest evidence first)

Attribute identity/ownership only from the top rungs. Never assert from the bottom.

| Rung | Example (Windows) | Use as |
|---|---|---|
| Authoritative identifier | Authenticode signer; service/driver instance name; `fltmc` altitude; vendor doc | Fact — cite it |
| Direct tool output | `Get-AuthenticodeSignature`, `sc.exe qc`, `fltmc instances`, event-log payload | Fact — cite it |
| Log-text / behavioural inference | "logged in the vendor's folder", correlated timing | Inference — label it |
| Filename / prefix / proximity | "starts with `tedr…`", "near a Tanium process" | Guess — **never assert** |

## Cross-check the workspace before asserting

Before stating a claim the existing files could already answer or contradict, search them. A one-minute `grep` of the repo, script comments, and prior notes catches contradictions before they ship.

## When you find an error

- Drop to **Unknown** and name the check that settles it. Do not swap one unverified explanation for another — replacing a wrong mechanism with a new plausible one repeats the same failure.
- **Propagate the fix to the artifacts, not just the chat.** Sweep every file (`grep` the workspace) and correct each instance. A correction stated only in conversation is *not done*: the stale files become the source of truth for the next session and re-seed the error.
- **Purge the wrong label.** Never let the corrected and uncorrected versions coexist in the artifacts.

## Worked example — verifying is necessary but not sufficient

A real case, all within one day-one session:

1. `tedrdrv` appeared in a FilterManager log and was labelled **"Tanium EDR"** within minutes — a guess from the `tedr` prefix, stated as fact. A stacked-driver I/O-storm narrative was built on it. (`cyvrfsfd`→Cortex was guessed by the same method and happened to be right, which masked the miss.)
2. **Later the same day, the correct identity was found and stated plainly:** `fltmc instances` showed instance name **TrapsEdr** (Palo Alto Traps → Cortex XDR), present on a machine with Tanium uninstalled; the real Tanium driver is **TaniumRecorderDrv**. The verification was done, and correct.
3. **It still failed** — because the correction stayed in the conversation. The scripts and documents were never swept, so they kept asserting "Tanium".
4. **Later sessions inherited the stale artifacts** as source of truth and re-seeded the error. It took days and a fresh re-verification to catch what was already known on day one.

Lesson: step 2 alone would not have saved it — the fix has to land in every artifact, or it evaporates.

## Output discipline

- Every substantive claim is Observed (cite source), Inferred (labelled), or Unknown. See `.claude/rules/troubleshooting-verification.md` and the facts-vs-inference discipline.
- In **delivered** documents, state the current confirmed truth plus live operational caveats (what remains unverified/unmeasured). Keep correction history in the changelog/commit, not the document.

## Related

`/debug` for the broader gather-hypothesise-fix flow; `.claude/rules/mental-models.md` for keeping Domain/Intent calibrated.
