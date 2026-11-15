# Milestone catalogue proposal and coordinate screening

Date: 2026-11-14. **Research format and offline demonstration, not a production catalogue or an approved matching algorithm.** No runtime plugin import or map integration is added.

Subsequent authorized increment: the [runtime debug catalogue](2026-11-14-catalogue-debug-guess.md) now imports all 351 markers for diagnostic comparison, with stable numeric IDs and qualified wiki labels. That supersedes this report's “no runtime import” status for debug use. GUIDs remain provenance, not future character binding identifiers. Production catalogue acceptance and map integration remain deferred.

Latest [geographic enrichment](2026-11-14-geographic-catalogue-enrichment.md) adds typed hierarchy metadata and 55 explicit fallback labels without populating any new native `names.en` entries. The geographic input now has 329 entities, including all seven coordinate regions; `kind` is the actual XML element type. The [full CSV](catalogue-proposal/debug-catalogue.csv) and [fallback queue](catalogue-proposal/geographic-fallbacks.md) are the current debug review exports.

The useful split is a rich research inventory, a reviewed destination catalogue compiled for Lua, and character-specific observations kept separately. A name, a marker object, a character's anchor position, and a skill slot are different entities. This avoids forcing an uncertain wiki settlement label into a native destination name.

## Concrete outputs

| File | Purpose |
|---|---|
| [marker-inventory.json](catalogue-proposal/marker-inventory.json) | All 351 pinned markers, coordinates, world codes, source IDs, area/dungeon hierarchy and wiki candidate references. Names are populated for 38 destinations with observed/reported evidence; 313 remain unnamed. |
| [wiki-observations.json](catalogue-proposal/wiki-observations.json) | All 309 coordinate rows from the supplied wiki snapshot, preserving labels, headings, notes, precision and all screened marker candidates. |
| [wiki-screening.csv](catalogue-proposal/wiki-screening.csv) | Spreadsheet-friendly review queue: one row per wiki observation, including ambiguous and unmatched rows. |
| [audit.json](catalogue-proposal/audit.json) | Counts, source checksum, extraction anomalies, screening settings and author-example association. |
| [runtime-shape-example.lua](catalogue-proposal/runtime-shape-example.lua) | A Lua 5.1-shaped example containing the 37 prior observed names plus Ilzag Khûl reported by the author. It is deliberately outside `src` and is not loaded by the plugin. |
| [identity-ledger.json](catalogue-proposal/identity-ledger.json) | Persisted local IDs for this inventory, retaining the 37 earlier destination IDs. |
| [geography-input.json](catalogue-proposal/geography-input.json) | 329 typed hierarchy/coordinate-region nodes extracted from the pinned Companion `geoAreas.xml` and `dungeons.xml`, with source hashes. |
| [author-example-input.json](catalogue-proposal/author-example-input.json) | The new Ilzag Khûl example as source evidence, including anchor, area, territory and icon. |
| [build_catalogue_proposal.py](catalogue-proposal/build_catalogue_proposal.py) | Offline extraction and regeneration using the supplied HTML and the persisted inputs. |

The earlier [37-name database](named-catalogue/README.md) is preserved as its historical snapshot. The new inventory adds one separately attributed author-reported destination; it does not rewrite that snapshot.

## Sources and evidence boundaries

The wiki input is the stakeholder's attached HTML, representing [Milestone revision 2078902](https://lotro-wiki.com/wiki/Milestone?oldid=2078902). Its SHA-256 is `86f46eafc365a03b8a7060638e23f32b662a6acf88af82d2cbb13b0d1a736a6c`. It was parsed as data, without running scripts or downloading linked content. This is not a claim that the page is current, exhaustive, or contains the exact skill tooltip names.

Marker source: the [pinned 351-marker extraction](evidence/2026-11-08-milestone-catalogue.csv), from `lotro-maps-db` revision `2e707ebf14162607f586ecf2948f97fc212090d0`. Geographic source: `lotro-data` revision `7097ff870cdeace51b7b34debc38b6a9969ae0c4`, `lore/geoAreas.xml` and `lore/dungeons.xml`. The new geography subset preserves IDs, kinds, parent IDs and icon IDs when provided. A dungeon's containing zone is obtained from its position `zoneID`; that is recorded as the research hierarchy parent, not asserted to be a raw travel-registry field.

The previous named observations came from 42 exported anchors across 12 character snapshots plus the stakeholder's Echad Vothui success-message observation. The author now reports Ilzag Khûl as another exact memory-read name. Every association of these names to generic marker records remains a **spatial candidate**, not a supplied upstream foreign key.

## Extraction and matching results

The supplied HTML contains 49 `locationList` tables and 309 rows with coordinates. One King's Gondor row has five cells, with a superfluous empty fifth cell; the extractor preserves the first four and records that recovery. No row was omitted for missing/unreadable coordinates. Names, links and table contexts are preserved in the extracted JSON. No translation was inferred.

| Screening result | Wiki rows |
|---|---:|
| One marker within 0.15 coordinate units, across all worlds | 260 |
| More than one nearby marker | 27 |
| No nearby marker | 22 |
| Total | 309 |

