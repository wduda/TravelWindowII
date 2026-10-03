# Scaling updates merge into v4.11.0

## Scope and branch

- Target: `v4.11.0`; source: `origin/scaling-updates`, tracked by open PR #323.
- The user confirmed the release was made and the LOTRO Lua API has since been updated, clearing the PR's earlier deferral.
- Preserve `codex/pre-push-v4.11.0-backup` and its three unpublished plan commits. Do not cherry-pick those commits as a group.
- Merge the current scaling update, preserve the Map View artefact and border fixes already on `v4.11.0`, update this plan with the outcome, close PR #323 as merged, and finish with local `v4.11.0` aligned to `origin/v4.11.0`.

## Plan

1. Verify the clean target, preserved backup commits, current PR head, and fetched target/source refs.
2. Review all source changes and check their merge against the current release branch.
3. Commit this updated plan before integrating the Lua changes.
4. Merge `scaling-updates` into `v4.11.0`, resolving overlap while retaining both the new edge-attachment updates and accepted Map View rendering fixes.
5. Run appropriate static checks, publish the successful merge, verify PR #323 is closed as merged, and sync the local target branch to origin.

## Results

In progress. The current source head is `b0a82dc` and target is `6494e8d`. The source touches `TravelCaroTab.lua`, `TravelMapTab.lua`, and `__init__.lua`; the map shortcut block needs a manual merge to preserve the target's newer border rendering fix. The backup branch remains unchanged.
