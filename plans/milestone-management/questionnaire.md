# Stakeholder questionnaire

**2026-11-08 evidence update:** [Findings and developer requirements](2026-11-08-findings-and-developer-notes.md) records the stakeholder's Combat - Player observation and successful one-skill debug-table mapping, the actual 11-skill Companion export, and the refreshed 351-marker inventory. These are evidence updates, not new answers to open product questions. This describes the evidence state on 2026-11-08; the 2026-11-09 direction below selects self-healing. Companion import remains deferred and localized/raw-event validation remains incomplete. The current implementation is the narrower debug-only, in-memory slice described in that supplement.

Prepared 2026-09-25; updated 2026-11-09 for specification draft 0.17. Q4 now selects automatic correction from unambiguous tracked successful use. The [proximity and self-healing plan](../2026-11-09-milestone-proximity-and-self-healing.md) records the stakeholder direction, edge cases and implementation gates. Bind-time location suggestions still require confirmation; runtime attribution/locale details remain validation work.

Use `Q2: ...` and so on when replying. Contradict the options freely; they are meant to expose tradeoffs, not constrain your design.

## Recorded decisions

| Question | Decision | Consequence |
|---|---|---|
| Q1 | **B — Manual management plus binding/location assistance in the target feature, delivered in three iterations.** | Iteration 1a is a debug-only popup/location/text-window proof, then 1b builds and hardens persistent tracking within the diagnostic workflow; iteration 2 adds successful-use repair against that data; iteration 3 integrates trusted data into production text views, then adds map presentation last. Each slice is reviewable and testable before the next begins. Broader travel reconciliation stays optional pending evidence/scope; Companion import is a later feature. Datamined milestone catalogue extraction is included. “Major” means product significance; version/changelog classification is open. |
| Q2 | **A — Small non-modal prompt with Later.** | The English bind signal is “This location is now bound to your milestone skill.” It supplies neither slot nor location, so ask the player to identify the skill and request a fresh location explicitly. Exact current ChatType/timing still needs runtime verification. |
| Q3 | **A — Destination first, slot always visible:** `Galtrev · Milestone 3`. Use the effective destination-first label for alphabetical sorting. | Text views identify the destination while retaining the slot; unknown destinations sort by their visible fallback label. Integration with existing name/zone preferences and alias behavior remain open. |
| Q4 | **B — Self-healing on a fresh trusted successful use attributable to one clicked TWII milestone skill (direction selected 2026-11-09).** | Correct the used row automatically with history, revision guards and undo; do not require Fix now in the normal case. Keep exact observed text when catalogue names/translations are missing; canonical/map resolution needs unique evidence. Ambiguity and manual correction reuse the existing manager and styled, movable fallback prompt. A different stale row heals on its own use or guarded repair, never by an inferred swap. |
| Q5 | **A — Use a labelled row when the player has multiple learned milestone skills.** | Read the character's learned milestone skills from the game's learned-skill method. If exactly one is learned, skip slot selection and attribute the pending bind to that skill; the player clicks **Use my location** to request a fresh sample. With multiple skills, show rows only for learned skills and their saved destinations. Skill slots can be skipped, so count the returned learned skills rather than assuming all slot numbers up to the highest are learned. In either case, show the detected location and ask the player to confirm before saving. Whether to pre-mark a recently attempted skill as a suggestion remains open; any suggestion requires explicit confirmation. |
| Q8 | **A — Guided “wrong skill” repair with a two-row preview.** | Move the destination to the intended skill and restore the overwritten row's previous value only if that value is still valid and unchanged. Include single-row edit/forget and undo/history. Whether history is routinely visible or under a recovery action remains open. |
| Q6 | **A — Keep all learned, enabled milestones in the tray and also draw known destinations on their respective maps.** | Access is retained across all five segmented maps. Overlap selection and marker styling remain open. |
| Q7 | **A — Catalogue destinations remain usable in text; draw map markers only for reviewed placements.** | Manual selection can cover the full curated catalogue while map coverage grows by reviewed regions/placements. Unknown or unprojectable entries stay accessible in the tray. |
| Q9 | **Detection support starts with EN/DE/RU; new milestone UI text may remain English on ES/RU clients for the first version.** | Parser locale and UI-copy localization are separate. RU messages need a Russian parser while UI prompts may display English; ES keeps the manual workflow and English copy, with detection deferred. |
| Q10 | **Defer character-specific Companion import to a later feature.** | No import bridge is required for the target release. The audited catalogue and manual record/review workflow remain in target scope. |

