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

## Results

Investigation and implementation pending.
