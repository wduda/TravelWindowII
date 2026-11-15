# Milestone management research dossier

Publication boundary, 2026-11-15: this branch checkpoint publishes documentation, plans and static research evidence/catalogue data only. The prototype plugin changes, generation/validation scripts and standalone Lua format example remain local and uncommitted. Implementation reports describe that local prototype; links to those code files will become available when the implementation is committed separately.

## Current handover: 2026-11-14

[Geographic catalogue enrichment](2026-11-14-geographic-catalogue-enrichment.md) now supplies labels for all 351 markers: 38 observed/reported names, 258 wiki-labelled candidates and 55 explicitly provisional geographic labels. Typed area/dungeon chains, territory IDs, separate coordinate/geographic region IDs and icon provenance are included in the [full CSV](catalogue-proposal/debug-catalogue.csv). The [55 fallback entries](catalogue-proposal/geographic-fallbacks.md) remain excluded from exact skill-name prediction. No numeric IDs, positions or prior named evidence changed.

Temporary [character-only debug checkpoints](2026-11-14-debug-persistence.md) are implemented behind `TravelDebugEnabled`: `/trav debug-store load|save|clear|status`. The isolated file stores numeric IDs/evidence/version metadata using decimal strings, with manual saves and guarded logical cleanup. First-run initialization is **clear → wait for acknowledgement → load**, before collecting test records. Live PluginData disk/callback acceptance remains pending.

The [latest picker increment](../2026-11-14-milestone-picker-two-click-assignment.md) explicitly instructs two clicks, removes below-icon labels while retaining number badges, and closes after valid location delivery. A clear named match fills the selected skill's session row with **[guess]**; successful travel confirms or corrects it. Manual LOC remains comparison-only. This revised layout/assignment needs an in-game check.

The debug result now predicts the English travel label, for example `Return to Hobbiton-Bywater (The Shire)`, from supported name/territory evidence. The large window has an **Open picker** button. **The stakeholder confirms that the picker requires two clicks and then updates the debug window with the correct identified location.** The first press installs the Alias; the next reuses it for capture. See the [current plan](../2026-11-14-milestone-picker-result-and-reopen.md) and [trial procedure](2026-11-14-mousedown-trial.md) for the remaining acceptance cases.

The stakeholder reports correct manual LOC nearest-marker/name results at at least three milestones. The [debug comparison](2026-11-14-catalogue-debug-guess.md) now displays only the calculated closest marker, retaining location/context and uncertainty diagnostics.

Final scope clarification: `;loc` is allowed in the **learned-skill picker and the explicit manual LOC test quickslot in the debug window**. Regular-view clicks only remember the travelled skill for successful-use reconciliation; they do not request location or change quickslot activation. The manual debug action has been restored. See the [clarified plan](../2026-11-14-milestone-picker-only-location.md).

The [picker polish and focused review](2026-11-14-picker-review.md) adds mouse-transparent milestone-number badges, retains the below-icon text and moves the initial picker to the right. The review reuses the existing chat subscription, skill lookup and location parser. [Disposable debug-storage research](2026-11-14-disposable-debug-storage.md) proposes an isolated, removable experiment store; it remains research only.

The debug increment includes a [351-marker runtime catalogue and location comparison](2026-11-14-catalogue-debug-guess.md): 38 observed/reported names, 258 wiki-labelled candidates and 55 geographic fallback labels. It uses an append-only numeric-ID ledger and keeps capture separate from explicit temporary checkpoint saves. [Character-only persistence research](2026-11-14-character-storage.md) defines the broader storage rules; production persistence remains deferred.

Start with the [developer knowledge base](knowledge-base.md): it consolidates the stakeholder decisions, live chat observations, Companion author's explanation, supplied wiki snapshot and existing research, with evidence and uncertainties separated. Companion reads the anchor name from memory; it computes area/dungeon context and the skill icon from the position. This does not reveal a complete static table of destination names.

