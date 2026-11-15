# Temporary milestone debug checkpoints

Implemented 2026-11-14 on `codex/milestone-learning-debug`. This is the disposable manual-checkpoint design from [debug-storage research](2026-11-14-disposable-debug-storage.md), not production persistence.

## Using it

All commands require `/trav debug on`. Opening debug mode, clicking skills, changing options and unloading the plugin do not load or save this store automatically.

| Command | Effect |
|---|---|
| `/trav debug-store load` | Explicitly load the current character's valid checkpoint and replace the session rows. Read-only disk operation; it is also the opt-in for later manual saves. |
| `/trav debug-store save` | Save a detached snapshot of numeric bindings and report completion/omitted text-only observations. |
| `/trav debug-store clear` | Deliberately reset this character's experimental file and session rows. Waits for older writes, then writes an empty clear marker. Also initializes an absent/incompatible throwaway store. |
| `/trav debug-store status` | Show state, record counts, whether the checkpoint matches the session and whether a write acknowledgement is still pending. No I/O. |

For a new test character/store: enable debug, issue **clear**, wait for the “debug data cleared; persistence disabled” acknowledgement, then issue **load**. Collect picker/use observations and issue **save**. After reloading the plugin, enable debug and explicitly **load** again to restore them. Finish testing with **clear** and wait for acknowledgement before disabling debug or exiting.

Clear intentionally discards the session records too. Initialize before collecting a new test set. An uncertain/missing load does not authorize a save; use explicit clear to initialize/reset this disposable key. There is no extra confirmation dialog because the command names the current character's debug data.

## What is stored

The only key is **`TravelWindowII_MilestoneDebug`**, hardcoded with `Turbine.DataScope.Character`. It is separate from `TravelWindowIISettings`, account defaults and any future production milestone key. The module accepts no caller-supplied scope/key.

The binding model contains actual numeric game skill IDs and immutable numeric TWII destination IDs from the checked-in ledger. The wire format uses ASCII decimal strings for every numeric value/key, avoiding locale-dependent number serialization. There are no raw numeric array keys and no dependency on catalogue array order.

Illustrative saved envelope:

```lua
{
    schemaVersion = "1",
    experimentEpoch = "1",
    destinationIdNamespace = "1",
    revision = "3",
    cleared = false,
    bindings = {
        ["1879201683"] = {destinationId = "194", evidenceKind = "1"}
    }
}
```

Here the skill is Return Home 3 and destination 194 is the current catalogue's Hobbiton-Bywater record. Evidence kind **1** is an inferred picker guess; **2** is successful-use evidence. Names, raw chat/location strings, coordinates, character names, window settings, pending tokens and session clock values are never serialized. Labels are reconstructed from the current catalogue on load. Client-language independence applies to identity/storage; detector and display translations remain separate work.

The wire dictionary is keyed by canonical decimal skill ID instead of a Lua-number-indexed list. Validation rejects unsupported skill IDs, malformed/noncanonical IDs, invalid evidence values, unknown fields, excessive records, incompatible schema/epoch/namespace and a nonempty clear marker. Valid positive destination IDs absent from the current catalogue are retained and shown as unresolved; they are not replaced by a nearby/similarly named entry.

A successful-use record receives an ID from its existing exact-matching association or an unambiguous exact catalogue destination string. Ambiguous names do not select an arbitrary marker. Records without a resolved numeric destination ID stay session-local and are **omitted with a count** when saving. Even after an acknowledged save, status does not claim the entire session was checkpointed if text-only records remain. Saving a full snapshot replaces the prior snapshot; it does not keep an old stale ID for an unresolved current observation.

## Load and write safeguards

