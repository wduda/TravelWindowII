# Plan: In-Map Region Navigation

Date: 2026-03-08
Branch: in-map-region-navigation
Base: origin/patch-og-font
Scope: Planning only for this task, no plugin behavior changes yet

## Goals
- Add clickable transition areas on the map image for each of the five normal map regions
- Make each transition area behave exactly like clicking the matching region button below the map
- Show a small hover overlay for transition targets using the same in-game assets MoorMap uses
- Ensure hitboxes and overlays remain correct at any map view scale
- Exclude creep map from this feature (no in-map region hotspots for creeps)

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
  - overlay center point (`cx`, `cy`) in 1024x768 coordinates
  - in-game overlay asset resource id/path (same family used by MoorMap)

2. Create in-map transition controls
- Add `self.regionHotspots` and `self.regionHotspotOverlays` collections to manage lifecycle
- Build a reusable `CreateRegionHotspotsForCurrentMap()` method called from `LoadMap()` and resize paths
- Parent hotspot controls to `self.mapLabel`, set `SetMouseVisible(true)`, transparent background, high `ZOrder`
- Bind `MouseClick` to call `self:SwitchRegion(item.toRegion)` for left-click and menu for right-click parity

3. Add hover overlay behavior
- Add a compact overlay control per hotspot, initially hidden
- Use in-game overlay art assets (matching MoorMap approach), not custom label-only fallback
- Position overlay from configured center point (`cx`, `cy`) so assets align consistently
- On `MouseLeave`, hide overlay
- Keep overlay behavior lightweight and deterministic, with no timers unless needed

4. Make scaling behavior robust
- Keep all hotspot and overlay controls parented to `self.mapLabel` so stretch scaling applies automatically
- Store hotspot positions in base-map coordinates and apply directly, matching existing quickslot positioning style
- Ensure control recreation/repositioning happens when map size changes and when switching regions

5. Integrate with existing lifecycle
- Add clear/reset methods similar to `ClearItems()` so hotspot controls are cleaned up on rebuild
- Ensure creep mode (`MapType.CREEPS`) never creates transition hotspots or overlays
- Keep existing region button behavior untouched and functionally equivalent

6. Add developer coordinate-debug workflow
- Reuse `/travel debug` mode to show current mouse map coordinates while hovering map
- Add a small debug label anchored to the map showing:
  - current mouse `x,y` in base map pixel space (1024x768 reference)
  - optional current region id/name
- Make this debug label visible only when debug mode is on
- Use this to capture exact overlay center points for source definitions

7. Validation checklist (manual in-game)
- For each of the five regions, verify every configured hotspot:
  - hover shows intended in-game overlay asset at the expected location
  - left-click switches to correct target region map
  - right-click still opens plugin menu
- Verify behavior at multiple `Settings.mapViewScale` values, including smaller and larger than `1.0`
- Verify hotspot clicks do not interfere with existing map quickslots
- Verify no stale hotspot controls remain after repeated region switches
- Verify debug coordinate label appears only with `/travel debug` and reports stable, usable values

## Open Data Decisions For Implementation
- Exact hotspot rectangles and overlay center points per region pair
- Exact in-game overlay resource ids/paths to standardize on (from MoorMap references)
- Whether all possible region-to-region transitions are configured now or staged incrementally
