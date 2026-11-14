# Milestone predicted name, picker result and reopening

Date: 2026-11-14
Branch: `codex/milestone-learning-debug`, continuing the authorized debug iteration and preserving uncommitted work.

## Plan

1. Add an English predicted travel-skill label to the existing closest-marker result: `Return to <name> (<territory>)`. Keep name evidence/uncertainty visible and do not invent a native name for unnamed or conflicting wiki entries. Manual LOC and picker capture must use the same formatter/text field.
2. Add an ordinary `Open picker` button beside the manual LOC controls, using the plugin's standard Button.Click pattern and existing picker-opening function.
3. Address the reported picker remaining open with an Alias: if the first press only selects/switches the control, a second press on the same control must reuse the existing Alias/token instead of replacing it again. Keep the pending Alias available for that retry and display a short instruction. Successful command delivery still updates the shared result and closes on a later Update; canceled/expired released selections restore the skill safely.
4. Run targeted Lua 5.1 checks for the predicted Hobbiton label, shared result updates, stable retry, reopen behavior and prior travel reconciliation. Record the stakeholder's hover/badge/Alias observations separately from unverified native dispatch.

No persistence, numeric-ID changes, normal-view modifications, new chat listener or production integration. Leave implementation uncommitted for review. This trial may require two physical clicks in the current client; offline validation cannot establish native first-click dispatch.
