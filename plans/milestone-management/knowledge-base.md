# Milestone functionality: developer knowledge base

Latest catalogue increment: [geographic enrichment](2026-11-14-geographic-catalogue-enrichment.md) resolves all 351 marker-zone joins and gives the remaining 55 unlabelled records area/dungeon/territory fallback labels. Native-name evidence stays at 38 observed/reported names; the 258 wiki-labelled candidates are unchanged. Only nine of those 38 names equal their zone name, so geography must not be promoted to a native destination name. Corrected XML element types, territory/icon source IDs and separate coordinate/geographic region identities are now exported. The new fallback classes remain excluded from exact skill-name prediction and persisted-name resolution.

Latest persistence increment: [temporary debug checkpoints](2026-11-14-debug-persistence.md) implement manual Character-scope load/save/clear/status behind `TravelDebugEnabled`. Only numeric identity/evidence/version data is serialized as decimal strings; labels are rebuilt from the catalogue. Debug-on, normal options and unload do not autosave this store. Earlier “no persistence” statements below describe prior slices or production persistence, which remains deferred.

Runtime update, 2026-11-14: the stakeholder confirms that the picker requires **two clicks**, then supplies debug data and identifies the correct location in the large window. Together with the earlier hover/badge/Alias report, this verifies the reported two-click capture/result path. Automatic closure, full callback order and the remaining E11 edge cases were not explicitly confirmed.

Latest increment: [runtime debug catalogue and location comparison](2026-11-14-catalogue-debug-guess.md) loads 351 markers with stable numeric IDs and qualified labels. Location-on-click belongs to the picker and the explicit manual LOC test quickslot in the debug window. Regular-view observers only remember the last clicked skill for successful-use reconciliation. [Character-only persistence research](2026-11-14-character-storage.md) records the new requirement: numeric identifiers only, no persisted destination names, no global-options coupling, and explicit load-state guards. Raw names mentioned below remain session diagnostics or source research, not approved character-save fields.

Consolidated 2026-11-14 from the research dossier, stakeholder decisions and runtime reports, the supplied LotroCompanion author explanation, and the supplied Milestone wiki HTML. This is a knowledge index and requirements record. It does not approve the full proposed feature for implementation.

## Read this first

The game owns the real milestone bindings. TWII records what it knows about them. The most useful evidence chains are:

1. **At bind time:** the generic bind message opens a prompt; the player identifies the learned milestone skill and requests current location; a compatible nearby milestone can be suggested for confirmation.
2. **After successful use:** a TWII quickslot click identifies the exact skill; a fresh successful-use message supplies its actual destination name and territory. This can later correct the used row automatically, with revision guards and undo.
3. **Offline character research/import:** Companion reads named travel records from the character's client-memory travel registry and stores them in `anchors.xml`. This gives character-specific names and positions, rather than a complete global table of named milestone stones.

The current small prototype is debug-only, session-local, and separate from the full design. The 2026-11-14 work adds a **trial** of native-skill hover followed by a location Alias on MouseDown; its native event ordering must be tested in LOTRO. No persistence, production labels, automatic proximity acceptance, repair, or map integration follows merely from this trial.

## Evidence and precedence

| Classification | Meaning |
|---|---|
| Inspected source/data | A statement supported by pinned files or code inspection; not proof of present live-game behavior. |
| Stakeholder runtime report | A concrete in-game observation supplied in this conversation; not an independently repeated test. |
| Companion author explanation | A primary maintainer explanation supplied by the stakeholder on 2026-11-14. Attribute claims accordingly. |
| Wiki snapshot | Community documentation in the attached HTML, revision `2078902`; useful reference with identifiable stale/conflicting details. |
| Selected requirement | A stakeholder decision about intended TWII behavior; not evidence it is already implemented. |
| Hypothesis / open experiment | An interpretation or interaction that needs source or runtime confirmation. |

Later dated evidence supersedes earlier statements on the same point. In particular, the November **351-marker** inventory supersedes September's 339 for the newer pinned dataset; the November 9 automatic self-healing decision supersedes November 8's “undecided” wording; the November 14 trial authorization supersedes earlier “not implemented / research only” scope statements **only for the trial**. Historical reports remain valuable and should not be silently rewritten as current validation.

## 1. Game mechanics and terminology

### Distinct concepts

| Concept | Meaning and consequence |
|---|---|
| Milestone object | A physical stone, fountain, or other milestone object at which the player can bind. Shared appearance/DID is not destination identity. |
| Milestone skill / slot | A learned Return Home skill with a stable skill ID and slot number. Its bound destination can change while its ID remains the same. |
| Native game binding | The game's association of a milestone skill with a destination. TWII recording, forgetting, or repairing its own record does not rebind the game skill. |
| TWII recorded binding | Character-specific knowledge connecting skill identity to observed or accepted destination data. It can be wrong while the game skill still works. |
| Travel record / anchor | Companion's representation of one travel-registry entry, keyed by a TravelLink type. Not every anchor is a milestone. |
| Destination | A named place plus physical/contextual identity. Several skills may be bound to the same destination. |

