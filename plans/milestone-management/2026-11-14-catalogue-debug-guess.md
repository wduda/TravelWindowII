# Runtime debug catalogue and location comparison

Implemented 2026-11-14 on `codex/milestone-learning-debug`. This remains behind `TravelDebugEnabled`, with optional [manual temporary checkpoints](2026-11-14-debug-persistence.md) and no production-view integration.

## Catalogue

[MilestoneCatalogue.lua](../../src/MilestoneCatalogue.lua) contains all **351** markers from the pinned research inventory: **38 observed/author-reported names**, **258 additional wiki-labelled candidates**, and **55 geographic fallback labels**. The [geographic enrichment](2026-11-14-geographic-catalogue-enrichment.md) supplies useful area/dungeon/territory labels for those last records while keeping their native destination names unknown. These fallback classes produce no exact skill-name prediction or picker row assignment. An observed anchor name does not make its spatial association to an object an explicit upstream link.

Records preserve signed object coordinates, raw world code, zone ID, area, territory, available icon, source marker ID, display label and name-evidence status. Wiki collisions/ambiguous associations are labelled. The 22 wiki rows without nearby markers remain research evidence; they are not invented as extra world-resolved objects.

TWII numeric destination IDs are allocated once in [numeric-id-ledger.json](catalogue-proposal/numeric-id-ledger.json), keyed by the existing research GUID. They do not depend on translated labels, array position, sorting or current source marker ID. Keep this ledger append-only; never regenerate it or reuse retired numbers. Source-ID changes require reviewed identity carry-forward first.

[debug-catalogue.csv](catalogue-proposal/debug-catalogue.csv) is the review export of all 351 IDs, labels, quality, coordinates and source identifiers. Regenerate it and the Lua catalogue with Python's standard library:

```text
python plans/milestone-management/tools/Build-MilestoneDebugCatalogue.py
```

The generator consumes persisted research evidence, without fetching live data or reading character settings. Rebuilding unchanged inputs must leave generated content and IDs unchanged.

## Debug interaction

Enable `/trav debug on`. Location capture is available through the learned-skill picker and the **explicit manual LOC test quickslot in the debug window**. The latest clarification restores that manual test action; regular views continue casting their real skills.

The picker trial switches its displayed skill to `/trav milestone-capture <skillId> <token> ;loc` on MouseDown (`;pos` for German). The handler requires debug mode, the active picker, matching selected skill/token, a learned skill and a fresh request. Close, debug-off and unload discard requests. Its native event ordering is still unverified; see the [trial acceptance procedure](2026-11-14-mousedown-trial.md). Malformed/literal expansion shows raw text and a parser diagnostic.

The manual test quickslot always contains `/trav milestone-guess <window-token> ;loc` (`;pos` for German). A physical click arms its request without changing that Alias. Its handler checks the active visible debug window/token and a 30-second lifetime. Close/debug-off/unload invalidate requests; missing expansion times out with a retry message. It samples current position without selecting or assigning a milestone skill.

The large debug window also has an **Open picker** button beside LOC. It calls the existing picker-opening function, so a closed picker can be reopened with fresh real skill shortcuts and number badges at the right-side position. The picker now explicitly says to click the same icon twice; below-icon labels are removed and row spacing is compacted. The first press shows selection/waiting status and installs the Alias; the second reuses the Alias/token for capture. A valid returned location updates the result and closes the picker on the next UI update, after native command dispatch. The stakeholder verified the earlier two-click capture/location path; this revised layout, row assignment and closure still need a fresh client check.

| Interaction | Behavior |
|---|---|
| Regular travel views | Cast the real skill; remember the last clicked milestone for successful-use reconciliation. No `;loc` or Alias replacement. |
| Learned-skill picker | Click twice: select/install the Alias, then capture location, record a clear named guess for the selected skill and close after delivery. |
| Debug-window LOC | Explicit manual current-position test, independent of skill binding/travel evidence. |

Results show the raw sample and **only the calculated closest marker**: numeric ID, label/evidence quality, distance, area, territory, world and object coordinates. Picker captures include the selected skill; manual captures say no skill was selected. Other nearby records remain internal to uncertainty detection and are not listed. A clear named picker match also sets the selected skill's session destination and numeric catalogue ID, displayed in the table with **[guess]**. Manual LOC does not set skill rows. Unknown-world, distant, ambiguous or unnamed matches remain diagnostics and leave the prior row unchanged.

`TrackMilestoneQuickslotClick` only remembers ordinary travel clicks; the matching successful-use message replaces that skill's session destination and removes the guess marker, confirming or correcting the inferred value while leaving other skills untouched. An existing catalogue ID survives an exact destination-text match; otherwise an unambiguous exact catalogue name can supply a new ID. Unknown or ambiguous text remains unresolved rather than retaining a stale ID. This observer never changes the travel shortcut or requests location.

