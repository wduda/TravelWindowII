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

- `origin/scaling-updates` was deleted at the user's request; its former tip `b0a82dc` was already contained in `v4.11.0`. The local `scaling-updates` ref remains for review.
- `codex/map-hover-artefacts` was deleted locally by user request. Its stale remote-tracking ref was pruned; the live origin has no matching branch. PR #325's fix is included on `v4.11.0`.
- `scrolling-update` and `map-view-learned-skill-borders` were local-only with deleted upstreams; the user authorized deleting these local refs in the follow-up above.
- `class_indicator` exists only on origin and has no open PR in the current PR list; purpose is unknown. `milestone-management-research` is local-only research, and the two `archive/*` branches are explicit archives. No action taken on these refs.

## Results: stale local branches and stash audit (2026-10-07)

- Deleted local `scrolling-update` (tip `830f5ab`) and `map-view-learned-skill-borders` (tip `435019d`) as requested. No corresponding live origin branches existed.
- The stash list is empty; no stash was changed.
- Pruned stale tracking ref `origin/codex/map-hover-artefacts`; live `origin` has no branch of that name.
- Remaining local branches: `main`, `v4.11.0`, `scaling-updates`, `milestone-management-research`, and the two explicitly named `archive/*` refs. Keep the core, research, and archive branches.
- Remaining origin heads: `main`, `v4.11.0`, `scaling-updates`, and `class_indicator`.
- `origin/scaling-updates` (`b0a82dc`) is already contained in `v4.11.0`. Local `scaling-updates` has two additional commits (`7dbb90d` and `f0ef172`); `f0ef172` adds three lines in `src/TravelMapTab.lua` and is absent from `v4.11.0`. Preserve the local branch pending review of that change. The remote `scaling-updates` ref is a cleanup candidate, but was left in place.
- `class_indicator` is a remote-only branch at `fad1245`; its purpose remains unclear, so leave it untouched.
- Committed this audit update on `v4.11.0` and pushed it to `origin` to keep the release checkout aligned.

## Follow-up: remove scaling-updates remote ref and review local history (2026-10-07)

The user authorized deleting `origin/scaling-updates` and confirmed that future fixes should proceed on `v4.11.0`. Keep the local `scaling-updates` branch while reviewing its commits. Explain the purpose and contents of the two `archive/*` branches, then inspect the local scaling branch's commits and differences against `v4.11.0`. Do not delete the local scaling branch or archives as part of this request.

### Steps

1. Confirm a clean `v4.11.0` checkout and verify `origin/scaling-updates` exists.
2. Commit this plan update before deleting the remote ref.
3. Delete only `origin/scaling-updates` and prune its remote-tracking ref.
4. Inspect archive branch ancestry and the local scaling branch's commits and patch.
5. Record what the archives preserve, the local commits' changes, and any remaining branch cleanup candidates.

### Results

- Deleted remote `origin/scaling-updates` at `b0a82dc`; that remote tip was already included in `v4.11.0`. The local branch was retained.
- `archive/map-borders-before-squash-055b46f` preserves the original multi-commit learned/unlearned map-border work through the final outline-alignment commit `055b46f`, before it was squashed to a single commit for PR #310. It is a local recovery pointer, not an active feature branch.
- `archive/pr310-before-squash-c5586aa` preserves the PR #310 working branch after merging `v4.10.0` and resolving the resulting conflicts, before the squash. It is a separate recovery point for the conflict-resolved tree.
- The two unique commits on local `scaling-updates` are `7dbb90d` and `f0ef172`. `7dbb90d` is an empty preparation commit. `f0ef172` adds explicit `Same, Same, Opposite, Opposite` edge attachments to the map label. Current `v4.11.0` makes the same call through `GetStandardEdges()`, whose helper returns those same four values. The reviewed code change is therefore already represented in `v4.11.0`; keep the local branch until the user decides whether its history should also be discarded.
- The broader local branch diff is mostly its older base and tree, not additional unique implementation beyond those two commits. No source files were changed during this review.
- Pushed this plan update to `origin/v4.11.0` after the review.
