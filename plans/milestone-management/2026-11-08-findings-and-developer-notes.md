# Milestone tracking findings and developer requirements

Date: 2026-11-08. This supplement records evidence obtained after research draft 0.16: the debug prototype's reported in-game results, refreshed Companion data, an actual character export, and MoorMap's milestone annotations. It supplements [research.md](research.md), [specification.md](specification.md), and [validation.md](validation.md). The September catalogue audit remains a historical snapshot.

**Further follow-up:** [Name origin and named database](2026-11-08-name-origin-and-database.md) traces client-memory import and builds a 37-destination named subset from 12 character snapshots plus the Echad Vothui observation. The earlier 11-skill example below remains a specific snapshot, not the full named input set. Repeated snapshots show differing anchor coordinates at the same destination; a single fixed arrival point is therefore not established. The unknown-name markers remain excluded from the named database.

## 1. Status and scope

**Verified data/source facts** below come from inspected files. **Reported runtime results** come from the stakeholder's in-game observations, not an independently controlled test run. **Hypotheses** and **proposed requirements** are identified explicitly.

The current execution slice is on `codex/milestone-learning-debug`, originally created from main while preserving this research branch. It is smaller than the full draft-0.16 iteration 1a: debug-only bind-slot selection, successful-use diagnostics, and an in-memory text table. No location-command capture or accepted production binding is implemented by this slice. No milestone persistence, production labels, map placement, repair, or Companion import is authorized by this documentation update.

The agreed larger delivery order remains: establish tracking in the diagnostic workflow; add successful-use repair; integrate trusted records into production text views and finally map view. Character-specific Companion import remains a later convenience feature. Static catalogue extraction remains useful independently of that import feature. Automatic repair is still undecided.

## 2. Debug prototype and runtime evidence

### Binding and skill identity

- The English bind confirmation is `This location is now bound to your milestone skill.` It identifies neither slot nor destination. It is different from learning/acquiring a skill.
- The debug picker says `Pick newly set milestone skill` and offers the actual learned milestone skills. Selection must identify the chosen skill, print a debug line, and close the picker without activating travel.
- The stakeholder successfully selected Milestone 5 and received `Milestone debug: Milestone 5 (Return Home 5, skill ID 0x70025795) was set.`
- A later runtime report found that selecting the picker activated travel. A select-only click overlay was added in the execution worktree; this supplement does not claim that its final behavior has been separately accepted in-game.
- Existing learned-skill identification, including characters with multiple milestone skills, is stakeholder-confirmed established functionality. Count the actual learned entries; gaps such as slots 1 and 3 are valid. Skills cannot be unlearned according to the stakeholder. Do not add a new learned-count feasibility gate.
- The approved future single-skill path skips slot selection when exactly one milestone skill is learned. After location capture, show the suggested location and ask for confirmation. This does not authorize automatic saving in the present debug slice.

### Successful use

The stakeholder supplied these successful-use lines and confirmed that they appear only after quick travel succeeds:

```text
Kyareth applied a benefit with Return to Nashûbu (Idagâl, the Dry-whelm) on Kyareth.
Kyareth applied a benefit with Return to Ingarûma (The Hatokáli Fells) on Kyareth.
Kyareth applied a benefit with Return to Echad Vothui (Heledhris, Rift of Shornshards) on Kyareth.
```

The stakeholder identified the successful-use message as **Combat - Player** in the chat UI. Do not confuse this displayed category with a numeric API enum verified from a raw event dump; the exact raw event payload was not captured in this research.

The debug handler observes all chat categories. Its current English pattern is:

```lua
"Return to (.-) %((.-)%) on (.-)%."
```

It searches inside the message body without requiring a timestamp or the leading actor phrase. The recipient after `on` is extracted and compared to `Player:GetName()` at runtime; no character name is hardcoded. A UI timestamp is not a required part of `args.Message`. Removing the actor-prefix requirement was followed by the stakeholder's successful test, but the original failure's exact raw-message cause was not established.

A TWII milestone quickslot click supplies the actual skill identity; the later success text supplies the destination. The stakeholder selected this attribution rule. A pending click expires after **30 seconds**. The click itself is not proof of completed travel. External game hotbar uses do not supply this TWII click identity.

The prototype immediately prints `Milestone debug: milestone skill no N clicked.` Recognized success then prints the combined slot/location result and updates the corresponding debug-table row. Pending attribution is cleared on use consumption, debug-off, or unload. Observations are keyed by skill ID and remain in memory only.

