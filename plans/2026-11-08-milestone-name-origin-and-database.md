# Milestone name origin and named database research

Date: 2026-11-08
Branch: `milestone-management-research`, continuing the approved research checkout.

Status: source trace and named research database prepared; 37 named destinations retained, 314 unknown-name markers omitted. Supporting observations and offline rebuild are persisted; plugin code remains unchanged.

## Objective

Trace the exact milestone destination name from Companion's UI through storage and import to its original data source. Build a research database with the best supported names, identifiers, coordinates and geography; omit milestones whose names or essential position/context are missing. Keep proposed spatial associations distinguishable from authoritative name/position observations.

## Steps

1. Trace the public application, core, import and memory dependencies; verify whether the name originates in static game assets, character runtime state, or a maintained lookup table.
2. Inspect any relevant public source and available research fixtures for an explicit full-world mapping. Record the boundary if a dependency/source is unavailable.
3. Build reproducible named records from supported evidence, with separate marker/anchor coordinates, geographic hierarchy, source revisions, identity provenance and confidence. Do not invent missing names from nearby places.
4. Exclude incomplete destinations from the named database; retain only aggregate exclusion reasons and separate existing raw research inventory.
5. Persist the source trace, database/schema, build method and checks in the research dossier. Commit research/tooling/data only, preserving the uncommitted plugin implementation.

## Constraints

- No plugin Lua/XML or release changes and no outreach.
- Do not read a running game's memory or execute Companion import as part of source analysis.
- Do not label a finite named subset as a complete current-game catalogue.
- Character-specific Companion import remains outside the present plugin implementation.
