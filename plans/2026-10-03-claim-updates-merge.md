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

The current source head was `b0a82dc` and target was `6494e8d`. The merge touched `TravelCaroTab.lua`, `TravelMapTab.lua`, and `__init__.lua`. I resolved the map shortcut overlap by preserving the release branch's sized, unstretched border parent and directly stretched native Quickslot, then adding the standard edge attachment to that Quickslot. The scaling edge attachments and shared helper are included; the accepted artefact-free border rendering path remains intact.

`git diff --cached --check` passed before commit. No LOTRO client rendering test was available in this session. Local merge commit: `d2d7ef1`. Publishing this commit and verifying PR #323 closure as merged remain pending. The three earlier plan commits are still preserved on `codex/pre-push-v4.11.0-backup` and were not cherry-picked.
