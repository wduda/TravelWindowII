# Character-only milestone storage and numeric identity

Research date: 2026-11-14. **Proposal only: no persistence is implemented by this work.** This answers the stakeholder's requirements that milestone bindings belong to a character, cannot affect global options, start unknown before observation, and use a numeric identity rather than a plaintext destination name.

Subsequent execution implements the [temporary manual debug subset](2026-11-14-debug-persistence.md), with the isolated Character key and numeric wire contract. This report remains the broader production proposal; automatic production persistence and its full acceptance matrix are not implemented.

## Recommendation

Use a dedicated store owned by a milestone model, loaded and saved exclusively with `Turbine.DataScope.Character` under a new fixed key such as `TravelWindowIIMilestones`. Keep it outside `Settings`, `SettingsConfig`, `AccountSettingsStrings`, normal options reset, and the save/load-global-defaults paths.

Persist the **numeric milestone skill ID → immutable plugin-owned numeric destination ID** association. Resolve a destination's translated label, geography and icon from the shipped catalogue when displaying it. The shared catalogue is read-only reference data, not character state. An unset association means **TWII does not know**, not that the character has no native game binding.

This does not authorize persisting today's proximity guess. Candidate identity, selected slot, accepted binding and actual successful-use evidence remain separate. The debug catalogue/capture workflow can stay entirely in memory until the persistence iteration is approved.

## 1. Why the ordinary options path is unsuitable

Current repository inspection:

| Code | Current behavior and consequence |
|---|---|
| `src/SettingsManager.lua:LoadSettings` | Reads both Character and Account `TravelWindowIISettings`, initializes account settings first, then character settings. |
| `CreateSettingsConfig`, `SetSettings`, `SaveSettings` | The same options configuration participates in both character and account processing. A milestone field added here would be easy to copy through global defaults. |
| `src/OptionsPanel.lua` global-default buttons | Save calls `SaveSettings(Turbine.DataScope.Account)`; load calls `SetSettings(AccountSettingsStrings, Turbine.DataScope.Account)`. |
| `src/TravelWindow.lua:ResetSettings` | Reinitializes ordinary options and shortcut presentation. It should never erase, replace, or import native-binding knowledge. |
| `src/Main.lua` unload | Saves character options and account options. A future milestone saver must be separate and guarded, rather than blindly joining these saves. |
| `src/VindarPatch.lua:PatchDataLoad` | Returns `nil` after a load exception or conversion failure. It also passes a supplied load callback directly to the API, without decoding the callback's eventual data. |
| `src/VindarPatch.lua:PatchDataSave` | Calls the API with `convSafe(data)` and forwards the save callback. It does not itself distinguish submission from successful disk completion. |

Therefore `PatchDataLoad(Character, key) or {}` is insufficient for a loss-sensitive new store: it conflates missing, pending, failed and malformed data. Do not alter the shared options machinery just to add milestones; a dedicated small adapter can reuse the understood number codec while preserving load outcome and applying decoding equally to immediate and callback-delivered results.

Character scope lets the client choose the current account/server/character namespace. Do not hand-build a filename containing the current character's display name, use a locale suffix, or maintain one account-wide map indexed only by character name. Two characters on different servers may have the same name. The conventional on-disk layout is `PluginData/<account>/<server>/<character>/<key>.plugindata`; the API scope, rather than custom path manipulation, is the contract to use.

## 2. The numeric identifiers

### Destination ID

Allocate a positive integer owned by TWII, from an append-only catalogue ledger committed with generated data. Once allocated, that integer must never be reassigned to a different destination, even if a row is removed or renamed. Keep retired IDs as tombstones or explicit aliases. Adding a new destination consumes a new number; sorting and regeneration do not renumber existing ones.

The existing research GUID ledger can be cross-referenced during the initial numeric allocation. Freeze that mapping before shipping persistent bindings. A one-time sorted allocation is acceptable for establishing a ledger; repeating the sorted allocation after data changes is not. The parent implementation is preparing a numeric catalogue ledger for this debug increment; it still needs the same permanence rules before release.

Do **not** save these as the destination identity:

- the catalogue array index or sorted position;
- the settlement/destination's translated name;
- an area, territory, map or object-template DID;
- a coordinate hash, because coordinate corrections would change identity;
- an upstream marker ID alone: [seven marker IDs changed at identical world coordinates](evidence/2026-11-08-marker-id-changes.json).

