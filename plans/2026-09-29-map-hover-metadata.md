# Map View artefact fix release metadata

## Scope and branch

- Branch: `codex/map-hover-artefacts`, the implementation branch for PR #325.
- Record the accepted Map View edge artefact fix and restored configurable learned/unlearned borders in all six release metadata files required by `AGENTS.md`.
- Keep the existing `v4.11.0` version values and release surfaces consistent. Do not claim scaling is fully validated.
- Stage the six metadata files without committing their changes, as required by `AGENTS.md`.

## Plan

1. Read current `v4.11.0` release metadata and preserve the established ordering and file formats.
2. Add the same concise `fix:` entry to `CHANGELOG.md`, `src/ChangelogData.lua`, `TravelWindowII.plugin`, `TravelWindowII.plugincompendium`, `doc/lotroforums.txt`, and `doc/lotrointerface.txt`.
3. Commit this plan before editing release metadata.
4. Check that all six surfaces describe the same accepted behavior, validate XML/Lua syntax where available, inspect the diff, and stage those six files only.

## Planned entry

`fix: Map View skill borders remain visible while scaled Quickslots stay free of colored edge artefacts`

## Results

Plan committed before metadata changes. Added the same `fix:` entry to all six
required release metadata files. Version values remain unchanged. Both XML
manifests parse successfully, the shared entry is present across all six
surfaces, and `git diff --check` passes. The six metadata files are staged
without a commit; the pre-existing `AGENTS.md` edit is untouched and unstaged.