These rows reference 289 distinct marker candidates. The 260 single-candidate rows point to 259 distinct markers: Iridír and Sûru share one wiki coordinate and candidate marker. That is a collision to investigate, not permission to merge the names. The wiki also lists Ost Lontir and Tadrent in King's Gondor with the same coordinates. All rows remain reviewable in the CSV.

The 0.15 limit is an intentionally broad **research screening radius in the game's coordinate units**, not metres, not a calibrated binding tolerance, and not an authorization to save a binding. It is distinct from the old named-anchor screening limit of 0.1. The screen compares all world codes and does not silently infer them from wiki headings. This deliberately exposes overlapping Gondor/King's Gondor coordinates as ambiguous; real `;loc` matching must first require a reliable world/region code.

Examples that explain why the schema preserves uncertainty:

- The wiki says **Hobbiton** at `31.4S, 71.1W`, while the observed anchor name is **Hobbiton-Bywater**. A useful display label does not establish the string expected in `Return to …` success messages.
- **Ethring** has nearby markers in world 3 and world 4. Distance alone cannot choose the original Gondor or King's Gondor location.
- **Gath Forthnír** and **Thorin's Hall** have no nearby candidate in this screen. Interior/dungeon coordinate conventions and outdated wiki coordinates are possible explanations; the extractor does not force a distant match.
- **Ilzag Khûl** has a wiki coordinate `26.5S, 61.4W`. The author reports an anchor at latitude `-26.551659`, longitude `-61.44319`, world 5, zone `1879487057`. The nearest same-world marker is `1450876936`, at `-26.513954, -61.43104`, in that same zone. Its separation from the anchor is about `0.0396143`; the nearest other world-5 marker is about `3.42472` away. The name evidence is stronger than a wiki label, while the name-to-object association is still spatial.

The marker count by numeric world code is 1:96, 2:98, 3:25, 4:61, 5:58, 6:12, 14:1. There are 14 shared object template DIDs in this snapshot; a DID identifies an appearance/template, not an individual milestone. The author's approximate “~350 / ~10” account agrees in scale, but does not supersede the audited snapshot.

## Proposed data contract

### 1. Destination catalogue, shared by all characters

Use a versioned record with a stable local ID, reviewed localized names and a physical marker position. Keep source IDs as attributes. Production should initially ship only records with a reviewed name and usable position; the 313 unnamed records remain research material until sufficient evidence exists.

```lua
{
    schemaVersion = 1,
    coordinateSystem = "lotro-world-latlon",
    records = {
        {
            id = "milestone-c9be2212-34c9-40a5-ade9-e02093712ed7",
            names = { en = "Ilzag Khûl" },
            worldRegion = 5,
            markerPosition = {
                latitude = -26.513954,
                longitude = -61.43104,
            },
            zoneId = "1879487057",
            sourceMarkerId = "1450876936",
        },
    },
}
```

This is the minimal runtime shape. The example ID above comes from the persisted ledger; it is not derived from the name or marker ID. Add only runtime fields that have a concrete use:

| Field | Meaning and rule |
|---|---|
| `id` | Plugin-owned stable destination identity. Never use a translated label as a key. |
| `names[language]` | Reviewed base destination name; no `Return to` prefix. Missing translations fall back to English. Keep source/proof in the research inventory. |
| `worldRegion` | Numeric world/region from the coordinate system. Not an area ID or one of TWII's five map tabs. Required for proximity matching. |
| `markerPosition` | The milestone object's location, with signed latitude/longitude. Preserve original precision in source data. |
| `zoneId` | Area or dungeon associated with the marker. Useful as a corroborating signal, subject to boundary/dungeon handling. |
| `territoryId`, `iconId` | Optional compiled geography fields when needed for a view or tooltip. Do not require every territory to have an icon. |
| `sourceMarkerId` | Upstream marker observation identity for provenance/update comparison, not the permanent plugin key. |
| `acceptedSuccessNames[language]` | Future reviewed native success-message aliases, if needed. Keep separate from wiki labels and display names. Never create these by simply taking a settlement name. |

Icon and territory are separate lookups. For Ilzag Khûl the local area **Paths of Khegûl** (`1879487057`) supplies icon `1092947644`; parent territory **Urash Dâr** (`1879487114`) is displayed in the native skill name. The territory has no icon. Derive such fields from typed geography nodes rather than equating area name, territory label and numeric world name.

Store external IDs as decimal strings in the research format to avoid confusion between ID namespaces and signed 32-bit handling in other tools. Lua supports these particular values numerically too, but no arithmetic is needed for identity fields. Only world codes and coordinates need numeric values here.

### 2. Research evidence, outside the runtime catalogue

Keep original records and observations with:

- source kind, source revision/date/checksum and locale;
- original source ID and source file;
- exact observed native name versus wiki display label;
- coordinate kind (`milestoneObject`, `importedAnchor`, `reportedCharacterAnchor`, `wikiListedLocation`, later `playerLocAtBind` or `postTravelLoc`);
- original coordinate text/precision and world/zone information, with unknown values explicit;
- area/dungeon hierarchy and separate local-area icon/territory name;
- association status, candidate set and distances; ambiguity and rejection reason;
- whether a row is ready to compile, still a candidate, superseded or omitted.

