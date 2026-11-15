# Feasibility experiments and acceptance plan

**Direction update (2026-11-09):** [Proximity and self-healing plan](../2026-11-09-milestone-proximity-and-self-healing.md) selects automatic used-row correction on fresh trusted successful-use evidence. These are future acceptance requirements, not a claim that the current debug prototype already performs persistent repair.

Original status: proposed experiment and acceptance plan. Subsequent authorization created a smaller debug prototype on `codex/milestone-learning-debug`; its scope and reported results are recorded in the [2026-11-08 supplement](2026-11-08-findings-and-developer-notes.md). This document does not authorize additional instrumentation or a broader feature.

## Follow-up results as of 2026-11-08

- **E02 / partial stakeholder acceptance:** the English bind confirmation opened the skill picker; choosing Milestone 5 printed the expected identification. A later report exposed accidental travel activation from picker selection; the follow-up select-only implementation still needs explicit acceptance.
- **E04 / partial stakeholder acceptance:** the user identified the successful-use text as Combat - Player and confirmed Milestone 5 -> Echad Vothui in both debug chat and the debug table. The handler observes all categories; raw API ChatType and message-body shape were not dumped. Timestamp/actor prefix are not required by the current English parser. Locale, duplicates, cancellation, and broader event-trust coverage remain open.
- **Two-row acceptance remains pending:** the user was waiting for cooldowns to test another skill. Do not mark independent retention of two destinations as runtime-verified.
- **E06 / additional static evidence:** actual exported Nashûbu and Ingarûma anchor coordinates differ slightly from nearby same-zone milestone objects. A separate Echad Vothui landmark-to-marker comparison is not an arrival measurement. The arrival-point explanation is plausible, not verified in-game; no tolerance is approved.
- **E10 / source and fixture evidence only:** read an actual character export with 11 named milestone bindings, exact skill-ID/travelType joins, precise positions, and two non-milestone anchors. This validates the data shape; it does not implement or accept the deferred import feature.
- **Catalogue refresh:** scanned all 459 marker XML files at `2e707ebf14162607f586ecf2948f97fc212090d0`, finding 351 category-55 markers with zero fetch/scan failures and all labels generic. This refresh did not repeat the old camp-site or overview-projection experiments.

The original experiment matrix below remains a checklist, not a claim that each experiment has been completed.

## What this research actually checked

- Inspected TWII baseline `5a06283991a57e63cb7db3bb37170521ce7f92a5` and local reference plugins.
- Inspected twelve sampled frames from the supplied 27.287-second video.
- Read primary-source game/API history and Companion source/data.
- Parsed all 445 marker XML files at pinned revision `063030b40ce85d173593de2e73cb7edde6ae1b53`, with zero failures, finding 339 category-55 markers among 4,354,284 records.
- Repeated the complete scan for category 57: 137 camp-site records; none shares a template DID or exact same-region position with category 55. Traced the upstream classification/merge rule and retained its completeness limitation.
- Joined marker parent IDs to geographic areas and dungeons; all parent IDs resolve across the two datasets. Counted repeated template IDs, generic labels, same-region spacing and cross-region identical coordinates.
- Screened marker centers arithmetically against compatible overview transforms, without asserting map accuracy or complete map coverage.
- Established source-level skill/travel-link mappings and an actual Companion anchor serialization path.
- Found the stakeholder's historical English bind-message capture and official historical native-name/tooltip behavior. Neither establishes current Lua event/API values.
- Inspected external `twii_miner` at `00367826c51e42045452bca0d93381f0c11909b6`; verified slots 12–16 are explicitly excluded in both its public curated input and this checkout's input. The generator was not built or run.
- Checked all 16 documented skill/travel-link mappings against pinned XML, marker manifest totals, projection arithmetic, local Markdown links and unique validation IDs.

The original static checks above did not demonstrate runtime behavior. The limited subsequent stakeholder-reported results are listed separately above; neither they nor static source inspection establish full acceptance of the experiment matrix, map calibration, or production UI.

## Runtime experiments, highest information value first

Record game build, server type, client language, character class, learned milestone count and loaded reference plugins. Use a character with at least two milestones for identity tests. Redact character/server identifiers in shared fixtures where they are not needed. Preserve message ChatType and event ordering, not general chat history.

