# Disposable milestone persistence for the debug period

Research date: 2026-11-14. **Recommendation only: no persistence or cleanup command is implemented.** This supplements [character-only storage research](2026-11-14-character-storage.md) with a deliberately small, removable debug checkpoint design.

Subsequent authorized execution: [temporary debug checkpoints](2026-11-14-debug-persistence.md) now implement this design, with numeric-keyed wire records, explicit manual commands and a serialized clear barrier. This research report preserves the original proposal; the implementation note records current behavior and remaining client acceptance.

## Recommended first version

Use **manual debug checkpoints**, rather than autosave. Keep one dedicated Character-scope key, for example `TravelWindowII_MilestoneDebug`, entirely outside ordinary settings. Require `TravelDebugEnabled` plus an explicit debug-store command to enable access for that session. Turning on `/trav debug` or opening the window alone must not load, create or save a file.

Put the adapter in one removable module with a fixed key and scope; callers must not supply a scope or arbitrary key. Reuse TWII's existing `/trav` command routing and already collected observations. Add no second chat listener, alternate skill tracker, new settings panel or global-default option.

Suggested command surface for a later implementation:

| Command | Intended behavior |
|---|---|
| `/trav debug-store load` | Explicitly opt in and load this character's matching debug snapshot. No write. |
| `/trav debug-store save` | Save one detached snapshot of eligible numeric test records. Reject if not writable or another checkpoint is in flight. |
| `/trav debug-store clear` | Explicitly discard this character's debug snapshot and session associations through the cleanup barrier below. This also serves as deliberate first-run initialization. |
| `/trav debug-store status` | Show disabled/loading/ready/blocked/saving/clearing/cleared, epoch, record count and whether disk completion was acknowledged. No write. |

These are developer commands, not a proposal for more production windows. An explicit `clear` is the destructive intent; no additional approval dialog is necessary for this isolated disposable key. Its help/output must say **current character's milestone debug data only**, not “reset TWII.”

The checkpoint can survive a plugin/game reload, but the opt-in does not: the next session starts disabled until an explicit load/clear. Debug-off disables new checkpoint activity. Do not attach checkpoint writes to normal options saving or plugin unload. Save manually before reload if the sample matters.

## Isolation and a compact envelope

Hardcode `Turbine.DataScope.Character`. Never pass `Settings`, `SettingsConfig`, `AccountSettingsStrings`, account scope, ordinary `TravelWindowIISettings` keys, or production milestone keys into this adapter. Account defaults, ordinary reset and UI/client-language changes must not affect it.

Keep one filename per character across compatible iterations, with explicit format and experiment metadata inside it. This avoids a pile of timestamped/epoch-specific files during fast iteration. Example wire shape, **not implementation**:

```lua
{
    kind = "TWII_MILESTONE_DEBUG",
    schemaVersion = "1",
    experimentEpoch = "1",
    destinationIdNamespace = "1",
    revision = "3",
    cleared = false,
    bindings = {
        {skillId = "1879201466", destinationId = "42", evidenceKind = "1"}
    }
}
```

The example IDs are illustrative, not a real binding. Identity is numeric in the model; ASCII decimal strings provide a locale-independent wire representation. Use validated numbers in memory and explicit digit-string conversion at the adapter boundary, or the existing numeric codec exactly once. Do not layer both indiscriminately. The existing `PatchDataLoad` cannot be reused unchanged for asynchronous loads: it decodes only the immediate result and conflates errors with `nil`.

Save the real numeric skill ID, not its displayed number/name. Destination IDs come from the [append-only numeric ledger](catalogue-proposal/numeric-id-ledger.json), never catalogue position or unstable upstream marker ID. Validate the epoch and ID namespace before interpreting them. Removing the temporary save adapter must **not** remove or renumber the catalogue's identity ledger.

No destination names, raw chat/location strings, character names, window positions, pending click tokens, or session `GetGameTime()` values belong in this checkpoint. Resolve labels from the current catalogue on display. Omitted skill records mean **unknown to TWII**, not unbound in the game. Valid but currently unresolved destination IDs remain unresolved; they must not become a nearest/currently similarly named entry.

The current debug table holds successful-use text, while LOC holds independent guesses. Neither is already an accepted numeric binding model. A later checkpoint implementation therefore needs one explicit source of staged numeric records; it must not dump all current window locals. A guess may be saved only if deliberately classified as a debug candidate with a numeric evidence enum, and must still display as a candidate after load. Do not silently promote the nearest guess or resolve an unknown native name by invention. For the smallest experiment, manually staged/confirmed numeric pairs are sufficient.

