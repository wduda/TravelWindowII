# Plan: Rework Map-View Learned/Unlearned Borders

Date: 2026-08-31
Branch: map-view-learned-skill-borders
Base: main at v4.9.0
Scope: Map quickslots only; navigation-panel quickslots remain unchanged

## Objective

Implement #297 with a green border for learned map skills and a red border for
unlearned map skills. The border must scale with the quickslot as one visual
unit when map scaling changes.

## Branch Resolution

- Preserve the previous experimental implementation behind the local tag
  `archive/map-view-learned-skill-borders-v1`.
- Reset the draft branch to current `main` and do not replay the obsolete
  independent-border rendering commits.
- Rebuild the feature in a new commit so the draft PR is based on v4.9.0.

## Implementation

1. Add learned and unlearned border colors plus a one-pixel base width in
   `src/TravelMapTab.lua`.
2. Create one wrapper control per map quickslot. At native scale, its colored
   background forms the border and its child quickslot is inset by one pixel.
3. Put the wrapper in stretch mode before resizing it for map scale. The
   wrapper, its border, and its native-size quickslot will then scale together.
4. Keep wrappers with the map quickslot lifecycle so region changes clear them
   together, without modifying navigation-panel shortcuts.
5. Treat creeps and displayed racial skills as learned; use the existing
   shortcut `found` state for class and reputation skills.

## Verification

- Confirm each map quickslot has exactly one colored border wrapper.
- Confirm learned skills are green and unlearned skills are red.
- Confirm changing map scale keeps each border aligned with its icon.
- Confirm map quickslot clicks and the Hide Skill context menu still work.
- Confirm navigation-panel shortcuts have no learned/unlearned border.
