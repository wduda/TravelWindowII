# Debug-only learned milestone picker

## Goal

On the clean `main` baseline, add a first, non-persistent milestone feature slice. When a milestone skill is learned while `TravelDebugEnabled` is enabled, show a plugin-styled prompt asking the player to identify the newly set milestone skill. The player chooses from quickslots representing the character's learned milestone skills. On selection, print the selected milestone skill to debug chat and close the prompt.

## Scope

- Use the existing skill-acquired chat signal and learned-skill/shortcut matching to detect a newly learned milestone skill.
- Gate detection, the prompt, and its selection output behind `TravelDebugEnabled`.
- Display the prompt text “Pick newly set milestone skill” and one clickable quickslot per currently learned milestone skill, including gapped skill sets.
- Match the plugin's established window style for the active Classic or Mini setting.
- On click, write an unambiguous debug chat line identifying the selected milestone skill, then close the prompt.
- Keep the slice transient: no saved binding, location capture, tracking record, or other persistence.

## Out of scope

Location detection, map/text-view integration, use-based repair, auto-repair, settings, saved window position, Companion import, and non-debug user-facing behavior.

## Implementation and review steps

1. Verify the branch starts at the current `main` baseline and inspect the existing acquisition chat handler, trained-skill matcher, milestone quickslot definitions, window-style conventions, and unload callback lifecycle.
2. Add the debug-gated milestone-acquisition path and transient picker using existing UI conventions and actual learned milestone shortcuts.
3. Add click behavior that reports the selected shortcut identity to debug chat and closes the window; ensure the prompt is not persisted and cannot trigger while debug mode is off.
4. Review/debug-check the relevant Lua and run repository-appropriate static validation. Record that LOTRO client interaction testing is still required if the runtime is unavailable.

## Acceptance checks

- With debug mode off, learning any skill does not open the picker or emit its diagnostic output.
- With debug mode on, learning a non-milestone skill does not open the picker.
- Learning a milestone skill opens one prompt showing the requested instruction and exactly the milestone skills learned by that character, even when slot numbers have gaps.
- Each displayed quickslot selects its corresponding skill; selection emits one clear debug chat line and closes the prompt.
- The prompt follows the plugin's active Classic/Mini window style and all state disappears when closed or the plugin unloads.
- No persistent data is written or loaded for this feature.
