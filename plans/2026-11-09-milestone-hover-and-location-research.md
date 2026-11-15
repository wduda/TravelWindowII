# Milestone native tooltip and location-click research

Date: 2026-11-09
Branch: `milestone-management-research`
Scope: source/API research and documentation; no plugin changes or runtime probe yet.

Status: research completed and linked to specification/validation. The alias action and visual overlays have source precedents; native skill hover with alias-only click remains unverified and is covered by E11.

## Questions

1. Can a milestone skill's native quickslot tooltip remain available on hover while a click requests location instead of casting travel?
2. Does the supported API distinguish hover pass-through from click interception, or offer native-tooltip display/click cancellation?
3. Which existing patterns support a visible skill icon/number over an alias quickslot, and what remains to test in-game?
4. Can the explicit location action carry the selected skill and a request identifier together with `;loc` to TWII's own command?

## Work

- Inspect SSG API documentation, installed MoorMap and SequenceBars, related alias-button implementations, and the current debug picker.
- Record primary-source evidence and distinguish documented behavior from event-order hypotheses and current-client acceptance.
- Persist the feasible designs, limitations, numbering proposal, and focused runtime experiment. Keep numbering across all views as a design candidate from the supplied Discord conversation, not an instruction to change all view behavior now.
- Link the findings into the proximity/self-healing plan and validation checklist. Preserve the execution branch and its uncommitted Lua.

## Acceptance of the research

Give a concrete source-backed location-capture design, identify whether the exact native-hover/alias-click combination is established, and document the smallest experiment needed to settle it. Do not call a custom tooltip a native dynamic skill tooltip or promise that forwarding Lua MouseEnter invokes the client's tooltip system.
