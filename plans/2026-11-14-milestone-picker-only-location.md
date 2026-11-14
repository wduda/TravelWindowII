# Keep location capture separate from ordinary milestone travel

Date: 2026-11-14
Branch: `codex/milestone-learning-debug`, continuing the authorized debug iteration.

Corrected stakeholder intent: `;loc` is allowed in the learned-skill picker **and the explicit manual-testing LOC quickslot in the debug window**. Removing that debug test button was an overcorrection. Regular list/grid/carousel/pulldown/map quickslots keep their real travel action. `TrackMilestoneQuickslotClick` only remembers the last clicked skill for successful-use reconciliation; it never requests location or changes a shortcut.

## Plan

1. Restore the dedicated manual LOC Alias/action and its guarded command/lifetime in the debug window. It samples current position and shows catalogue guesses without assigning a skill binding.
2. Preserve the picker's separate physical-click location Alias, hover trial, numbered badges and placement.
3. Leave every regular-view file and its travel-click observer unchanged. A successful-use message updates the exact last-clicked milestone's session record, including correction of an earlier destination; ordinary clicks do not request `;loc`.
4. Check both diagnostic capture paths, stale/expired requests, and repeat successful-use reconciliation. Verify regular-view file hashes are unchanged and compile/test under Lua 5.1. Native picker dispatch remains an in-game experiment.

No persistence, production-view integration, additional chat listener, or other feature expansion is included. Leave implementation uncommitted for review.