The [catalogue format proposal](catalogue-format.md) keeps the pinned 351 markers, observed names and rounded wiki positions as separate evidence. Candidate proximity joins are not authoritative destination identities. The existing [37-name database](named-catalogue/README.md) remains an observed subset.

The debug-only [MouseDown trial](2026-11-14-mousedown-trial.md) is implemented on `codex/milestone-learning-debug`; it does not autosave or integrate with production views. Temporary checkpoints are explicit commands. Lua 5.1/offline guards pass, and the stakeholder reports hover/badge/Alias behavior plus successful two-click capture. Exact native event order and the full no-unintended-travel/edge-case matrix remain unverified; this is partial E11 acceptance. The [execution plan](../2026-11-14-milestone-knowledge-catalogue-and-hover-trial.md) records the original limited authorization.

The dossier was brought into this checkout from the preserved `milestone-management-research` branch (research head `4f2da08`). Older dated reports below describe their original snapshots and scope, not the latest implementation status.

## Latest direction: 2026-11-09

[Native tooltip and location-click feasibility](2026-11-09-native-tooltip-and-location-click.md) separates the proven icon/number-over-Alias pattern from the unverified native-skill-hover/alias-click combination. MoorMap's inline `;loc` command pattern can carry selected skill and request context in one user action. A focused E11 probe is planned, not implemented or executed; numbering across normal views remains a design candidate.

The stakeholder selected **bind-time proximity capture followed by self-healing on successful use**. The [updated implementation plan](../2026-11-09-milestone-proximity-and-self-healing.md) and specification draft **0.17** make automatic correction the normal iteration-2 path when a fresh trusted message belongs to the exact clicked skill. Location suggestions still need bind-time confirmation. Ambiguous evidence uses the existing manager; exact observed destination text can be retained while catalogue/map resolution is pending. The stakeholder reports contacting LotroCompanion about exact names and translations; no assistant outreach is implied.

## Latest evidence: 2026-11-08

The subsequent [name-origin trace and named database](2026-11-08-name-origin-and-database.md) follows Companion's display through saved anchors to client-memory import. The [readable named catalogue](named-catalogue/README.md) contains **37 observed names** with coordinates, identifiers, area hierarchy and explicit spatial-candidate status; **314 unknown-name markers are omitted**. It combines 42 exported bindings from 12 character snapshots with the verified Echad Vothui example. No complete global bind-name table was found in the inspected public source.

Read the [findings and developer requirements supplement](2026-11-08-findings-and-developer-notes.md) before using the older proposal below. It records the stakeholder-confirmed one-skill debug success, current prototype boundaries, an actual 11-skill Companion export, the refreshed **351-marker / 459-file** inventory, MoorMap's **348 static milestone annotations**, and seven upstream marker-ID changes at unchanged world coordinates. All 351 refreshed marker labels are still generic. The older **339-marker** audit remains a pinned historical snapshot; its camp-site and projection checks were not rerun for the refresh.

The current authorized implementation is debug-only bind-slot selection and successful-use mapping in an in-memory table, with no persistence or production-view integration. This is smaller than draft 0.16's proposed location-capture slice. Character import remains deferred; automatic used-row correction is now the selected future design direction under the 2026-11-09 plan, not a change to the current prototype. The supplement includes a complete extracted catalogue and supporting evidence under `evidence/`.

Prepared 2026-09-25 on `milestone-management-research`, based on local `v4.11.0` commit `5a06283991a57e63cb7db3bb37170521ce7f92a5`. Research and documentation only; no plugin code or release metadata changed. This is an evolving proposal for stakeholder review, not an approved implementation specification.

## Recommended direction

Build a character-specific milestone manager with a complete manual workflow, then add evidence-based assistance around it. Preserve the player's accepted records, keep inferred observations separate, and make wrong-slot corrections reversible. Named destinations and map markers should derive from the same binding model.

