# Milestone picker polish, focused review and disposable storage research

Date: 2026-11-14
Branch: `codex/milestone-learning-debug`, continuing the approved debug iteration and preserving existing uncommitted work.

## Plan

1. Use the first requested subagent to research an explicitly opt-in, disposable Character-scope debug store: isolated key/version, numeric identities, safe load/save states, cleanup/reset during fast iteration and retirement before production. Document the recommendation; do not implement persistence.
2. Use the second requested subagent to make a small picker-only change: retain the label beneath each learned skill, add its true milestone number over the quickslot's bottom-right corner with mouse input passing through, and start the popup vertically centered on the right with safe screen margins. Preserve Classic/Mini styling and existing capture behavior.
3. After that implementation, review only the milestone additions and their existing integration points. Reuse the single existing chat listener, location parser and travel-click hook; remove justified small duplication and fix local issues without a plugin-wide refactor or changing normal quickslot activation.
4. Run Lua 5.1 syntax and targeted offline checks, inspect the final diff, and record what still requires in-game testing.

## Boundaries

- No storage implementation, settings/global-default changes, production views, release metadata or broad refactoring.
- The badge is decorative, not an input interceptor, and its number comes from skill identity rather than display order. Keep ordinary travel shortcuts untouched.
- Native hover/MouseDown alias-dispatch timing remains an unverified in-game experiment; static review cannot establish absence of a client-side cast.
- Commit this plan before runtime edits. Leave implementation and research output uncommitted for review.

## Completed

Both requested subagents delivered their scoped work. The focused [review](milestone-management/2026-11-14-picker-review.md) records the picker change, existing-listener/lookup reuse, redundant membership-set removal and parse-result reuse. [Disposable persistence research](milestone-management/2026-11-14-disposable-debug-storage.md) recommends manual checkpoints in one isolated Character-scope key, with explicit logical cleanup after any in-flight write; physical deletion still needs a client probe. Persistence remains unimplemented.

Lua 5.1 syntax and targeted offline checks pass for all 42 plugin files and the milestone UI/state paths. Native badge readability, mouse pass-through and popup alias-dispatch behavior still need in-game testing.
