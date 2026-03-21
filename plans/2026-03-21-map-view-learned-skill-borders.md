# Plan: Map-View Learned/Unlearned Borders

Date: 2026-03-21
Branch: map-view-learned-skill-borders
Base: v4.7.0
Scope: Map view only, no nav panel border changes

## Goals

- Add a visible border around map quickslots to distinguish learned and unlearned skills
- Use a green border for learned map shortcuts and a red border for unlearned map shortcuts
- Keep the nav panel unchanged
- Make the base border width easy to tweak in code during visual testing
- Scale the rendered border width with map view scaling

## Visual Rules

- Learned border color: `#60C476`
- Unlearned border color: `#D90000`
- Initial base border width: `1`
- Effective border width scales from map zoom using `max(1, floor(baseWidth * scale + 0.5))`

## Current State Summary

- Map quickslots are created directly on `TravelMapTab.mapLabel`
- Nav panel quickslots are created separately on `TravelMapTab.navPanel`
- Map quickslots currently do not have wrapper controls or status-based visual styling
- Learned state already exists through shortcut/skill `found` tracking

## Implementation Plan

1. Add map border constants and helpers in `src/TravelMapTab.lua`
- Define base width and learned/unlearned colors near the existing map constants
- Add a helper to compute scaled border width from `Settings.mapViewScale`
- Add a helper to determine learned state for a map shortcut or skill id

2. Wrap map quickslots with a colored parent control
- Update map quickslot creation so each map quickslot gets a parent wrapper on `self.mapLabel`
- Size the wrapper to quickslot size plus border inset on all sides
- Position the wrapper so the quickslot stays visually centered on the existing map coordinates
- Keep the quickslot as the interactive child

3. Keep borders map-only
- Apply the wrapper logic only in map quickslot creation
- Leave nav panel quickslot creation and nav panel layout untouched

4. Update lifecycle and cleanup
- Track wrapper controls alongside map quickslots
- Remove wrappers and map quickslots together in `ClearItems()`
- Ensure region switching rebuilds borders correctly

5. Preserve interaction and layering
- Keep map quickslot click behavior unchanged
- Keep hotspot overlays and debug label working
- Keep border wrapper below the quickslot and above the map background

## Test Plan

- Confirm learned map skills show a green `#60C476` border
- Confirm unlearned map skills show a red `#D90000` border
- Confirm nav panel shortcuts have no border
- Confirm borders scale up when map scaling increases
- Confirm region switching and resize paths rebuild borders cleanly
- Confirm map quickslot left-click and right-click behavior is unchanged

## Assumptions

- Monster-player map shortcuts are treated as learned for this feature
- Border width remains code-configurable only for now; no settings UI or persistence is added
