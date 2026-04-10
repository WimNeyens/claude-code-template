# Sources

Authoritative external documentation: specs, standards, official vendor docs, RFCs. Stable, long-lived references.

Format: `- [Title](url) — one-line what/why — captured YYYY-MM-DD`

## Specifications and standards

<!-- e.g. - [RFC 7519 — JWT](https://datatracker.ietf.org/doc/html/rfc7519) — token format used by the auth service — captured 2026-04-06 -->

## Vendor documentation

<!-- e.g. - [Stripe API reference](https://stripe.com/docs/api) — payment integration — captured 2026-04-06 -->

## Claude Code

- MCP servers configured on claude.ai (e.g. Atlassian Rovo, third-party connectors) appear in the Claude Code CLI's MCP config alongside locally defined servers. They use `type: "url"` transport. Be aware of them when reviewing MCP health or troubleshooting server lists. — captured 2026-04-10
