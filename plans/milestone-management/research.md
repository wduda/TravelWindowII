# Milestone management research

**2026-11-09 design update:** the stakeholder selected [bind-time proximity capture and automatic self-healing on successful use](../2026-11-09-milestone-proximity-and-self-healing.md). This supersedes earlier undecided auto-repair statements. The marker inventory and name-origin findings below remain evidence snapshots; name/translation coverage is still incomplete. The stakeholder reports contacting LotroCompanion about that gap. No outreach or plugin behavior change is part of this documentation update.

Original research date: 2026-09-25. That pass covered source inspection, public-data analysis, and reference-video inspection, without in-game experiments or plugin implementation. Recommendations are proposals for stakeholder review.

**Follow-up evidence (2026-11-08):** the [findings and developer requirements supplement](2026-11-08-findings-and-developer-notes.md) records stakeholder-reported prototype acceptance, a real character export, a refreshed 351-marker inventory, seven changed marker IDs at identical world coordinates, and MoorMap's static milestone annotation model. Its source/data snapshots supersede older inventory totals for current-data discussion. The pinned September audit and its camp-site/projection calculations below remain historical and have not been silently refreshed. The current debug implementation is on a separate branch and has no milestone persistence.

## Findings that change the design

1. **Manage knowledge about bindings, not the game's bindings themselves.** A plugin record can be wrong while the game skill works correctly. The product needs an explicit distinction between recording a destination and binding a skill at an in-game milestone.
2. **The successful-use chat line identifies the clicked skill's dynamic destination.** The stakeholder has verified two messages: `Kyareth applied a benefit with Return to Nashûbu (Idagâl, the Dry-whelm) on Kyareth.` and `Kyareth applied a benefit with Return to Ingarûma (The Hatokáli Fells) on Kyareth.` The stakeholder confirms this appears only after quick travel succeeds. Pair the chat destination with the exact skill ID of the clicked TWII quickslot to identify both sides; regional-channel inference is unnecessary for this path. E04 still needs ChatType, locale, duplicate/order and parser-boundary details.
3. **Companion import is concrete, but requires a bridge.** Its client extractor reads travel records and its character storage writes `anchors.xml`, including travel type, name, region, latitude, longitude, and optional zone ID. No TWII importer or ready-to-use milestone export was found in the inspected Companion plugin.
4. **The catalogue is not a ready-made list of destination names.** A complete scan of the pinned map-marker dataset found 339 category-55 records, all labelled `Milestone`. Naming and disambiguation require additional sources or curation.
5. **Neither marker IDs nor template IDs are sufficient permanent identities.** Companion's marker IDs are allocated within geographic blocks; the 339 records share just 14 object template DIDs. TWII needs its own stable destination keys and a migration ledger.
6. **World regions, geographic-area hierarchy, and TWII map IDs are different namespaces.** Same coordinates occur in different world regions. Interior records and story versions require explicit handling.
7. **Learned milestone skills can be enumerated independently of slot numbering.** TWII already obtains the player's trained-skill list and matches learned skills against its known travel shortcuts. The stakeholder confirms skills cannot be unlearned, though players can skip slot numbers. The fast path can therefore count the actual learned milestone entries; it must not assume a contiguous progression. This does not mean the generic bind message itself identifies the slot.
8. **The supported skill catalogue must respect explicit exclusions.** TWII and installed Voyage have 11 entries. The pinned skill dataset defines Return Home 1–16, while TWII's `data/skill_input.toml` explicitly ignores 12–16. Definitions alone do not establish that additional skills should be presented as learned or justify undoing those exclusions.

## Evidence classifications

- **S — source-confirmed:** present in inspected source/data; says nothing by itself about current runtime acceptance.
- **D — documented:** primary author/API/release documentation; version and age matter.
- **V — video-observed:** visible in the supplied recording, not a test of the current client.
- **H — hypothesis:** plausible and testable, not established.
- **P — proposal:** a product/engineering recommendation, not an existing capability.

## 1. Current TWII architecture (S)

Baseline commit: `5a06283991a57e63cb7db3bb37170521ce7f92a5`, local `v4.11.0`. Research branch creation does not update this baseline from another remote branch.