A runtime-friendly table should not carry character export paths, full audit traces or a speculative label for every generic marker. The JSON inventory is richer on purpose. Native message text observed on a character is valuable evidence even when its catalogue ID is unresolved.

### 3. Character-specific binding observations

A future character record should reference `skillId` and `destinationId`, with independent fields for observed success text, capture time/source, selected slot and capture confidence. It must not put mutable character bindings into the global destination catalogue. This work adds no such persistence or runtime binding changes.

If a success message identifies a native name the catalogue does not yet know, retain that raw destination text for repair/display. Do not discard it or invent coordinates. An offline catalogue improvement can follow separately.

## Identity, updates and translations

The 37 prior destination GUIDs are reused. New GUIDs are persisted for the other marker candidates in this proposal. They are **provisional research identities** until a destination association is reviewed. The ledger is currently indexed by marker ID for deterministic regeneration of this pinned snapshot; it is not a complete future migration algorithm.

Upstream marker IDs have changed at identical coordinates in earlier comparisons. At a future data update, compare world, coordinates, area/dungeon context and supporting name evidence, then explicitly carry the local ID forward. Do not regenerate all IDs, merge nearby markers automatically, or use a name-only join. Split/merge/retired records need a reviewable migration record.

English wiki text supplies English labels only. Native names from character exports also need their observation locale. Exact punctuation, accents and capitalization are preserved; normalization used for searching must not alter the original display string. Translation slots should be absent until sourced. A localized `Return to` prefix belongs to the message parser/UI, not the destination identity.

## Future bind-time match sequence

**Integration gap:** the current trial's inline `;loc` expansion provides localized world/area text, not the catalogue's numeric world/region code. The trial therefore does not yet supply everything required for exact-world filtering. Before a proximity implementation, add a reviewed resolver from client locale plus world/area/story context to numeric world code, or obtain a different raw `/loc` representation that exposes the numeric region. A display string such as Gondor or a TWII map-tab index must not be treated as that code. If the resolver cannot distinguish overlapping original/after-battle/King's Gondor contexts, keep the result ambiguous instead of searching a guessed world.

1. Arm a short-lived capture for the selected learned skill and popup token. Parse the physical-click-expanded location; reject literal `;loc`, malformed data, missing required world code, stale or superseded requests.
2. Filter marker records by exact numeric world code. Use area/dungeon context when reliably available, without assuming a near-boundary area mismatch is conclusive.
3. Compare signed coordinates in that world. Prefer the object position for “standing near the milestone”; keep anchor/arrival observations as separate calibration evidence.
4. Produce a candidate set with distance, precision/position uncertainty and runner-up separation. Require an approved maximum radius and ambiguity margin before calling a suggestion clear.
5. Show the suggested location and ask the player to confirm, as already decided. Unknown/ambiguous results retain the capture and offer a choice instead of silently saving the nearest marker.
6. Later trusted use messages repair the clicked skill's observed destination. A catalogue match should corroborate the name and territory and must not silently swap another skill's row.

A popup left open while the character moves remains a real limitation: a valid fresh click captures the current position, not the earlier bind position. Token freshness and bind-to-click elapsed time make this visible; they cannot prove the player remained beside the original object. Self-healing after later travel reduces the lasting harm of a wrong selection.

No production proximity radius is chosen here. Collect actual `;loc` samples next to milestones, examples on both sides of area boundaries, interiors, rounded wiki positions, and actual arrival positions before calibrating it. The new Ilzag offset is slightly larger than the maximum imported-anchor offset in the prior 37-record study, which is another reason not to use that earlier maximum as a hard bound.

## Regeneration and verification

The builder uses Python's standard library only. Run it from any directory, giving the attached HTML snapshot path:

```powershell
& '<python executable>' 'plans/milestone-management/catalogue-proposal/build_catalogue_proposal.py' --wiki '<Pasted text.txt>'
```

Inputs other than that attachment are persisted in the dossier. The builder checks the expected wiki revision and 351-marker count, reuses the identity ledger, verifies the author example's same-world/same-zone association and writes the inventory, wiki observations, CSV, audit and Lua-shaped example. The original attachment's hash is recorded; `wiki-observations.json` persists the normalized evidence even if the attachment is later unavailable. Preserve the original HTML independently if byte-identical re-extraction must remain possible.

Validation performed for this proposal: offline parser run succeeded; counts reconcile to 309 wiki rows and 351 markers; every marker's zone resolved into the retained geography subset; 351 local IDs are distinct; the 37 earlier IDs are retained; no wiki label was copied into the observed-name field. Re-running with the same inputs and ledger produces identical generated files. This verifies the research transformation, not correctness of wiki coordinates, names, native runtime location parsing or in-game proximity behavior.

Next reviewable increment: inspect the 27 ambiguous and 22 unmatched wiki rows, select a small representative set with known native names, and use live debug captures to establish the coordinate envelope. Promoting hundreds of wiki labels without that review would overstate the evidence.