Store upstream marker IDs, current coordinates, reviewed alias links and the research GUID in the catalogue's build/provenance files. They help maintain the numeric ledger, but character bindings need not duplicate them. Source marker IDs include a signed-negative value; preserve their source representation independently of the positive TWII destination namespace.

### Skill ID

Use the actual skill ID, not the translated `Return Home` name or display ordinal. For example, slot 1's `0x700256BA` is numeric **1879201466**. Slot number and TravelLink type are separate namespaces. The existing supported skill registry maps the numeric ID to the displayed ordinal and can handle gaps such as learned skills 1 and 3.

These skill IDs and a reasonably bounded catalogue integer fit exactly in Lua's numeric representation. Validate integer-ness and range before use. Do not perform arithmetic on game IDs or derive a slot from their order.

### Numeric identity versus safe serialization

“Numeric identifier” does not require saving a raw Lua number to PluginData. The existing Vindar compatibility layer exists for locale-related serialization problems and converts numbers and numeric keys. The binding's **semantic identity** should remain numeric and language independent, while the wire form may encode it as an invariant ASCII decimal string, for example `"1879201466"` and `"42"`.

Recommended adapter: use explicit fields with decimal-digit strings on disk, and validated numbers in memory. Do not mix a custom decimal-string codec with `convSafe`/`convBack` without documenting the boundary: those wrappers deliberately distinguish numeric strings from numbers. Alternatively, use their established conversion exactly once and validate the decoded numeric fields. Round-trip either chosen contract under EN/DE/FR clients before claiming persistence acceptance.

Names are not serialized in the binding store. English fallback or a new translation changes only the catalogue/UI. The same saved association should load unchanged after a client-language switch. The detector and localized-world resolver still need their own locale support; language-independent storage does not make chat parsing language independent.

## 3. Proposed logical schema

Illustrative semantic record, not implemented Lua:

```lua
{
    schemaVersion = 1,
    catalogueIdVersion = 1,
    revision = 7,
    bindings = {
        {
            skillId = 1879201466,
            destinationId = 42,
            bindingRevision = 2,
            evidenceKind = 1,
        },
    },
}
```

`42` is an illustrative destination ID, not an assignment to a real location. `evidenceKind` should be a documented numeric enum, for example accepted user selection versus trusted successful-use evidence. Do not infer confirmation from a catalogue ID merely being present.

Use a dense list of explicit records on disk rather than an array with holes keyed by displayed slot. Reject duplicate skill IDs instead of allowing input order to choose the winner. An empty `bindings` list is valid. A learned skill absent from that list remains unknown.

The minimal store needs schema version, destination-ID namespace/version, document revision and bindings. Per-binding revision supports future stale-observation guards. Future history/undo should store numeric IDs and numeric metadata with bounded retention, not copies of localized labels.

If a destination is temporarily absent from the current catalogue, preserve its valid numeric ID as **unresolved**; show a generic unknown-destination label. Do not reinterpret it as an array index, silently delete it, or choose a similarly named place. A reviewed migration can resolve aliases later.

If a successful-use name has no canonical catalogue association yet, keep that message text session-local for diagnosis. Do not fabricate a destination ID or persist a plaintext name as the binding. A later extension may retain typed numeric world/area/coordinates as unresolved evidence, but it must still distinguish that observation from an accepted destination. This follows the latest requirement for identifier-based, language-independent saved bindings; older proposals to persist raw observed names need revision before implementation.

## 4. Initial state and load state are different

Maintain a store-status state independently from each skill's binding knowledge:

| Store state | UI and write policy |
|---|---|
| `uninitialized` / `loading` | No loaded values yet. Show unknown/loading, permit travel, and block persistent writes. A live observation can be retained as a session draft. |
| `ready-empty` | A completed, recognized first-run/empty read. Every learned slot is unknown. Do not prepopulate guesses or automatically write a default file merely because a window opened. |
| `ready` | Valid supported data loaded. Display known records plus unknown learned skills. Accepted changes may enqueue a save. |
| `load-failed` / `invalid` | Keep normal travel working and session observations available; do not replace the source with `{}` on unload. Report that saving is unavailable until recovery. |
| `newer-schema` | Preserve the file, remain read-only for that store, and explain that this version cannot write it safely. |
| `saving` / `dirty` | A revision exists only in memory or a write is pending; distinguish it from acknowledged saved state. |