## Remaining decisions: interaction and trust

### Q1. What makes the first public release worthy of this major feature?

**Evidence:** Manual assignment and presentation are technically concrete. Automatic binding/arrival attribution still needs runtime tests. Destination naming and projection are substantial work even before detection.

- **A — Complete manual management plus maps/text, then add assistance.** Useful foundation sooner; less of the original detection vision in the first release.
- **B — Manual management plus bind/location assistance in one release (selected target, now staged).** Includes a meaningful reduction in manual effort while keeping travel reconciliation optional until proven; the work is split into tracking, repair, and map iterations.
- **C — Full detection, reconciliation and import before public release.** Most complete launch; all uncertainties become release dependencies.

The target remains B, now explicitly staged as tracking → use-based repair → production-view integration. Iteration 1 starts with a debug-only detection/location proof (1a), then adds persistent tracking and review within the diagnostic workflow (1b). Iteration 2 repairs and reconciles those records from successful use. Iteration 3 first adds production text/list/pulldown integration, then milestone map markers and tray access as the last step. The remaining release-label question is whether “major” means semantic-version major, changelog `major:` classification, or product significance only. No release number is assumed.

### Q2. How intrusive should binding assistance be by default?

**Evidence:** A bind signal may identify neither slot nor exact destination. MoorMap demonstrates a small prompt followed by an intentional location click.

- **A — Small non-modal prompt with Later (selected).** Noticeable but does not steal focus.
- **B — Open the full assignment window immediately.** Harder to miss; interrupts repeated rebinding and ordinary play.
- **C — Badge in TWII only; no automatic popup.** Quietest, but easiest to leave stale.

The English signal is “This location is now bound to your milestone skill.” It tells TWII neither the skill slot nor the location. Ask the player to identify the slot and explicitly request a location sample; do not present either as detected fact. Suppression while hidden/in combat and dismissal duration remain open.

### Q3. How should destination names appear in text views?

**Evidence:** Native skill identity must remain intact internally. The list and pulldown can show a separate label; two slots may share a destination.

- **A — `Galtrev · Milestone 3` (selected).** Destination first, slot always visible.
- **B — `Milestone 3 · Galtrev`.** Stable slot-first scanning.
- **C — `Galtrev` with slot only in detail/tooltip.** Most compact, least explicit for duplicates and correction.

Should this follow existing skill-name/zone-name preferences, introduce a milestone-specific naming preference, or always show the native name when “use skill names” is selected? Do you want user aliases, and should an alias ever replace the canonical location name completely?

### Q4. What should happen when evidence contradicts a saved binding?

**Direction selected 2026-11-09: B — Self-healing after an unambiguously identified successful use.** The stakeholder wants the bind dialog to suggest a destination from a clicked location sample and normal later use to correct recording mistakes automatically. The exact clicked TWII skill identifies the slot; the successful-use chat identifies its reported destination. No regional-channel notice or redundant location request is required for this path.

Retain before/after history and undo, guard revisions and freshness, and suppress duplicate changes. Correct only the actually used skill. If a previous wrong-slot choice also corrupted a second row, that row heals on its own use or through guided manager repair; one success does not identify both rows.

The old A policy (confirm every replacement) is superseded for this strong-evidence path. Confirmation remains required for bind-time proximity suggestions and fallback manual/ambiguous corrections. **Fix now** opens the existing manager for cases that cannot be safely resolved; it is not a mandatory step for a clear automatic correction. Keep the established medium, Classic/Mini-styled, movable, position-saving fallback prompt with initial right-side placement. Exact notification styling for an already-applied correction and focus/input behavior remain open.

