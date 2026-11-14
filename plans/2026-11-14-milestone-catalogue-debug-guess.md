# Milestone catalogue and debug location guesses

Date: 2026-11-14
Execution branch: `codex/milestone-learning-debug`, continuing the previously authorized debug prototype and preserving its uncommitted work.

Final stakeholder clarification: location-on-click is allowed in the learned-skill picker and the dedicated manual LOC test quickslot in the debug window. Regular views keep real travel shortcuts and only remember the last clicked skill for success-message reconciliation. Removing the manual debug button was an overcorrection; it is restored.

Display refinement: the stakeholder reports that manual LOC chose the correct closest marker with the correct name at at least three milestones. Show only the calculated closest record, retaining raw location/context and uncertainty diagnostics. Keep the matching algorithm, picker/manual actions and regular-view successful-use reconciliation unchanged.

## Plan

1. Compile the pinned 351-marker research inventory into a runtime catalogue. Retain observed/reported names where available; add useful wiki label candidates with explicit uncertainty, area/context and coordinates. Use a checked-in allocation ledger for stable numeric plugin IDs, independently of upstream marker IDs and translated names.
2. Capture inline location through the picker and a dedicated manual LOC test quickslot in the debug window. Show the raw sample and only the closest catalogue marker, its distance/context and any unknown-world/ambiguity warning. Regular views never request location.
3. Keep the experiment behind `TravelDebugEnabled`, session-only, and separate from successful-use evidence. Do not change real milestone bindings, global options, ordinary travel views or save character bindings yet.
4. Use one requested subagent to research safe character-only persistence, empty/load-failure handling and numeric language-independent identity. Persist the recommendation separately without implementing storage.
5. Validate catalogue generation, numeric-ID stability, location matching/ambiguity, command lifecycle and Lua 5.1 compatibility. Document a concise in-game test; native Alias expansion and GUI operation still need client verification.

## Acceptance

- `/trav debug on` shows the milestone table, explicit LOC test quickslot and a text result area.
- A picker or manual LOC click expands `;loc` (`;pos` on German clients) through TWII's command and displays only the calculated closest milestone, its numeric ID, distance and context. Unsupported/unresolved location text is displayed without claiming certainty.
- Wiki display labels remain distinguishable from observed destination names. Unknown-name markers can be identified by numeric ID and area for this debug workflow.
- World overlap cannot silently produce an authoritative match. No database binding is saved by a location sample.
- Previous successful-use mapping and bind-popup trial remain available; all pre-existing changes are preserved. Code remains uncommitted for review.
