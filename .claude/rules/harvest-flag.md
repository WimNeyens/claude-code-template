# Harvest Flag

Watch for conversational signals that the user wants to bookmark something for transfer back to the template.

## Trigger phrases

When the user says any of the following (or close variations) in reference to a specific concept, rule, skill, or piece of content:

- "save this for the template"
- "keep this for the template"
- "this should go back to the template"
- "the template needs this"
- "transfer this to the template"
- "harvest this"

## What to do

1. Identify what the user is referring to (the current file, a concept just discussed, a rule just created, etc.)
2. Append a line to `.claude/harvest-queue.md`:
   `- [ ] <short description of what to transfer> — flagged <today's date> — source: <file path or conversation context>`
3. If the file does not exist, create it with a `# Harvest queue` header first.
4. Confirm briefly: "Flagged for template harvest: <description>"

## What NOT to flag

- Generic praise ("nice", "great", "good") without explicit reference to the template.
- Statements about the current project only ("this works well here") unless the user explicitly connects it to the template.
- Lean conservative. False positives create noise in the harvest queue. When in doubt, ask: "Want me to flag this for the template?"
