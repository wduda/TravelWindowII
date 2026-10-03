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

In progress. The backup branch exists locally at `eb885fd`; no same-named ref appears in the current origin heads. Its three unique commits change only `plans/2026-10-03-claim-updates-merge.md`, whose content is already on `v4.11.0`.
