# Debug-only milestone bind and use diagnostics

## Goal

On the clean `main` baseline, add a first, non-persistent milestone feature slice. When the game confirms that a location was bound to a milestone skill and `TravelDebugEnabled` is enabled, show a plugin-styled prompt asking the player to identify which learned milestone skill was set. On selection, print the chosen slot to debug chat and close the prompt. Later, when the player uses a milestone quickslot in TWII and the successful-use chat message arrives, parse its destination and print a transient skill-to-location mapping for diagnosis.

## Scope

- Use the bind-confirmation chat signal (“This location is now bound to your milestone skill.”), not the skill-acquired message, to trigger the picker.
- Gate bind detection, the picker, quickslot-use correlation, destination parsing, and diagnostic output behind `TravelDebugEnabled`.
- Display the prompt text “Pick newly set milestone skill” and one clickable quickslot per currently learned milestone skill, including gapped skill sets.
- Match the plugin's established window style for the active Classic or Mini setting.
- On picker click, write an unambiguous debug chat line identifying the selected milestone skill, then close the prompt.
- Observe clicks on TWII milestone quickslots in its List, Grid, Carousel, Pulldown, and map-tray views. Keep the pending skill identity and timestamp in memory only.
- Parse the successful-use message after travel succeeds, retain the full destination phrase and parenthetical region, correlate it with the recent TWII milestone quickslot click, print a line such as “Milestone 3 is mapped to Ingarûma (The Hatokáli Fells),” and clear the pending click.
- Clear pending correlation when debug mode is turned off or the plugin unloads; ignore successful-use messages without a recent TWII milestone click or without a recognized destination.
- Keep the slice transient: no saved binding, location capture, tracking record, or other persistence.

## Out of scope

Persistent binding/location tracking, map/text-view integration, use-based repair, auto-repair, settings, saved window position, Companion import, and non-debug user-facing behavior. The successful-use parser is limited to the confirmed English message format until localized variants are verified.

## Implementation and review steps

1. Continue on `codex/milestone-learning-debug`; inspect the existing chat handler, click handlers for every TWII quickslot view, learned-skill matcher, milestone IDs, window styling, and unload/debug-toggle lifecycle.
2. Change the picker trigger from the skill-acquired message to the milestone bind-confirmation message and keep its selection diagnostic-only.
3. Add debug-gated temporary correlation for milestone quickslot clicks, parse the confirmed successful-use message into a destination string, and emit a slot-to-destination diagnostic only for a recent TWII click. Do not persist the click or mapping.
4. Review/debug-check the relevant Lua and run repository-appropriate static validation. Record that LOTRO client interaction testing is still required if the runtime is unavailable.

## Acceptance checks

- With debug mode off, bind confirmations and skill-use messages do not open the picker or emit feature diagnostics.
- With debug mode on, the bind-confirmation opens one prompt showing the requested instruction and exactly the milestone skills learned by that character, even when slot numbers have gaps; unrelated skill-acquired messages do not open it.
- Each displayed quickslot selects its corresponding skill; selection emits one clear debug chat line and closes the prompt.
- A recent click on a TWII milestone quickslot followed by a recognized successful-use message emits one mapping line with the correct milestone number and destination; unrelated chat, expired/missing clicks, and unrecognized messages do not produce a mapping.
- Turning debug mode off or unloading clears the prompt and pending correlation.
- The prompt follows the plugin's active Classic/Mini window style and all state disappears when closed or the plugin unloads.
- No persistent data is written or loaded for this feature.
