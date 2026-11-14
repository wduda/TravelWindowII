# Restrict location capture to the milestone picker

Date: 2026-11-14
Branch: `codex/milestone-learning-debug`, continuing the authorized debug iteration.

The stakeholder clarified that `;loc` on click belongs only in the learned-skill picker. Normal travel quickslots must retain their normal activation. The existing `TrackMilestoneQuickslotClick` observer does not execute location commands or change shortcuts; it supplies the exact skill ID for the already working successful-use chat mapping. Preserve that requested detection while restricting location capture.

## Plan

1. Remove the standalone LOC Alias/action, command route and request/update state from the debug table window. Keep it as a display of successful-use destinations and picker-captured catalogue guesses.
2. Keep the physical-click location Alias confined to the picker. Preserve its hover trial, numbered badges and placement.
3. Leave normal-view activation and successful-use observers intact; clarify the observer's limited purpose in code/documentation rather than replacing ordinary skills with location commands.
4. Update the relevant plan/docs and targeted checks. Validate one remaining Alias path in the picker, ordinary shortcut identity preservation, successful-use mapping and Lua 5.1 compatibility. Native picker dispatch remains an in-game experiment.

No persistence, production-view integration, additional chat listener, or other feature expansion is included. Leave implementation uncommitted for review.
