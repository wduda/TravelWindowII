# Plan: Shared Font Size Option for List and Pulldown Labels

Date: 2026-03-06
Branch: feat/list-and-pulldown-font-size-option

## Goals
- Apply configurable font size to both List View labels and Pulldown labels
- Keep pulldown scope limited to label text only
- Rename the option text so it no longer refers only to List View
- Preserve compatibility with existing saved settings

## Steps
1. Locate current list-font-size setting usage and pulldown label rendering path
2. Introduce shared font configuration helper usable by List and Pulldown views
3. Update pulldown label font application without changing non-label control sizing behavior
4. Rename option label/localization key and wire the options panel to it
5. Add settings migration for old key/value names if needed
6. Validate references and ensure no duplicate/legacy UI entries remain
