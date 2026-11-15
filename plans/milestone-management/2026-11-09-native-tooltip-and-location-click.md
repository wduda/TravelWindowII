# Native milestone tooltip and location-click feasibility

Research date: 2026-11-09. Scope: documentation and source inspection only. No plugin code or in-game experiment was added. The supplied Discord conversation is design context; its cross-view numbering ideas are not authorization to change every view now.

## Result

**Supported patterns:** put a mouse-transparent number/icon overlay above a real quickslot; use an Alias quickslot to execute a user-clicked location command; include the selected skill and an expanded location in the same command to the plugin.

**Not established:** the exact combination of a native skill tooltip over the full icon area and an alias-only click on that same area. The inspected API exposes a whole-control mouse-visibility flag, not separate hover/click pass-through switches. No documented native skill-tooltip invocation API or quickslot default-action cancellation contract was found in the inspected member documentation. This is a statement about inspected documentation, not proof that no current-client technique can exist.

A graphic of a milestone over an Alias quickslot does not turn the Alias tooltip into that skill's native dynamic tooltip. Forwarding Lua MouseEnter/MouseLeave callbacks is also not evidence that the client will display its internal skill tooltip.

## 1. API and source evidence

The inspected SSG API HTML mirror is [Goldbishop/Lotro_LUA](https://github.com/Goldbishop/Lotro_LUA/tree/fe36613c8a4f83e68089fbe135d455deb77b0db1/SSG), revision `fe36613c8a4f83e68089fbe135d455deb77b0db1`. The pages carry SSG 2016 copyright and Beta documentation notices. [Official Update 24 documentation](https://www.lotrointerface.com/downloads/info1035-OfficialUpdate24LuaDocumentation.html) is dated 2019. Neither is a live verification of the current client. Source examples and later author comments supplement them.

| Evidence | What it establishes | What it does not establish |
|---|---|---|
| [Control.SetMouseVisible](https://github.com/Goldbishop/Lotro_LUA/blob/fe36613c8a4f83e68089fbe135d455deb77b0db1/SSG/Turbine_UI_Control_SetMouseVisible.html) | When false, underlying controls handle mouse messages. This is a whole-control flag. | A supported way to pass hover to one control but clicks to another. |
| [Quickslot members](https://github.com/Goldbishop/Lotro_LUA/blob/fe36613c8a4f83e68089fbe135d455deb77b0db1/SSG/Turbine_UI_Lotro_Quickslot%24Members.html) | One current shortcut; normal mouse callbacks; right-click activation setting; inherited enabled/mouse visibility. | A tooltip-source override, documented click cancellation result, or per-event pass-through API. |
| [SetUseOnRightClick](https://github.com/Goldbishop/Lotro_LUA/blob/fe36613c8a4f83e68089fbe135d455deb77b0db1/SSG/Turbine_UI_Lotro_Quickslot_SetUseOnRightClick.html) | Controls whether right clicks activate the quickslot. | A documented way to disable left activation or redirect left clicks to a different shortcut. |
| [Control.SetEnabled](https://github.com/Goldbishop/Lotro_LUA/blob/fe36613c8a4f83e68089fbe135d455deb77b0db1/SSG/Turbine_UI_Control_SetEnabled.html) | Disabled controls typically ignore user actions. | A guarantee that disabled native quickslots retain tooltips while their clicks activate another control underneath. |
| [Garan's alias-button explanation](https://www.lotrointerface.com/forums/showthread.php?t=1866), 2012 | A visual mask with mouse visibility disabled can cover an oversized/cropped Alias quickslot; the physical user click activates the alias. | Native skill hover with independent alias activation. |
| [2025 alias-icon discussion](https://www.lotrointerface.com/forums/archive/index.php/t-4126.html) | Garan again describes masking; Thurallor describes two-pixel alias strips used by TrickButton. | Any replacement of Alias native tooltip with a Skill tooltip. |
| [Garan's quickslot update explanation](https://www.lotrointerface.com/forums/showthread.php?t=2046), 2013 | Changing the alias during a click handler can interfere with native alias execution; deferred Update is used to change it afterwards. | Safe skill-to-alias switching before the current native click executes. |

No evidence was found that returning false, setting a hypothetical `Handled` field, calling a Lua handler manually, or programmatically invoking a Quickslot click is a supported substitute for the native user action. Do not borrow event-cancellation semantics from browser or desktop UI frameworks.

## 2. Local implementations

Paths below are relative to the user's `Plugins` directory. Inspectors should retain their actual local versions rather than assuming a public archive is identical.

- **MoorMap `Main.lua:1602–1636`:** an oversized Alias quickslot is cropped by its container; a separate icon with `SetMouseVisible(false)` provides appearance. The click still belongs to the Alias quickslot.
- **MoorMap `Main.lua:3131–3152`:** location shortcut rebuilding uses the actual client language, with `/loc`, `/pos`, or `/emp`, and a mouse-transparent location icon. UI-language preference must not choose the game command.
- **MoorMap `Main.lua:3205–3217`:** aliases such as `/Moormap setloc ;loc` and `/Moormap setloc ;pos` pass the expanded location to MoorMap's own command. The quick annotation aliases similarly include location and target metadata.
- **SequenceBars `Slot.lua:66–73`:** action-enabled state alternates mouse visibility between the real object and its number label. This is routing the control, not selective native hover/click pass-through.
- **SequenceBars `Slot.lua:268–290`:** a separate outlined label draws a slot number. Numbering is an overlay concern, independent of the shortcut's destination.
- **Thurallor Common `UI/TrickButton_1.lua:70–88`:** Alias quickslots two pixels high form an invisible clickable surface. Its MouseDown/MouseUp forwarding and custom hover machinery do not supply native skill tooltip content. The source even notes that some quickslot move/hover events did not seem to fire in that implementation; measure the current event sequence instead of assuming one.
- **WarbandsSlayer `src/QuickSlotGenericButton.lua:21–43`:** masks an Alias quickslot with a control and text/image layer; both decorative layers ignore the mouse.

The current debug picker in the execution worktree sets the real skill quickslot mouse-invisible and places a mouse-visible selection control above it. This prevents ordinary input from reaching that skill. The select-only overlay is therefore not a demonstrated native-tooltip-preserving design. Restoring mouse visibility alone could restore travel activation, the regression already reported by the stakeholder.

## 3. Concrete one-click location proposal

Prefer a real, user-clicked Alias shortcut as the action owner. A proposed payload shape is:

```text
/trav milestone-capture <skillId> <requestToken> ;loc
```

**This command is not implemented.** It illustrates a later dedicated handler, not the current `/trav` syntax. A locale-specific expansion, such as the DE `;pos` used by MoorMap, needs validation. Preserve the exact expanded location and full world/instance context for parsing.

The intended result is one intentional click carrying:

1. The canonical selected milestone skill ID, validated against the learned set.
2. A pending-request token identifying the bind dialog/session/revision.
3. The location expanded by the game at click time.

This is preferable to relying only on a generic `/loc` chat line from any requester. It can associate the selection and location without programmatically sending chat or activating another quickslot. The request token cannot prove the player stayed beside the original milestone; delayed movement remains the existing proximity risk.

If `/loc` chat output is used instead, arm a pending request before the actual user action and apply the existing freshness/ambiguity rules. `/loc` emits game output; `;loc` is an inline alias expansion and is not interchangeable with the slash command in arbitrary Lua code.

The future alias shortcut must resist replacement/drag-out as appropriate to the current client. Keep the alias/control alive until the native command has actually been delivered; do not close/rebind it prematurely in a mouse callback and assume the original click will complete. Close the picker on successful capture handling or after a validated deferred lifecycle step. Source examples show drag/drop and native click ordering deserve explicit checks.

The icon and number can be independent, mouse-transparent overlays above this Alias. Its native tooltip would still describe the alias. A custom tooltip can display known skill identity/observed destination, but must not claim to be the game's live destination tooltip. Whether SkillInfo provides the current bound destination remains experiment E01.

## 4. Designs and their status

| Design | Hover behavior | Click behavior | Status |
|---|---|---|---|
| Real skill quickslot plus mouse-transparent number | Native skill tooltip expected from the real shortcut | Normal skill activation | Established layering pattern; suitable candidate for normal travel views, not the bind picker action. |
| Alias quickslot plus skill icon/number | Alias native tooltip, or a separate custom tooltip | Location alias | Source-backed action/appearance design; native skill tooltip requirement is not met. |
| Current interactive selection overlay over a mouse-invisible skill | Overlay receives input; native skill tooltip not established | Selection only | Current debug design; no location request yet. |
| Disabled native skill over an alias | Unknown whether tooltip remains and whether alias can receive the real click | Unknown | Runtime probe only; documentation does not promise this. |
| Switch Skill to Alias in MouseDown, restore later | Skill hover before the press might be possible | Depends on native event order/cached shortcut | Runtime hypothesis only; do not ship on static reasoning. Switching during MouseClick has documented historical problems. |
| Change Z-order/mouse visibility on press | Might allow hover to the skill first | Unknown capture/hit-test order for the same press | Runtime hypothesis only; must not assume the current event is re-routed. |
| Separate inspect area and location action | Native inspection requires its own real target/validated tooltip source | Separate explicit location click | Honest fallback if the same-area combination cannot be proven. Do not expose an unintended travel action in the picker. |

Manually forwarding the overlay's Lua MouseEnter/MouseLeave to the hidden quickslot does not constitute a verified native-tooltip design. Merely overlaying the number is much simpler: visual overlays can ignore all mouse messages and leave the underlying real skill quickslot unchanged.

## 5. Number overlays from the supplied design conversation

Treat unobtrusive numbers over milestone icons, removal of the debug picker's underneath label, and numbering across normal quickslot views as **design candidates recorded from the Discord context**. Styling and rollout need a later implementation plan.

- Derive the number from the canonical skill ID registry, never from grid position, current sorted order, shortcut array index, or destination name.
- Keep it stable across grid/list/carousel/pulldown/map tray and any per-skill map buttons. Text-only views can retain the existing destination-plus-slot label.
- Set every decorative input-capable layer to ignore mouse messages; do not assume a mouse-invisible parent makes every child mouse-invisible.
- Check outlined text, one- and two-digit numbers, cooldown overlays, resizing/scaling and Classic/Mini modes. Position and contrast remain design choices.
- Custom/alphabetical sorting can produce nonascending numbers. Preserve the selected/custom order rather than renumbering skills or silently sorting the tray numerically. The number identifies the game skill, not its display position.
- A picker icon uses the location action; a normal travel-view icon still casts its milestone. Sharing visual numbering must not change those distinct actions.

## 6. Focused runtime experiment E11

No probe was written or run for this research. A later, separately planned debug probe should compare the following and log the actual event sequence, shortcut type/data at each event, action output and tooltip content:

1. Baseline native skill quickslot and the same control with a mouse-transparent number. Confirm the tooltip contains the current bound destination rather than only a static template.
2. Masked Alias quickslot receiving a skill ID, token and expanded location in the plugin's own command. Confirm left click generates one usable location and no skill use; verify locale expansion and drag/drop recovery.
3. Whole-control mouse visibility and disabled-state variations. Record whether native tooltips remain and which control receives the physical click. Do not extrapolate from appearance alone.
4. Only if needed, test press-time switching/capture behavior first with two harmless diagnostic aliases. Then separately validate the actual native skill-tooltip case; alias-to-alias behavior alone does not prove skill-to-alias safety.
5. Exercise immediate click without prior hover, configured tooltip delay, stationary and moving hover, left/right/double click, press-drag-release inside/outside, Escape/close, debug-off, and delayed location arrival.

Success for the dream interaction requires the real native skill tooltip, exactly one location action tied to the chosen skill, and **no milestone cast** for any picker action. A Lua MouseEnter log or a static custom tooltip does not satisfy it. If the exact interaction fails, keep the proven location action with an explicitly different tooltip/inspection design; do not trade accidental travel for visual similarity.

## 7. Recommendation

Proceed with the source-backed Alias plus icon/number design as the location-capture foundation and keep native-hover/alias-click separation as E11's explicit feasibility gate. Evaluate normal-view number overlays independently because they need no action redirection. Preserve the earlier self-healing and three-iteration sequencing; these findings do not authorize implementation or change the debug picker now.
