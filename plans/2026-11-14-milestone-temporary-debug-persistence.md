# Temporary character-only milestone debug persistence

Date: 2026-11-14
Branch: `codex/milestone-learning-debug`, continuing the authorized prototype and preserving existing changes.

## Plan

1. Implement the researched manual checkpoint adapter in one removable module. Only explicit `/trav debug-store load|save|clear|status` commands may access the fixed `TravelWindowII_MilestoneDebug` key at Character scope, and only while `TravelDebugEnabled` is true. Do not autosave or couple the adapter to settings/account defaults.
2. Store numeric skill IDs, immutable numeric destination IDs and numeric evidence/version metadata using invariant decimal-string wire fields/keys. No names, raw messages, coordinates, character identity or session tokens are serialized. Resolve display names through the current catalogue; preserve unknown destination IDs as unresolved.
3. Add narrow model snapshot/apply/clear/revision helpers. Preserve guess versus successful-use evidence; resolve successful-use names to an ID only from an existing matching association or an unambiguous exact catalogue match. Omit unresolved text-only observations from checkpoints with an explicit count.
4. Validate both immediate and callback loads, reject malformed/incompatible data, and block writes after uncertain reads. Reject late loads that would overwrite newer session observations. An explicit debug clear may initialize/reset this disposable store.
5. Permit one write in flight. Clear invalidates pending reads, freezes record updates and runs an acknowledged empty-marker write after any pending write. Debug-off/unload disable new operations and prevent callbacks from repopulating state; already dispatched writes may finish and must not be reported as canceled or durably saved without acknowledgement.
6. Add meaningful offline tests for character isolation, numeric-only encoding, missing/failed/deferred reads, save failure, stale callbacks, clear ordering, debug-off/unload boundaries and previous picker/use behavior. Document commands, first-run initialization, logical cleanup and the remaining client API acceptance checks.

## Boundaries

No new chat listener, normal travel activation changes, production import/store, physical deletion API, or global settings modification. Keep the ID ledger. Clear removes current-character experimental records through a tombstone; physical file deletion remains a manual/probed follow-up. Leave implementation uncommitted for review. In-game disk/callback behavior is not established by mocks.

## Implementation handover

The adapter and model/command integration are implemented. See [usage and validation](milestone-management/2026-11-14-debug-persistence.md). The wire binding dictionary is keyed by decimal skill-ID strings to avoid raw numeric table keys. Explicit initialization is clear, await acknowledgement, then load; there is no first-run empty-file assumption. Offline tests cover the async/write-order failure cases and the previous picker/travel paths; live disk/callback acceptance is pending.
