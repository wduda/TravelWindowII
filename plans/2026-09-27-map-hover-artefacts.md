# Map View travel-skill edge artefacts

## Scope and workflow

- Base: `origin/v4.11.0`; implementation branch: `codex/map-hover-artefacts`.
- Create or locate a GitHub issue as the bug's source of truth and open a focused PR targeting `v4.11.0` with `Fixes #...`. Do not merge.
- Commit this plan before implementation and update it when findings change the approach.

## Plan

1. Inspect map Quickslot construction, native and custom borders, hover/drop configuration, scaling, geometry, lifecycle, and relevant Git history.
2. Record the reported Eriador / Forochel / Ered Luin / Thorin's Hall symptoms and distinguish source evidence from unverified rendering hypotheses in the issue.
3. Report a concrete implementation-backed root-cause hypothesis before changing Lua. Select the smallest correction supported by that investigation.
4. Preserve native activation, tooltips, hover, right-click menus, border preferences, and existing drag/drop policy. Avoid unrelated UI changes, locale data, release metadata, and Turbine libraries.
5. Review the diff, run available deterministic checks, and document limitations of source-level verification.
6. Commit and push the focused change, create the linked PR, and provide the remaining in-game checks.

## Initial findings

- `AddSingleShortcut` creates a 36px container containing a native 36px Quickslot and optional four 1px learned/unlearned border edges.
- `SetAllowDrop(false)` is already configured. There is no custom icon overlay, texture atlas, or skill MouseEnter/MouseLeave handler.
- The parent is stretched as a group. `UpdateMapQuickslot` rounds parent position/size, but child border coordinates still undergo the parent's fractional transform.
- Region changes rebuild the skill controls; map-connector hover overlays are separate children of the map label.
- No screenshots were included in the supplied text attachment. A visual root cause cannot be claimed as reproduced from that text.

## In-game acceptance (pending)

- Eriador: Forochel and Ered Luin / Thorin's Hall, with learned/unlearned border options enabled and disabled.
- Repeated enter/leave and movement between skills; native hover and tooltips.
- Region/tab switching, closing/reopening, classic/minimal window modes, and supported resizing/scales.
- Travel activation, hide-on-travel, and right-click context menus.
- Dragging out of skills where supported; dropping onto fixed map skills remains disabled. Navigation-panel reordering remains unchanged.

## Selected correction

Issue: https://github.com/wduda/TravelWindowII/issues/324

The concrete source defect is fractional outline geometry inside a stretched
parent. For example, scale 1.25 transforms a 1px edge to 1.25px at a 2.5px
inset. Its relationship to the reported state-dependent green/yellow fragments
is a working hypothesis, not an in-game reproduction.

Keep the parent unstretched and scale the native Quickslot itself, initialized
once at its native size. Lay out the optional outline controls in final integer
pixels using the same rounded frame bounds, inset, and edge thickness. Retain
the existing placement convention, colors, preferences, event handlers, and
drop policy. No custom hover state or texture substitution is needed.

## Results

- Implemented in `src/TravelMapTab.lua`: the parent remains unstretched, the
  native Quickslot uses stretch mode initialized once at 36px, and the four
  optional outline controls receive final integer geometry from
  `UpdateMapQuickslot`.
- A temporary Lua 5.1 harness executed the actual source with mocked UI
  controls. All 9,648 cases passed: 201 scales (1.00 through 3.00), two window
  offsets, three map positions (including Forochel and Thorin's Hall), both
  learned states, and all four border-option combinations.
- Checks cover effective whole-pixel edge geometry, outline continuity and
  containment, original scale-1 geometry, color/preferences, mouse transparency,
  preserved shortcut/drop policy, click/context-menu and hide-on-travel routing,
  repeated size updates, and cleanup. The baseline fails the effective
  whole-pixel edge check at scale 1.02.
- Lua 5.1 loading/syntax and `git diff --check` passed. The existing
  `Turbine.Testing` tests require the game client and were not run.
- Mocks do not implement LOTRO rendering, native hover/tooltips, activation,
  opacity composition, or drag/drop. All in-game acceptance above remains
  pending; use a draft PR until the reported artefacts and these interactions
  have been checked in the client.

## In-game feedback and follow-up

- User testing of `b1cf67f` confirmed the original artefacts are gone, but both
  learned/unlearned borders are invisible regardless of settings. Acceptance
  therefore failed; the initial mock checks did not model native drawing order.
- Working diagnosis: the stretched Quickslot draws over ordinary sibling
  border controls despite their higher Z-order. This matches the historical
  SetStretchMode overlay behavior reported by plugin author Garan:
  https://www.lotrointerface.com/forums/showthread.php?t=1604
- On the same implementation branch, initialize each edge's stretch mode after
  its final integer position/size is assigned. This puts the outline in the
  same rendering mode without fractionally scaling a shared parent. Explicitly
  show edges and propagate opacity because stretched controls do not reliably
  inherit it. Recheck geometry and opacity plumbing, then repeat in-game tests
  for visible learned/unlearned borders and absence of the original artefacts.
- Runtime confirmation of the follow-up remains pending.
- Follow-up checks: Lua 5.1 loaded the updated source and all 9,648 mocked cases
  passed, including explicit edge visibility, matching stretch-mode setup at
  final pixel size, and opacity values 0/0.25/0.75/1. The previous fix fails the
  newly added configuration check. This verifies API calls and geometry only,
  not native draw order. `git diff --check` passed.