`nil` for a binding is not `false`, zero, or an explicit “unbound” game state. TWII generally cannot conclude that the native skill is unbound. “Forget TWII's saved destination” removes the plugin record only; it does not change the game binding.

Closing and reopening the diagnostic window must not reinitialize or reload the store. One model instance owns it for the plugin session. New observations received while loading are drafts, and must be applied only after load completes using expected revisions or explicit review; they must not be silently lost to a late load callback or overwrite loaded data by default.

## 5. What the inspected API actually guarantees

The [SSG Load reference](https://github.com/Goldbishop/Lotro_LUA/blob/fe36613c8a4f83e68089fbe135d455deb77b0db1/SSG/Turbine_PluginData_Load.html) says data may be returned immediately, or `nil` returned and a handler invoked later. It also says nonexistent data yields `nil`. Consequently a bare immediate `nil` does not, by itself, prove first run. This is the most important guard against overwriting previously saved records.

The [SSG Save reference](https://github.com/Goldbishop/Lotro_LUA/blob/fe36613c8a4f83e68089fbe135d455deb77b0db1/SSG/Turbine_PluginData_Save.html) documents replacement of existing data and a completion handler with success and failure-message arguments. A successful `pcall` around Save means the call did not throw; it is not confirmation that the save completed successfully.

The primary docs do not fully specify missing-file versus deferred-load completion/error delivery, callback argument shape for Load, callback behavior during unload, or atomic/fsync guarantees. They are copyright-2016 beta documentation, not a current-client acceptance test. Local `Thurallor/SequenceBars/Manager.lua:LoadSettings` uses a single loaded-data callback; this is implementation precedent, not proof of all missing/error cases.

**Implementation gate:** instrument a tiny dedicated Character-scope test store in the actual client to establish immediate/callback behavior for an existing file, missing file and malformed file, during initial load and a runtime read. Record callback arguments and completion ordering. Only a positively established completed empty read may become `ready-empty`. A timeout is an unavailable/error state, never evidence of missing data. If the API cannot distinguish an absent file from an uncertain failure in a particular path, preserve the file and require an explicit recovery/initialization action rather than automatically overwriting it.

The future adapter should:

1. Enter `loading` before calling Load, register a session/generation-bound callback, and catch immediate exceptions.
2. Decode and validate both immediate data and callback data through the same function.
3. Accept one terminal load outcome; ignore duplicate/late callbacks from older sessions or replaced requests.
4. Avoid deciding “missing” from the synchronous return while a callback may still arrive.
5. Distinguish invalid decoded data from an empty valid schema. Never turn either a conversion exception or unsupported schema into defaults eligible for saving.

Do not copy the generic skill-guide fallback-to-defaults example verbatim: it is suitable for replaceable preferences, while milestone observations must survive an uncertain read.

## 6. Safe save lifecycle

Once load is positively complete and a supported store is writable:

1. Apply an accepted change atomically in memory, increment document/binding revisions, and mark it dirty.
2. Queue a detached, validated snapshot. Coalesce short bursts, but save important accepted changes promptly rather than waiting only for unload. A 0.5–1 second debounce is a proposal to test, not an API fact.
3. Allow one in-flight write per key. Keep the submitted revision with the callback and retain newer edits separately.
4. In the save-completion callback, acknowledge only the submitted revision on success. Clear dirty only if it is still the latest revision. If edits occurred meanwhile, queue the newest snapshot next.
5. On synchronous exception or callback failure, retain dirty data and visible unsaved status; retry with bounded delay or on a later explicit action. Avoid a per-frame write loop and repetitive chat spam.
6. On unload, stop observers and attempt a final eligible dirty snapshot. Do not save an empty default if loading failed or never completed. An unload save is best effort; persistence acceptance must establish callback/lifetime behavior in game rather than assume an asynchronous operation can finish after Lua teardown.

Retain a last-known-good Character-scope recovery snapshot for migrations and explicit destructive reset. Do not rotate a corrupt/newer-schema source over a good backup. All recovery keys must use Character scope. A backup can be written through PluginData; arbitrary file-copy/rename/delete APIs are not assumed available.

A single Save call's replacement behavior does not establish crash-atomicity. If tests show that interrupted saves can damage the only copy, consider two alternating validated snapshot keys with monotonically increasing revisions and load the highest valid supported revision. That is a separate robustness increment, with extra write cost and recovery tests; do not claim it solves concurrent clients or cloud-sync conflicts automatically.

## 7. Validation and migration rules

- Require a table/envelope, supported integer schema version, bounded entry count, unique skill IDs and finite positive integer IDs in documented ranges.
- Validate supported milestone IDs through the canonical registry; preserve otherwise valid unknown/future records in a quarantined passthrough area or make the store read-only. Never silently rewrite away a future skill.
- Preserve valid destination IDs that the current catalogue cannot resolve; they are missing reference data, not automatically corrupt bindings.
- Catalogue additions, name translations, spelling fixes and coordinate corrections must not change destination IDs. Renumbering requires an explicit old→new mapping, migration receipt and recovery snapshot.
- Future-schema or failed migration must not mutate the original file. Migrate a copy in memory, validate it, retain a recovery copy, then save only through the controlled queue.
- Keep the transient capture token, pending click and 30-second correlation window out of persistent state. Session times from `GetGameTime()` cannot be compared across sessions as wall-clock timestamps.
- Global save, global load, ordinary options reset and changing UI/client language must leave the milestone store unchanged. Only an explicitly named character-milestone reset may clear it.
- A character rename/server transfer can move the storage namespace. Recovery/import must be an explicit association; equal display names alone must not silently merge two characters. Manual copying of another character's file cannot be prevented by scope alone; future import must preview identity and freshness.

## 8. Acceptance checks before enabling persistence

1. Fresh character with no store: every learned slot unknown, no file created by opening/closing windows or disabling debug, first accepted binding saves only after a completed safe load state.
2. Two characters with distinct records, including same-name characters on different servers: neither reads/writes the other's records.
3. Save/load global defaults, reset ordinary options, change map/tab order, and unload: character milestone contents and IDs remain unchanged except an intentionally dirty milestone save.
4. Existing, missing, malformed and unsupported-schema files: record actual return/callback behavior; uncertain reads never trigger an empty overwrite.
5. Late callback and live observation during loading: draft is neither lost nor silently applied over a newer loaded binding.
6. Save failure, edits during an in-flight write, immediate reload and unload during save: saved/unsaved state and revision acknowledgement remain honest.
7. EN→DE/FR/RU client switch: numeric bindings round-trip unchanged; presentation resolves through catalogue fallbacks; no localized filename or stored name is needed.
8. Add/reorder/rename catalogue rows and apply reviewed upstream marker-ID changes: saved numeric destination IDs still refer to the same destinations.
9. Temporarily remove a referenced catalogue row: its numeric record survives as unresolved and resolves again when reference data returns.
10. Verify number/string codec round trips for actual game skill IDs, highest allocated destination ID, empty records, duplicate IDs, unknown IDs and numeric strings. Include a locale with comma decimal formatting even though identity fields are integers.

## Sources and scope

- Current repository `src/SettingsManager.lua`, `src/OptionsPanel.lua`, `src/TravelWindow.lua`, `src/Main.lua`, `src/VindarPatch.lua`, inspected 2026-11-14.
- [SSG DataScope reference](https://github.com/Goldbishop/Lotro_LUA/blob/fe36613c8a4f83e68089fbe135d455deb77b0db1/SSG/Turbine_DataScope.html), [Load](https://github.com/Goldbishop/Lotro_LUA/blob/fe36613c8a4f83e68089fbe135d455deb77b0db1/SSG/Turbine_PluginData_Load.html), [Save](https://github.com/Goldbishop/Lotro_LUA/blob/fe36613c8a4f83e68089fbe135d455deb77b0db1/SSG/Turbine_PluginData_Save.html), pinned mirror of SSG's beta API documentation. These pages were read directly from the pinned raw files when the browser fetch did not render them.
- Local `Plugins/Thurallor/SequenceBars/Manager.lua` callback/number-codec precedent; no dependency on SequenceBars is proposed.
- [Catalogue format and provenance](catalogue-format.md), [developer knowledge base](knowledge-base.md), [source-ID changes](evidence/2026-11-08-marker-id-changes.json), and the [current staged persistence design](specification.md#persistence-lifecycle-and-performance).

No plugin Lua, account defaults, saved character data, branch state or commits were changed by this research task. The only authored output is this developer note.
