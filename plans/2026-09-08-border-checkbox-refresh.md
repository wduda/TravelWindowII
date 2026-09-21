# Fix border checkbox refresh

- Use the existing map-view-learned-skill-borders branch.
- Both border checkbox handlers call the removed MapTab:SetItems method after saving their settings.
- Replace those two calls with MapTab:UpdateLayout, the current map rebuild method.
- Leave options-window layout, marker positioning, scaling, and border styling unchanged.
- Verify the handlers use the current method and no obsolete MapTab:SetItems calls remain; in-game toggle validation remains required.