| ID | Experiment | Procedure and observations | Decision it resolves |
|---|---|---|---|
| E01 | Direct description/binding access | Capture actual SkillInfo names/descriptions before and after rebinding two different slots; compare existing objects with freshly fetched objects and native examination/name/icon. Repeat after reload, with same-area destinations and with Beorning Return Home present. Inspect current supported API members for any new identity/binding access. | If exact slot/destination can be read reliably, simplify assisted UI and reduce heuristic dependence. Static templates, native tooltips and stale object reads are not enough to decide. |
| E02 | Binding signals | The stakeholder supplies the English text “This location is now bound to your milestone skill.” Rebind two slots to different stones; repeat same-stone bind, cancel native dialog and rapid rebinding. Capture current ChatType, delivery/timing, multiplicity and identifiers. Test EN/DE/RU clients and channel settings; confirm it contains no slot/location. | Current trigger reliability, EN/DE/RU strings and whether anything beyond the user's slot/location selection is exposed. |
| E03 | User-clicked location | Test parser and location command on EN/DE/RU clients; outdoors, interior, instance/layer, negative offsets, with/without heading. Compare location command and `;loc` alias expansion. Trigger another plugin's location request during TWII review. Verify manual fallback and English milestone UI copy on ES/RU clients. | Parser grammar, request correlation and locale-specific detector availability. |
| E04 | Successful-use message adapter | Stakeholder has already observed two locations and confirmed the line appears only after successful quick travel. In-game, capture ChatType, exact raw line, timing relative to the TWII quickslot ID, duplicate/order behavior and any locale variants. Verify parser boundaries around the dynamic Return to name and destination suffix; test names with punctuation/diacritics and ensure the clicked `Shortcut:GetData()` skill ID is paired with the right line. Verify the selected automatic correction path updates only the used row with revisions/history. Known-key resolution must be unique; unknown catalogue names retain exact observed text with physical/map resolution pending, never a guessed marker. | Confirm the runtime event source and robust EN/DE/RU parsing/correlation. This is the primary Q4 trigger; regional-channel inference is not required if these checks pass. The experiment validates the evidence guards for the selected undoable automatic correction design. |
| E05 | Regional channels (secondary/fallback) | Travel within one area, across areas, across story versions and into interiors. Repeat with channels enabled/disabled, plugin loaded after arrival, login/reconnect and another travel skill. Measure entry notice timing against a tracked milestone attempt and saved region. | Optional corroboration or fallback only if E04 does not supply a reliable success/destination signal. Not required for the primary Q4 path when the successful-use message is validated. |
| E06 | Arrival envelopes | For representative milestones, capture object-side bind position and repeated post-travel locations before moving. Rebind from different sides/distances/elevations to test whether the saved anchor depends on the player's bind position. Include Bree variants, Moria/Gundabad/interiors, region 4, Tales of Yore, Haradwaith and boundary cases. | Actual spatial tolerances, context keys, and supported coverage. Do not borrow MoorMap's treasure threshold or assume imported anchor coordinates equal the marker position. |
| E07 | Existing learned-skill identification (established) | The stakeholder confirms the existing codebase has reliably identified learned milestone skills, including multiple learned skills, for a long time. Reuse that path; retain existing regression coverage if the milestone manager changes it, and check edge cases only when a concrete code change touches the matcher. | No new research gate. Keep learned-skill count and slot identity separate from saved destination records. |
| E08 | Storage semantics | Save a small character-scoped fixture; observe callback/errors/readback during session, unload/reload and normal client exit. Test a failed save and malformed/newer-schema input using backups in a later authorized test environment. | Honest persistence status, write coalescing and recovery guarantees. Do not intentionally crash a user's active client. |
| E09 | Map calibration | Compare known points spanning each exact map asset, at minimum/maximum TWII map scale and UI layouts; use independent holdout points, not just fitted anchors. Test interiors and story versions separately. | Valid transforms, approximation labels, acceptable error and fallback placement. |
| E10 | Later Companion snapshot | After the target release, compare a test character's `anchors.xml` plus identity/import metadata against known bindings and skill IDs. Then rebind in-game and import the older snapshot. | Later import contract, timestamps, slot mapping, stale conflict handling and unknown destination behavior. Does not gate target release. |
| E11 | Native tooltip with location action | The [2026-11-14 debug trial](2026-11-14-mousedown-trial.md) implements real skill at rest, MouseDown Alias replacement, stable-Alias second-click retry, token/skill/location validation and deferred cleanup. Log native tooltip content, actual action and event order; exercise single/retry/right/double click, drag/cancel, locale and close/unload. Keep the [prior alternatives](2026-11-09-native-tooltip-and-location-click.md) if this fails. | Stakeholder reports hover, number badges and Alias replacement, and subsequently confirms that two clicks work and display the correct identified location in the debug window. Lua 5.1/offline checks also pass. This is verified two-click capture/result delivery; closure, exact native order, other locales and the full edge-case matrix remain pending. Full E11 acceptance is not claimed. |