- The store begins disabled each plugin session. Debug-on alone performs no store I/O. Debug-off and unload invalidate pending loads and queued clears and permit no new store operations.
- A load handles an immediate result and a later callback through the same one-shot validation path. Immediate `nil` means unavailable/pending/possibly missing, not permission to write `{}`. Invalid or uncertain loads block saving.
- Session records have a local revision. A delayed load that would overwrite observations made since its request is rejected. Explicitly loading again is a deliberate replacement operation; clear deliberately discards the disposable snapshot.
- There is one write in flight, no autosave queue. Save completion acknowledges its submitted model revision, not edits made afterwards. `pcall` success alone is not durable-save acknowledgement.
- A clear increments the request generation, cancels pending travel/picker capture, freezes binding changes and waits for an already dispatched write. Its empty marker is submitted **after** that write completes. Duplicate/stale callbacks cannot release a newer write barrier or repopulate the model.
- Only an acknowledged clear empties the session rows and disables checkpoint access. The debug window is recreated to invalidate old manual LOC tokens too. Loading the empty marker is an explicit new opt-in before saving again.
- Failure reports do not claim completion. A synchronous save exception leaves its outcome/barrier unresolved because it might already have been dispatched. Wait for completion or restart the client before recovery; do not issue competing writes.
- Turning debug off/unloading cannot cancel a write already handed to the game. Its callback can drain bookkeeping, but cannot apply data or initiate a canceled queued clear. If cleanup was interrupted, inspect/load and explicitly clear again after pending operations finish. There is no unload flush.

## Cleanup and removal

**Clear is logical cleanup:** it removes stored bindings but leaves one small, clearly named empty-marker file per tested character. No undocumented Delete method or nil-save deletion assumption is used. Physical file removal remains a separate manual/probed action with the game closed, restricted to this exact key; never remove normal settings or the shared PluginData folder.

The adapter is one removable module, [MilestoneDebugStore.lua](../../src/MilestoneDebugStore.lua), plus one import, command branch and debug-off/unload hooks. Model snapshot/apply/revision helpers live beside the debug model; the existing chat listener and travel observer are reused. Removing persistence must not remove or renumber the catalogue ID ledger. A future production store must use another key and must not automatically promote test data.

## Validation and client acceptance

[Test-MilestoneDebugStore.py](tools/Test-MilestoneDebugStore.py) uses Lua 5.1 and an in-memory PluginData stub. It loads actual model/store/command/unload source; it does **not** access real PluginData files. It checks character isolation, numeric-only wire data, checkpoint reload, evidence/unknown-ID preservation, omitted names, immediate/deferred/duplicate/failed/malformed loads, fresh-session revision guards, save failures/unknown outcomes, dirty revisions, serialized clearing, late callbacks and debug-off/unload boundaries. Existing picker/manual LOC/travel checks run in the same harness; all **43** plugin Lua files compile.

Run with Python and `lupa` installed:

```text
python plans/milestone-management/tools/Test-MilestoneDebugStore.py
```

Required live-client checks:

1. Clear a fresh Character-scope test store, wait for acknowledgement, load it, pick a known milestone, save, reload TWII and load again. The same numeric destination and guess marker should return.
2. Confirm a guessed row by actual travel; save/reload and check successful-use evidence remains distinct from a guess. Test unresolved names/IDs and omission diagnostics.
3. Repeat on another character and test ordinary save/load global defaults. Each character's checkpoint must remain isolated; normal settings must be unaffected.
4. Inspect the debug file for digit IDs/evidence/version metadata only, then clear and reload it. Verify empty bindings and that subsequent debug activity does not autosave/recreate them.
5. Record actual Load/Save callback timing for missing, existing and invalid files, and completion during debug-off/unload. The stub contract checks are not runtime disk/callback acceptance.
6. Switch client language where available and verify ID round trips; English display fallback is expected until catalogue translations exist.

Primary references re-read on 2026-11-14: pinned SSG [Load](https://github.com/Goldbishop/Lotro_LUA/blob/fe36613c8a4f83e68089fbe135d455deb77b0db1/SSG/Turbine_PluginData_Load.html) and [Save](https://github.com/Goldbishop/Lotro_LUA/blob/fe36613c8a4f83e68089fbe135d455deb77b0db1/SSG/Turbine_PluginData_Save.html). They establish possible immediate/deferred load and Save's success/message completion handler; they are 2016 beta documentation, not current-client proof. Local SequenceBars `Manager:LoadSettings` supplies the single-loaded-data callback precedent. `PatchDataLoad` is intentionally not used: its callback bypasses decoding and its immediate result conflates errors with nil. The new adapter instead uses a separate validated digit-string contract, without altering shared wrappers.
