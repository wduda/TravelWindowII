# Remove pre-push backup branch and audit stale refs

## Scope and branch

- Work from `v4.11.0` and keep it aligned with `origin/v4.11.0`.
- Delete local `codex/pre-push-v4.11.0-backup`; delete the same remote branch only if it exists.
- Preserve all other local and remote branch refs. Report branches that appear stale or already merged as candidates for a later cleanup decision.

## Plan

1. Confirm the worktree is clean, `v4.11.0` is current, and the backup branch's unique content is preserved on the target.
2. Check whether the backup ref exists on origin and inspect other branch tracking/merge status and related PRs.
3. Commit this plan before deleting the specifically requested local branch.
4. Delete the local backup ref and any matching remote ref if present.
5. Verify `v4.11.0` remains aligned with origin and summarize other cleanup candidates without deleting them.

## Results

Deleted local `codex/pre-push-v4.11.0-backup` at `eb885fd`. No same-named branch existed on origin, so no remote delete was needed. Its three unique commits changed only `plans/2026-10-03-claim-updates-merge.md`, whose updated content is already on `v4.11.0`.

Other review candidates (left untouched):

- `scaling-updates` exists locally and on origin; PR #323 is merged, and the remote ref is already an ancestor of `v4.11.0`.
- `codex/map-hover-artefacts` exists locally and on origin; PR #325 is merged. The branch ref is not an ancestor of `v4.11.0`, consistent with a squash-style integration, so verify its residual diff before deleting.
- `scrolling-update` and `map-view-learned-skill-borders` are local-only with deleted upstreams; PRs #313 and #310 respectively are merged, but both local branch tips retain large diffs against `v4.11.0`. Keep until the residual changes are reviewed.
- `class_indicator` exists only on origin and has no open PR in the current PR list; purpose is unknown. `milestone-management-research` is local-only research, and the two `archive/*` branches are explicit archives. No action taken on these refs.

The plan commit is the only unpublished commit on `v4.11.0`; push it so the local release checkout remains aligned with origin.