| Concern | Source | Consequence |
|---|---|---|
| Known milestone skills | [SkillData.lua](../../src/SkillData.lua), lines 3655–3789 | Eleven explicit skill IDs, generic category, `MapType.NONE`, level-sort value 1. Beorning also has a different skill named Return Home. |
| Learned-skill matching | [TravelShortcut.lua](../../src/TravelShortcut.lua), `MatchSkillInfo`, `FindSkill`, lines 478–501 | Uses localized name plus an optional description substring. A destination label must not replace the canonical skill name used by matching. |
| Startup sequence | [Main.lua](../../src/Main.lua), lines 19–43 | Trained skills, dictionary, settings, labels, then shortcuts. Character binding data must be available before effective labels/map placements are built. |
| Chat integration | [TravelWindow.lua](../../src/TravelWindow.lua), lines 44–50 | Existing additive chat listener watches Advancement for learned skills. Add a separate listener/service; do not overwrite this callback. |
| Labels | [IndexedDictionary.lua](../../src/IndexedDictionary.lua), `SetSkillLabel`; [TravelShortcut.lua](../../src/TravelShortcut.lua), getters and constructor | Skill/list labels, zone/tag preferences and normalized sort labels all need coherent refresh. Native game tooltips are a separate surface. |
| Sorting | [TravelShortcut.lua](../../src/TravelShortcut.lua), lines 373–419 | Name, label, level, and saved custom order are distinct. Destination-level sorting must not change the skill's acquisition level or silently destroy custom order. |
| Map render path | [TravelMapTab.lua](../../src/TravelMapTab.lua), lines 599–711 | Map rendering traverses class, reputation, racial, or creep locations. Merely attaching a map field to a generic milestone will not add it to this traversal. |
| Map tray | [TravelShortcut.lua](../../src/TravelShortcut.lua), `InitMapTray`/`AddNavPanelSkills`; [TravelMapTab.lua](../../src/TravelMapTab.lua), lines 778–837 | Tray membership is initialized from `MapType.NONE`/allegiance. A binding change needs explicit re-evaluation or a policy retaining all milestone shortcuts in the tray. |
| Skill activation surfaces | [TravelMapTab.lua](../../src/TravelMapTab.lua), `AddSingleShortcut`/`AddPanelQuickslots`; [TravelGridTab.lua](../../src/TravelGridTab.lua); [TravelPulldownTab.lua](../../src/TravelPulldownTab.lua) | All relevant views require consistent attempted-travel observation. A mouse event is not cast completion. External game hotkeys are not covered by TWII mouse handlers. |
| Character vs account storage | [SettingsManager.lua](../../src/SettingsManager.lua), lines 290–318 and 501–533 | Account defaults and character overrides are both loaded. Bindings must never propagate through account defaults/reset/import behavior. |
| Persistence format | [VindarPatch.lua](../../src/VindarPatch.lua) | Existing wrapper transforms numbers/strings and non-ASCII text. A new nested schema needs round-trip checks, including IDs and Unicode. |

The baseline's map mode already exists (`TabId.MAP = 5`); the historical idea of first making maps a full mode is not automatically a remaining dependency. UI acceptance is still separate from source existence.