A complete static name/translation catalogue is not a prerequisite for retaining exact observed slot-to-text records. Proposed representation: preserve the message name, territory, locale and source when no unique canonical key exists, while withholding physical/map association. Review this representation during iteration 2. Raw event trust, locale formats, ordering, expiry and cancellation are still developer validation tasks, not a reason to ask the stakeholder to choose the trust policy again.

### Q5. After the game says a milestone was set, how should TWII ask which skill was changed?

The game message (“This location is now bound to your milestone skill.”) confirms that a binding happened, but it does not say which skill changed. If TWII knows the character has only one learned milestone skill, the slot is unambiguous; the player need not make a separate slot choice. If several skills are learned, TWII needs the player to identify the changed slot. In either case, the fresh location sample is a separate step from choosing a skill.

**Evidence:** Both local references have numbered slots; dragging a skill can expose its shortcut ID. No reliable slot field in a binding event has been established.

- **A — Click a labelled row (recommended).** Show each milestone skill with its current saved destination, such as `Return Home 3 — Galtrev`; the player clicks the row they just rebound. A drag target could also be offered as a shortcut for identifying the skill, but would not be required. Seeing the old destination helps distinguish otherwise similar slots.
- **B — Click a number or icon.** Show compact numbered buttons (or the game's skill icons) and have the player click the changed slot. This takes less room, but the player has less context and can more easily choose the wrong slot.
- **C — Drag the skill into TWII.** Ask the player to drag the milestone skill from their skill bar into a target area. TWII can identify that exact skill by its shortcut ID. This avoids guessing a number, but requires extra mouse interaction and the skill to be available to drag; it does not cast or use the skill.

**Selected: A, with a single-skill fast path; existing learned-skill identification is stakeholder-confirmed reliable.** The current codebase has reliably identified learned milestone skills, including multiple learned skills, for a long time. Reuse that existing behavior; this is not an open feasibility gate. If exactly one skill is learned, identify the pending bind with that skill and skip the slot picker; the player clicks **Use my location** to request `/loc` or the supported `;loc` equivalent. If multiple skills are learned, show labelled rows for those skills and their saved destinations so the player can click the one they changed. Learned skills are not necessarily consecutive by slot number, so retain the existing actual learned-skill set rather than inferring from the highest slot number. A drag target may be offered as an optional shortcut, never as a requirement. Identifying the slot does not identify the new location; show the location result for review before accepting the record.

**Confirmed:** after the location request, show the detected place and ask the player to confirm before saving, even when the learned-skill count is one. The fast path removes only the slot-selection step.

One detail remains open: if TWII recently saw the player attempt a particular milestone skill, should it mark that skill as a suggestion? The suggestion would still need an explicit click to confirm; alternatively, the prompt can always open with no skill selected.

### Q6. What is the right relationship between map markers and the map tray?

**Evidence:** The tray currently holds milestone/housing shortcuts. Moving a milestone exclusively onto its destination map can make it inaccessible while another map is selected.

- **A — Keep all learned enabled milestones in the tray and also draw known destinations (selected).** Reliable access across five segmented maps; duplicate visual presence.
- **B — Tray only for unknown/unprojectable milestones.** Cleaner tray; requires another quick path to other-region skills.
- **C — Show other-region milestones in the tray, current-region ones only on the map.** Compact but shifting positions/layout.

How should identical-position skills be selected: fanned icons, a stacked marker opening a list, or another mechanism? Should recorded-but-unchecked markers look different from checked ones, without reusing the learned/unlearned border colors?

### Q7. How complete and exact must map coverage be initially?

**Evidence:** The audit found interiors and story-coordinate regions; overview placement is not always a direct projection. Some existing transform parameters are estimates.

- **A — All catalogue destinations usable in text; map markers only where placement is reviewed (selected).** Honest coverage, some destinations stay in the tray.
- **B — Require every destination to have a curated overview anchor.** Consistent visual coverage, larger up-front curation effort.
- **C — Show estimated placements with an explicit approximation indicator.** More coverage, potential confusion about precision.

Are regional representative anchors acceptable for interior destinations? Must story variants appear separately even when they share the same overview point?

### Q8. What repair experience is essential?

Imagine TWII has saved `Return Home 3 → Bree` and `Return Home 4 → Rivendell`. After the player sets one of those skills to Galtrev, they accidentally tell TWII it was skill 3 when it was actually skill 4. The records are now wrong in two ways: Galtrev is attached to the wrong skill, and the old Bree destination may have been overwritten. Q8 asks how TWII should help repair that kind of mistake without losing recoverable information.

**Evidence:** Correcting a wrong-slot assignment may affect two skills: the skill that received the mistaken new location and the skill that should receive it. Fixing only one row can leave the other stale or discard its former destination.

- **A — Guided “wrong skill” repair in the milestone manager (recommended).** The player chooses **Move this destination to another skill**, selects the correct skill, then reviews a preview of both affected rows before applying. For example, preview `Return Home 3: Galtrev → Bree` and `Return Home 4: Rivendell → Galtrev`. TWII restores a previous value only when it still has a valid, unchanged value to restore; otherwise it asks the player what should happen. A separate edit/forget action handles one row. This protects the common correction while keeping repair in the manager rather than opening another specialized window.
- **B — Edit the full set in one table.** Show every milestone skill and its saved destination together. The player changes the needed rows and presses **Apply** once to save the whole set. This gives a broad overview and can be efficient when several records need work, but requires the player to notice and fix all affected rows themselves.
- **C — Keep repairs manual and simple.** Let the player edit or forget individual rows, and provide undo/history to recover from mistakes. This is a smaller interface, but a wrong-slot fix may require several separate edits and the player must work out which old values need restoring.

**Selected: A.** Use the guided repair: choose the intended skill, review both affected rows, then apply the correction as one transaction. Restore the previous destination only if TWII can verify it has not since changed; otherwise show the conflict and ask what to do. Keep single-row edit/forget and undo/history as well.

One detail remains open: should the change history be visible in the normal manager, or tucked under an advanced/recovery action and shown when needed?

## Next decisions: coverage and architecture

### Q9. Which client languages need detection and localized prompt text at launch?

**Evidence:** TWII has EN/DE/FR/ES/RU data. Location parsing is client-language-specific; reference code does not provide current acceptance evidence for all five.

Detection scope is **EN/DE/RU**. Keep the existing manual workflow across all client languages. For the first version, new milestone-specific UI copy can remain English on ES/RU clients. Treat parser language and prompt-copy language separately: RU detection must still parse Russian game messages even if the prompt is English. Verify fixtures for EN/DE/RU; report that detection is unavailable on ES.

Which clients can you or testers capture? This asks about future acceptance resources, not for an upload now.

### Q10. When should character-specific Companion import be delivered, and what form fits?

**Decision:** Defer Companion import until after the first milestone-management release. The static datamined location catalogue is still in the target scope; Companion's per-character anchor snapshot is a separate convenience improvement.

**Evidence:** `anchors.xml` exists, but it lacks identity/time metadata in its own root and there is no ready TWII bridge in the inspected source.

- **A — Optional local converter to a versioned paste payload.** Self-contained; an extra external step.
- **B — Dedicated PluginData handoff file.** Less pasting; filesystem placement and unload/reload become part of support.
- **C — Upstream Companion export.** Better long-term integration; depends on another project's agreement and release.
- **D — Defer import until after the target release (selected).** Smaller first scope.

For the later feature, should import merely propose changes or establish records in bulk after one preview? Do you want cooperation with Companion upstream later? No outreach is authorized by this questionnaire.

### Q11. How far should users be able to extend the destination catalogue?

**Evidence:** Every extracted marker has a generic name; new or special destinations may remain unresolved. The catalogue will require maintenance.

- **A — Local custom location with name/context and optional observed coordinates; later link it to a catalogue entry (recommended).** User can recover without a plugin update.
- **B — Name-only manual override.** Simpler, cannot reliably map or reconcile it.
- **C — Catalogue entries only, with a missing-location report workflow.** Most consistent, blocks unsupported destinations.

Should custom destinations be strictly character-local, or may users explicitly share their location definitions between characters while keeping bindings separate?

### Q12. How should destination-level sorting work?

**Evidence:** Current milestone skills have a generic level-sort value. A destination area's typical level is different from the level required to acquire/use a skill.

**Recommendation:** Keep this optional and defer until there is a defined, maintained destination-level source. Use a separate destination sort key with an explicit unknown fallback; retain custom order and skill requirements unchanged.

Do you want it in the initial release? What should “level” mean: area level, milestone bind requirement, expansion progression, or your existing curated travel order?

### Q13. What is the expected behavior for travel initiated outside TWII?

**Evidence:** Native-hotbar usage cannot be assigned to a slot by TWII mouse handlers. Shared cooldowns are unlikely to solve identity by themselves.

- **A — Best-effort unassigned observations, with manual “check this skill” available (recommended).** Honest limits.
- **B — No automatic prompts for external travel.** Quieter, less coverage.
- **C — External-travel attribution is essential.** Adds a feasibility gate; may require more explicit user input if the API cannot identify the cast.

Should routine successful travel ever prompt, or only missing/conflicting records and explicit validation requests?

### Q14. What should be retained for recovery?

**Recommendation:** Bounded per-character edit history and compact evidence summaries, no general chat log. Keep pending automatic observations session-local unless the user explicitly defers a review.

What retention feels right: last few changes per slot, a fixed number of transactions for the character, or time-based retention? Should “reset interface/settings” preserve bindings by default, with a separate deliberate “forget all milestone records” action?

### Q15. Who owns catalogue generation and review?

**Evidence:** Research located [whiterabbit963/twii_miner](https://github.com/whiterabbit963/twii_miner), which combines Companion data with TWII's `data/skill_input.toml`. It currently outputs skill/locale files; milestone marker extraction and durable destination identities are new work.

Datamined milestone-catalogue extraction is part of the target release. Should it extend that tool with a separate output mode (recommended if its maintainer agrees), use a separate tool in TWII, or be maintained upstream? Who owns extraction changes, canonical destination names and translations? Is extending the tool's outputs acceptable while leaving `LocaleData.lua` untouched? Is this public revision the version you intend to maintain, or is there a newer/private working version?

### Q16. How should unsupported/new milestone skills be surfaced?

**Evidence:** Data contains slots 12–16, and local `data/skill_input.toml` explicitly excludes them. This research did not establish their live availability or the reason for those exclusions. Known definitions and learned availability are separate facts.

**Recommendation:** Build an extensible registry; preserve current exclusions until evidence justifies changing them. Show supported learned slots and retain unknown imported slots as reviewable data. Do you know why 12–16 were excluded? Do you want explicit experimental exposure for newly discovered skill IDs, or only after verified support lands?

## Technical confirmation after experiments

These are not questions you need to answer from memory. [Validation experiments](validation.md) should resolve them with evidence:

- Does the current description API expose the dynamic bound destination?
- Which bind messages/events occur, with what slot/location information and locale variants?
- Can the current API identify successful casts separately from attempted activation/shared cooldown changes?
- How does current PluginData persistence behave during a session and shutdown?
- What arrival envelope works across terrain, story regions, interiors, and loading delays?

## Suggested review order

Q1–Q3, Q5–Q10 have direction recorded. The Q4 mismatch prompt's medium size, movable position, active-mode styling and right-side initial placement are specified; only focus/input blocking remains open. Validate the Q4 success message and its parsing/correlation in E04; E05 is secondary unless E04 fails. The 2026-11-09 direction selects automatic correction on strong successful-use evidence; validate its guards and fallback behavior instead of reopening that policy choice. Decide whether to pre-mark a recently attempted skill as a suggestion (Q5 follow-up) and where change history should appear (Q8 follow-up). Existing multiple learned-skill identification is established behavior and is not a new research gate. The repository's spec-driven execution workflow applies when implementation is authorized.