The same result field includes **Predicted skill (English)**, built as `Return to <destination> (<territory>)`. For marker #194 this is `Return to Hobbiton-Bywater (The Shire)`. This follows the Companion author's explained native-name structure; it is a prediction for comparison, not proof of every catalogue label/territory or a localized skill-name API. Wiki-derived names keep their quality warning; unnamed, conflicting or spatially ambiguous wiki labels do not produce an invented skill name. Picker-derived row values are guesses, not successful-use evidence. Manual checkpoint commands save only numeric IDs/evidence, never these displayed names.

Distances are Euclidean in game coordinate units, not metres. The provisional **0.15** radius is a debug screening value, not a calibrated acceptance rule. Multiple nearby markers are ambiguous; if none are nearby, nearest entries are comparison-only. The picker can set a clear session guess, but this does not approve it as a production binding, change the game binding or save it automatically.

## World and language limitations

The debug resolver recognizes source-backed English labels: Eriador→1, Rhovanion→2, Gondor→3, Mordor / Gondor (After Battle)→4, Haradwaith→5, Mordor (Outer)→6, Tales of Yore→14. Companion region names come from pinned `geoAreas.xml`; inspected MoorMap `Main.lua` near 5900 supplies the inline Mordor→4 precedent. These mappings still need current-client samples, especially story variants/world 6.

Unknown/localized world text shows an unresolved-world warning and the closest marker calculated across all worlds. Familiar names do not establish full locale coverage. Parsing accepts decimal points/commas, N/S, E/W, German O-east, French O-west, and colons within area names. Actual EN/DE/FR/RU/ES expansion formats remain to be collected.

Area text is displayed for human corroboration rather than used as a hard filter: boundaries, translations and story variants are not calibrated. A newer client can differ from a source mapping. Compare raw text, world and coordinates before extending it. Numeric catalogue identity is independent of these display/parser limitations.

## Persistence research

The requested subagent's [character-only storage recommendation](2026-11-14-character-storage.md) requires a dedicated Character-scope store outside options/account defaults, explicit unknown/empty/load-failed states, numeric skill-ID→destination-ID records, and guarded completion-aware saves. [Temporary manual checkpoints](2026-11-14-debug-persistence.md) now implement the disposable debug subset. Raw chat/location names remain session-local diagnostics; only numeric records are saved on explicit command.

## Validation and in-game check

Stakeholder report, 2026-11-14: the manual LOC button selected the correct closest marker with a correct name at **at least three milestones**. The specific locations/raw samples were not supplied. This supports the tested manual path; it does not establish full catalogue coverage or the picker's native MouseDown behavior. Following that report, output was simplified to the closest record only without changing distance matching or uncertainty detection.

Further stakeholder evidence: Hobbiton-Bywater (#194) was reported as closest at distance 0.0025, with object coordinates `-31.40240, -71.10068`, territory The Shire, world 1. The character's raw captured coordinates were not supplied. The screenshot/report confirms native hover, number badges and click-time Alias replacement in the picker, but the picker remained open showing the Alias. It does not establish command delivery or its cause. The stable-Alias second-click retry addresses one plausible cause: repeatedly replacing the Alias can prevent native activation.

Subsequent stakeholder report, 2026-11-14: **the picker needs two clicks, works, and shows debug data with the correct location identified**. This supersedes the earlier unknown command-delivery status for the reported two-click path. It does not identify the tested destination/raw sample or establish automatic closure, all edge cases, other languages, or single-click feasibility.

Offline checks compiled **42** plugin Lua files under Lua 5.1 and exercised numeric-ID uniqueness, named proximity, world-3/world-4 separation, unknown-world ambiguity, no-nearby results, colon-containing context, request/expiry/replay/debug-off/close handling, and previous bind/use paths. Generation is checked for byte-identical regeneration and unchanged IDs. These checks do not establish native UI or Alias expansion behavior.

1. Reload TWII, run `/trav debug on`, stand near a milestone and click the debug window's LOC test button. Confirm raw location plus useful labels/IDs appear without travel/cooldown.
2. Repeat the manual test near another milestone, then return to the first and confirm its ID is unchanged. Also bind a milestone and test the picker path.
3. Try wiki-only and unnamed locations; inspect quality/context rather than expecting exact native names.
4. Compare overlapping Gondor variants and preserve raw expansion if the resolver is wrong/unresolved.
5. Use **Open picker**, check the two-click instruction and number-only icons, then hover a real skill. Click twice on the same icon: the first selects, the second captures. Confirm the predicted name and selected row **[guess]** appear, then the picker closes after delivery. Reopen it for fresh native hover. Verify an unclear match leaves the prior row alone with a diagnostic.
6. Verify ordinary travel still casts normally and reconciles the successful-use table without requesting location. Manual LOC must not overwrite those skill records. Test Classic/Mini, close/reopen, debug-off and reload: only an explicit checkpoint save/load should carry numeric bindings across reload.