On 2026-11-08 the stakeholder reported:

```text
[11/08 07:12:47 PM] Kyareth applied a benefit with Return to Echad Vothui (Heledhris, Rift of Shornshards) on Kyareth.
[11/08 07:12:47 PM] Milestone debug: Milestone 5 is mapped to Echad Vothui (Heledhris, Rift of Shornshards).
```

The stakeholder also confirmed that the debug window showed that mapping. This establishes the reported one-skill success path. Retaining different destinations for two different skills remains unconfirmed: the stakeholder was waiting for cooldowns to expire. Replacing only one row, reload loss of observations, all activation surfaces, multiple characters, locales, cancellation, duplicate events, and expiry boundaries are not established by this one test.

For later accepted-record or repair logic, characterize trusted event categories and prevent quoted player chat from becoming authoritative evidence. The current broad debug scan is not a complete production trust policy.

## 3. Refreshed Companion milestone inventory

### Sources and method

The repository [README](https://github.com/LotroCompanion/lotro-data/blob/7097ff870cdeace51b7b34debc38b6a9969ae0c4/README.txt) places map data in a separate repository. [Map category 55](https://github.com/LotroCompanion/lotro-maps-db/blob/2e707ebf14162607f586ecf2948f97fc212090d0/categories/categories.xml) is Milestone.

The refreshed scan read all **459** `markers/*.xml` files from `lotro-maps-db` revision `2e707ebf14162607f586ecf2948f97fc212090d0`. It selected generated, single-line marker tags containing `category="55"`. All files were fetched/scanned successfully. Only selected milestone records and file metadata were retained; the original marker files total **701,725,848 bytes**. This was not an audit of every non-milestone record or a live game survey.

| World region code | Marker count |
|---|---:|
| 1 | 96 |
| 2 | 98 |
| 3 | 25 |
| 4 | 61 |
| 5 | 58 |
| 6 | 12 |
| 14 | 1 |
| **Total** | **351** |

All 351 have distinct marker IDs and distinct world-region/latitude/longitude triples. **All 351 labels are exactly `Milestone`.** They share 14 object-template DIDs. A shared DID identifies an object definition, not an individual milestone destination.

The 339-marker / 445-file result in the original audit belongs to `063030b40ce85d173593de2e73cb7edde6ae1b53`. Its region counts remain historically correct; the refreshed inventory includes 12 region-6 markers. The older total-marker, camp-site, spacing, and overview-projection results were not recomputed for this refresh and must not be relabelled as results for the 351-marker snapshot.

**351 is a count of extracted milestone markers, not a proven count of currently accessible, bindable destinations.** Story versions, instances, supported world contexts, and upstream classification still require review. The earlier category-57/camp-site caveat remains applicable; the new scan did not audit that category again.

### Geographic names and completeness

`parentZoneId` joins to [geoAreas.xml](https://github.com/LotroCompanion/lotro-data/blob/7097ff870cdeace51b7b34debc38b6a9969ae0c4/lore/geoAreas.xml). Five IDs require [dungeons.xml](https://github.com/LotroCompanion/lotro-data/blob/7097ff870cdeace51b7b34debc38b6a9969ae0c4/lore/dungeons.xml): Gath Forthnír, Thorin's Hall, Hall of Vérnozal, Annâk-khurfu, and Vestibule of Utug-bûr. All parent-zone IDs resolve across the two catalogues.

This produces geographic context for every marker, but an area name is not necessarily the bind destination's name. Multiple milestones can share the same area. The static landmark and travel catalogues contain named places, but the inspected files do not provide an explicit global named-destination-to-milestone-marker relation. `travels.xml` includes transport destinations/routes; a named stable destination does not establish a bindable milestone. The map database's `links.xml` describes map navigation links; the examined Echad Vothui milestone ID and shared milestone DID were absent from it.

An area-and-coordinate label such as `Milestone — Imlad Drúnos, 56.3S 100.0W` is technically possible. This is a **fallback-label proposal**, not an approved canonical name or a substitute for a confirmed `Echad Vothui` mapping.

### Source marker IDs change

Comparing the refreshed catalogue to the original audit finds 19 IDs present only in the new snapshot and seven IDs present only in the old snapshot. Each of those seven old records has exactly one new-ID record with identical world region and coordinates:

| Previous marker ID | Refreshed marker ID | World region |
|---|---|---:|
| 536060218 | 536060182 | 1 |
| 343179312 | 343179313 | 1 |
| 360595494 | 360595483 | 1 |
| 393752627 | 393752629 | 1 |
| 699727910 | 699727918 | 2 |
| 1161678855 | 1161678852 | 4 |
| 1432600576 | 1432600593 | 5 |

These seven exact-coordinate correspondences are concrete evidence of upstream ID instability, not approved automatic migrations. TWII requires independent destination keys and reviewed upstream-ID aliases. The other 12 new IDs belong to world region 6. Preserve signed source IDs as strings, as already required by the original audit.

## 4. Actual character export

The stakeholder supplied `D:\LOTRO Exports\characters\toon-00002` and a screenshot of Companion's milestone tab. The relevant files are `skills.xml` and `anchors.xml`. The latter's filesystem modification time is **2026-09-10 14:15:54**; this is not proof of game observation time. Character/server identity was not established from the anchor file, and the export must not be assumed to be the character in the later live-chat examples.

The skill snapshot contains all 11 currently supported milestone skills with `available="true"`. `anchors.xml` has 13 anchors: 11 named milestone bindings and two other travel anchors. The screenshot's names and displayed rounded coordinates agree with the milestone records.

### Exact skill-to-anchor join

The deterministic relation is:

```text
character skills.xml skill.id
  -> reference skills.xml travelSkill.identifier
  -> reference travelSkill.travelType
  -> character anchors.xml anchor.type
```

The reference skill catalogue uses `identifier`; the character skill-status file uses `id`. `anchor.type` is a TravelLink code, not a numbered skill or a skill ID. Do not use row order or arithmetic on the type code.

| Milestone | Skill ID (hex) | Skill ID (decimal) | Anchor type | Saved destination |
|---|---|---|---:|---|
| 1 | 0x700256ba | 1879201466 | 3 | Ghun Shâna |
| 2 | 0x70025792 | 1879201682 | 15 | Khanâg Gur |
| 3 | 0x70025793 | 1879201683 | 16 | The Twenty-first Hall |
| 4 | 0x70025794 | 1879201684 | 17 | Grúmachath |
| 5 | 0x70025795 | 1879201685 | 18 | Gadim-ûn |
| 6 | 0x70025796 | 1879201686 | 19 | Nashûbu |
| 7 | 0x7002ff62 | 1879244642 | 26 | Beorninghús |
| 8 | 0x7002ff61 | 1879244641 | 27 | The Dawn-warden |
| 9 | 0x7002ff60 | 1879244640 | 28 | Swain's Guild-hall |
| 10 | 0x7002ff5f | 1879244639 | 29 | Ingarûma |
| 11 | 0x7002ff63 | 1879244643 | 20 | Hobbiton-Bywater |

The screenshot lists Ingarûma seventh, although it belongs to Return Home 10. The screenshot order cannot assign slot numbers. The current supported registry and learned-skill data agree on the table above; additional TravelLink enum definitions do not establish additional learned skills or override the existing exclusion of slots 12–16.

### Record shape and meaning

```xml
<anchor type="19" name="Nashûbu">
  <position region="5" longitude="-87.36572" latitude="-65.42276" zoneID="1879500799"/>
</anchor>
```

Names are stored without `Return to` and without the parenthetical territory. Positions have greater precision than the one-decimal coordinate display. Region and zone are different namespaces. No milestone marker ID or landmark ID appears in the supplied anchor records.

The [TravelRegistryExtractor](https://github.com/LotroCompanion/lotro-data-extractor/blob/d9a854220477675721f7264f8a57974bdf025ad8/src/main/java/delta/games/lotro/extractors/travels/TravelRegistryExtractor.java#L58-L72) reads the position from travel-record attribute `111647278`, the name from `47172757`, and the travel-type-keyed map from registry attribute `194458403`. It stores name and position together. [AnchorStatus](https://github.com/LotroCompanion/lotro-core/blob/2356eef3c74140db0cebfae5b5c7a91b7839330f/src/main/java/delta/games/lotro/character/status/travels/AnchorStatus.java) represents these fields. [AnchorsStatusIo](https://github.com/LotroCompanion/lotro-core/blob/2356eef3c74140db0cebfae5b5c7a91b7839330f/src/main/java/delta/games/lotro/character/status/travels/io/AnchorsStatusIo.java) selects the per-character `anchors.xml` file; [AnchorsStatusXMLWriter](https://github.com/LotroCompanion/lotro-core/blob/2356eef3c74140db0cebfae5b5c7a91b7839330f/src/main/java/delta/games/lotro/character/status/travels/io/xml/AnchorsStatusXMLWriter.java) writes type, name, and position. [The display controller](https://github.com/LotroCompanion/lotro-companion/blob/fa4c084467b3c957d1660d2fb847e6ea42e1f228/src/main/java/delta/games/lotro/gui/character/status/travels/AnchorsStatusDisplayPanelController.java#L84-L114) adds `Return to ` for presentation.

The unnamed anchors have type 1 (`PrivateEncounter`) and type 13 (`NeighborhoodEntrance`) in the inspected [TravelLink enum](https://github.com/LotroCompanion/lotro-data/blob/7097ff870cdeace51b7b34debc38b6a9969ae0c4/lore/enums/TravelLink.xml). An importer must filter by supported milestone travel types and learned skills; not every anchor is a player milestone binding.

The export's zone hierarchy reproduces the territory portions of the two earlier success examples:

- `Nashûbu` -> zone `1879500799` / Hoards of Koratíya -> **Idagâl, the Dry-whelm** -> Haradwaith.
- `Ingarûma` -> zone `1879521058` / Kupu-shagâm -> **The Hatokáli Fells** -> Haradwaith.

This establishes agreement for those names and territory suffixes. It does not prove a universal chat-string construction rule across all destinations and locales. Preserve the original observed text alongside any parsed/canonical form.

## 5. Destination-name and marker matching

### Concrete spatial candidates

| Observation | Position: latitude, longitude | Candidate milestone | Candidate position | Euclidean coordinate separation |
|---|---|---|---|---:|
| Imported Nashûbu anchor | -65.42276, -87.36572 | 1414172678 | -65.4071, -87.37451 | 0.0179583 |
| Imported Ingarûma anchor | -74.96585, -85.31062 | 1413271558 | -75.00425, -85.313934 | 0.0385427 |
| Named Echad Vothui landmark, ID 1666863112 / DID 1879527912 | -56.250523, -100.052185 | 1666863107 | -56.29513, -100.04626 | 0.0449988 |

The first two comparisons use exported anchor positions, not measured post-travel player positions. Each candidate matches its anchor's world region and zone. They were selected from the inspected world-5 tiles [5-4-4](https://github.com/LotroCompanion/lotro-maps-db/blob/2e707ebf14162607f586ecf2948f97fc212090d0/markers/markers-5-4-4.xml) and [5-4-3](https://github.com/LotroCompanion/lotro-maps-db/blob/2e707ebf14162607f586ecf2948f97fc212090d0/markers/markers-5-4-3.xml); their earlier nearest-candidate comparisons were not a global world-5 nearest-neighbor audit.

The Echad Vothui records are in [6-3-5](https://github.com/LotroCompanion/lotro-maps-db/blob/2e707ebf14162607f586ecf2948f97fc212090d0/markers/markers-6-3-5.xml), world region 6, zone `1879524632` / Imlad Drúnos, parent territory Heledhris, Rift of Shornshards. Comparing against all 12 region-6 milestone markers found the next candidate approximately 6.12 coordinate degrees away. This is strong spatial evidence for that candidate, not an explicit upstream relation or a measured arrival offset.

Separations are Euclidean differences in game coordinate values, not metres or Earth geographic distances. The displayed approximations are not approved match thresholds.

### Offset hypothesis

The stakeholder's explanation is that a milestone marker describes the world object while an anchor describes a safe arrival point beside it. The two imported-anchor examples are consistent with that explanation. It remains a hypothesis until repeated post-travel locations and bind positions are measured. Another possibility to examine is whether the anchor depends on where the player stood while binding; E06 already covers this.

Keep object position, imported anchor position, user-captured bind position, measured arrival position, and named-landmark position as separately typed observations. Do not replace one with another or describe the landmark-to-object difference as an observed arrival offset.

### Proposed catalogue workflow

1. Extract category-55 markers with source revision, world region, exact coordinates, source ID, template DID, and geographic context.
2. Generate name candidates from localized named landmarks/settlements and territory ancestry. A nearby stable destination alone is insufficient evidence of a milestone.
3. Add stronger observations from known character anchors or controlled successful-use/location captures. This can be an offline research/data-curation step while the user-facing Companion import feature remains deferred.
4. Match within known world/instance context; use zone agreement as corroboration, then a calibrated spatial tolerance and a nearest-versus-runner-up ambiguity check. Do not assume every valid arrival stays on the same side of an area boundary.
5. Keep confirmed names/aliases separate from inferred candidates and unresolved records. Unknown or ambiguous names remain reviewable; do not automatically convert them to accepted destinations.
6. Assign independent TWII destination keys; retain reviewed source-ID aliases across snapshots. Permit multiple skills to refer to one destination.

The inspected Companion source already supplies a **character-specific name-to-position mapping**. A complete static destination-name-to-marker-ID catalogue or equivalent reverse lookup was not found in the public files and source inspected. Extending raw game-data extraction to retain an explicit per-placement bind-target name/telepad is an open research avenue, not a proven available field.

## 6. MoorMap milestone annotations

Installed source: `C:\Users\wojci\OneDrive\Dokumente\The Lord of the Rings Online\Plugins\GaranStuff\MoorMap`, version history identifies 1.66. This inspection extends the earlier treasure-chest popup review.

- `Defaults.lua:65` assigns **MoorMap icon/type 27** to milestones. This is unrelated to Companion category 55 or TravelLink type codes.
- `AnnotationsWindow.lua:2,836` documents annotation fields: map ID, north/south coordinate, east/west coordinate, icon/type, allegiance, text index, description, and other metadata.
- `Data/MapData_*.lua` supplies static annotation positions and language-indexed strings. No destination-name inference is needed to draw an icon labelled Milestone.
- `AnnotationsWindow.lua:163–166` and `Main.lua:6828–6831` resolve localized text with an English fallback.
- `Main.lua:6638–6639` projects coordinates using per-map factors and offsets from `Defaults.lua`; world position and map placement are separate concerns.
- `Data/MapData_5.lua:129,792` and `Data/MapData_6.lua:25,72` show Archet's milestone repeated on the Bree-land and Archet maps.

A read-only extraction of category/type-27 annotation rows found **348 annotations**, with no missing English text references. **334** have the exact label `Milestone: Milestone`; two further labels differ only by the omitted space after the colon. Some remaining strings mention Archet, Aughaire, Carn Dûm, Vernozal, or The Jolly Bell; others resolve to labels such as Stable-master, Door, or Mailbox. These require curation, not automatic acceptance as destination names.

A provisional grouping by stored world-region/map metadata and exact textual coordinates yields 281 groups, but that is not a proven count of distinct game destinations: positions are often rounded, numeric formatting differs, maps can overlap, and instance/world conventions need checking. Do not equate 348 annotations, 281 provisional groups, or 351 Companion markers.

The transferable patterns are a central location model with separate per-map placements, independent text resources, English fallback, and explicit map calibration. The installed static milestone data does **not** establish automatic binding detection or a comprehensive named-destination catalogue. Do not copy MoorMap's treasure-cache distance threshold into milestone matching.

## 7. Requirements for later execution

These refine the existing research requirements; proposals do not approve automatic repair, fallback UI copy, catalogue generation ownership, or a new implementation phase.

| ID | Requirement or constraint | Basis/status |
|---|---|---|
| N01 | Retain canonical skill ID, numbered slot, destination key, source marker ID, template DID, world region, and geographic-zone ID as distinct fields. | Verified identity differences and source-ID changes. |
| N02 | Use reference `travelType` to join supported learned skills to imported `anchor.type`; never use screenshot order or type arithmetic. | Exact 11-skill export join. |
| N03 | Preserve game-observed destination text and territory context; do not hardcode character names or depend on chat UI timestamps. | Runtime report plus source inspection. |
| N04 | Require the selected attribution evidence before assigning a success to a slot. A click alone is not success; a message alone does not identify a numbered slot. | Approved TWII-click attribution; 30-second prototype window. |
| N05 | Keep bind-picker identification separate from travel activation. | Explicit stakeholder requirement and reported regression. |
| N06 | Do not persist current prototype state; keep all feature UI/diagnostics behind `TravelDebugEnabled`. | Approved execution scope. |
| N07 | Represent names and map placements independently, including unresolved names and unavailable/unreviewed map placement. | Generic labels and partial coverage. |
| N08 | Model stone, anchor, bind sample, arrival sample, and landmark coordinates separately; calibrate tolerances before accepting automatic matches. | Source facts plus offset hypothesis. |
| N09 | Use stable TWII destination keys with reviewed source migration aliases. | Seven ID changes at identical world/coordinates. |
| N10 | Treat imports as character-scoped snapshots; require surrounding identity and freshness information. Filter non-milestone anchors and respect later in-game changes. | Actual 13-anchor export; root lacks identity/time metadata. |
| N11 | Keep one destination record usable in several map placements and by several milestone skills. | Repeated MoorMap placements; existing duplicate-binding requirement. |
| N12 | Do not promote a generic area label or nearest-name guess to a confirmed canonical destination. Preserve confidence/provenance and unresolved cases. | All 351 static labels generic. |
| N13 | Continue the approved EN/DE/RU detector goal, but label the present successful-use prototype as English-only evidence. | Existing product decision; no new localized fixtures obtained. |

## 8. Validation still needed

- **Prototype:** a second distinct milestone retains its own location while the first stays unchanged; overwriting one row preserves others; the picker remains select-only; debug toggling/unload and the 30-second expiry behave as specified.
- **Chat:** raw ChatType and raw body capture, target name across characters, actor-prefix variants, duplicate and out-of-order delivery, cancelled casts, other travel skills, quoted messages, and EN/DE/RU fixtures.
- **Names:** compare exact success suffixes with geographic ancestry across more destinations, punctuation/diacritics, interiors, and story variants. Establish all canonical names and localized aliases with provenance.
- **Coordinates:** compare repeated actual arrivals before moving with exported anchor and stone positions; vary bind positions; test area boundaries and interiors. Derive tolerance and ambiguity rules from those results.
- **Catalogue:** verify currently bindable coverage, review upstream classification, map calibration, and changed source IDs. Do not assume the old camp-site or projection audit was rerun.
- **Later import:** surrounding character/server identity, observation time, stale snapshots, missing names/types, malformed/newer schemas, and safe unknown-slot retention.
- **Product decisions:** automatic repair remains unapproved; if adopted, define unambiguous evidence, undo/history, and notification. Existing manager-based repair and mismatch-prompt decisions remain in the specification.

The stakeholder need not answer these by guessing: most are developer experiments or catalogue-curation work. No outreach to other maintainers is authorized by these notes.

## 9. Persisted evidence and reproducibility

| File | Contents |
|---|---|
| [Latest catalogue CSV](evidence/2026-11-08-milestone-catalogue.csv) | All 351 source records with coordinates and resolved geographic names. These are marker labels, not confirmed bind destination names. |
| [Marker scan](evidence/2026-11-08-marker-scan.json) | Pinned map revision, scan timestamp, per-file sizes/counts/errors, and selected marker XML for all 459 files. |
| [Changed marker IDs](evidence/2026-11-08-marker-id-changes.json) | Seven old/new-ID exact-coordinate correspondences against the original audit. |
| [Character anchors](evidence/2026-11-08-character-anchors.json) | Derived 11-skill mapping, precise anchor coordinates, two non-milestone anchors, and snapshot limitations. No inventory or unrelated character data copied. |
| [MoorMap annotations](evidence/2026-11-08-moormap-annotations.json) | The 348 extracted type-27 annotation facts and English text references. |
| [MoorMap source fingerprints](evidence/2026-11-08-moormap-sources.json) | Installed version, inspected root, and hashes for key source/data files. |
| [Original audit](catalogue-audit.json) | Historical 339-marker, camp-site, and projection evidence; not overwritten. |

Public revisions inspected during the follow-up:

| Repository | Revision |
|---|---|
| lotro-data | `7097ff870cdeace51b7b34debc38b6a9969ae0c4` |
| lotro-maps-db | `2e707ebf14162607f586ecf2948f97fc212090d0` |
| lotro-core | `2356eef3c74140db0cebfae5b5c7a91b7839330f` |
| lotro-companion | `fa4c084467b3c957d1660d2fb847e6ea42e1f228` |
| lotro-data-extractor | `d9a854220477675721f7264f8a57974bdf025ad8` |
| lotro-tools | `bcda345998795b447f94d1e53fd117ad161f882c` |

The regex scan's reproducible selection is `category="55"` in one-line marker tags. Count source IDs and exact world/coordinate triples separately. Join geographic IDs to areas first and dungeons second. Retain source revision and the raw selected record; do not infer an observed time from file modification time. The saved small evidence files remove any dependency on the temporary source downloads or their archives.