The generator is outside this checkout: [whiterabbit963/twii_miner](https://github.com/whiterabbit963/twii_miner/tree/00367826c51e42045452bca0d93381f0c11909b6), pinned to a 2026-06-28 commit. The local [data/skill_input.toml](../../data/skill_input.toml) is its curated input. `src/LocaleData.lua` is generated game data; keep curated UI strings and destination overrides separate.

### Existing generator and the extension boundary (S, P)

The inspected C++20 tool loads Companion `lotro-data` and `lotro-items-db`, merges curated skill inputs, then writes `skill_input.toml`, `SkillData.lua` and `LocaleData.lua`. [SkillLoader](https://github.com/whiterabbit963/twii_miner/blob/00367826c51e42045452bca0d93381f0c11909b6/src/skill_loader.cpp) reads travel-skill IDs/categories/description keys and localized labels. Its inspected travel-skill loop does not retain `travelType`; explicit skill-to-anchor mapping would be an addition.

[Skill input merging](https://github.com/whiterabbit963/twii_miner/blob/00367826c51e42045452bca0d93381f0c11909b6/src/skill_input.cpp) supplies map pixels, aliases, level ordering and other curated fields. A comment still identifies map-location extraction from XML as future work. This is not an existing physical-position/arrival-envelope pipeline. The local TOML deliberately puts Return Home 12–16 in `[[ignore]]` and slots 1–11 in the generic group with no map placement.

**Proposed extension:** prefer a separate milestone-catalogue output mode in this existing tool if its maintainer agrees, sharing source/locale handling while adding `lotro-maps-db`, geographic/dungeon joins, a durable destination-key ledger and curated placement/name overrides. Keep character bindings entirely outside generated global skill metadata. A separate small extractor remains viable if ownership/build dependencies make extending the C++ tool undesirable. This is a maintenance decision, not a runtime dependency.

The [update wrapper](https://github.com/whiterabbit963/twii_miner/blob/00367826c51e42045452bca0d93381f0c11909b6/update_twii.sh) pulls data repositories, runs the miner and copies its current outputs into TWII. It was inspected, not run. A milestone-only workflow should pin input revisions and stage its distinct output for review; it should not invoke this wrapper to overwrite unrelated generated skill/locale files. No generator build or output generation was performed during research.

## 2. API and detection feasibility

| Proposed capability | Evidence | Assessment and boundary |
|---|---|---|
| Identify a chosen TWII quickslot's skill ID | S: `Shortcut:GetData()` throughout TWII | Strong identity for that control. Does not prove a successful action. |
| Obtain a skill ID by dragging a skill into a capture slot | D: [Garan's direct explanation](https://www.lotrointerface.com/forums/showthread.php?t=2072), 2013; S: existing drag/drop ID use | Useful alternative to remembering slot numbers. Validate current event payload and reject non-milestone skills. |
| Enumerate learned skills and find learned milestone slots | S: `Main.lua` reads `LocalPlayer:GetTrainedSkills()` when available; `TravelShortcut.lua` scans that list and marks matching shortcuts `found` using known names/descriptions; S: each TWII travel shortcut has its own `Shortcut:GetData()` ID. Stakeholder confirms multiple learned-skill identification has worked reliably in the existing codebase for a long time. | Reuse the established matcher and learned set; this is not an open feasibility question. Keep the existing mapping between TWII skill IDs and learned skill objects. |
| Read the bound destination from skill description | H | Static game labels contain only the generic description prefix. That does not establish whether current `GetDescription()` includes the tooltip's dynamic destination. This is the first runtime experiment because success could simplify the design substantially. |
| Notice that a milestone was bound | Stakeholder-confirmed English text; current delivery details still need runtime capture | The stakeholder confirms “This location is now bound to your milestone skill.” A public 2021 capture corroborates it. The message identifies neither slot nor destination. Current ChatType, localized DE/RU text, duplicate behavior and timing still need runtime verification. |
| Ask for location with a user click | S: MoorMap alias quickslot and chat parser | Strong feasibility. EN `/loc`, DE `/pos`, FR `/emp` appear in source; RU/ES `/loc` also appear, with comments indicating some assumptions. Validate all supported clients. |
| Run `/loc` automatically or activate a skill from Lua | No established supported path | Design around a real user quickslot click. The [official Update 24 documentation page](https://www.lotrointerface.com/downloads/info1035-OfficialUpdate24LuaDocumentation.html) includes a developer response confirming custom quickslots cannot be programmatically activated in that API generation. Recheck current API before relying on any extension. |
| Read cooldown/reset time | D: [API documentation update](https://www.lotrointerface.com/downloads/info997-UpdatedLuaDocumentation.html) lists ActiveSkill methods/events | Can be investigated as supporting evidence. Shared milestone cooldowns may make several skills change together; cooldown alone must not identify a slot or prove arrival. |
| Infer area from regional channel entry | S: installed TitanBar; D: [author's description](https://www.lotrointerface.com/downloads/info692-TitanBar.html) | Coarse conditional evidence. Missing/disabled channel notices or same-area travel produce no reliable negative evidence. A changed area does not prove milestone travel. |
| Infer exact destination from fresh coordinates | S: coordinate data and MoorMap matching; H: arrival tolerances | Rank candidates only within compatible world/interior context. Require measured tolerance, candidate separation and action timing. Location alone does not establish a binding. |
| Observe all native hotbar activations | Not established | External casts may be unattributable. Never infer the slot from whichever row was last selected in the manager. |

The [official Update 8 notes](https://www.lotro.com/update-notes/lotro-update-8-release-notes-en) establish the introduction of client-language and trained-skill access, not a complete current API contract. Historical [skill lookup discussion](https://www.lotrointerface.com/forums/archive/index.php/t-3705.html) also distinguishes quickslot data from SkillInfo lookup. Negative conclusions here mean “not established in inspected sources,” not a proof that no newer API can exist.

### Additional historical evidence worth testing now

The stakeholder confirms the English bind text: “This location is now bound to your milestone skill.” The public [2021 skill-chat capture](https://gist.github.com/wduda/64303b4c84d9d148b664b3bd07f0c852/61aa14e36a1204b68e59a32d5f85dbd21df91d1d) corroborates it. The text carries no slot or location. Current ChatType, timing/duplication and DE/RU variants remain E02 questions. The neighbouring acquisition messages must not be mistaken for a binding signal.

The [official Update 2 notes](https://www.lotro.com/update-notes/lotro-update-2-release-notes-en) describe native milestone selection, destination-dependent icon changes and more specific examination information. The [Update 9 notes](https://www.lotro.com/update-notes/lotro-update-9-release-notes-en) describe destination/region text in the native skill name. These are evidence of game UI behavior in 2011–2012, **not** evidence that Lua's `GetName()` or `GetDescription()` exposes the same text today. E01 should compare native examination, existing SkillInfo objects, and freshly fetched SkillInfo objects after a rebind. A cached object could otherwise produce a misleading negative result. A regional icon, even if readable, would not uniquely identify a milestone.

The stakeholder's [Skill Explorer by Garan](https://gist.github.com/wduda/4b7a7ad21c88d955b1b2b9a240303934) constructs quickslots from a range of skill IDs and displays those IDs. It does not enumerate learned skills or read dynamic bindings. It may assist a later authorized ID/tooltip experiment, but is not a solution to E01 by itself.

## 3. Reference implementations

### Voyage by Homeopatix (S, V)

The installed `Homeopatix` folder contains Voyage 3.48. The archive downloaded from the supplied [LOTROInterface page](https://www.lotrointerface.com/downloads/info1125-Voyage.html) on 2026-10-15 identifies itself as 3.49 in both manifests, while the page text still lists 3.48. The downloaded archive SHA-256 is `E941038EF32F1BAFEFF2D08800F207EF661CB602B5E129B5BBFBD70E3E32CD9D`; treat the page's version text as stale until confirmed by the publisher. The 3.49 `OptionsWindowTeleport.lua` is byte-identical to the installed 3.48 copy (SHA-256 `E3DB3F29DB266D19700A643DFA8289B0143E3A00456B9532A8CBA42D22112E75`), so the existing manual-selection findings remain valid for that file.

- `Voyage/OptionsWindowTeleport.lua:20–243`: choose a broad region and a destination from region-specific checkboxes, then store a numeric catalogue index in `settings["Teleport_" .. slot].value`.
- The inspected selection loops cover indices 1–270. They assign every checked index in turn, so the final checked index wins if multiple remain checked. TWII should use a single-selection list and a visible before/after preview.
- `Voyage/DATA_EN.lua:613–627` and the parallel localized data files: destinations are positional catalogue entries with map asset IDs and image pixel coordinates. A persisted number is coupled to list ordering; portable TWII records should use stable destination identity rather than an ordinal.
- `Voyage/UI.lua:193–255`, `MapWindow.lua:203–255`: right-click opens the map and marker for the destination recorded in Voyage. This reads the plugin's record; it does not validate the game's actual binding.
- The downloaded 3.49 `Init.lua:17–25` expands the shortcut capacity from 140 to 196 and raises the Hunter, Warden, Mariner, and reputation destination counts. `LoadAndSave.lua:304–325` updates those counters, initializes missing slots, and preserves the saved shortcut arrangement when `keepShortcuts` is true. When that option is false, it clears the shortcut data on a catalogue-count change before requesting a grid-size check. Older pre-U35 settings still take a full reset path. This is a useful example of a gated data migration, with explicit preservation policy and initialization of newly added fields; it is not a migration design to copy wholesale.
- The 3.49 source still contains no `Turbine.Chat` listener, chat-received handler, or trained-skill enumeration. No automated milestone-binding detector was identified. Static source inspection cannot establish runtime compatibility.

### Voyage follow-up source review (2026-10-15)

The 3.49 download adds no new milestone-binding feature over the installed 3.48 source. Its useful additional lesson is migration behavior: when expanding its catalogue, it separates a player's opt-in shortcut preservation from initialization of the newly allocated slots. For TWII, the transferable principle is to keep stable records and initialize additions without silently replacing reviewed bindings or custom order; the specific ordinal catalogue and reset behavior are not suitable templates. The supplied page's version mismatch and this source comparison are recorded above; no plugin files were changed and no in-game behavior was tested.

Video: `C:\Users\wojci\Downloads\20250327-2019-26.9265884.mp4`, 27.287 seconds, 970×854. Twelve sampled frames were inspected: roughly 0–4 seconds show skill/options selection, 4–11 seconds region/destination selection and return to options, 18–23 seconds the shortcut grid, and around 25 seconds the map preview. The recording is useful for interaction structure, not detection or present-day compatibility. No audio claims are made.

### MoorMap 1.66 (S)

Installed source under `GaranStuff/MoorMap`:

- `Main.lua:1546–1593`: movable prompt with a real alias quickslot.
- `Main.lua:3218–3316`: locale-aware location parsing, including region, landblocks, offsets, optional instance marker, and interior formats. Standard chat is used in normal operation.
- `Main.lua:3316–3389`: world-coordinate conversion, nearest-cache matching with threshold `0.2121`, recording of unmatched positions, and support for marking the same cache on multiple maps.
- `Main.lua:3588–3597`: chat-triggered treasure prompts. Some branches also accept Tell; this is not a precedent for trusting arbitrary player messages as milestone evidence.
- `Main.lua:704,3825`: callback removal/registration.

Borrow the **interaction pattern**: event → small prompt → explicit location click → suggestion → recoverable record. Do not copy the treasure threshold, its message trust rules, or its “each cache once per character” assumptions into rebinding logic. Milestones can be rebound repeatedly.

MoorMap's readme contains historical storage restriction claims; treat those as historical implementation context, not authoritative current PluginData behavior.

### Additional references found during research (S, D)

Installed `Vinny/TravelRef` 3.3 has manual slot/location assignment and character persistence (`TR_Window.lua:356–378`) plus a `/tr ms` listing. Its [public page](https://www.lotrointerface.com/downloads/info524-3.3.1.html) describes routing that incorporates milestones. The inspected path assigns a record, not an actual in-game binding. This supports keeping route optimization outside TWII's initial scope.

Its installed `TR_Data.lua:4502–4503` also illustrates a concrete identity hazard: the `Miles` array contains twelve IDs, while `TR_Window.lua:30` offers slots 1–11. Array entries 7–12 map to Return Home 16, 10, 9, 8, 7, 11 in the pinned skill definitions. This is a source discrepancy, not an in-game test or a claim about the newer public release. Do not copy that array or infer milestone IDs arithmetically.

Installed `HabnaPlugins/TitanBar/Control/PlayerLoc.lua:54–84` listens for Standard-channel area-entry messages using English, French and German patterns. It supplies concrete source evidence for regional notices, while requiring current-client verification of exact text and channel prerequisites. Do not assume the installed, locally evolved source is identical to its old public release.

## 4. Catalogue audit

Pinned sources:

- [lotro-data](https://github.com/LotroCompanion/lotro-data/tree/c1833140af7ec41bab1853c676c671079291e7a5), commit dated 2026-09-19.
- [lotro-maps-db](https://github.com/LotroCompanion/lotro-maps-db/tree/063030b40ce85d173593de2e73cb7edde6ae1b53), commit dated 2026-09-02.

A full scan of all 445 `markers/*.xml` files processed 4,354,284 marker records, with zero fetch/parse failures. Category 55 is explicitly named Milestone in `categories/categories.xml`. The scan found **339 milestone marker records**, not 339 runtime-verified bindable destinations.

| World coordinate region | Records |
|---|---:|
| 1 | 96 |
| 2 | 98 |
| 3 | 25 |
| 4 | 61 |
| 5 | 58 |
| 14 | 1 |

All 339 have generic `Milestone` labels, DIDs, parent-zone IDs, and latitude/longitude. They reference 240 distinct parent-zone IDs; 71 parent zones contain more than one milestone. Five parent IDs are absent from `geoAreas.xml` but resolve in `dungeons.xml`: Gath Forthnír, Thorin's Hall, Hall of Vérnozal, Annâk-khurfu, and Vestibule of Utug-bûr. Therefore, joining geographic areas alone is incomplete and area names alone are not unique destination names.

No identical coordinate pairs occur **within the same region** in this snapshot. The closest same-region pair is about 0.8616 coordinate units apart. Identical coordinates **across different regions** do occur. These findings do not establish an arrival tolerance or prove there are no missing/overlapping in-game destinations.

`geoAreas.xml` names region 4 Gondor (After Battle), while older MoorMap comments call it Mordor. Some region-4 markers join through Mordor Besieged or other story areas to a geographic hierarchy headed by Rhovanion. Retain raw coordinate-region codes independently of display hierarchy; do not overwrite them by walking geographic parents.

The dataset includes region 6 in the geographic definitions but the pinned marker snapshot has no category-55 records there. This is a coverage observation, not a statement that the live game has no such milestones.

Detailed derived records and audit metadata are in [catalogue-audit.json](catalogue-audit.json). This is research evidence, not a deployable catalogue. The scan retained milestone facts and source metadata, not the roughly 656 MB of raw marker XML.

### Camp-site classification cross-check

The upstream [duplicate merger](https://github.com/LotroCompanion/lotro-tools/blob/7f8069b4382daabb4b3131b3d68adb6a9100106a/src/main/java/delta/games/lotro/tools/extraction/geo/markers/MarkerDuplicatesRemover.java) groups records by DID within a landblock and merges identical positions. Its category resolution retains Camp-site (57) when resolving Milestone (55) against Camp-site. The [classifier](https://github.com/LotroCompanion/lotro-tools/blob/7f8069b4382daabb4b3131b3d68adb6a9100106a/src/main/java/delta/games/lotro/tools/extraction/geo/markers/classification/MarkerClassifier.java) also demonstrates that the object type named Milestone includes campfires; that type alone cannot identify player milestone stones.

This tools revision is newer than the pinned marker snapshot. The exact producer revision of that snapshot was not established, so this source rule is a pipeline caveat, not proof that particular snapshot records were merged by that version.

A second complete scan of the same 445 marker files found **137 category-57 records**, with zero failures: 129 labelled Camp Site Fire and eight Camp-site, using seven template DIDs. None shares a template DID or an exact same-region coordinate with the 339 category-55 records. This is **not evidence of 137 missing milestone destinations**. It establishes why an upstream category label cannot prove live bindability or exhaustive coverage. Keep camp-sites excluded unless independently identified as actual milestone destinations. A future extractor should retain classification provenance where available and review unexplained category changes, rather than broadly including both categories.

### Identity and update pitfalls

[GlobalMarkersManager](https://github.com/LotroCompanion/lotro-maps/blob/2c50cc98d60ebd7b2f880ec124f7e8b4fd2934cf/src/main/java/delta/games/lotro/maps/data/markers/GlobalMarkersManager.java) packs region/block information into IDs. [LandblockMarkersManager](https://github.com/LotroCompanion/lotro-maps/blob/2c50cc98d60ebd7b2f880ec124f7e8b4fd2934cf/src/main/java/delta/games/lotro/maps/data/markers/LandblockMarkersManager.java) assigns sequential IDs to records without IDs and resets the counter on clear. There is no cross-release identity guarantee demonstrated by this algorithm. One region-14 marker has a negative signed integer ID. Preserve source IDs as strings and distinguish signed representation from identity.

Proposed extraction must produce additions/removals/moves/renames and unresolved associations for review. It must never migrate a saved binding solely because a new record inherited an old marker ID or array position. Template DID is provenance, not a unique destination key.

## 5. Coordinates and map presentation

MoorMap computes signed world coordinates from raw location values:

`east = (floor(lx / 8) × 160 + ox − 29360) / 200`

`north = (floor(ly / 8) × 160 + oy − 24880) / 200`

This is a source-confirmed formula, not a universal guarantee for interiors. Preserve original region, landblock, offsets, height, instance/interior markers, and sample time before normalization. The current exported milestone markers lack height and explicit instance metadata; interior ambiguity cannot be repaired by inventing those values.

TWII's overview maps use a 1024×768 logical canvas. MoorMap `Defaults.lua:124,152,269,562` has matching Eriador/Rhovanion/Gondor/Haradwaith assets and affine transform parameters. Rendering in MoorMap uses `x = east × factorX + offsetX`, `y = north × factorY + offsetY` (`Main.lua:3443–3444`). Haradwaith's parameters are expressly estimates. Overview placement for interiors or other world regions may need curated representative anchors instead of raw projection.

Use three separate concepts: physical milestone-object position, observed travel-arrival position, and representative overview-map position. Do not feed an overview icon's deliberately shifted collision-avoidance position back into geographic detection. Do not treat the map's logical ID as a coordinate region.

An arithmetic screening with those transforms produced the following counts. It excludes the five dungeon-parent records and only applies a transform to its declared coordinate region. Being inside the canvas does not establish geographic coverage or positional accuracy.

| Overview map | Eligible records | Centers inside 1024×768 | Outside |
|---|---:|---:|---:|
| Eriador | 94 | 90 | 4 |
| Rhovanion | 96 | 89 | 7 |
| Rohan | 96 | 40 | 56 |
| Gondor | 25 | 25 | 0 |
| Haradwaith | 57 | 46 | 11 |

Across overlapping overviews, 250 unique centers fall inside at least one compatible canvas; 89 are unscreened or outside all applicable canvases. Rohan naturally covers only a subset of coordinate region 2, so its out-of-bounds count is not a calibration failure count. Region 4 and 14 were not projected with another region's transform. Icon extents, geographic coverage, collisions and visual accuracy remain untested. This screening supports explicit partial-coverage policy, not shipping any inferred map placement without review.

## 6. Companion import

Primary sources:

- [TravelRegistryExtractor](https://github.com/LotroCompanion/lotro-data-extractor/blob/54afd8d6a4e063176754dca1e6a5356d09ad1769/src/main/java/delta/games/lotro/extractors/travels/TravelRegistryExtractor.java): reads a travel-type keyed record with name and DatPosition.
- [AnchorStatus](https://github.com/LotroCompanion/lotro-core/blob/55e0b936a7ba85293343aa08b766997e643b054e/src/main/java/delta/games/lotro/character/status/travels/AnchorStatus.java) and [AnchorsStatusIo](https://github.com/LotroCompanion/lotro-core/blob/55e0b936a7ba85293343aa08b766997e643b054e/src/main/java/delta/games/lotro/character/status/travels/io/AnchorsStatusIo.java): per-character anchor storage in `anchors.xml`.
- [AnchorsStatusXMLWriter](https://github.com/LotroCompanion/lotro-core/blob/55e0b936a7ba85293343aa08b766997e643b054e/src/main/java/delta/games/lotro/character/status/travels/io/xml/AnchorsStatusXMLWriter.java) and `common/geo/io/xml/PositionXMLWriter.java`: persisted fields.
- [TravelLink enum](https://github.com/LotroCompanion/lotro-data/blob/c1833140af7ec41bab1853c676c671079291e7a5/lore/enums/TravelLink.xml) and [skills.xml](https://github.com/LotroCompanion/lotro-data/blob/c1833140af7ec41bab1853c676c671079291e7a5/lore/skills.xml): non-sequential mapping between travel types and skills.
- [Companion Lua plugin](https://github.com/LotroCompanion/lotro-companion-plugin/blob/0ab1ee57355b7120b8a443d446dfa34d9b317c59/LotroCompanion/LotroCompanion/main.lua): inspected exports concern character/crafting/recipes/items, not an existing milestone bridge.

An `anchors.xml` root does not itself carry character/server identity or observation timestamp in the inspected writer. The converter must obtain those from the surrounding character metadata/import process or require explicit identification. File modification time is not proof of when the game state was observed.

A local converter producing a bounded, versioned text payload for paste/import is the recommended first bridge to evaluate. Alternatives are writing a dedicated PluginData handoff file (requires unload/reload and storage-format testing) or adding an upstream Companion export. Do not propose arbitrary filesystem reads, live network polling, or execution of pasted Lua inside TWII.

Companion provides a snapshot of a binding, not proof it remains current after a subsequent rebind. Distinguish import time, game-observation time if known, and user acceptance time. A fresh file containing old data must not overwrite newer in-game observations automatically.

## 7. Unresolved evidence, explicitly

- Exact current milestone bind messages and whether they contain any usable slot or destination identifier.
- Dynamic content of `SkillInfo:GetDescription()` before/after binding, reload, and locale changes.
- Whether a current supported API extension exposes additional IDs/events; no exhaustive live API enumeration was performed.
- Learned availability of milestone skills 12–16, including server/version differences.
- Current shared-cooldown event timing and whether cancelled casts alter reset times.
- Arrival offsets, interiors/layers, delayed loading, and same-area travel behavior.
- Complete milestone display names and live bindability, especially generic-labelled records.
- Catalogue source refresh cadence, maintainer agreement on extending the identified generator, and redistribution permissions for any copied implementation/data additions. The generator has an MIT license; this does not establish the terms of every reference plugin, game asset or upstream dataset. No blanket reuse conclusion is made.

The target decisions are Q1=B, Q2=A, Q3=A, Q5=A with a single-skill fast path, Q6=A, Q7=A, Q8=A, Q9=EN/DE/RU detection with English milestone UI copy for ES/RU, and Q10=defer character import. Q4's successful-use signal is stakeholder-verified at two destinations and only after successful travel; regional-channel inference is unnecessary for this primary path. Exact ChatType, locale variants, event/message ordering, duplicates and parser boundaries remain validation work. The user specified a medium, movable, mode-matched mismatch prompt with a saved position and right-side initial placement. The 2026-11-09 direction selects self-healing from this direct signal when exact skill/message attribution is trustworthy. Require revisions, undoable history and a clear low-intrusion explanation; ambiguous or stale evidence remains in manager review. Preserve exact observed destination text independently of unresolved canonical marker identity. These gaps become [runtime experiments](validation.md) or [stakeholder decisions](questionnaire.md), rather than assumptions embedded in code.

## Local snapshot fingerprints

Paths below are relative to the parent `Plugins` directory except the supplied video.

| Source | SHA-256 |
|---|---|
| Homeopatix/Voyage/OptionsWindowTeleport.lua | `E3DB3F29DB266D19700A643DFA8289B0143E3A00456B9532A8CBA42D22112E75` |
| GaranStuff/MoorMap/Main.lua | `158F4BFE56C73C2299B48DCCF524C63C4E4AD068FA7ED1F5ADE953228973241F` |
| GaranStuff/MoorMap/Defaults.lua | `6DAE9CBC72D4E8798AA1EB03A67FD2E60F66A9092D781D9A2DE4022C9E8EEAD0` |
| Vinny/TravelRef/TR_Window.lua | `C01C86405E63F4C791358A2A40C27617216912D01F87E3C1E39C48F3B507E454` |
| Vinny/TravelRef/TR_Data.lua | `727CB58558E870175F600AFBB58D1A4740B51032511BAD98636A07E7FF3FEEFC` |
| HabnaPlugins/TitanBar/Control/PlayerLoc.lua | `A791F89343964F76B0FB39E78AA7DE9E80A059CFA532F7BF1C7E21ADEE698237` |
| Supplied MP4 | `0312094E51340F8C62CBFC49968A3FC37C6CAB736829D7AAFC54ADC24CBD6679` |

The stakeholder's [discussion #224](https://github.com/wduda/TravelWindowII/discussions/224) establishes the original manual-catalogue/import idea and the desired text/map benefits. Discord excerpts are requirements input and hypotheses, not proof of API behavior.
