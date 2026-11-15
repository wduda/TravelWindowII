# Milestone proximity capture and self-healing on use

Date: 2026-11-09
Branch: `milestone-management-research`
Scope: update requirements and implementation planning only; no plugin behavior changes.

Status: incorporated into specification draft 0.17, questionnaire Q4, research index, worked scenarios and acceptance plan. Documentation checks complete; future runtime checks remain pending.

## Stakeholder direction

Use the bind dialog to request an explicit, user-clicked `;loc` or `/loc` sample, then suggest the most likely bound milestone from proximity. After a later successful milestone use, combine the actual clicked TWII skill ID with the destination-bearing success message to correct TWII's record automatically. This makes ordinary user mistakes recover through normal use instead of requiring manual repair.

This selects narrowly attributed self-healing as the design direction for iteration 2, superseding the previous unresolved confirm-first-versus-auto-repair choice. Implementation remains subject to the iteration gates and runtime evidence checks. The current debug slice stays in memory and gains no new behavior from this plan edit.

The stakeholder reports having contacted LotroCompanion about obtaining exact names and translations. This is a reported external dependency, not an instruction for the assistant to contact anyone. The audited dataset has 351 generic-labelled markers; the separate 37-name research subset does not resolve full naming or translation coverage.

## Documentation work

1. Update the active specification, questionnaire and research index to describe the bind-time suggestion and use-time correction loop.
2. Keep the implementation sequence: diagnostic tracking first, automatic use-based repair second, production text integration and then maps last. Preserve the current smaller debug prototype's scope.
3. Update worked scenarios and acceptance criteria for successful healing, dismissed dialogs, delayed/moved location capture, wrong-slot assignment and missing catalogue names.
4. Preserve dated evidence, identify proposals separately from observed behavior, check document consistency and links, and commit documentation only.

## Target interaction

The [native-tooltip/location-click research](milestone-management/2026-11-09-native-tooltip-and-location-click.md) identifies a source-backed Alias payload carrying skill ID, request token and expanded `;loc` to TWII's own command. That is a proposed future command, not implemented syntax. Native skill tooltip plus alias-only click on the same hit area remains unverified and is tracked as E11; mouse-transparent number overlays are a separate, simpler visual candidate.

1. A supported bind-confirmation message opens the small, mode-styled dialog. It confirms a bind event but supplies neither slot nor location.
2. Reuse reliable learned-skill enumeration. A sole learned milestone identifies the slot; otherwise ask which learned skill changed, preserving actual/gapped slot numbers.
3. An explicit user click requests a fresh location sample using the supported command/alias. Prefer combining selection and location capture into one intentional interaction if the quickslot API permits it safely; otherwise provide a separate location action. Selecting the skill must never cast travel. Command/alias behavior still requires client validation.
4. Find compatible milestone candidates using world/instance context, proximity and an ambiguity check. Suggest the best candidate; retain the prior requirement to show the location and ask for confirmation before saving the bind-time assignment. Manual search remains a fallback.
5. On later use from a tracked TWII shortcut, retain the exact clicked skill identity and wait for successful-use chat. If one fresh trusted success belongs to that use, update that skill's observed destination automatically, retaining before/after history and an undo path. Normal successful healing must not require the player to choose Fix now first.
6. If that name/context resolves uniquely to a validated destination key, update the canonical binding too. Never infer a map marker from the plaintext name alone when several locations could match.

## Names and physical location are separate

The success message can establish the used slot's reported destination text even before the static catalogue has its exact name or translation. Do not make a complete named catalogue a prerequisite for collecting or correcting that observed slot-to-text record.

**Proposed unresolved-catalogue behavior:** retain the exact destination text, parenthetical territory, locale and provenance for the used skill, show that observed label, and leave canonical marker/map placement unresolved until supported. A conflicting old canonical location belongs in history and must not keep being presented as confirmed current placement. This is a representation requirement to refine during iteration 2; it does not authorize inventing new catalogue associations or treating name-only matching as unique identity.

