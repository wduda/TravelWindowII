# Plan: v4.9.0 Release Kickoff

Date: 2026-06-23
Branch: release-v4.9.0
Base: main
Scope: Implement map-view hide-skill support, racial map visibility fix, Osgiliath/Henneth Annun map correction, and release packaging cleanup

## Summary

- Create a dedicated GitHub issue for the missing map-view `Hide Skill` behavior and implement that fix in this release
- Fix `#300` by making map-view racial rendering respect enabled and disabled state
- Fix `#301` by correcting the shared coordinates for after-battle Osgiliath and Henneth Annun
- Fix `#293` by excluding non-release folders from the generated release archive

## Implementation Plan

1. Add map-view `Hide Skill` parity
- Update map-view quickslots to use the same right-click `Hide Skill` menu flow as list and grid views
- Apply the same behavior to both map-body shortcuts and navigation-panel shortcuts
- Create a GitHub issue to track this missing behavior before implementation is finalized

2. Fix racial skill visibility in map view
- Refactor `TravelMapTab:AddRacialLocation()` so it uses the active racial shortcut's enabled state in addition to trained-state checks
- Preserve the existing single-active-racial model driven by `TravelInfo.racial`
- Validate the logic conceptually across all racial travel variants

3. Correct Osgiliath and Henneth Annun coordinates
- Audit the shared `SkillData.lua` entries used by Hunter, Warden, Mariner, and rep-return skills
- Adjust the common map coordinates so after-battle Osgiliath is south of Henneth Annun
- Keep overlap groups intact and verify the corrected stacking relationships

4. Clean up release packaging
- Update `.github/workflows/release.yml` exclusions so non-release folders are not bundled into the archive
- Preserve required release metadata and plugin files

## Validation

- Right-click class, rep, racial, and nav-panel map shortcuts and confirm `Hide Skill` is available and persists
- Disable an active racial skill and confirm it disappears from map view, then re-enable and confirm it returns
- Verify after-battle Osgiliath renders south of Henneth Annun for all shared overlap families
- Confirm the release archive excludes non-release folders while keeping required distributable files
