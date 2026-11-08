# In-memory milestone-use debug table

## Goal

Add a separate debug window alongside the existing chat diagnostics. It shows the character's learned milestone skills and the destination identified from successful-use chat messages, so multiple skill-to-location observations can be inspected during one plugin session.

## Scope

- Show the window while `TravelDebugEnabled` is on; hide and release it when debug mode turns off or the plugin unloads.
- Match the active Classic/Mini window styling.
- Make picker quickslot clicks select-only: show the skill icons, but intercept the click so choosing a bound skill never activates travel.
- Render a basic table with one row per learned milestone skill, showing the milestone number/name and its latest identified location. Show an empty marker until a successful-use message has been correlated.
- On a correlated successful-use message, update the row for that skill and keep the existing debug chat mapping message.
- Keep observations in a module-local, in-memory table keyed by stable milestone skill ID. Two different milestone skills can retain two different locations simultaneously. A later success for the same skill replaces that row's location.
- Refresh the table when learned milestone skills change and when a successful-use observation arrives.

## Out of scope

Saving or loading observations, binding/location persistence, location correction, production text/map integration, Companion import, and non-debug user-facing behavior.

## Implementation and review steps

1. Continue on `codex/milestone-learning-debug`; preserve the current first-slice changes and the existing 30-second click correlation.
2. Add an in-memory location map and a separate Classic/Mini-styled debug table window.
3. Connect debug-mode on/off and plugin unload lifecycle to show/close the window; refresh it on learned-skill and successful-use updates.
4. Keep the existing chat diagnostic and update the matching row for each parsed successful-use event. Do not persist observations.
5. Run static checks and review two distinct skill/location observations; record that rendering and live chat events still need LOTRO client validation if unavailable.

## Acceptance checks

- Debug mode on shows a separate table with all currently learned milestone skills and an empty location for skills without a successful-use observation.
- A successful-use message updates the correct skill row and still emits the existing chat diagnostic; parsing works whether the chat UI timestamp is present in the event string or not.
- Selecting a skill in the bind picker closes it and logs the selection without activating the milestone skill.
- Two successful-use messages for different milestone skills retain two distinct locations at the same time.
- A later message for the same milestone skill replaces only that skill's location.
- Debug mode off and plugin unload close the window; observations are lost on plugin reload.
- No milestone locations are loaded from or written to plugin persistence.