### Supplied wiki mechanics

The attached [Milestone wiki snapshot](https://lotro-wiki.com/index.php?title=Milestone&oldid=2078902) describes interacting with a milestone, selecting the milestone skill in the game's dialog, choosing Bind, and confirming the change. A character normally has one milestone skill; additional skills permit additional recorded home locations. Rebinding replaces the chosen skill's old destination and can be repeated.

The snapshot states that all milestone skills share a **60-minute cooldown**, reduced by **30 minutes** through Hurried Traveller and a further **25 minutes** through Expedient Traveller. This is wiki evidence for the five-minute fully reduced cooldown reported by the stakeholder. Shared cooldowns do not distinguish which slot was used. Cooldown passive-skill modelling remains outside this feature's current scope.

It describes additional skills as purchasable after level 10 through the LOTRO Store, and one Mithril Trader purchase equivalent to Milestone Skill II. Prices and availability are snapshot claims, not requirements for TWII and not live commerce verification. Its “up to 11 can be purchased” phrasing does not settle the supported maximum: TWII currently supports **eleven total registry entries**, while datamined definitions include more. Use the actual learned set and supported registry instead of extrapolating from that prose.

The wiki describes skills in the Skills panel and quickslot bars, native map filtering for Milestone notes, and map cursor coordinates. It also lists milestone style emotes. Cosmetic styles are distinct from the object-template DID, learned skill, destination, and icon; they provide no demonstrated binding-identity signal.

**Known conflict:** the wiki says binding emits `This location is now your home`. The stakeholder repeatedly observed `This location is now bound to your milestone skill.` in the current English client. The latter is the prototype's trigger. Do not substitute the wiki wording for a verified live fixture.

### Learned skills

The stakeholder confirms that TWII has reliably established learned milestone skills for a long time, including characters with multiple slots. Reuse that code. A character can have gaps, such as slots 1 and 3 without 2; skills cannot be unlearned according to the stakeholder. Count the actual learned supported entries, not the highest slot number or the number of recorded destinations.

With exactly one learned milestone skill, slot identity is trivial by exclusion. Location still needs capture and confirmation. With multiple learned skills, the generic bind signal and current coordinates cannot identify which skill was changed; the player must select it unless a separately verified API exposes better information.

## 2. Skill identity registry

These IDs and TravelLink mappings are established in the inspected skill/enum data and documented in the [specification](specification.md#skill-to-travel-link-mapping-established-by-source). `anchor.type` is not the numbered slot, and neither source ordering nor arithmetic on IDs/types is safe.

| Slot | Skill ID | TravelLink / anchor type | Current TWII support |
|---:|---|---:|---|
| 1 | `0x700256BA` | 3 | Supported |
| 2 | `0x70025792` | 15 | Supported |
| 3 | `0x70025793` | 16 | Supported |
| 4 | `0x70025794` | 17 | Supported |
| 5 | `0x70025795` | 18 | Supported |
| 6 | `0x70025796` | 19 | Supported |
| 7 | `0x7002FF62` | 26 | Supported |
| 8 | `0x7002FF61` | 27 | Supported |
| 9 | `0x7002FF60` | 28 | Supported |
| 10 | `0x7002FF5F` | 29 | Supported |
| 11 | `0x7002FF63` | 20 | Supported |
| 12 | `0x7002FF64` | 21 | Explicitly ignored in curated input |
| 13 | `0x7002FF66` | 22 | Explicitly ignored in curated input |
| 14 | `0x7002FF67` | 23 | Explicitly ignored in curated input |
| 15 | `0x7002FF68` | 24 | Explicitly ignored in curated input |
| 16 | `0x7002FF5E` | 25 | Explicitly ignored in curated input |

The reason for the 12–16 exclusions and their current live availability remain unverified. Definitions alone do not authorize exposing them. The inspected export's type 1 (`PrivateEncounter`) and type 13 (`NeighborhoodEntrance`) are non-milestone anchors and must not become milestone rows.

Canonical identity is the skill ID, independently of localized skill name, current tooltip, icon, display order, custom sort, and destination. For example, the supplied Companion screenshot places Ingarûma seventh even though it is bound to Return Home 10 in that export. Number overlays must use this registry, never row position.

## 3. What bind and successful-use chat establish

### Generic bind signal

Verified English message:

```text
This location is now bound to your milestone skill.
```

It reports a binding, not a newly learned/acquired skill, and contains **neither slot nor location**. “Learning” in the debug window/module name is historical naming, not a domain distinction to copy into production text. The player has already chosen a slot in the game's own binding dialog; TWII does not receive that choice through this message.

The prototype opens `Pick newly set milestone skill` with the supported learned skills. The stakeholder successfully selected slot 5 and received the expected diagnostic. An earlier implementation accidentally activated travel on selection; the select-only overlay avoided that activation but did not establish native tooltip support. The new hover/location trial must be judged against that regression.

### Successful-use signal

The stakeholder supplied and verified:

```text
Kyareth applied a benefit with Return to Nashûbu (Idagâl, the Dry-whelm) on Kyareth.
Kyareth applied a benefit with Return to Ingarûma (The Hatokáli Fells) on Kyareth.
Kyareth applied a benefit with Return to Echad Vothui (Heledhris, Rift of Shornshards) on Kyareth.
```

The stakeholder reports that the line appears **only after quick travel succeeds**, in the **Combat - Player** chat UI category. The exact numeric raw API category, complete raw payload, localization variants, duplicates, and ordering have not been captured as acceptance fixtures. Keep this distinction explicit: a category name in the UI is not a verified enum value.

The line provides destination and parenthetical territory, but not milestone slot. A TWII quickslot click supplies the exact selected skill ID. The approved prototype correlation window is **30 seconds**, long enough for induction and loading. It remains session-local and is cleared on consumption, debug-off, and unload. A click records an attempt; a cancelled or failed cast is not successful travel. A timer alone is not proof of attribution if another action intervenes.

The observed line's leading actor and trailing recipient vary by character. The prototype compares the parsed recipient with `Player:GetName()`; Kyareth is not hardcoded. UI timestamps must not be required in the raw chat-event string. The prototype currently searches for `Return to … (…) on ….` inside the message body rather than requiring its actor prefix.

The stakeholder confirmed a debug chat line and debug-table row for **Milestone 5 → Echad Vothui (Heledhris, Rift of Shornshards)** on November 8. This establishes the reported single-row path. It does not establish two independent rows surviving two uses, all quickslot surfaces, all characters, or localization. That wider runtime coverage remains to be recorded.

### Production trust requirements selected for later work

- Require a fresh successful-use event attributable to exactly one known TWII milestone activation before automatic used-row correction.
- Character-recipient checks and text matching alone do not make arbitrary player chat authoritative. The current broad debug scan is not the final production ChatType/trust policy.
- Do not identify an external native-hotbar cast through TWII mouse handlers; external-travel policy remains a later decision.
- Shared cooldown changes, regional-channel joins, unchanged coordinates, missing messages, and arbitrary loading delays cannot independently prove which skill succeeded.
- Preserve exact observed name, territory, locale, and provenance even when no catalogue entry resolves. Reliable slot-to-text knowledge can exist without a physical marker.

## 4. New Companion author evidence: name, area and icon

Source: the stakeholder's supplied explanation from LotroCompanion's author, received in this task on 2026-11-14. This corroborates and clarifies the [public-source trace](2026-11-08-name-origin-and-database.md).

### Registry and anchor contract

The author describes the main character's client-memory **travel registry** as a collection of **travel records**. Each has:

1. A type, most mapping to a milestone slot.
2. A position: latitude, longitude, and world region.
3. Possibly a name.

Companion reads the recorded name from memory. The author did not investigate how the game originally computes that name because the name was already supplied. From position, Companion computes an enclosing area or dungeon and obtains the appropriate milestone icon. The supplied `zoneID` is therefore enriched geographic context; do not assume it is a raw travel-registry field.

The author supplied this example for the main milestone at Ilzag Khûl:

```xml
<anchor type="3" name="Ilzag Khûl">
  <position region="5" longitude="-61.44319" latitude="-26.551659" zoneID="1879487057"/>
</anchor>
```

The enclosing area is Paths of Khegûl (`1879487057`), whose territory parent is Urash Dâr (`1879487114`):

```xml
<area id="1879487057" name="Paths of Khegûl" parentId="1879487114" iconId="1092947644"/>
```

| Presentation part | Provenance in the author's example |
|---|---|
| `Ilzag Khûl` | Name already present in the character's memory travel record. |
| `Paths of Khegûl` / `1879487057` | Enclosing local area computed from position. |
| `Urash Dâr` / `1879487114` | Territory-level parent used in the displayed destination context. |
| `1092947644` | Icon from Paths of Khegûl; Urash Dâr has no own icon in this example. |
| `Return to Ilzag Khûl (Urash Dâr)` | Native travel skill presentation described by the author. |
| `Return to bound milestone: Current home location - Ilzag Khûl (Urash Dâr)` | Native description described by the author. |

The icon source and displayed territory can therefore be **different levels of the geographic hierarchy**. A settlement-name lookup, territory-only icon lookup, or inference that icon uniquely identifies a milestone would lose information.

This is one concrete example plus the author's general explanation. It does not prove that every native description follows this exact punctuation/parent traversal, that every area has an icon, that the same rules apply in every locale/interior, or that Lua `SkillInfo:GetName()` / `GetDescription()` exposes this dynamic native text. E01 remains a useful separate experiment.

### Public source and character-export corroboration

The inspected trace is:

```text
client memory import → travel registry → type/name/position
  → AnchorStatus → per-character anchors.xml → Companion milestone panel
```

[TravelRegistryExtractor](https://github.com/LotroCompanion/lotro-data-extractor/blob/d9a854220477675721f7264f8a57974bdf025ad8/src/main/java/delta/games/lotro/extractors/travels/TravelRegistryExtractor.java#L41-L72) reads registry attribute `194458403`, name attribute `47172757`, and position attribute `111647278`. The public Companion application invokes its external memory dependency. The current dependency's full source was not located in the inspected public repositories; an older published binary's symbols corroborate the bridge, with the version limit documented in the name-origin report. No memory library was executed by this research.

The per-character skill-to-anchor join is explicit:

```text
character skills.xml skill.id
  → reference skills.xml travelSkill.identifier
  → reference travelSkill.travelType
  → character anchors.xml anchor.type
```

`anchors.xml` carries names without `Return to` or parenthetical territory. The inspected root does not carry character/server identity or game-observation time. Modification time is not that observation time. Any later importer needs surrounding identity/freshness metadata and preview/conflict handling.

The earlier source review found no complete static milestone-name table. The author's new explanation **does not supply one**; it confirms why individual character bindings can have exact names even though the global marker list has generic labels. No translations of the unobserved names were supplied. Nearby landmarks, stable destinations, and geographic names remain candidates/context rather than proven bind names.

### Author counts versus audited counts

The author estimates roughly 350 milestones and roughly 10 DIDs representing different shapes. The pinned full inventory has **351 markers and 14 shared template DIDs**. These are compatible at the level of an approximate explanation; preserve the exact audited result for that snapshot and the author's approximation as an attributed statement. Neither is proof of live accessible/bindable coverage.

## 5. Existing data inventory and identity constraints

### Marker catalogue

The refreshed [inventory evidence](evidence/2026-11-08-marker-scan.json) scans all **459** marker XML files at `lotro-maps-db` revision `2e707ebf14162607f586ecf2948f97fc212090d0`, selecting **category 55 / Milestone**. Every retained marker label is exactly `Milestone`.

| Raw world-region code | Markers |
|---:|---:|
| 1 | 96 |
| 2 | 98 |
| 3 | 25 |
| 4 | 61 |
| 5 | 58 |
| 6 | 12 |
| 14 | 1 |
| **Total** | **351** |

All 351 have distinct marker IDs and distinct world-region/latitude/longitude triples in that snapshot. Parent-zone IDs resolve across `geoAreas.xml` and five dungeon entries: Gath Forthnír, Thorin's Hall, Hall of Vérnozal, Annâk-khurfu, and Vestibule of Utug-bûr. Area resolution provides context, not exact milestone name.

The old [September audit](catalogue-audit.json) has 339 markers from 445 files at a different revision. Its complete-marker totals, camp-site scan, spacing analysis and projection screening were not recomputed for the refreshed 351 dataset. Preserve both source revisions rather than combining their statistics.

An inspected upstream classification/duplicate-merging path can prefer Camp-site over Milestone, and an object type named Milestone can include campfires. The historical category-57 scan found 137 camp-sites, with no exact same-region coordinate or shared template DID in the 339 milestone subset. This is a completeness/classification caveat, **not evidence to add 137 missing milestones**.

### Stable identity

Marker IDs are generated geographic/block-related source IDs, not guaranteed durable destination identities. Seven changed marker IDs were found at identical world coordinates between the old and refreshed snapshots; their pairs are retained in [ID-change evidence](evidence/2026-11-08-marker-id-changes.json). One source ID is signed-negative. Preserve source IDs as strings; do not migrate by row index, assume unsigned conversion, or identify destinations solely by template DID.

Use independently maintained TWII destination keys and reviewed source-ID aliases. Retain explicit namespaces for `skillId`, `travelLinkCode`, `destinationKey`, `worldRegionCode`, `geoAreaId`, `sourceMarkerId`, `templateDid`, and `mapId`.

### Named research subset

The existing [named database](named-catalogue/README.md) has **37 destinations**: 42 imported bindings across 12 character snapshots yield 36 names; the verified Echad Vothui message contributes one further destination. Its 43 position observations preserve imported anchors separately from the Echad Vothui named-landmark position. **314 markers without supported exact names are omitted** from that named output. Ilzag Khûl's new author-supplied observation is additional evidence in this knowledge base and the new catalogue proposal; it has not silently altered the earlier 37-entry snapshot. The proposal therefore distinguishes 37 previous observed names, one additional author-reported name, and 313 markers without an observed/reported name; all marker associations remain inferred.

All named-marker links are labelled spatial candidates, not explicit upstream foreign keys. The offline research screening used a maximum separation of 0.1 game coordinate degrees, runner-up ratio at least 3, same known world/zone, and consistent candidates across repeated observations. All 37 passed, with a minimum actual runner-up ratio above 91. These thresholds are **research settings, not production-approved tolerances**.

The maximum imported-anchor separation was approximately 0.038543; Echad Vothui's landmark/object difference was approximately 0.044999. Several names have differing anchor positions in different snapshots. Keep names/observations and their source kinds; do not describe one representative coordinate as the uniquely established arrival point.

## 6. Supplied wiki locations: useful evidence with limits

Source attachment: `C:\Users\wojci\.codex\attachments\0a5b78eb-75a6-4dfb-b4c9-7c1db9a6f62b\Pasted text.txt`.

Snapshot metadata: title **Milestone - Lotro-Wiki.com**, page ID `19552`, revision `2078902`, English. SHA-256: `86F46EAFC365A03B8A7060638E23F32B662A6ACF88AF82D2CBB13B0D1A736A6C`. The HTML was read as data; its scripts were not executed. The revision identifies the supplied content, not a live freshness check.

The location tables provide settlement labels, subarea labels, rounded latitude/longitude, notes, and page links grouped by broader geography. They are useful **name candidates and approximate position observations** for a catalogue proposal. The stakeholder explicitly says the page is incomplete; no extraction should call it an exhaustive list.

Concrete review cases from the supplied snapshot:

- **Ilzag Khûl / Paths of Khegûl**, `26.5S, 61.4W`, agrees approximately with the author's more precise world-5 anchor. Wiki rows do not independently supply that raw world-region code.
- **Hobbiton** is the wiki settlement label at `31.4S, 71.1W`, while the character export records **Hobbiton-Bywater**. Settlement labels are not necessarily native destination text.
- **Dale** appears twice; **Erebor** has interior and exterior entries; **Minas Tirith** has different tiers and story variants; **Lond Cirion** has two noted positions. Preserve qualifiers and rows rather than deduplicating solely by name.
- **Ost Lontir (King's Gondor)** and **Tadrent (King's Gondor)** share the displayed coordinate `74.9S, 65.7W` in the snapshot. **Iridír** and **Sûru** share `21.8S, 81.0W`. These are ambiguity/data-review cases; rounded equal coordinates do not prove one physical destination or a valid alias.
- A King's Gondor row and its pre-battle counterpart can share a display coordinate. A geography heading is not a substitute for the datamined world/story context.
- The page has rounding variation (mostly one decimal, with exceptions), spelling/punctuation variation, and places whose displayed wiki area differs from the datamined enclosing area. Preserve the original and avoid exact-string-only joins or pretending rounded positions have marker precision.

Suggested use: retain each wiki row's original name, coordinate text, linked-page targets, enclosing headings, notes, source revision and derived signed coordinates; propose spatial associations only after compatible context and ambiguity checks. Promote a name to exact native milestone status only with stronger evidence or explicit review. Missing names/translations remain missing rather than synthesized from a nearby settlement.

The [offline catalogue proposal audit](catalogue-proposal/audit.json) extracts **309 coordinate rows from 49 location tables**, recovering one row by ignoring a trailing empty cell and reporting no missing-coordinate rows. Its deliberately provisional all-world distance screening at **0.15 coordinate units** finds 260 rows with one spatial candidate, 27 ambiguous rows and 22 without a nearby marker. The one-candidate rows reference 259 distinct markers because Iridír/Sûru select the same marker. These are reproducible screening counts, **not approved matches or a runtime tolerance**: the all-world comparison intentionally exposes overlapping world contexts and supplies no native-name confirmation.

## 7. Location capture and coordinate model

### Slash command versus inline expansion

`/loc` requests game location output. `;loc` expands location inline in a user-triggered command/Alias. They are different mechanisms. MoorMap provides a concrete localized Alias pattern such as `/Moormap setloc ;loc`, with `;pos` for German in the inspected source; it passes expanded location directly to its own handler.

Choose commands/expansion from **actual game client language**, independently of TWII's chosen UI language. MoorMap uses slash forms `/loc` (EN), `/pos` (DE), and `/emp` (FR). Current EN/DE/RU location fixtures, especially inline expansion, still require runtime validation; do not invent a Russian spelling from UI language names.

The proposed trial payload is `/trav milestone-capture <skillId> <token> ;loc`, adapted to verified client syntax. The physical click supplies the user action; the token associates that sample with a live popup/session. Validate token, learned supported skill, freshness, parsed context and expanded location. A token cannot prove the player remained beside the milestone where they originally bound.

### Coordinate namespaces and provenance

Keep these separately typed:

1. Static milestone-object position.
2. Imported character anchor position.
3. User-captured position near the stone at bind-review click time.
4. Measured post-travel player arrival position.
5. Named landmark position.
6. Wiki rounded position.
7. Representative overview-map anchor or deliberately offset collision-avoidance position.

The stakeholder's safe-arrival-point explanation is plausible: a player should not arrive inside the physical object. The current evidence is consistent with it but does not establish whether each anchor is a fixed safe arrival point, depends on bind position, or has another origin. E06 should measure repeated binds and arrival positions. Do not calibrate arrival tolerances from landmark or wiki offsets.

MoorMap's inspected normalization is:

```text
east  = (floor(lx / 8) * 160 + ox - 29360) / 200
north = (floor(ly / 8) * 160 + oy - 24880) / 200
```

Preserve raw region, landblock, offsets, height, instance/interior indicators and sample time before conversion. This is source evidence, not a universal proof for every current-client location format/interior. Marker records lack height and explicit instance metadata; do not invent them.

Filter/rank candidates in compatible world/interior/story context before measuring coordinate distance. Require calibrated absolute distance **and** separation from alternatives. Do not borrow MoorMap's treasure threshold `0.2121`, use terrestrial distance units, force nearest-at-any-distance, or infer missing context from the expected saved binding.

The delayed-click failure remains: bind at A, leave the prompt open, walk nearer B, then request location. The sample genuinely describes B at click time. Show what was sampled and require confirmation; a later attributable successful use can heal the actually used row. Dismissing the popup or choosing the wrong skill also leaves recoverable uncertainty.

## 8. Native tooltip and click handling: established versus trial

The [detailed feasibility note](2026-11-09-native-tooltip-and-location-click.md) records primary API/source references and E11.

| Technique | What is supported or unknown |
|---|---|
| Real skill quickslot plus mouse-transparent number/image | Established layering pattern; normal input reaches the skill. Stable numbers should come from skill ID. |
| Alias quickslot masked with skill icon | Established user-clicked command pattern; its native tooltip remains the Alias tooltip, not the dynamic skill tooltip. |
| `SetMouseVisible(false)` | Routes all mouse messages underneath; no documented independent hover/click pass-through switches. |
| Calling Lua `MouseEnter` / `MouseLeave` manually | Does not establish the client's native skill tooltip. |
| `SetEnabled(false)` / right-click options | No inspected documentation guarantee of retained native tooltip plus alternative left-click action. |
| Replace Skill with Alias during MouseDown | **Trial hypothesis:** native shortcut resolution may happen before or after MouseDown. Must test actual action, not infer from Lua logs. |
| Change Alias in MouseClick | Historical author evidence warns this can interfere with activation; deferred update is used after the native action. |

The desired local trial keeps the real milestone skill at rest, changes to a location Alias on MouseDown, lets the physical click activate it, then closes/restores after capture or validated deferred cleanup. It applies **only to the bind popup**. Normal travel quickslots continue casting their real skill.

Runtime success requires the actual native tooltip with current destination, exactly one location command associated with the intended skill, and **no unintended milestone cast**. Check immediate click without hover, tooltip delay, left/right/double click, press-drag-release outside/inside, drag/drop, close/Escape, timeout, debug-off, and unload. Alias-to-alias ordering tests or a hover log alone do not prove skill-to-alias safety.

Removing the underneath label and adding unobtrusive numbers over quickslots across views are separately recorded design candidates, not an automatic scope extension of the trial. Sorting can make visible numbers nonascending; preserve custom/alphabetical order rather than renumbering identities.

## 9. Selected product requirements

| Decision | Recorded direction |
|---|---|
| Q1 / target | B: reliable tracking, successful-use repair, then production integration, maps last. |
| Q2 / bind prompt | A: generic bind signal triggers a small review/location flow; Later/dismissal remains possible. |
| Q3 / effective names | A: `Destination · Milestone N`, alphabetical sorting by effective label when alphabetical mode is selected. Preserve custom order. |
| Q4 / mismatch | Strong fresh attributable use should self-heal the used row. Ambiguity uses the existing manager and Fix now/Later fallback. |
| Q4 / fallback prompt | Medium-sized, active Classic/Mini style, movable, saved/reused position, initially to the right to reduce interruption. Focus/input-blocking detail remains open. |
| Q5 / slot choice | A: reuse learned set; skip choice for exactly one learned skill; labelled choices for multiple/gapped skills. Show suggested bind-time location and require confirmation before saving. |
| Q6 / maps | A: all learned/enabled milestone shortcuts remain available in the tray on all five segmented maps, even when also drawn on their own map. |
| Q7 / coverage | A: all supported catalogue destinations usable in text; draw only reviewed map placements. No fabricated placement for missing coverage. |
| Q8 / wrong-slot repair | Guided transaction with both affected rows previewed; guarded restoration from history, plus single-row edit/forget and undo. |
| Q9 / language | Initial detection EN/DE/RU; new milestone UI text may remain English on ES/RU. Parser language follows the client, not UI copy. FR first-release detection is not promised by this choice. |
| Companion import | Later convenience feature; offline use of exported anchors to curate the global research catalogue is independently useful. |
| Current diagnostic slice | `TravelDebugEnabled`, memory only, no production-view integration or saved binding data. |

### Delivery order and boundaries

1. **Tracking foundation:** first a small diagnostic popup/location/text-table proof (1a), then persistent, character-scoped diagnostic tracking and review (1b). The already working bind-selection/use-text prototype is a smaller stepping stone; the new hover/location experiment remains debug-only.
2. **Repair before normal views:** successful-use automatic used-row correction, revisions, bounded before/after history, guarded undo, and manager fallback/wrong-slot correction.
3. **Production integration:** text/list/pulldown naming first (3a), then map markers/overlap handling and tray access across five maps (3b). Do not make map calibration a blocker for the earlier diagnostic iterations.

Milestone observations must not leak through account defaults. Future persistence needs character identity, schema/version handling, explicit unsaved/error status, and recovery. Keep transient click/capture contexts session-local. No arbitrary filesystem access, live Companion memory reader, network polling, or execution of pasted Lua is assumed available in a plugin.

### Repair invariants

- A clear successful use can repair only the used skill. If the player earlier chose the wrong row, that mistaken other row remains unresolved until its own later use or guarded manual repair. Never infer a swap.
- Keep exact observed text even without catalogue resolution. Remove a contradicted old map association from current confirmed presentation rather than drawing it as if it matched the new text.
- Guard changes with session/revision/freshness checks; preserve before-images and provide undo. An old success cannot overwrite a newer bind/edit.
- Duplicate unchanged success is idempotent; it should not create repeated history or prompts.
- A location sample, absent chat, cancelled cast, or failed parse is not a negative verdict on the game's binding.
- An unresolved generic rebind makes the overall set potentially stale without proving every row wrong. Keep an honest set-level reminder and dated row evidence.
- Two rapid binding events are not automatically duplicates. A current sample cannot reconstruct both historical bind locations.

Inventory travel-map items, housing ownership/ports, route optimization, passive cooldown modelling, and automatic game rebinding are separate features.

## 10. Maps and reference implementations

TWII already has map mode; the historic proposal to make maps a full mode is not automatically a remaining dependency. Its logical maps use a 1024×768 canvas. Physical-world region codes, geographic hierarchy and TWII map IDs are different namespaces. In particular, region-4 naming in older plugin comments conflicts with some geographic hierarchy labels; keep the raw coordinate region.

MoorMap provides useful transforms and source-backed prompt/parse patterns, but Haradwaith transform values are explicitly estimated. The **historical 339-marker** arithmetic screening put 250 unique marker centers inside at least one compatible overview canvas; 89 were outside or unscreened. This is not calibration or a coverage verdict for the newer 351 set. Interior representative anchors and map overlap selection require separate review. Never feed displaced map icons back into proximity matching.

| Reference | Transferable lesson and limit |
|---|---|
| Voyage / Homeopatix | Manual destination list and right-click map preview; per-slot saved catalogue indices. No automated chat detector found in inspected 3.48/3.49 source. Indices are a migration hazard, not a suitable TWII identity. Supplied video demonstrates interaction only. |
| MoorMap | Chat-triggered prompt, physically clicked location Alias, locale parsing, world normalization, compatible matching, annotations and multiple maps. Treasure thresholds and once-per-character cache rules do not transfer to repeatable rebinding. Its 348 static milestone annotations, including duplicated/mostly generic labels, are not a complete exact-name database. |
| TravelRef | Manual assignment and character persistence; inspected source includes an ID/order discrepancy, reinforcing explicit identity mapping. Route optimization is out of scope. |
| TitanBar | Concrete localized regional-channel listener; regional notices remain coarse optional evidence, superseded as the primary repair signal by successful-use text. |
| SequenceBars / Thurallor controls | Number overlays and masked Alias interaction patterns; whole-control input routing, not demonstrated native-hover/independent-click behavior. |

The existing `twii_miner` generator produces curated skill/locale outputs. A separate milestone-catalogue output with map/geography sources, durable destination keys and reviewed overrides is a proposed maintenance direction. Generator ownership and missing-name/translation curation remain decisions, not an agreed upstream change.

## 11. Remaining work, ordered by impact

1. **E11 trial acceptance:** does MouseDown precede native shortcut capture, preserve genuine dynamic tooltip at rest, and avoid travel for every popup interaction? Record exact logs/actions and client locale; fail honestly if native ordering prevents it.
2. **E03 location fixtures:** capture real expanded EN/DE/RU payloads, raw context, malformed/instance/interior variants, and localization. Confirm token lifecycle and candidate parsing separately from game action ordering.
3. **E04 production successful-use trust:** raw event category/body, recipient/actor semantics, duplicate/order behavior, alternate/cancelled actions, two learned skills/destinations, expiry and stale revisions. One confirmed debug row is not broad acceptance.
4. **E06 proximity calibration:** measured standing-at-bind and post-arrival samples across worlds, interiors, story versions and boundaries; compare nearest alternatives. Marker-to-anchor offsets alone do not set a runtime radius.
5. **Catalogue quality:** exact names versus wiki labels; translations, identity changes, duplicate names/coordinates, classifying bindable entries, upstream update/migration ownership and independently reviewed associations.
6. **E01 dynamic Lua metadata:** native tooltip clearly has dynamic information, but exposure through current/fresh `SkillInfo` remains unverified. This could simplify future interaction; do not assume it.
7. **E08 persistence, later iteration:** character isolation, save failure/readback/unload/reload, malformed/newer schema, bounded history and recovery semantics. None is part of the current memory-only trial.
8. **E09 map calibration, last iteration:** exact assets, scale, holdout points, interior representatives, overlap interaction and unprojectable locations.

Product details still open include queue/coalescing presentation, fallback focus behavior, history visibility/retention, local custom-destination scope, external-hotbar observations, supported slots beyond 11, destination-level sorting source, and catalogue generator ownership. See the [questionnaire](questionnaire.md); do not reopen already selected Q1–Q9 directions merely because an old section still says “undecided.”

## 12. Source map and reproducibility

| Source | What to consult |
|---|---|
| [Research](research.md) | Detailed pinned sources, local reference-plugin fingerprints, API feasibility, classification and older map audit. |
| [November 8 findings](2026-11-08-findings-and-developer-notes.md) | Runtime reports, exact toon-00002 join, 351 inventory, marker-ID changes, MoorMap annotations and coordinate examples. |
| [Name-origin trace](2026-11-08-name-origin-and-database.md) | Public import chain/dependency boundary, name source, named subset contract and deterministic offline rebuild. |
| [Tooltip/location feasibility](2026-11-09-native-tooltip-and-location-click.md) | API/source evidence, limitations and detailed E11 test design. |
| [Proximity/self-healing plan](../2026-11-09-milestone-proximity-and-self-healing.md) | Latest full-feature direction before this narrow trial. |
| [November 14 execution plan](../2026-11-14-milestone-knowledge-catalogue-and-hover-trial.md) | Three-agent knowledge/catalogue/trial scope and current implementation boundaries. |
| [Specification](specification.md), [scenarios](scenarios.md), [validation](validation.md) | Proposed model, eleven worked edge cases, E01–E11 and A01–A49 acceptance scenarios. These are not all implemented. |
| [Named subset](named-catalogue/README.md), [builder](tools/Build-NamedMilestoneCatalogue.ps1) | 37 observed names, identity ledger, separately typed positions, offline research screening; keep original evidence and ledger. |
| [351-marker CSV](evidence/2026-11-08-milestone-catalogue.csv) | Complete pinned generic marker subset, separated from named observations. |
| [Catalogue proposal audit](catalogue-proposal/audit.json), [wiki observations](catalogue-proposal/wiki-observations.json), [screening CSV](catalogue-proposal/wiki-screening.csv) | Newly extracted wiki evidence and provisional associations; no wiki names promoted to exact native destination names. |
| Supplied author message and wiki snapshot | New evidence preserved and attributed in sections 4 and 6; no extra outreach or live wiki verification implied. |

Pinned modern source revisions used by the existing research:

| Repository | Revision |
|---|---|
| `LotroCompanion/lotro-data` | `7097ff870cdeace51b7b34debc38b6a9969ae0c4` |
| `LotroCompanion/lotro-maps-db` | `2e707ebf14162607f586ecf2948f97fc212090d0` |
| `LotroCompanion/lotro-core` | `2356eef3c74140db0cebfae5b5c7a91b7839330f` |
| `LotroCompanion/lotro-companion` | `fa4c084467b3c957d1660d2fb847e6ea42e1f228` |
| `LotroCompanion/lotro-data-extractor` | `d9a854220477675721f7264f8a57974bdf025ad8` |
| `LotroCompanion/lotro-tools` | `bcda345998795b447f94d1e53fd117ad161f882c` |
| `LotroCompanion/lotro-companion-distrib` | `527341b7176a0ee1e55f35b7648b83a5c4a9acbc` |

Do not silently upgrade revisions or counts when rebuilding. New rows/aliases/renames, source marker reassociations, names/translations and match tolerances require their own source attribution and review.
