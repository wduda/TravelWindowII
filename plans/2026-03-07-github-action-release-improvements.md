# Plan: GitHub Action Release Workflow Improvements

Date: 2026-03-07
Workflow: `.github/workflows/release.yml`
Scope: Analysis and implementation plan only, no workflow changes in this task

## Current State Summary

The workflow manually dispatches a tag input, checks out that ref, zips files, extracts the latest changelog section, and creates a draft GitHub release with the zip attached.

## Findings From Parsing

1. Changelog escaping order is incorrect
- Escaping runs before `CHANGELOG_CONTENT` is actually populated
- Escaping currently has no effect on extracted content

2. Unpinned floating ref for zip action
- `thedoctor0/zip-release@master` is used
- Floating refs are fragile and supply-chain risky

3. Missing explicit job permissions
- Release creation needs `contents: write`
- No explicit permissions block is defined

4. Weak input validation for `workflow_dispatch.inputs.tag`
- No `required: true` on tag input
- No early validation for expected tag format (for example `vX.Y.Z`)

5. Hard-coded shell parsing with several failure modes
- Changelog parsing assumes at least one `## v` heading
- No explicit failure message if heading is missing
- Could fail silently with unexpected changelog structure

## Version Update Targets (verified 2026-03-07)

1. `actions/checkout` from `v4` to `v6`
2. `softprops/action-gh-release` from `v2` to `v2.5.0`
3. `thedoctor0/zip-release` from `master` to `0.7.6`

## Proposed Improvement Plan

1. Harden workflow trigger and permissions
- Mark `tag` input as required
- Add job-level `permissions: contents: write`
- Add an early validation step for tag format

2. Fix changelog extraction reliability
- Extract content before escape operations
- Move newline/percent escaping to run immediately after content extraction
- Add explicit error handling if no changelog heading is found

3. Stabilize and secure action references
- Replace floating `@master` with explicit fixed versions

4. Improve archive reproducibility
- Ensure archive root/path are explicit so output is predictable
- Confirm exclusions are still correct after explicit pathing

5. Add guardrails for release creation
- Fail if archive file is missing before release step
- Optionally set `fail_on_unmatched_files: true` in release action

## Validation Plan (for implementation task)

1. Run workflow manually on a test tag in a fork or test branch
2. Confirm archive name and contents are correct
3. Confirm draft release body matches latest changelog section
4. Confirm failure modes are explicit and actionable

## Notes

- Per `AGENTS.md`, use the `lotro-plugins-development-skill` from `.skills` during implementation work on this repository.
