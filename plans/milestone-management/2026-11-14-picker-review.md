# Picker polish and focused milestone-code review

Date: 2026-11-14. Scope: the new milestone prototype and its existing integration points, not a plugin-wide review. Code remains debug-only and session-local. No persistence was added.

Subsequent picker iteration: [two-click assignment plan](../2026-11-14-milestone-picker-two-click-assignment.md) supersedes this review's retained below-icon label layout. Labels are removed, number badges remain, instructions explicitly require two clicks, and clear named captures set session guesses before deferred closure. The review below records the earlier code state; its shared listener/parser/normal-view boundaries remain applicable.

## Picker change

The learned-skill picker retains its text beneath each icon and adds an 18×16 number badge over the quickslot's bottom-right corner. Numbers come from `GetMilestoneSlot`, so learned slots 1 and 3 display 1 and 3, independently of row order. The badge uses the existing map-debug label's Verdana/gold/dark styling, has `SetMouseVisible(false)`, and has no event handlers. It is decorative; the real quickslot receives input.

The initial popup position is vertically centered at the right edge with a 20px margin. Coordinates clamp to zero for small displays. Classic/Mini construction and the existing below-icon labels remain in the same window; no new window/helper framework was introduced.

## Review result and small cleanup

- **One chat subscription:** `TravelWindow.lua`'s existing `ChatLogHandler` remains the only `Received` registration in `src`. It routes advancement messages to existing skill detection and debug messages to the milestone filters. The milestone modules add no chat listener or replacement dispatcher.
- **Existing skill lookup:** Carousel/pulldown tracking can receive a native `GetShortcut()` result without the custom `.skill` field. The shared tracker now resolves it through existing `GetTravelSkill(shortcut:GetData())`, following the map/grid drag-drop pattern, instead of relying on the extension fields or adding another lookup implementation. The original shortcut is not mutated.
- **One milestone-ID lookup:** removed the redundant membership set; membership and number lookup use the same ID→slot table.
- **One location parse per capture:** formatting returns its already parsed location to the bind handler. The picker and explicit manual debug LOC button share the same parser/matcher/result presentation. The manual button is restored after clarifying that only regular views must avoid location capture.
- **Normal quickslot activation:** list/grid/carousel/pulldown/map callbacks retain their normal menu/hide/activation behavior and call the same observing tracker. This remembers identity for successful-use reconciliation, never a location command. Skill→Alias substitution is confined to the experimental picker; the separate manual LOC test control always contains an Alias. No skill definition or shortcut data is rewritten by the observer or badge.
- **Lifetime and debug gates:** debug-off/unload/close clear pending request state and stop the windows' updates; stale tokens are rejected. No additional timer service, options field or storage path was introduced.

These are small changes to the existing additions. Reworking the plugin's window hierarchy, chat registration ownership, global options or normal quickslot handlers would widen this task unnecessarily.

## Validation and limits

`tools/Test-MilestoneCaptureTrial.py` loads the real `TravelShortcut.lua` lookup and current source modules under Lua 5.1 with UI stubs. All 42 plugin files compile. Checks cover right-side/vertical-center positioning, bottom-right badge alignment, slots 1/3, mouse-transparent badges without handlers, Classic/Mini paths, native-shortcut lookup without changing its data, the existing bind/use paths, capture cleanup and catalogue matching. Tracked whitespace and dossier-link checks also pass.

Native mouse hit testing, tooltip readability and click dispatch require LOTRO. The existing MouseDown skill→Alias experiment can still cast if the client caches the real skill before the Lua handler; offline tests cannot settle that. This review does not promote that trial to production-safe interaction.

In game: reload TWII, enable debug, bind a milestone, confirm the picker opens on the right, inspect labels/numbers including a multi-skill character, hover and click both the number and the exposed icon area, and compare Classic/Mini. A successful picker click must capture location without casting or starting a cooldown. Check ordinary travel separately to confirm its existing debug click/use mapping still works.

Related: [disposable persistence research](2026-11-14-disposable-debug-storage.md), [runtime catalogue/LOC notes](2026-11-14-catalogue-debug-guess.md), [native-click trial](2026-11-14-mousedown-trial.md).