Global display names/translations, geographic resolution and map placement remain distinct data work. Observed names and catalogue candidates keep their evidence status.

## Boundaries of self-healing

- Location is sampled when the player clicks, not when the bind message arrived. Keeping the dialog open and moving closer to another stone can produce a plausible but wrong initial suggestion. Time/context checks reduce this risk but cannot prove the original bind position when it was not observed. Label delayed samples and retain confirmation/manual fallback.
- Closing or deferring the dialog leaves a pending/unrecorded change. A later attributable success may populate the used skill without reopening the old bind flow. Login/reload reminder policy remains governed by the later persistence design.
- A wrong-slot assignment can make two rows stale. Using the actual rebound skill repairs that used row only. It does not prove the destination of the other, mistakenly overwritten row; that row heals on its own later successful use or through guarded undo/manager repair. Never silently swap, clear, or restore a different skill based on one success.
- Two milestone skills may legitimately share a destination. Duplicate destination text is not proof that a slot is wrong.
- Cancelled/failed travel, expired or superseded attempts, unmatched success text, unsupported locale, quoted player chat, external hotbar use without slot evidence, and conflicting newer edits do not authorize reassignment. An unambiguous destination message is stronger than regional-channel hints; regional channels are not required for the primary path.
- The prototype's 30-second click window remains the starting attribution rule, subject to measured load-screen/event behavior. A missed observation is not proof the game binding failed.
- Each automatic correction changes TWII's record, never the game's milestone binding. Keep revisions, bounded history and undo. Duplicate success delivery must be idempotent. Repeated unchanged successful use should not create a repair prompt/history entry each time.
- Reuse the existing manager for unresolved/conflicting cases. The medium, movable, Classic/Mini-styled prompt with saved position and initial right-side placement remains the fallback-review design. The exact low-intrusion notification after a completed automatic correction remains to be settled; this does not introduce another window type.

## Iteration gates

| Iteration | Planned result |
|---|---|
| Current debug stepping stone | Existing bind-slot picker, successful-use diagnostics and in-memory text table; verify independent retention for multiple skills. No added persistence, location action or repair in this planning task. |
| Tracking foundation | Add and validate explicit location capture, candidate selection and confirmation; harden tracking and later persistence in the diagnostic workflow. |
| Use-based repair | Add the attributed automatic correction loop, known-key resolution where possible, unresolved-name representation, revisions/history, undo and fallback manager repair. Review this before production presentation. |
| Production integration | Show trusted/appropriately qualified destination labels in normal views, then add reviewed map placements last; preserve tray access across the five maps. |

## Required evidence and acceptance

- Validate the actual user-clicked command/alias behavior and supported EN/DE/RU location/message formats; do not assume a bind notification itself can execute a command.
- Capture trusted raw success categories/body, duplicate/order behavior and failure/expiry cases. The reported one-skill debug success is useful evidence, not complete acceptance of production healing.
- Measure proximity/arrival/bind offsets and ambiguous/boundary cases. The research database's screening thresholds are not production tolerances.
- Demonstrate wrong initial destination -> successful use -> automatic corrected used row, with recoverable history and no mandatory manual correction step.
- Demonstrate a dismissed bind dialog can be recovered through a later tracked successful use, without a second location request when the success text already supplies the destination.
- Demonstrate wrong selected skill -> correction of the actually used skill only -> correction of the remaining stale row on its own use or explicit guarded repair.
- Demonstrate an unknown catalogue name can be retained as exact observed text without assigning an unverified marker, and a later catalogue update can resolve it without losing provenance.
- Demonstrate intervening edits and stale/ambiguous success events cannot overwrite newer records; unchanged duplicate success is idempotent.

Documentation updates do not authorize implementation, expand the debug branch, or mark these future acceptance checks complete.
