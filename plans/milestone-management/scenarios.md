# Worked reconciliation scenarios

Updated 2026-11-09 for the [proximity and self-healing approach](../2026-11-09-milestone-proximity-and-self-healing.md).

These are synthetic design walkthroughs, not recorded game behavior or executable test fixtures. Location names illustrate the UX; they do not establish the catalogue's exact naming. Revisions are illustrative counters.

## 1. Accurate location, wrong skill

Initial TWII records: slot 2 → Bree at revision 4; slot 3 → Galtrev at revision 9. The player rebinds slot 2 in-game to Rivendell. TWII correctly suggests Rivendell from location, but the player accidentally chooses slot 3.

| Step | TWII state | Required explanation/action |
|---|---|---|
| Accept mistaken edit | Slot 2 remains Bree/r4; slot 3 becomes Rivendell/r10 | Preview showed the change, but an accurate location suggestion cannot prevent every slot mistake. Keep the before-image Galtrev/r9. |
| Player chooses “Wrong skill” | No mutation yet | Select slot 2. Show slot 2: Bree → Rivendell; slot 3: Rivendell → Galtrev. |
| Apply without intervening edits | Slot 2 becomes Rivendell/r5; slot 3 becomes Galtrev/r11 | One transaction checks expected revisions r4 and r10. Preserve Bree and the mistaken edit in bounded history. |
| Alternative: slot 3 changed meanwhile | Keep newer state | Do not restore Galtrev over the newer edit. Rebuild the preview and let the player choose. |
| Undo the repair | New revisions, if still applicable | Restore the transaction's before-images. Do not turn an old arrival check into fresh evidence. |

**Normal self-healing alternative:** using the actually rebound slot 2 produces a trusted success naming Rivendell, so slot 2 corrects itself automatically with history. Slot 3 still contains the mistaken Rivendell record; using slot 3 later reports Galtrev and corrects that row. The manual table above is an alternative when the player chooses repair before those uses. One successful use cannot prove both destinations or authorize a silent swap.

The repair moves a **recorded change**, not an in-game binding. It is not automatically a swap: the correct result may restore a third destination from history. If the source history expired, show a manual two-row editor rather than invent a restoration.

## 2. Two bindings while the prompt is deferred

The player binds at location A, leaves the prompt open, then binds another slot at location B. Both events have generic messages and no slot field. A subsequent `/loc` sample at B cannot identify the first event's destination or either slot.

Keep two unresolved events unless duplicate delivery of one event is established. Label the sample as current location at B, not as the destination of every queued event. Let the player resolve the latest change, pick A manually for the earlier one, dismiss a redundant event explicitly, or review all slots. If neither event can be associated confidently, a single “two changes need review” entry with two underlying observations is preferable to two interrupting popups.

This reveals a product choice: automatic assistance should reduce work without pretending to reconstruct information the API never supplied. Queue size and prompt coalescing affect presentation, not truth.

## 3. Contradiction after attempted travel

TWII records slot 3 → Galtrev. The player clicks it, but cancels the induction and then travels by another means. A regional notice and a location sample near Bree arrive.

The click identifies the attempted slot, not successful travel. The new location is insufficient to reassign slot 3. Expire/invalidate the old attempt when an observed conflicting action occurs. If external actions cannot be observed, retain that limitation and ask which skill was actually used before treating the sample as attributable.

If the player later explicitly uses slot 3, waits for arrival, and checks it, a consistent sample can be recorded against the current revision. A contradictory sample opens review. For same-origin/destination travel, unchanged coordinates alone still cannot prove that a cast completed. The UI should say what was checked, not claim a successful teleport from position alone.

## 4. Precise import with stale or incomplete context

An import says travel-link code 20 has a named anchor and coordinates. The explicit registry maps code 20 to slot 11, regardless of source order. The payload has an export time but no game-observation time.

| Condition | Result |
|---|---|
| No existing record | Offer a new imported record, displaying unknown snapshot age. |
| Existing newer user-accepted record differs | Show a conflict; the later export time does not establish freshness. |
| Coordinates do not match a catalogue stone | Preserve the reported anchor as an unresolved/custom location; no nearest-at-any-distance substitution. |
| Same payload imported again | Unchanged rows create no new edits or repeated history. |
| Same slot appears twice with conflicting values | Mark that slot invalid until resolved; input order does not choose. |
| Another row is absent | Keep its current binding. Absence is not an instruction to forget. |
| User edits a row while preview is open | Recheck revisions at Apply; update the preview before overwriting. |

An exported character name matching the active name is not enough to resolve server transfer or another server's same-named character. Recovery requires an explicit association.

## 5. Good destination identity, unsuitable overview coordinates

