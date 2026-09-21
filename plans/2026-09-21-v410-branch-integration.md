# v4.10.0 branch integration

## Scope

- Carry the learned-state centralization commits `312a7ab` and `435019d` into `v4.10.0`.
- Rebase `scrolling-update` onto the updated `v4.10.0` and verify that only its intended scrolling changes remain.
- Merge the cleaned scrolling work through pull request #313.
- Comment on pull request #312 with the issues its merge is expected to close.
- Delete the obsolete `map-skill-positioning-hotfix` branch.

## Boundaries

- Do not update release metadata or localization until the user authorizes that follow-up work before merging #312.
- Stop and report if the cherry-pick, rebase, or PR merge has a substantive conflict requiring a choice.

## Order

1. Cherry-pick `312a7ab` and `435019d` onto `v4.10.0`.
2. Create/update a local `scrolling-update` branch, rebase it onto `v4.10.0`, and inspect the resulting diff.
3. Merge #313 after the rebased branch is clean.
4. Add the issue-closing comment to #312.
5. Delete `map-skill-positioning-hotfix` after confirming its work is already represented in `v4.10.0`.
