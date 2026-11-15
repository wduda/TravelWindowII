# Persist milestone research and prototype findings

Date: 2026-11-08
Branch: `milestone-management-research`
Scope: requirements and developer documentation only.

Status: findings consolidated; linked documentation and derived evidence prepared on the research branch. Plugin code and release metadata are unchanged by this task.

## Plan

1. Compare the existing research dossier with the subsequent in-game reports, Companion source review, full marker scan, actual character export, and MoorMap annotation inspection.
2. Add a dated supplement recording new facts, source revisions, concrete fixtures, requirements, hypotheses, and remaining validation work. Preserve the September audit as historical evidence.
3. Persist the latest catalogue and supporting derived evidence beside the supplement so documentation does not depend on temporary research files.
4. Link the supplement from the dossier index, research, specification, questionnaire, and validation notes where older statements need qualification.
5. Review internal links, counts, examples, and the documentation-only diff. Commit these documentation changes on the research branch.

## Boundaries

- Continue the existing research branch in a separate checkout; preserve the uncommitted implementation on `codex/milestone-learning-debug`.
- Do not change plugin Lua/XML, release metadata, runtime persistence, or product scope.
- Record reported runtime acceptance separately from static source findings and unverified hypotheses.
- Keep character-specific Companion import deferred and automatic repair undecided.
- Do not treat a raw marker count as a count of currently bindable destinations, or inferred names as confirmed game destination names.