A milestone is known inside a hall. Its local coordinates are valid in that interior, but applying the outdoor transform would put it in an unrelated part of the overview.

Keep the binding and exact context. Display it in text and the tray. If the catalogue includes a reviewed representative anchor, show the overview marker there with an interior/approximate indication. Otherwise, explain that map placement is unavailable. Detection still uses the physical/arrival context, never the shifted overview position.

If two milestone skills share this destination, preserve both shortcuts. If several destinations share the same representative entrance, opening the stack must list the destination **and** skill identity. A click on an ambiguous stack must not silently cast the first skill.

## 6. Unidentified rebind after an apparently clean setup

All rows have earlier checks. A reliable generic bind signal arrives, but the player dismisses it without assigning a slot. The historical checks remain true observations of those earlier revisions; TWII cannot assert that every in-game binding still matches them.

Show a set-level unresolved-change reminder, preserving individual evidence dates. Avoid both extremes: a reassuring “all correct” summary and a blanket warning on every slot. Dismissal can stop a popup while retaining the unresolved condition. If the player deliberately says their records are already correct, record that acknowledgment separately from a new coordinate-based check.

## 7. Self-healing after a tracked successful use

TWII records slot 3 -> Galtrev. The player clicks slot 3 in TWII; a fresh trusted successful-use message names Nashûbu (Idagâl, the Dry-whelm). The exact clicked skill and success text qualify for automatic correction, so TWII updates that used row without requiring Fix now. Retain the before/after record, guard revisions, explain the correction without unnecessary interruption, and offer undo. A repeated unchanged success creates no repeated correction/history entry. Regional-channel messages and a second location capture are unnecessary.

If the name resolves uniquely to a supported canonical destination, update that identity too. If it does not, preserve the exact name/territory/locale as a reliable observation and leave map identity unresolved. Do not keep drawing a conflicting old canonical location or pretend a generic nearest marker has been identified from the text alone.

If the attempt expired, more than one use could match, the event is untrusted/unparsed, or a newer conflicting edit exists, do not auto-replace. Reuse the existing manager and medium, movable, saved-position Classic/Mini fallback prompt for review. This exception path preserves the previous Fix now/Later interaction without making it a required step for every clear mismatch. The planned behavior still requires E04 acceptance before implementation.

## 8. One learned milestone skill

The game's learned-skill method reports exactly one learned milestone skill: Return Home 3. Lower-numbered skills are not assumed learned, and gaps in slot numbering are allowed. After the generic bind message, TWII identifies Return Home 3 as the only learned skill and skips the slot picker. The player clicks **Use my location**, which requests a fresh `/loc` sample or supported `;loc` equivalent. TWII shows the likely destination and Return Home 3 together; the player must confirm before the location becomes an accepted record.

If the learned-skill method returns an unexpected error, do not infer the slot from the bind message. Keep the event pending for review after the method can be read again.

## 9. Multiple learned milestone skills

The learned-skill method returns Return Home 1 and Return Home 3; slot 2 is not learned. The same generic bind message arrives, and neither message text nor the current location distinguishes the slot. Keep the Q5=A labelled row choice, showing exactly the learned skills and their current saved destinations. Once the player identifies the changed skill, a **Use my location** click requests the fresh sample. Do not let the single-skill fast path remove slot choice merely because only one row currently has a TWII destination; the count is based on learned skills, not recorded bindings or the highest slot number.

## Consequences for review

These scenarios motivate Q2 (binding prompts), Q4 (post-use mismatch prompts and trust), Q5 (single/multiple-skill slot choice), Q6 (overlapping map shortcuts), Q8 (repair), Q9 (locale split) and Q14 (history). They do not require deciding pixel layout or implementing a statistical confidence score. They should be replayed against any alternative UI proposed during stakeholder review.


## 10. Delayed location click near another milestone

The player binds at A, keeps the dialog open, walks near B, then clicks the location action. The sample is at B at click time. A proximity algorithm can legitimately select B as nearest; it cannot reconstruct A's bind position from a signal that carried no coordinates. Show the delay/current sample and require confirmation, with manual selection available. If B is mistakenly recorded, a later tracked successful use of the actual skill reports A and corrects that used row automatically. No claim is made that delay checks can detect every short movement to another stone.

## 11. Dismissed dialog and incomplete names

The player dismisses a bind dialog. Later, a tracked successful use names a destination that is not in the named catalogue or lacks translations. Preserve that exact destination text, territory, locale and the actual used skill ID; later use can therefore populate the observed record without reopening the old bind flow. Physical marker resolution remains pending. This is not a promise that a complete unknown-name catalogue can be generated from one player's bindings. If the evidence cannot identify one used skill, keep it unassigned and use the manager fallback.
