# Milestone catalogue geographic enrichment

Date: 2026-11-14
Branch: `codex/milestone-learning-debug`, continuing the authorized catalogue prototype.

## Plan

1. Join all 351 existing markers to the pinned Companion `geoAreas.xml` and `dungeons.xml`. Extract actual XML element types, parent chains, territory identifiers and icon provenance; keep raw coordinate-world codes distinct from geographic region ancestry.
2. Preserve every existing research GUID, numeric destination ID, source marker, coordinate and observed/wiki name. For the 55 records without a label, add a clearly classified area/dungeon fallback, or territory fallback when the source area has a placeholder name. Do not promote geography to an exact native destination name.
3. Extend the reproducible catalogue tooling and human-readable export with this context. Keep source hashes, counts, unresolved native names and placeholder cases in developer documentation. The author's Ilzag Khûl / Paths of Khegûl example is an explicit counterexample to equating destination and zone names.
4. Update only the debug result's quality label as needed. Geographic fallbacks must remain excluded from exact skill-name prediction and name-based identity resolution. Do not change travel, picker capture, chat parsing, persistence scope or global settings.
5. Verify complete joins, stable IDs/positions/names, typed hierarchy and deterministic regeneration. Run the existing offline Lua/capture/persistence checks; distinguish these from live game acceptance. Leave implementation and generated evidence uncommitted for review.

## Acceptance

All 351 markers have reviewable geography and a display label, with the evidence class explicit. Exact destination-name coverage must not be inflated by geographic fallbacks. Missing or placeholder source names remain documented rather than invented.

## Implementation handover

Completed the typed join and generated catalogue version 2: 44 area, five dungeon and six territory fallback labels, with all prior names/IDs/positions preserved. Both pinned source XML hashes were verified against fresh public downloads. See the [developer report](milestone-management/2026-11-14-geographic-catalogue-enrichment.md) and [fallback review queue](milestone-management/catalogue-proposal/geographic-fallbacks.md). Offline Lua/capture/storage checks pass, including exclusion of all 55 fallback records from exact destination prediction. In-game checks of the new labels remain pending; only this plan's initial version was committed.
