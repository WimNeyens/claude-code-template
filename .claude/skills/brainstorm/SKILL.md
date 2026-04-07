---
description: Structured pre-planning conversation. Ask clarifying questions before proposing an approach. Use when the user says "brainstorm", "let's think through X", "help me figure out", or asks for a plan on a vague or ambiguous task.
---

# Brainstorm

A structured back-and-forth that surfaces unknowns *before* you propose a plan or write code. The goal is to make the Intent and Domain mental models explicit (see `.claude/rules/mental-models.md`) so the eventual plan is grounded.

## When to use

- The user's request is ambiguous, broad, or could be solved several different ways.
- You catch yourself about to guess at requirements, scope, or constraints.
- The user explicitly says "brainstorm" or "let's think this through."
- A task touches code or systems you haven't read yet.

## When NOT to use

- The task is small, concrete, and reversible. Just do it.
- The user has already given a clear spec. Don't manufacture ambiguity.
- The user is in a hurry and wants an answer, not a conversation.

## Process

1. **Restate the goal in one sentence.** Your understanding of what the user actually wants — not the literal request. If you're wrong, they'll correct you immediately and you've saved a wasted plan.

2. **Ask 3–6 clarifying questions, in one batch.** Not a Socratic drip. Group them by theme. Cover at least:
   - **Scope:** what's in, what's out, what's a non-goal
   - **Constraints:** deadlines, dependencies, tech stack limits, things you must not touch
   - **Success criteria:** how will the user know it's done and right
   - **Audience or consumer:** who uses the result
   - **Trade-offs:** if there's a known tension (speed vs. correctness, simple vs. flexible), name it and ask which side to favor

   Use the `AskUserQuestion` tool if available — it lets the user pick from options instead of typing free-form answers.

3. **Wait for answers.** Do not propose a plan in the same turn as the questions. Brainstorm is two-way.

4. **Reflect back what you heard.** One short paragraph summarizing the goal, scope, and key constraints. Give the user one more chance to correct you.

5. **Propose 1–3 approaches.** Not one. Give the user real choices with honest trade-offs:
   - **Option A** — what it is, what it costs, what it gives up
   - **Option B** — same
   - (Option C if there's a genuinely different third path)

   State your recommendation and *why*, but don't bury the alternatives.

6. **Hand off to planning.** Once the user picks a direction, exit brainstorm and either start working or invoke a `/plan` flow if the task is large enough to need step-by-step decomposition.

## Notes

- Brainstorm is not a status report. Don't list everything you know about the codebase. Ask what you don't know.
- One round of questions, not five. If you need a second round, the first round was too narrow — rethink before re-asking.
- If the user gives a one-word answer to a question, that's a signal: they want you to decide. Stop asking and propose.
- Never use brainstorm to stall. If the task is clear, skip straight to the work.
