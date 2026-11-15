# Debug trial: native milestone hover and location click

Date: 2026-11-14. Status: **stakeholder-verified two-click capture and correct location output in game**. Internal native event ordering and the complete acceptance matrix remain unverified. This is not production bind detection.

Latest UI increment: the picker explicitly instructs two clicks and uses number-only icons. A clear named second-click capture now records a session guess for the selected skill, shows it as **[guess]** in the large table, and requests closure on the following Update. These assignment/layout changes require a fresh client check; the prior runtime report verified capture/result delivery.

The earlier report confirmed hover, numbered badges and click-time Alias replacement while the picker stayed open. After the stable-Alias retry was added, the stakeholder confirmed that **two clicks are required and the debug window then shows the correct identified location**. This verifies delivery/result display for the reported two-click path. Exact callback order, automatic closure, absence of unintended travel in every interaction and other acceptance cases were not explicitly reported; do not mark all E11 checks complete.

## What changed

The bind-confirmation popup remains behind `TravelDebugEnabled` and lists the character's learned milestone skills. Its actual quickslots now receive the mouse instead of an intercepting selection control. At rest each contains the real skill, so the native destination tooltip can be tested.

On left `MouseDown`, only that popup's selected quickslot is replaced with:

```text
/trav milestone-capture <canonicalSkillId> <requestToken> ;loc
```

The German client uses `;pos`, based on the existing actual-client `GLocale`, independently of UI language preference. Other clients use `;loc`, following the inspected MoorMap pattern. This is an alias intended for the physical click; Lua does not execute it or issue a separate chat command.

The handler requires debug mode, the active popup/request, matching skill ID and token, a still-learned milestone, and a request no older than 30 seconds. Selecting another skill replaces the request; pressing the same selected icon refreshes the request time and reuses the existing Alias/token, avoiding another shortcut replacement during native activation. Closing/replacing the popup, disabling debug or unloading discards the active request. Tokens correlate local pending events; they are not authentication or proof that the character remained beside the milestone originally bound.

The handler logs the full expanded text and updates the same debug result field used by manual LOC, including the selected skill, closest-marker guess and predicted English skill name where supported. A clear named match updates the selected skill's session row as **[guess]**, with a numeric catalogue ID. Uncertain matches preserve the prior row and explain why. It marks the request complete and explicitly enables the later `Update` that closes the popup. No shortcut replacement or window destruction happens inside the shell-command callback. This does not accept a production binding, change the game's binding or save data.

## Location formats and limitations

MoorMap documents inline expansion as `world: area: NSCoordinate, EWCoordinate`. This differs from `/loc` output containing `r`, `lx`, `ly`, `ox`, `oy`, etc. The trial recognizes the former, retaining the raw expansion in diagnostics. It accepts decimal points or commas, N/S and E/W, plus German O for east or French O for west. Coordinate parsing does not resolve world/area strings to IDs, infer an instance, or declare proximity to a milestone.

Unexpected formats and literal, unexpanded `;loc`/`;pos` generate diagnostics and leave the picker available for retry. A different native format is evidence to collect, not a reason to silently guess a destination. English bind and successful-use detection retain their existing scope; choosing the German expansion token does not add German bind-chat detection.

## Event lifetime and restoration

- The first `MouseDown` installs the Alias and shows the selected number/waiting status. A repeat press on the same icon reuses the Alias/token and refreshes the click time; it does not call `SetShortcut` again.
- `MouseUp` and `MouseClick` log their observation and record release time without replacing the shortcut.
- Successful capture closes on a subsequent `Update`.
- If no command arrives, keep the pending Alias available for a second physical click. Only a canceled/expired selection with observed release is restored in a later `Update`, at least 0.5 seconds after release. This delay is an experiment allowance, not a documented timing guarantee.
- A press held longer than 30 seconds expires the request but leaves the harmless alias installed until release or retry. Restoring a real skill while a press is held could cause travel on release. Updates stop while awaiting that release, and resume when release is observed.
- A drag/drop recovery is deferred to `Update`; drops are disabled. Release outside the control still requires in-game verification. If no release was delivered, another press on that same selected icon refreshes the active request without rewriting the Alias; closing/reopening discards it and restores fresh skill controls.
- Closing discards the quickslots and their request, disables their mouse input and stops updates. There is no need to restore a discarded hidden control's native skill during the dispatching callback.

