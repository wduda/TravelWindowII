# Remove pre-push backup branch and audit stale refs

## Follow-up: remove merged Map View artefact branch (2026-10-07)

The user authorized deleting `codex/map-hover-artefacts` locally and on `origin`. PR #325 is merged into `v4.11.0`; the branch's separate commit history is from the rebase merge, not evidence that the fix is missing. Execute from `v4.11.0`, preserve this plan update in Git before deleting the local ref, and remove the remote ref if it still exists. Keep all other branch refs unchanged.

### Steps

1. Confirm the `v4.11.0` checkout is clean and the branch ref points to the reviewed Map View history.
2. Record and commit this plan update.
3. Delete local `codex/map-hover-artefacts`.
4. Delete the matching `origin` ref if it exists and authentication permits.
5. Verify local and remote refs are absent and report any blocked operation.

## Follow-up: remove stale local-only branches and inspect stashes (2026-10-07)

The user authorized deleting local `scrolling-update` and `map-view-learned-skill-borders`. Both have deleted upstreams, and their related PRs (#313 and #310) were previously reported merged; their branch trees nevertheless differ substantially from `v4.11.0`. This removes the named local branch refs only. Check current refs and stashes, record this plan before deleting, then audit remaining branches and report any unique history or other cleanup candidates. Do not drop stashes or delete other refs.

### Steps

1. Confirm clean `v4.11.0`; inspect both branches against it and list stashes.
2. Commit this plan update before deleting the two named local refs.
3. Delete only local `scrolling-update` and `map-view-learned-skill-borders`.
4. Audit local branches, remote heads, stale tracking refs, and stashes.
5. Record results and keep `v4.11.0` aligned with origin.

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
- `codex/map-hover-artefacts` existed locally and on origin; PR #325 is merged. Its commits have different IDs from the rebase-merged commits on `v4.11.0`; the fix is included. The user later authorized deletion; see the follow-up above.
- `scrolling-update` and `map-view-learned-skill-borders` were local-only with deleted upstreams; the user authorized deleting these local refs in the follow-up above.
- `class_indicator` exists only on origin and has no open PR in the current PR list; purpose is unknown. `milestone-management-research` is local-only research, and the two `archive/*` branches are explicit archives. No action taken on these refs.

The plan commit is the only unpublished commit on `v4.11.0`; push it so the local release checkout remains aligned with origin.
