# Travel Button Icon and Size Customization with Resource Path Normalization

## Summary
- Add per-character settings for travel button icon style and double-size mode
- Expose both settings in the options panel and the right-click settings menu
- Add a live preview in the options panel
- Include both settings in account-wide save/load defaults
- Rename the travel button asset folder to `src/resources`
- Rename 32x32 icon files to explicit `_32x32.tga` names

## Implementation
1. Save this plan file in `plans/`
2. Rename `src/Resources` to `src/resources`
3. Rename the 32x32 travel button images to `_32x32.tga`
4. Add shared icon metadata and persisted settings in `SettingsManager.lua`
5. Refactor `TravelButton.lua` to apply icon and size dynamically
6. Update `SyncUIFromSettings()` to refresh button appearance
7. Add icon selection, size toggle, and preview UI in `OptionsPanel.lua`
8. Extend `SettingsMenu.lua` with icon and size controls using action-based dispatch
9. Add localized strings in `LocaleStrings.lua`
10. Verify resource references and persistence behavior

## Validation
- Options panel updates preview and button immediately
- Settings menu updates button immediately
- Reset/load global defaults refresh icon and size
- Existing settings files fall back to default icon and 32x32 size