E01–E04 can materially change the primary design; E05 is secondary if E04 validates the successful-use destination message. E07 is established behavior, not a new gate. E04 gates the selected automatic updates to TWII's stored destination: verify the exact successful-use-to-click correlation and parser certainty first. A negative or ambiguous result uses fallback manager review for that case; it does not authorize guessing or mark the self-healing acceptance gate complete.

## Acceptance scenarios for future implementation

### Manual foundation and presentation

| ID | Given / action | Required result |
|---|---|---|
| A01 | Learned skill, no TWII binding | Native shortcut remains usable; manager says location not recorded, not unbound in-game. |
| A02 | User records a known destination | Correct real skill ID remains; diagnostic tracker refreshes in iteration 1; production text views refresh in iteration 3a; valid map placements refresh in iteration 3b. |
| A03 | Record slot 2 after slot 3 was selected previously | Explicit slot selection/preview prevents an invisible carry-over. |
| A04 | Beorning has two skills with Return Home names | Canonical matching distinguishes the milestone from the racial skill. |
| A05 | Switch client/UI language or label preferences | Binding keys survive; labels follow approved preferences and parsers follow actual client language. |
| A06 | Two slots share a destination | Both remain accessible; no automatic clearing or forced one-to-one assignment. |
| A07 | Undo a wrong-slot edit | Restore only matching revisions; preview every changed slot. Later edits cannot be overwritten silently. |
| A08 | Custom sort order exists before recording | Custom order remains intact; when alphabetical mode is active in production text views (iteration 3a), labels sort by the selected destination-first effective label. |
| A09 | Destination has no map projection (iteration 3b) | Binding remains visible in the diagnostic manager before production integration and in production text views/map tray after the relevant iteration 3 gates; no invented marker. |
| A10 | Several shortcuts overlap on a map (iteration 3b) | Every shortcut is intentionally selectable; visual displacement does not alter physical coordinates. |
| A11 | Another of the five segmented maps is selected (iteration 3b) | All learned enabled milestones remain accessible in the tray, including those also drawn on their respective maps. |
| A12 | User forgets TWII record | Only plugin record changes; native skill and in-game binding are untouched; the action clearly identifies the TWII record being removed. |

### Binding and location assistance

| ID | Given / action | Required result |
|---|---|---|
| A13 | Valid binding signal with no slot | One unassigned review prompt; no guessed accepted assignment. |
| A14 | Player chat quotes a bind/location message | No trusted game observation is created from unsupported player ChatTypes. |
| A15 | Multiple duplicate notices or two rapid bindings | Duplicates coalesce only within a proven event; distinct events remain distinguishable. |
| A16 | User clicks location, then waits/moves or another plugin emits location | Stale/ambiguous sample is not silently attached; user can recapture or choose manually. |
| A17 | Same coordinates in different regions/story versions | Region/context constraints prevent cross-assignment. Unknown context remains unresolved. |
| A18 | Unsupported language, malformed location, missing catalogue entry | Manual workflow remains usable; no destructive fallback or nearest-at-any-distance guess. |

### Travel and reconciliation

