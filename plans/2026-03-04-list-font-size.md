# Plan: List View Font Size Option

## Date
2026-03-04

## Feature Summary
Add an option to adjust the font size in the Text List (list view) tab. Users can choose between Small, Medium, and Large font sizes via radio buttons in the General options tab.

## Implementation Details

### Font Size Mapping
| Value | Label  | Turbine Font                       | Item Row Height |
|-------|--------|------------------------------------|-----------------|
| 1     | Small  | Turbine.UI.Lotro.Font.TrajanPro14  | 20              |
| 2     | Medium | Turbine.UI.Lotro.Font.TrajanPro15  | 22 (default)    |
| 3     | Large  | Turbine.UI.Lotro.Font.Verdana16    | 26              |

Default value: 2 (Medium), matching the current behaviour.

### Files to Change

#### 1. `src/SettingsManager.lua`
- Add `AddSettingConfig("listFontSize", 2)` in `CreateSettingsConfig()`.

#### 2. `src/LocaleStrings.lua`
- Add `listFontSize` label key in all four locales (EN/DE/FR/RU).
- Add `fontSizeSmall`, `fontSizeMedium`, `fontSizeLarge` label keys in all four locales.

#### 3. `src/OptionsPanel.lua`
- Add a `AddListFontSizeOption()` method that creates a radio button group (Small / Medium / Large) for the `listFontSize` setting.
- Register each radio control via `self.options["listFontSize" .. value]` so `UpdateOptions()` can reach them.
- On change: update `Settings.listFontSize`, set `_G.travel.dirty = true`, call `_G.travel:UpdateSettings()`.
- Call `self:AddListFontSizeOption()` in `SetupGeneralTab()` right after the `useTagInListTab` checkbox option.

#### 4. `src/TravelListTab.lua`
- Add helper `GetListFontConfig()` that returns `{font, height}` based on `Settings.listFontSize`.
- In `Constructor`: call `GetListFontConfig()` and set `self.itemHeight` from result (instead of hardcoded 22).
- In `AddItem`: after creating each label, call `label:SetFont(font)` if font is non-nil.
- In `SetItems` / any place `self.itemHeight` is initialised: re-read from config so live font changes take effect when `dirty` causes a full rebuild.

#### 5. `CHANGELOG.md` + `src/ChangelogData.lua`
- Add entry under the current development version with prefix `feat:`.

## Acceptance Criteria
- Changing font size option rebuilds the list view with the new font and row height.
- Scrolling, resizing, and FitToPixels all use the updated row height.
- Setting is persisted and loaded correctly across sessions.
- All four locales have the new strings (EN full copy used as fallback for DE/FR/RU).
