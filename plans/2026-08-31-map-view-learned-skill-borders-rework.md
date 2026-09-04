# Plan: Rework Map-View Learned/Unlearned Borders

Date: 2026-08-31
Branch: map-view-learned-skill-borders
Base: main at v4.9.0
Scope: Map quickslots only; navigation-panel quickslots remain unchanged

## Objective

Implement #297 with independently configurable green borders for learned map
skills and red borders for unlearned map skills. Both border types are enabled
by default and must scale with the quickslot as one visual unit when map
scaling changes.

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
   Derive the final frame size, quickslot size, and inset from the same rounded
   pixel values so fractional map scales cannot shift the icon within its frame.
   Apply a two-pixel top-left visual-origin correction for the quickslot artwork,
   based on in-game visual comparison at the default map scale.
   Do not resize or reposition the child after stretching its parent: the
   parent control scales the complete native-size composition exactly once.
   Use four explicit one-pixel edge controls in the shared frame rather than a
   colored frame background, so the quickslot skin cannot add a second visible
   layer of padding.
4. Keep wrappers with the map quickslot lifecycle so region changes clear them
   together, without modifying navigation-panel shortcuts.
5. Treat creeps and displayed racial skills as learned; use the existing
   shortcut `found` state for class and reputation skills.
6. Add two persisted, character-scoped settings through `SettingsConfig`, both
   defaulting to `1` so existing border behavior remains unchanged:
   `showLearnedMapBorders` and `showUnlearnedMapBorders`.
7. Add separate localized checkboxes to the general options UI for learned and
   unlearned map borders. Each checkbox updates only its own setting, so users
   can show green borders, red borders, both, or neither. Add the required
   locale strings for every supported language.
8. When either option changes, rebuild or refresh the active map shortcuts so
   the matching border edges appear or disappear immediately without requiring
   a plugin reload. Keep the quickslots themselves clickable and visible when
   their border type is disabled.
9. Create learned edge controls only when `showLearnedMapBorders` is enabled
   and unlearned edge controls only when `showUnlearnedMapBorders` is enabled.
   Do not add a color-picker or a combined master toggle in this scope.

## Verification

- Confirm each map quickslot has exactly one colored border wrapper.
- Confirm learned skills are green and unlearned skills are red.
- Confirm changing map scale keeps each border aligned with its icon.
- Confirm each scaled icon has equal border padding on all four sides.
- Confirm the rendered quickslot artwork, not only its control bounds, is centered.
- Confirm map scaling keeps all four border edges visible around each icon.
- Confirm the visible border is one pixel at the native map scale.
- Confirm map quickslot clicks and the Hide Skill context menu still work.
- Confirm navigation-panel shortcuts have no learned/unlearned border.
- Confirm the new learned-border and unlearned-border options are both enabled
  by default for an existing character without saved values.
- Confirm disabling learned borders hides only green borders, while red borders
  and all map quickslots remain visible and functional.
- Confirm disabling unlearned borders hides only red borders, while green
  borders and all map quickslots remain visible and functional.
- Confirm either option applies immediately to an open map at native and
  enlarged map scales, then persists across a refresh or plugin reload.