| ID | Given / action | Required result |
|---|---|---|
| A19 | TWII skill click fails/cancels | No success claim, reassignment, or negative binding verdict. |
| A20 | Shared cooldown events arrive | One attempted action stays distinct from other skill cooldown changes; no inferred slot swap. |
| A21 | Same-area successful travel with no region notice | No mismatch prompt and no false error. Explicit arrival check remains optional. |
| A22 | A different travel skill, recall, death/respawn or login changes location | No milestone correction based solely on regional/location evidence. |
| A23 | Fresh attributable coordinate evidence contradicts recorded location | Coordinate-only contradiction opens review; automatic correction requires the stronger trusted clicked-skill/success-message chain. Preserve before/after history when that chain qualifies. |
| A24 | Binding edited while an earlier travel check is pending | Old evidence cannot mark the new revision checked or overwrite it. |

### Import, storage and maintenance

| ID | Given / action | Required result |
|---|---|---|
| A25 | Import exact unchanged snapshot twice | Idempotent; no duplicate history or repeated prompts for unchanged rows. |
| A26 | Older, wrong-character, unknown-time or partial import | Identity/time uncertainty visible; missing rows do not delete; conflicting rows require appropriate review. |
| A27 | Import has hunter/instance anchor or unknown slot | Preserve/report unsupported data without treating it as a milestone. |
| A28 | Catalogue rows reorder, IDs shift, a destination moves/disappears | Stable keys prevent rebinding by index; explicit migration or unresolved state preserves history. |
| A29 | Account defaults applied or a second character loads | UI preferences may copy; bindings never leak between characters. |
| A30 | Save fails, file is malformed, or schema is newer | Preserve input; no false persisted status; normal travel remains usable; bounded recovery path. |

### UX and compatibility

| ID | Given / action | Required result |
|---|---|---|
| A31 | Combat, hidden UI, Escape, scaling, long localization | Approved prompt policy and focus behavior; no inaccessible actions or clipped essential text. |
| A32 | Toggle detector off/unload/reload with MoorMap and other chat plugins | No overwritten listeners, duplicate registrations or continuing stale callbacks. |
| A33 | Large catalogue, long session, repeated edits and observations | Bounded queues/history; no per-frame full-catalogue scan; acceptable measured responsiveness. |
| A34 | User cannot distinguish status colors | Text/icons explain status and repair; normal navigation works with the approved keyboard/mouse model. |

### Adversarial review additions

| ID | Given / action | Required result |
|---|---|---|
| A35 | Previously checked slots, then an unidentified bind event | Set-level unresolved-change reminder; no false “all checked” summary and no blanket wrong-row verdict. |
| A36 | Defer a bind review, travel elsewhere, then request current location | Do not label current position as the old binding position. Offer manual choice, return-to-stone or identified arrival check. |
| A37 | Undo/repair after history expiry or after an intervening edit | Explain recovery limit; use explicit editing or refreshed preview. No revision reuse and no restored check status presented as newly verified. |
| A38 | Import contains two conflicting records for one slot, or a row changes while preview is open | Conflicting input has no implicit last-row winner; changed revisions force review before Apply. |
| A39 | Character rename/transfer or another character with the same name | Explicit recovery association; no automatic merging based on name alone. |
| A40 | Normal travel follows recording but saving fails | Travel remains usable; all rows in a repair stay one in-memory transaction; visible unsaved status and retry path. No partial transaction claimed durable. |
| A41 | A fresh trusted successful-use message identifies a destination different from the saved one and belongs to exactly one clicked TWII milestone skill | Correct that used row automatically with revision guards, history and undo; no mandatory Fix now or repeated location request. Unique catalogue resolution may update the canonical key. Otherwise retain exact observed text with map resolution pending. Ambiguous/stale attribution uses the existing fallback prompt and manager. Duplicate delivery is idempotent; regional channels are unnecessary. |
| A42 | Bind signal arrives and the game's learned-skill method returns exactly one learned milestone skill | Skip slot selection, identify that skill in the prompt, and make **Use my location** request a fresh location sample. Show the detected location and affected slot, and require explicit confirmation before saving. |
| A43 | The learned-skill method returns slots 1 and 3, with slot 2 unlearned | Show exactly the two learned skills as choices. Do not treat the maximum slot number as the count, show unlearned slot 2 as an available skill, or take the single-skill fast path. |
| A44 | Debug tracking slice observes a bind and a location | Future location-capture debug slice shows an unresolved candidate in the diagnostic window without accepted/persisted production data or normal-view integration. The currently approved smaller prototype has no location action; expanding it needs its own execution plan. |
| A45 | The bind dialog was closed, then a tracked milestone skill succeeds | Capture/correct the used skill from success evidence without requiring the old dialog, another location sample or a manual Fix now step. Do not claim every unassigned historical bind event is resolved. |
| A46 | The player recorded a new destination against the wrong skill, then uses the actually rebound skill | Correct only the used row. The mistakenly overwritten row remains recoverable through its own later successful use or guarded history/manager repair; never infer a swap. |
| A47 | A bind dialog remains open while the player moves nearer a different milestone, then requests location | Treat the sample as current click-time position, label delay/context and require bind-time confirmation. Do not claim the original bind location was observed. A later attributable success corrects a mistaken recorded destination. |
| A48 | A qualifying success contains an exact name/territory missing from the static catalogue or translations | Retain exact observed text, locale and provenance for the used skill. Do not guess a marker or keep a conflicting old placement as confirmed current data. Later catalogue resolution preserves the observation. |
| A49 | A duplicate/stale successful-use event arrives, or the binding changed after the tracked click | Duplicate unchanged success creates no repeated repair/history. Conflicting newer revisions are not overwritten. Successful automatic corrections have guarded undo. |

