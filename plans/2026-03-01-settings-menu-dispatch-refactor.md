# Settings Menu Dispatch Refactor

## Summary
- Remove string-based action dispatch from the settings menu
- Bind each menu item directly to the behavior it triggers
- Keep shared refresh logic centralized after each menu change

## Implementation
1. Save this plan file in `plans/`
2. Replace `action` and `value` metadata on menu items with direct click callbacks
3. Extract shared post-change refresh logic into a dedicated helper
4. Extract toggle button appearance refresh into a dedicated helper
5. Remove the old `SettingsMenu:Update(action, value)` dispatcher
6. Verify the menu still updates selections, options panel state, and main window state correctly

## Validation
- Filter toggles still mark the main window dirty and refresh settings
- Mode changes still refresh the main window
- Button icon and size changes still refresh the toggle button appearance
- Opening options still opens the panel and refreshes menu selections safely
