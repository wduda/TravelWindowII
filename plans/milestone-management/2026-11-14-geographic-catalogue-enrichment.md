# Milestone catalogue: geographic labels and complete context

Implemented 2026-11-14 on `codex/milestone-learning-debug`. This enriches the existing debug catalogue, not production views or character settings.

## Result

Every one of the **351 existing markers** now has a reviewable display label and a resolved area/dungeon → territory → region chain. The join supplies useful geography for all 55 previously unlabelled records, without claiming to recover their exact native milestone names.

| Display-name evidence | Records | Meaning |
|---|---:|---|
| Observed / author-reported native base name | 38 | Existing evidence retained; the association to a marker is still a spatial candidate. |
| Wiki label only | 258 | Existing candidates retained: 230 single-label candidates, one label collision, 27 ambiguous spatial candidates. |
| Area fallback | 44 | Area name displayed; native destination name remains unknown. |
| Dungeon fallback | 5 | Dungeon name displayed; native destination name remains unknown. |
| Territory fallback | 6 | Source area has a placeholder name, so the containing territory is displayed. |
| Total | 351 | No marker or destination ID was added, removed or reassigned. |

The [full CSV catalogue](catalogue-proposal/debug-catalogue.csv) contains all names, evidence classes, IDs, coordinates, source marker/template IDs, territory IDs, region IDs and available icon provenance. The [55-entry fallback review queue](catalogue-proposal/geographic-fallbacks.md) is the compact human-readable list of newly labelled entries. The [machine-readable audit](catalogue-proposal/geography-audit.json) records coverage and source hashes.

**Native-name completeness has not increased:** 313 records still lack an observed/reported native destination name. Geography makes these records useful to inspect without inventing that evidence. There is no claim that every datamined marker is currently accessible or bindable.

## What the marker join establishes

The source marker's `parentZoneId` is an explicit geographic foreign key. Look it up by exact ID in [geoAreas.xml at the pinned revision](https://github.com/LotroCompanion/lotro-data/blob/7097ff870cdeace51b7b34debc38b6a9969ae0c4/lore/geoAreas.xml), or in [dungeons.xml](https://github.com/LotroCompanion/lotro-data/blob/7097ff870cdeace51b7b34debc38b6a9969ae0c4/lore/dungeons.xml) for an interior. Follow the typed parent chain to the territory and region. A dungeon's parent here comes from its child `position` element's `zoneID`, with that relationship recorded explicitly.

This produces 346 `area → territory → region` chains and five `dungeon → area → territory → region` chains. There are no missing parents or unresolved marker-zone joins in this snapshot. The compact geography input contains 329 relevant entities, including all seven coordinate-region definitions.

The prior input accidentally duplicated the geographic name in `kind` for area/territory/region nodes. The new extractor uses the XML **element tag**, so code can select a territory by type instead of assuming a fixed hierarchy position. IDs, names and existing parent associations were preserved.

The first supplied icon along the existing hierarchy remains the debug icon, now accompanied by `iconSourceId`; 349 markers have one. A dungeon's `basemapId` is retained as research metadata and is not substituted for an icon. Missing icons remain missing.

## Why zone names are not exact milestone names

The Companion author's example is retained unchanged:

| Entity | Value |
|---|---|
| TWII destination ID | 288 |
| Source marker | 1450876936 |
| Template DID | 1879496037 |
| Zone | 1879487057 — Paths of Khegûl |
| Territory | 1879487114 — Urash Dâr |
| Icon | 1092947644, supplied by Paths of Khegûl |
| Observed native destination | Ilzag Khûl |
| Expected native skill text | Return to Ilzag Khûl (Urash Dâr) |

Using the zone name as the destination would incorrectly predict `Return to Paths of Khegûl (Urash Dâr)`. Across the 38 observed/reported names, only nine exactly equal their zone name; 29 differ. The author's account says the anchor name is read from the character's travel record in memory, while area/context/icon are computed separately. The geographic join does not expose that missing name field.

Marker 1467326471 is another marker in Paths of Khegûl without established native-name evidence. It gets the area fallback, not the nearby marker's Ilzag Khûl name. Markers must not be merged or assigned another name merely because they share a zone, label or template DID.

## Placeholder and world handling

Six records have source area names of `Unexplored Territory` or `TBD - …`: two use **Bree-land** as their fallback and four use **Hithaeglir**. The original placeholder remains in `area` and is flagged `sourcePlaceholder`; the fallback's source ID is separately available in the CSV. No settlement name is guessed.

The coordinate world and geographic ancestry are independent. **81 markers** have a coordinate-region entity different from their hierarchy's region ancestor, including story variants and festival geography. `worldRegion` and coordinates stay unchanged; `coordinateRegionId` and `geographicRegionId` retain both facts. Do not infer the coordinate world from the area ancestry or collapse identical names across worlds.

All newly extracted labels are English source text. No translations are invented, and labels are never destination identifiers. The numeric-ID ledger and persistence namespace remain unchanged.

## Debug behavior and storage boundaries

The debug output marks these records as **area label**, **dungeon label**, or **territory label**, followed by **destination name unknown**. Exact English skill-name prediction remains unavailable for them. The existing name-status allowlist excludes all three fallback classes from `GetMilestoneCatalogueDestination` and name-based identity resolution; a picker capture at such a marker remains diagnostic rather than assigning a fabricated destination.

The existing observed names and wiki candidates retain their prior behavior and quality warnings. Hobbiton-Bywater remains destination **194**. No normal quickslot, location capture, chat listener, matching radius, manual checkpoint command or global option was changed. Only the debug evidence label and generated catalogue were extended. Character checkpoints still store numeric identifiers only.

## Reproduction and validation

Use the two pinned XML files and the already supplied wiki snapshot:

```text
python plans/milestone-management/tools/Build-MilestoneGeography.py --geo-areas <geoAreas.xml> --dungeons <dungeons.xml>
python plans/milestone-management/catalogue-proposal/build_catalogue_proposal.py --wiki <supplied-wiki-snapshot.html>
python plans/milestone-management/tools/Build-MilestoneDebugCatalogue.py
```

The first command checks the XML hashes before writing. Both cached inputs were independently fetched again from the pinned public revision and matched byte-for-byte:

| Source | SHA-256 |
|---|---|
| lore/geoAreas.xml | 56016a45641aa65f5694e8fe4f48839bd16efbd3a4ab96913b91f338c86a9b2b |
| lore/dungeons.xml | 2a8af3a4291905db8cf6d40d6354750f0253fddf3f003fa0fab3a10748aa93bf |

Offline verification compared the previous catalogue with the rebuilt output: all 351 research/numeric identities, marker/template IDs, positions, area/territory/icon values, name evidence and wiki associations are preserved. The 296 previously populated debug labels and statuses are unchanged. Repeated generation is deterministic. Lua 5.1 compilation and the existing capture/persistence suite pass, with new checks that all 55 geographic fallbacks produce no native-name prediction; Ilzag Khûl and Hobbiton-Bywater remain intact.

These checks do not establish in-game accuracy of the newly labelled records or source completeness. A useful next client check is a previously unnamed location: LOC should show its geographic fallback and uncertainty, without inventing a skill name or replacing the selected skill's saved destination. Exact-name enrichment still needs new observed travel records/success messages or a separately discovered authoritative name source.
