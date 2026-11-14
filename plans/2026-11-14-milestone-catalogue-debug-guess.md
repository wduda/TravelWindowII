# Milestone catalogue and debug location guesses

Date: 2026-11-14
Execution branch: `codex/milestone-learning-debug`, continuing the previously authorized debug prototype and preserving its uncommitted work.

## Plan

1. Compile the pinned 351-marker research inventory into a runtime catalogue. Retain observed/reported names where available; add useful wiki label candidates with explicit uncertainty, area/context and coordinates. Use a checked-in allocation ledger for stable numeric plugin IDs, independently of upstream marker IDs and translated names.
2. Add a dedicated user-clicked location Alias quickslot to the existing debug table window. Parse inline location, show the raw sample and nearby catalogue candidates/distances/context in that window, and keep unknown world/ambiguous matches visible for human comparison. Reuse the same diagnostic results for bind-popup location captures when available.
3. Keep the experiment behind `TravelDebugEnabled`, session-only, and separate from successful-use evidence. Do not change real milestone bindings, global options, ordinary travel views or save character bindings yet.
4. Use one requested subagent to research safe character-only persistence, empty/load-failure handling and numeric language-independent identity. Persist the recommendation separately without implementing storage.
5. Validate catalogue generation, numeric-ID stability, location matching/ambiguity, command lifecycle and Lua 5.1 compatibility. Document a concise in-game test; native Alias expansion and GUI operation still need client verification.

## Acceptance

- `/trav debug on` shows a location-capture quickslot and a text result area in the milestone debug window.
- A click expands `;loc` (`;pos` on German clients) through TWII's command and shows nearby milestone guesses, numeric IDs and context. Unsupported/unresolved location text is displayed without claiming certainty.
- Wiki display labels remain distinguishable from observed destination names. Unknown-name markers can be identified by numeric ID and area for this debug workflow.
- World overlap cannot silently produce an authoritative match. No database binding is saved by a location sample.
- Previous successful-use mapping and bind-popup trial remain available; all pre-existing changes are preserved. Code remains uncommitted for review.
