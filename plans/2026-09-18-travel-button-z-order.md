# Travel button Z-order

## Branch

`main`

## Goal

Keep the Travel Window II travel button visible and usable without forcing it above other LOTRO windows.

## Plan

1. Update the travel button window Z-order from `1` to `0`.
2. Leave button visibility, movement, opacity, size, icon selection, and click behavior unchanged.
3. Verify there is no additional Z-order assignment in the travel button implementation that would override the change.

## Expected result

LOTRO windows can render above the Travel Window II button while the button remains available on the normal UI layer.
