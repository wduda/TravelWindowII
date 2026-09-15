# Map border learned state

Date: 2026-09-15
Branch: `map-view-learned-skill-borders`

## Objective

Derive map border learned state from `travelShortcut.found == true` inside
`TravelMapTab:AddSingleShortcut()`. Skill detection provides `found` for all
categories, including racial and creep skills, as confirmed by the user.

## Implementation

1. Remove the `isLearned` parameter from `AddSingleShortcut()`.
2. Define `local isLearned = travelShortcut.found == true` inside the method.
3. Remove the fourth argument from racial, creep, and regular skill callers.
4. Preserve existing shortcut inclusion checks and border rendering logic.

## Validation

- Inspect every `AddSingleShortcut()` definition and call for consistent arguments.
- Run `git diff --check` and review the scoped Lua diff.
- Run Lua syntax validation if a compatible checker is available.
- In-game border rendering remains a manual acceptance check, including learned
  and unlearned creep skills and both border visibility settings.