The stakeholder selected target **Q1=B**, delivered as three reviewable iterations: **1a) debug-only popup/location/text-window proof; 1b) persistent tracking in the diagnostic workflow; 2) successful-use repair against those records; 3) production text integration followed by map presentation across the five segmented maps.** Iteration 1's diagnostic manager writes and reviews character records without changing normal travel views. The user-verified successful-use messages pair with the clicked quickslot ID to identify the slot and reported destination; they appear only after quick travel succeeds. Regional channels are not required for this primary path. E04 remains to validate ChatType, ordering/duplicates, locale variants and parser boundaries. The Q4 prompt should be medium-sized, match Classic/Mini styling, be movable, save/reuse its position and open to the right initially; focus/input blocking remains open. The 2026-11-09 direction selects automatic correction from strong attributable successful-use evidence, with history/undo and fallback review for ambiguity. **Q2=A** remains a small bind prompt with Later; **Q3=A** uses `Destination · Milestone N` and alphabetical sorting by that effective label; **Q5=A** reuses reliable existing learned-skill identification, skips slot selection when exactly one is learned, and uses labelled rows for multiple learned skills; the bind-time proximity suggestion needs confirmation before saving; **Q6=A** keeps the map tray available across all five maps in iteration 3b; **Q7=A** keeps all catalogue entries usable in text and draws only reviewed map placements; **Q8=A** uses a guided wrong-skill repair with a two-row preview and guarded restoration of the overwritten value in the manager in iteration 2. Detection starts EN/DE/RU, while new milestone UI copy may remain English for ES/RU clients initially. These decisions and the self-healing update are in specification draft 0.17.

TWII already reads the character's trained skills and matches them against known travel shortcuts; the stakeholder confirms learned-skill identification, including multiple skills, has worked reliably for a long time. A verified single learned milestone skill identifies the slot by exclusion; with multiple learned skills, location capture alone cannot identify which one changed. Separately, test whether the skill-description API exposes the bound destination dynamically.

## Reading order

| Document | What it provides |
|---|---|
| [Proximity and self-healing plan](../2026-11-09-milestone-proximity-and-self-healing.md) | Latest stakeholder direction, automatic used-row correction, missing-name treatment, edge cases and iteration gates. |
| [Name origin and named database](2026-11-08-name-origin-and-database.md) | Source trace, public-dependency boundary, 37 named research records, schema, offline rebuild and exclusions. |
| [2026-11-08 findings and developer requirements](2026-11-08-findings-and-developer-notes.md) | Latest runtime reports, exact character anchor joins, refreshed inventory, marker-ID changes, name/position matching evidence, MoorMap patterns, and remaining validation. |
| [Research and evidence](research.md) | Source-linked feasibility, TWII integration points, reference-plugin/video findings, data audit, Companion import and limitations. |
| [Proposed specification](specification.md) | Data model, evidence rules, UI journeys, repair transactions, map/text behavior, persistence and the three iteration gates, including the 1a debug slice. |
| [Stakeholder questionnaire](questionnaire.md) | Recorded choices including Q4 self-healing direction; remaining interaction/data decisions and runtime validation. |
| [Worked scenarios](scenarios.md) | Eleven concrete walkthroughs, including the successful-use-message mismatch prompt and one-/multi-skill paths. |
| [Validation plan](validation.md) | Eleven runtime experiments and 49 future acceptance scenarios; distinguishes completed static work from unperformed game tests. |
| [Catalogue audit](catalogue-audit.json) | Machine-readable source facts, all 339 category-55 records, geographic joins, source manifest and arithmetic projection screening. Research data, not a production catalogue. |
| [Research plan](../2026-09-25-milestone-research.md) | Scope, working agreement and progress. |

## Most consequential findings