Normal list/grid/carousel/pulldown/map quickslots keep their existing travel action and successful-use tracking. This trial is confined to the bind popup.

## Required in-game acceptance

Offline validation on 2026-11-14 used [Test-MilestoneCaptureTrial.py](tools/Test-MilestoneCaptureTrial.py) with `lupa.lua51`: all 40 plugin Lua files compiled under Lua 5.1. Stubbed-UI checks covered wrong token/skill, duplicate delivery, expiry, debug-off, learned-set validation, unexpanded location, deferred close/restoration, German/French parsing, gapped slots and existing successful-use attribution. These checks do not reproduce the native tooltip, mouse capture or shortcut dispatch. Run with Python and `lupa` available: `python plans/milestone-management/tools/Test-MilestoneCaptureTrial.py` from the repository root.

1. Reload the plugin, enable `/trav debug on`, and bind a milestone. Hover the popup skill without clicking. Record whether the tooltip is the real dynamic skill tooltip and displays the currently bound destination.
2. Left-click once. If that only installs the Alias, follow the instruction and click the same icon again. Capture `MouseDown armed`, the optional stable-Alias retry, `MouseUp`, `MouseClick`, `alias received` and `selected at` diagnostics **in their actual order**. Successful delivery updates the large window and closes the picker. There must be one usable location capture and **no cast, loading screen, cooldown or successful-travel message** from those picker clicks.
3. Repeat immediately without prior hover, with a long hover, and on another learned slot. Compare selected slot IDs/numbers and the expanded location. Test both Classic and Mini styling.
4. Check right-click, double-click, press/drag/release inside and outside, dragging a skill, a held press longer than 30 seconds, and retry after a failed capture. The picker must recover without casting a milestone. Verify the restored hover uses the real skill, rather than the alias tooltip.
5. Close/reopen the popup, rebind while it is open, disable debug, and unload during a pending request. Delayed/replayed commands from the old token must be ignored and no updater should remain active.
6. Travel using a normal TWII view. Existing `milestone skill no N clicked` and successful-use mapping must confirm or correct that skill's guessed row and remove **[guess]**, leaving other skill rows untouched. The manual LOC test remains comparison-only and must not assign any skill.
7. Where available, verify actual client expansion for DE/FR/RU/ES and preserve any unexpected raw string before adjusting parsing. No cross-language runtime success is claimed.

If the client captures the skill shortcut before Lua's `MouseDown`, clicking may still cast the skill. That outcome means this approach failed the feasibility gate. A phase log or syntactically valid alias alone is not acceptance. Revert to a real alias action with explicitly different tooltip behavior if that gate fails; do not ship a picker with unintended travel.

## Evidence

- [Prior tooltip/location research](2026-11-09-native-tooltip-and-location-click.md), including the API limitations and experiment E11.
- Local `Plugins/GaranStuff/MoorMap/Main.lua`, location alias around lines 3205–3217 and inline expansion documentation around lines 5899–5905; alias language is selected from the actual game client.
- [Garan's alias update explanation](https://www.lotrointerface.com/forums/showthread.php?t=2046): changing a quickslot alias while its native click is being processed can disturb execution; later `Update` restoration is the precedent. It does not establish that Skill-to-Alias switching during `MouseDown` works.
- Implementation: `src/MilestoneLearnedWindow.lua`, and the dedicated early command route in `src/Main.lua`. The two-click capture/result path has a positive stakeholder runtime report; remaining acceptance cases are pending.
