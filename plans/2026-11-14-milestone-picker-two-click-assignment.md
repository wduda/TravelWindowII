# Two-click milestone selection and session assignment

Date: 2026-11-14
Branch: `codex/milestone-learning-debug`, continuing the authorized debug prototype.

## Plan

1. Make the picker explicitly instruct two clicks on the same icon. Remove the below-icon text labels, retain mouse-transparent numeric badges, and reclaim the unused vertical label space.
2. Reuse the validated location-command handler for the second click. A valid returned location updates the closest-marker/predicted-name result, then closes the picker on the following UI update so native Alias dispatch is not interrupted. Malformed/stale requests do not assign a name.
3. For a clear named closest match, record the predicted destination and numeric catalogue ID for the selected skill in session memory, marked as a guess in the large debug table. Manual LOC remains comparison-only. Trusted successful-use text replaces the guess through the existing reconciliation path. Unknown/ambiguous matches remain diagnostics without changing the prior skill record.
4. Keep Open picker, manual LOC, normal travel activation, character/global settings and the single chat listener intact. Run the targeted Lua 5.1 checks for guessing, two-click completion/closure, reopening and later successful-use correction.

No persistence or production-view integration. Leave implementation uncommitted for review. The existing two-click capture has a positive stakeholder runtime report; the changed layout and row-assignment behavior require a fresh client check.
