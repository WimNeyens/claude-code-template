# references

Pointers to external knowledge and project-specific vocabulary. These files are the first place to look for "where is X documented" or "what does this term mean in this project".

## Files

| File | Purpose |
|---|---|
| `sources.md` | Authoritative external docs — specs, standards, vendor documentation |
| `tools.md` | SaaS dashboards, admin consoles, internal portals |
| `research.md` | Articles, blog posts, papers — opinionated, dated, decay fast |
| `people.md` | Stakeholders and contacts (name, role, link — no PII beyond that) |
| `glossary.md` | Project-specific terms, acronyms, codenames |
| `decisions-log.md` | Lightweight log for small decisions that don't warrant a full ADR |

## Conventions

Each link entry:

```
- [Title](url) — one-line what/why — captured YYYY-MM-DD
```

- Split by file, not by one giant list — different decay rates and trust levels
- Never put credentials, tokens, or PII in these files
- When a link rots, update or remove it — don't leave dead links

## For AI assistants

Check `references/glossary.md` first when the user uses unfamiliar terminology. Check `references/sources.md` before searching the web for authoritative docs.