## Data acceptance checks

Later generator validation should reject duplicate canonical keys, invalid/nonfinite coordinates, missing skill↔travel-link mappings, unsupported signed-ID conversions, unresolved migrations and map placements outside their declared canvas/context. Catalogue reports should expose missing names/translations, source removals, new templates, dungeon joins, and game-data revision differences.

Run detectors against a labelled fixture set containing both genuine and unrelated events. Require zero accepted false reassignments on that set. This is a test-set result, not proof of a universal zero-error rate. Measure candidate suggestion accuracy separately from accepted-binding accuracy. Do not optimize for detection coverage by hiding uncertainty.

## Exit criteria before implementation

Stakeholder decisions relevant to the selected scope are resolved, naming/projection scope is bounded, relevant feasibility results are recorded, and the draft spec is updated. Do not require iteration 3 map calibration or iteration 2 repair evidence to ship iteration 1. E08 gates the tracking store; E02/E03 gate bind/location assistance in iteration 1; E04 gates mismatch repair in iteration 2; E09 gates map projection in iteration 3. Existing learned-skill matching is not a new gate. E10 gates only the later Companion import. Deferring import or broader travel reconciliation must not block the three target iterations. The later execution plan must name exact runtime evidence still required and must not call source inspection “in-game validated.”

### Three-iteration acceptance gates

The gate order is **1a debug proof → 1b persistent diagnostic tracking → 2 use-based repair in the diagnostic manager → 3a production text integration → 3b map integration**. Iterations 1 and 2 do not surface milestone data in normal travel views. Iteration 3a promotes only records that have been tracked and reviewed; map markers and map-tray access remain the final 3b gate.

1. **Tracking foundation, two review slices:**
   - **1a debug slice:** gate only on the E02/E03 vertical-slice checks and A44. Pop-up to location capture is observable in a diagnostic text window, with no production persistence or normal-view integration.
   - **1b persistent diagnostic tracker:** after 1a review, finish the character-specific catalogue/binding model, basic set/update/forget flow, bind signal and confirmed location capture, learned-skill selection, persistent records and diagnostic-manager review. Gate on E01/E02/E03/E08 and A01–A06, A12–A18, A29/A30, A32/A33, A35/A36, A40, A42/A43. No production text views, map markers or map tray. The feature remains useful without automatic mismatch repair.
2. **Use-based repair and mismatch handling:** implement the selected automatic used-row correction from successful-use attribution, revisions/history and undo, exact observed-text retention when catalogue resolution is pending, and fallback manager/wrong-skill repair. Gate on E04 and A07, A19/A20, A31/A34, A37/A41 and A45–A49. Canonical/map identity requires unique evidence; weak or stale observations do not authorize correction. Do not integrate into normal travel views yet.
3. **Production integration:** first promote reviewed records into text views, lists and pulldowns (3a), gated by A02/A08 and relevant text acceptance; then add milestone markers and tray access across the five segmented maps (3b), gated by E09, overlap/unprojectable-location cases and map-specific layout acceptance. Existing tracking and repair behavior must remain unchanged.
