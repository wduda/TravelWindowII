# Plan: v4.11.0 scaling metadata and Map View opacity

## Scope

- Work on the `scaling-updates` branch, now targeting `main` through PR #326.
- Prepare v4.11.0 release metadata from commits after the latest release tag, v4.10.0.
- Fix the Map View background asset so it follows the Travel Window opacity setting.
- Stage all release metadata files, the runtime fix, and this plan without committing or pushing.

## Implementation steps

1. Add the map background label to `TravelMapTab:SetOpacityItems` so it receives the same opacity value as the Map View shortcuts and borders.
2. Add v4.11.0 changelog entries for the scaling changes in the release history and update both plugin manifests.
3. Record the opacity fix in the changelog and user-facing release notes.
4. Review the diff for consistent versions, wording, and staging scope. Do not commit or push.

## Validation

- Review the changed files and staged diff for consistency.
- LOTRO runtime verification of Map View background opacity remains a manual in-game check.