- **Concrete import source:** Companion persists a character's anchor types, names and positions in `anchors.xml`; a TWII bridge still has to be designed. Import freshness and character identity need metadata beyond that file's root.
- **Catalogue discovery is feasible:** all 445 marker files were examined, containing 4,354,284 records. The category-55 subset has 339 records. All have the generic label Milestone, so extraction does not finish destination naming.
- **Completeness needs a separate check:** the upstream merger can retain Camp-site over Milestone. A complete category-57 scan found 137 camp-site records with no shared template IDs or exact same-region positions in the milestone subset. That is a classification caveat, not evidence to include all campfires.
- **Geographic ambiguity is real:** ten pairs share identical coordinates across different world regions; five records require dungeon metadata. World regions must remain distinct from TWII map IDs and geographic-area hierarchy.
- **Skill counts and ordering are unsafe assumptions:** current TWII lists eleven milestone skills; game data contains definitions through sixteen, with non-sequential travel-link codes. The extra five are explicitly ignored in curated input; availability and the exclusion rationale remain unverified.
- **The generator was located:** public `whiterabbit963/twii_miner` consumes Companion data and TWII's curated TOML. A distinct milestone-catalogue output is a plausible extension; source marker extraction and stable destination keys are new work.
- **Detection limits remain runtime questions:** current bind-message ChatType/timing, DE/RU variants, dynamic descriptions, regional-entry attribution, arrival offsets and current storage behavior have not been tested in-game.
- **The English bind text is known:** “This location is now bound to your milestone skill.” It gives no slot or location. Manual slot selection and a requested location sample remain necessary unless E01 shows that Lua exposes better information.
- **Map coverage needs explicit policy:** borrowed transforms place 250 unique marker centers inside at least one compatible overview canvas in an arithmetic screening. That is not proof of map accuracy. The other 89 include unscreened region/interior cases and out-of-bounds points, not a claim that they are inherently unmappable.

## What the references establish

Voyage/Homeopatix provides a manual assignment and right-click map-preview pattern, also visible in the supplied video. MoorMap provides a chat-triggered, user-clicked location prompt and coordinate matching. TravelRef provides another manual slot/location editor. TitanBar provides a concrete localized regional-channel listener. None of these source inspections establishes accurate automatic milestone binding detection in the current client.

## Decisions with the largest architectural effect

1. Release scope, primary label, map tray, text/map coverage, detector languages and import deferral are decided. Q4's exact ChatType, locale parsing, ordering and duplicate handling remain open, alongside automatic-correction notification details and whether the fallback prompt blocks input or takes focus. The direction of healing from strong attributable successful use is selected. Slot-suggestion behavior, overlap handling and generator ownership also remain open.
2. EN/DE/RU runtime fixtures are still required. ES detection is outside the initial detector scope; milestone-specific UI copy may remain English on ES/RU clients.

## Risk register

| Risk | Effect | Proposed response |
|---|---|---|
| Wrong skill attributed to accurate coordinates | Confidently incorrect travel label/map icon | Separate slot/location evidence; user preview; transactional repair. |
| Stale observation or import | Newer accepted record overwritten | Binding revisions, session correlation, provenance, conflict preview. |
| Incomplete/renumbered upstream markers | Missing destinations or silent reassignment | Stable TWII keys, reviewed migration ledger, coverage reports and fallback records. |
| Generic names and story variants | User selects the wrong destination | Canonical names with context, search aliases, map preview and explicit qualifiers. |
| Approximate overview projection | Misleading precision or wrong-map placement | Independent projection quality; calibration; tray/manual fallback. |
| Detector unavailable in a language/client | Feature becomes unusable or noisy | Full manual path; detector-specific capability status. |
| Storage failure or account-default leakage | Lost or cross-character bindings | Character-only store, migration safeguards and tested save semantics. |

## Next review

Refine the remaining interaction and ownership choices and run the target-scope feasibility experiments. Keep the implementation order fixed: 1a debug proof, 1b persistent diagnostic tracking, iteration 2 use-based repair, then iteration 3 production text integration followed by map presentation last. The stakeholder has confirmed the successful-use signal on two destinations and that it appears only after quick travel succeeds; validate its runtime event type, locale variants, ordering and parser boundaries before iteration 2. Companion import is a later improvement. The repository's spec-driven execution workflow applies when implementation is authorized; research has not authorized implementation.
