# Fix map icon clipping

- Branch: map-view-learned-skill-borders.
- The 32px quickslot positioned at (-2, -2) ends at (30, 30), short of its 32px frame.
- Increase the inner quickslot control to 36px to allow for its two-pixel visual inset on each side; retain the existing frame, border geometry, positioning and joint scaling.
- Check the scoped diff and geometry. Validate native icon edges in-game with borders on/off and at multiple map scales before accepting the visual fix.

## Follow-up attempt

- Screenshots show residual right/bottom clipping after enlarging only the quickslot.
- Enlarge its parent to the same 36px bounds and place the quickslot at (0, 0).
- Move the parent by the scaled existing -2px offset and inset custom border edges by 2px, preserving their map alignment.
- Keep this an unverified visual fix until the tooltip comparison passes in-game.

## Custom border alignment

- Draw the custom one-pixel outline outside the 32px visual icon area rather than over its edge pixels.
- Use a 34px outline starting at (1, 1) within the existing 36px parent; leave quickslot bounds, map positions, and scaling unchanged.
- Validate red and green outlines in-game at native and enlarged scales, including toggling them off to compare native artwork.

## Outline position refinement

- The enlarged screenshot shows excess space above/left of the icon relative to below/right.
- Shift only the 34px custom outline from (1, 1) to (2, 2) inside the 36px parent. Its bounds remain inside the parent.
- Preserve icon position, quickslot size, outline size and shared scaling; verify the alignment in-game.