## Safe first run and loads

The minimal state distinction is disabled, loading, ready, blocked, saving and clearing. Per-skill knowledge remains separate: absence is unknown, including before the load finishes. Normal travel always continues regardless of store status.

On explicit load, install a generation-bound completion callback before calling the API. Decode and validate immediate and eventual data through the same function, accepting at most one terminal result. Preserve session drafts separately until the load result is known; do not let a late result overwrite fresh observations.

The [SSG Load contract](https://github.com/Goldbishop/Lotro_LUA/blob/fe36613c8a4f83e68089fbe135d455deb77b0db1/SSG/Turbine_PluginData_Load.html) permits an immediate value or an immediate `nil` followed by a later callback; it also describes `nil` for nonexistent data. Therefore `nil` alone is not proof of an empty store. Exceptions, malformed data, incompatible schema/epoch/namespace, or uncertain completion block writes. A timeout is not evidence of first run.

For disposable data, an explicit `clear` is a useful simplification: it deliberately authorizes replacement of this temporary key with a valid empty current-epoch envelope, even when the previous content is unreadable or a load result is uncertain. Invalidate the old read generation, freeze new checkpoints, and perform the controlled clear. This is not an automatic fallback from load failure. It does not touch production/global options and needs no general data-recovery UI.

## Saves and cleanup must account for already dispatched writes

Permit only one in-flight write. An explicit checkpoint copies and validates the records, records its submitted revision, and uses the save completion callback to acknowledge that revision. If observations change meanwhile, keep them dirty; do not queue an automatic checkpoint. The next explicit save can capture them. A successful `pcall` is dispatch acceptance, not disk completion.

**Clear must be the final write**, not merely a memory reset:

1. Freeze new saves and candidate/model updates to this store; increment the read/model generation so late load results cannot refill it.
2. If a write is in flight, retain one `clearRequested` flag and wait for that operation's actual completion before submitting the empty snapshot. Do not dispatch an older checkpoint and clear concurrently.
3. Keep the operation-completion bookkeeping alive even when its model generation is stale: it must drain the write barrier without restoring old payloads or acknowledging the old state as current. Invalidating a Lua callback does not cancel a client-side write already sent.
4. Save a current-epoch envelope with `cleared = true`, incremented revision and empty `bindings`. This is a small logical-clear marker. On successful completion, clear session associations and report **debug data cleared; persistence disabled**.
5. If completion fails, never claim success. Keep status visibly failed/incomplete and allow explicit retry. If callback completion remains unknown, do not race another write; require a controlled client restart/probe before recovery.
6. Finish the clear before turning debug off or unloading. If either interrupts the operation, do not initiate new data saves or promise cleanup completed; on the next opt-in, inspect status/load and reissue clear if needed. Old-generation callbacks cannot refill the live model.

There is no background autosave queue, periodic timer, automatic unload save or post-clear model notification allowed to recreate bindings. A known tombstone/empty envelope can be loaded as an empty debug store; another explicit opt-in is needed before testing writes again. Resetting the UI alone is never called disk cleanup.

The barrier needs only one pending-clear flag, not a generic task queue. This is worth retaining even for disposable data: without it a slow old write can resurrect records after a seemingly successful reset.

## Logical cleanup versus physical file deletion

The pinned [SSG PluginData member list](https://github.com/Goldbishop/Lotro_LUA/blob/fe36613c8a4f83e68089fbe135d455deb77b0db1/SSG/Turbine_PluginData%24Members.html) lists **Load and Save only**. No Delete/Remove method is documented there. [Save](https://github.com/Goldbishop/Lotro_LUA/blob/fe36613c8a4f83e68089fbe135d455deb77b0db1/SSG/Turbine_PluginData_Save.html) documents replacement and a completion callback but does not specify what saving `nil` does to the underlying file.

There is a useful local author precedent: `Plugins/Thurallor/Reminders/MigrateDialog.lua:230` calls `Save(Server, "Reminders", nil)` beneath a comment saying server-specific settings are deleted. That supports testing nil-save cleanup; it does not prove physical deletion, missing-file behavior or callback semantics in the present client. No nil-save or deletion experiment was executed for this research.

Recommended initial cleanup is the acknowledged empty/tombstone envelope above. It removes the experimental bindings while leaving at most one small, clearly named file per tested character. Call it **logical cleanup**, not physical deletion. If strict file removal is wanted:

- First probe nil-save in a dedicated disposable key, with the same write barrier and completion logging. Inspect the filesystem and subsequent load; establish whether the file disappears or merely contains an empty/nil representation.
- Until verified, physical removal is a manual developer action with the game closed and pending writes finished. Remove only the exact `TravelWindowII_MilestoneDebug.plugindata` files belonging to tested characters, using the actual configured LOTRO data location. Do not delete `TravelWindowIISettings*`, production milestone stores, shared PluginData folders, or wildcard all TWII data.
- Character scope cannot enumerate/clean every character/server from one logged-in character through the inspected API. Track tested characters in the developer test checklist; do not add an account-wide binding index just for cleanup.

These are proposed future cleanup procedures; this task did not read, create, overwrite or remove saved game data.

## What can be deferred from the production proposal

| Keep now | Defer for this disposable experiment |
|---|---|
| Fixed Character scope/key; no global settings coupling | Account-wide management or cross-character cleanup UI |
| Numeric identity, locale-safe wire format, input validation | Serialized names, full observations, travel history or import receipts |
| Explicit load outcome, generation guard and completed-save acknowledgement | General schema migrations and recovery wizard; an explicit debug clear can replace an incompatible throwaway snapshot |
| One in-flight write and clear barrier | Debounced autosave/latest-revision queue and unload-flush orchestration |
| Dirty/submitted revision distinction and failure output | Full transactional undo, retention policies and production notification UX |
| One temporary file and no automatic promotion | A/B snapshot rotation, rolling backups and cloud-sync conflict resolution |

Losing a disposable checkpoint after a crash can be acceptable if reported honestly; corrupting ordinary options or resurrecting cleared state is not. This tradeoff is the reason for manual checkpoints and a single isolated file.

## Epoch retirement and removing the experiment

Increment the envelope epoch only for incompatible experimental meaning/schema or destination-ID namespace changes; do not create a new key on every build. Reject old epochs for normal load and offer the explicit debug clear. Name/cosmetic/catalogue coordinate changes alone must not renumber IDs or require an epoch reset.

Production persistence uses a **different key** such as `TravelWindowIIMilestones`. It must never automatically load/import the debug key. Any later promotion of test observations requires deliberate reviewed import, not renaming the file or treating experimental guesses as accepted bindings.

Developer removal is small: clear the debug key for tested characters, wait for acknowledgement, remove the adapter import and debug-store command branch, remove its debug-off/unload cancellation hook, then verify normal `/trav debug`, LOC captures and successful-use tracking still work. Keep the catalogue/ID ledger and normal chat listener intact. A harmless old temporary file can be ignored indefinitely if manual physical cleanup is not worthwhile.

## Focused tests before implementing persistence

1. Debug off and `/trav debug` alone produce zero temporary/global writes. Only explicit load/save/clear touches the dedicated Character key.
2. Two characters keep different numeric associations; save/load global defaults and options reset leave both untouched.
3. Existing, missing, malformed and incompatible-epoch loads establish actual immediate/callback behavior; no uncertain read triggers an empty save.
4. Delayed load followed by explicit clear cannot repopulate records. Slow checkpoint followed by clear writes in the correct order, and reloading shows no old bindings.
5. Save failure, clear failure, debug-off and unload while a write is in flight report incomplete/unknown status honestly. No discarded callback or event silently recreates data.
6. EN/DE/FR round-trip the numeric IDs with no destination/character names in the file. Unknown IDs survive as unresolved or block writes according to the chosen debug policy.
7. Regeneration/reordering of catalogue rows preserves numeric identities. An old debug epoch never populates the future production store.
8. If nil-save physical cleanup is chosen, verify actual file existence and next-load behavior in a dedicated throwaway key before applying it to the debug store.

Sources: the pinned SSG beta documentation above (copyright 2016, read directly on 2026-11-14), current `src/VindarPatch.lua`, `src/SettingsManager.lua`, `src/Main.lua`, the local Reminders migration source, [numeric catalogue notes](2026-11-14-catalogue-debug-guess.md), and [character-only storage research](2026-11-14-character-storage.md). Source inspection is not current-client acceptance.
