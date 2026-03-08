# Plan: In-Map Region Navigation

Date: 2026-03-08
Branch: in-map-region-navigation
Base: origin/patch-og-font
Scope: Planning only for this task, no plugin behavior changes yet

## Goals
- Add clickable transition areas on the map image for each of the five normal map regions
- Make each transition area behave exactly like clicking the matching region button below the map
- Show a small hover overlay for transition targets, similar to the in-game map behavior
- Ensure hitboxes and overlays remain correct at any map view scale

## Current State Summary
- Region switching is currently handled by `TravelMapTab:SwitchRegion(newRegion)` and the five bottom navigation buttons
- Map content is rendered in `self.mapLabel` with `SetStretchMode(1)`
- Existing quickslot map markers are parented to `self.mapLabel`, which already scales with map resize
- No in-map interactive transition controls currently exist

## Reference Findings (MoorMap)
- MoorMap attaches interactive controls to the map control parent in stretch mode
- Click handlers switch map via a central map-change function
- Hover UI is shown through dedicated controls and hidden on leave/update
- Explicit coordinate scaling math is not required when controls are parented to the stretched map

## Implementation Plan
1. Add transition data model for the five normal regions
- Define a static table in `TravelMapTab.lua` keyed by source region
- Each entry is a list of transition items with:
  - `toRegion`
  - base-map rectangle (`x`, `y`, `w`, `h`) in 1024x768 coordinates
  - optional hover label key/resource key for localized text
  - optional overlay background resource id/path if available

2. Create in-map transition controls
- Add `self.regionHotspots` and `self.regionHotspotOverlays` collections to manage lifecycle
- Build a reusable `CreateRegionHotspotsForCurrentMap()` method called from `LoadMap()` and resize paths
- Parent hotspot controls to `self.mapLabel`, set `SetMouseVisible(true)`, transparent background, high `ZOrder`
- Bind `MouseClick` to call `self:SwitchRegion(item.toRegion)` for left-click and menu for right-click parity

3. Add hover overlay behavior
- Add a compact overlay control (or label) per hotspot, initially hidden
- On `MouseEnter`, show overlay near hotspot and display localized target region text
- On `MouseLeave`, hide overlay
- Keep overlay behavior lightweight and deterministic, with no timers unless needed

4. Make scaling behavior robust
- Keep all hotspot and overlay controls parented to `self.mapLabel` so stretch scaling applies automatically
- Store hotspot positions in base-map coordinates and apply directly, matching existing quickslot positioning style
- Ensure control recreation/repositioning happens when map size changes and when switching regions

5. Integrate with existing lifecycle
- Add clear/reset methods similar to `ClearItems()` so hotspot controls are cleaned up on rebuild
- Ensure non-player map mode (creeps) does not create normal-region transition hotspots
- Keep existing region button behavior untouched and functionally equivalent

6. Validation checklist (manual in-game)
- For each of the five regions, verify every configured hotspot:
  - hover shows intended overlay text
  - left-click switches to correct target region map
  - right-click still opens plugin menu
- Verify behavior at multiple `Settings.mapViewScale` values, including smaller and larger than `1.0`
- Verify hotspot clicks do not interfere with existing map quickslots
- Verify no stale hotspot controls remain after repeated region switches

## Open Data Decisions For Implementation
- Exact hotspot rectangles and hover text per region pair
- Whether hover overlays use existing game resource ids or simple styled labels first
- Whether all possible region-to-region transitions are configured now or staged incrementally
