# Classic Map Skill Overlap Hotfix

## Objective

Fix the Galtrev travel-skill quickslot overlapping the bottom row of buttons in the classic Map view, reported after the v4.9.0 update.

## Scope

- Reproduce and inspect classic versus minimal Map-view layout and the reparented quickslot positioning.
- Trace the offset and scaling calculations shared with the bottom button row.
- Implement the smallest Lua/UI correction that keeps the travel skill accessible without changing minimal-mode behavior.
- Preserve existing user positioning and support the configured map-view scale.
- Add or update focused validation where practical, including static Lua checks and manual in-game checks at default and non-default UI/map scales.
- Create a GitHub issue from the supplied LotROInterface and Discord reports, linking the issue to this hotfix branch/work.

## Reported evidence

- Galtrev travel skill overlaps the bottom Map-view buttons.
- The reported workaround is dragging a corner of the skill box.
- The issue was reported at 1920x1080 with default UI scaling and across multiple characters.
- The reporter stated the previous plugin version positioned the skill correctly.
- The discussion suggests the regression is specific to the classic window and may involve the hacked offset added for reparented quickslots while fixing the bottom button row.
- Minimal UI mode was proposed as a comparison, but its result is not yet confirmed.

## Acceptance criteria

- In classic Map view, the Galtrev travel skill no longer overlaps the bottom button row and remains fully usable.
- Minimal Map view remains unchanged or is verified not to regress.
- Positioning remains correct across relevant `Settings.mapViewScale` values and at the reported 1920x1080 resolution.
- The implementation is documented in the changelog only when the fix is ready for release; issue creation and code fix remain separately reviewable.

## Tracking

- GitHub issue: [#306](https://github.com/wduda/TravelWindowII/issues/306)

## Investigation findings

- Galtrev map locations use `y = 715` and map quickslots are 32x32 at native scale.
- Map quickslots are parented to the full tab because child controls did not scale reliably with the stretched map label.
- The current reparented positioning applies a hard-coded `-15` Y offset.
- Review of commit `6842cff` confirms that this offset was introduced with the reparenting change after v4.8.0.
- The fix should preserve the existing scale calculation and adjust only the Y offset for classic versus minimal window padding.

## Review adjustment

- The 55px value was rejected by in-game evidence because it moves every marker upward; `hPadding` is outer-window layout padding, not a map-coordinate offset.
- Map quickslots should instead use the actual rendered map-label width and height, preserving each marker's relative map position without a hard-coded Y offset.
