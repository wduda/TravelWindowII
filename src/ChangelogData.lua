-- Changelog data structure for update notifications
-- Versions are ordered newest first
-- Each entry: {version = "v3.x.x", changes = {"line1", "line2", ...}}

ChangelogData = {
    {
        version = "v4.1.2",
        changes = {
            "major: V4 introduced a map mode view, turn it on through right-click menu or in options",
            "enhance: min window opacity no longer affects map view",
            "fix: hovering on skills in map view no longer changes the map opacity",
        }
    },
    {
        version = "v4.1.1",
        changes = {
            "fix: update mode radio in settings windows when changed from settings menu",
            "fix: make spacing between mode options and other options consistent",
        }
    },
    {
        version = "v4.1.0",
        changes = {
            "major: V4 introduced a map mode view, turn it on through right-click menu or in options",
            "enhance: to make the new map mode easier to find, mode selection has been added to the options window",
            "enhance: Map View will now store its last position and size separately from other window modes",
            "enhance: navigation panel at the bottom of Map View now has the right-click menu",
            "enhance: adding default for Mûr Ghala Sârz in RU client",
            "fix: some racial travel skills were missing from Map View, they are now back in this view",
            "enhance: updated settings handling under the hood to be more robust",
        }
    },
    {
        version = "v4.0.0",
        changes = {
            "major: introducing a brand new view mode called Map Mode",
            "major: check it out by right-clicking the TW II window, select MODE and then MAP VIEW",
            "enhance: adding new notification window notifying of changes in installed update",
            "enhance: adding some region labels to U46 skill data for EN/DE/FR/RU",
            "enhance: vendor and skillname updates from U46.0.1 for FR"
        }
    },
    {
        version = "v3.2.0",
        changes = {
            "enhance: window positioning is happening now relative to screen rather than absolute - positioning will work now much better if screen resolutions changes",
            "enhance: add new skills from U46 in EN/DE/FR",
            "enhance: add skills from U45.X in RU",
            "enhance: adjust Annak-Khurfu map location",
            "fix: updated to support skills renamed in U45.X in EN/DE/FR/RU"
        }
    },
    {
        version = "v3.1.0",
        changes = {
            "enhance: the skill type is now an optional part of the skill label and can be turned off  - affects text list and tab pulldown view only",
            "enhance: the text list view now does not force line breaks forcing inconsistent line height",
            "enhance: the pulldown tab view can now be resized horizontally",
            "fix: map window is again loading for creep characters",
            "fix: the reputation requirement for King's Gondor version of Dol Amroth is correctly shown as friend",
            "fix: the Find tab now shows updated lower levels for Hunter skills learned earlier after rework",
            "fix: all skills for travel to King's Gondor version of Dol Amroth will be recognized again in all languages official languagaes"
        }
    },
    {
        version = "v3.0.0",
        changes = {
            "enhance: the Find tab in options now has information on all obtainable skills and their sources",
            "enhance: the Find tab in options now has full support for all four supported langauges",
            "enhance: the Find tab in options now has better formatting of source entries",
            "enhance: added new travel skills from U44 in EN/DE/FR",
            "enhance: mini window can now be scaled down to width of one skill",
            "fix: Mariner skill for Lothlorien now has proper duplicate detection"
        }
    },
    {
        version = "v2.6.0",
        changes = {
            "enhance: added new travel skills from U43 in EN/DE/FR",
            "enhance: adding labels for eight more barter currencies for skill source tab"
        }
    },
    {
        version = "v2.5.1",
        changes = {
            "enhance: added Ikorbani faction, adding rep level required for U42 skills",
            "enhance: adding some tokennames to DE and FR to start filling the acquisition tab",
            "enhance: open pull-down list upwards/downwards based on screen check so it does not go off screen",
            "fix: wrong label for Guide to Jirush"
        }
    },
    {
        version = "v2.5.0",
        changes = {
            "enhance: U42 travel skills added for EN/FR/DE for all classes, with map coords, overlap settings and aquisition source",
            "enhance: removed no longer needed buttons and options menu for \"Check Trained Skills\" as TW II now reliably autodetects skill acquisition",
            "fix: Dol Amroth and Halrax now have correct coordinates on Haradwaith map for guide/muster/sail skills",
            "fix: Bej Magha skills will now be detected again after being renamed by SSG in U42"
        }
    },
    {
        version = "v2.4.4",
        changes = {
            "enhance: UI texts in RU - skill acquisition data tab should now be complete"
        }
    },
    {
        version = "v2.4.3",
        changes = {
            "enhance: minor enhancements to skill acquisition data for Find Skills tab in EN (skill acquisition data data should now be complete)",
            "enhance: updated most UI texts in DE (skill acquisition data still not fully supported)",
            "enhance: updated most UI texts in RU (skill acquisition data should now be complete)"
        }
    },
    {
        version = "v2.4.2",
        changes = {
            "enhance: plugin will be more resilient against mistakes by authors when adding new text for labels",
            "enhance: added many new text labels for RU client support (RU support is still unfinished and in beta status)",
            "enhance: skill info labels on learnable skills tab will be more readable (tab is fully functional in EN only, beta in DE/FR/RU)",
            "fix: new skill acquisition detection will now work in RU client",
            "fix: Ledger-Keepers in DE client now have a German label",
            "fix: multiple fixes to currency names and minor typos"
        }
    },
    {
        version = "v2.4.1",
        changes = {
            "fix: plugin will no longer fail to load in DE and FR client"
        }
    },
    {
        version = "v2.4.0",
        changes = {
            "add: newly learned skills will be detected automatically and become visible and usable in TW II",
            "add: new option to use skill name as label instead of location name",
            "add: incorporated RU translations by Svertalf",
            "add: new options tab with list of still learnable travel skills",
            "add: acquisition method for skills on still learnable skills tab (beta, EN only)",
            "enhance: checkboxes in options now have better labels so checkbox marked means \"turned on\"",
            "enhance: minor improvements to main window, mostly fixing scaling issues"
        }
    },
    {
        version = "v2.3.1",
        changes = {
            "add: option to turn off zone names in labels",
            "fix: icons on maps sometimes not turning on/off properly"
        }
    },
    {
        version = "v2.3.0",
        changes = {
            "add: grid tab sorting through drag & drop",
            "add: all travel skill labels now also have data for the zone (i.e. \"Michel Delving\" is in zone \"Shire\")",
            "add: enabled list now has labelled sections",
            "add: options window position can be locked now",
            "add: toggle button position can be locked now",
            "add: Bej Maghda travel skill and map location in EN/DE/FR client",
            "enhance: code cleanup in multiple methods under the hood",
            "fix: rare case for window width snapping that was adding extra padding",
            "fix: scroll height calculation for scroll bar",
            "fix: ambiguity in Beorning racial skill in EN/DE/FR client",
            "fix: Mariner Tharbad skill name & label in FR client"
        }
    },
    {
        version = "v2.2.0",
        changes = {
            "add: sorting alphabetically by skill label",
            "add: sorting by zone level",
            "add: move skill in sort list up/down by 10 slots",
            "enhance: saving globals properly remembers hunter/mariner/warden skills for those classes",
            "enhance: smooth out grid resize snapping around a column midpoint",
            "enhance: remove dependency on Turbine utils, these can be removed if you do not need them for other plugins",
            "enhance: significantly improved skill data storage in codebase to prevent human mistakes when creating new releases",
            "fix: saving and loading globals will save properly every time and not mess up sort order",
            "fix: plugin will load again for creep characters",
            "fix: updated creep travel skills in EN/DE/FR"
        }
    },
    {
        version = "v2.1.0",
        changes = {
            "add: default and alphabetic ordering buttons in sorting tab (note: sort by name sorts by ingame name, not by TW II label)",
            "add: a fade out delay and option slider to control duration of that delay",
            "enhance: mini and legacy windows having the same minimum size",
            "enhance: resize hitbox now has highlight on hover",
            "enhance: increased size for mini-window resize hitbox",
            "enhance: overlapping skills button no longer turns off Lalia's market",
            "enhance: enable/disable overlapping skills buttons only show up if character has overlapping skills",
            "enhance: updated labels for King's Gondor Dol Amroth in EN/DE/FR",
            "enhance: download size of plugin reduced from 2MB+ to 200kb",
            "fix: last entry in text list being not visible in legacy window",
            "fix: made row snapping much smoother",
            "fix: multiple small resizing issues"
        }
    },
    {
        version = "v2.0.0",
        changes = {
            "adds a mini window option offering an alternative interface with minimal window size",
            "adds skills snapping for cleaner resizing of main and mini windows",
            "adds slider to control speed of fadeout to min opacity",
            "adds the ability to save a global preset so main options can be transferred to alts",
            "adds option to control whether Esc closes main Travel window",
            "adds enable/disable all buttons in enable options tab",
            "adds enable/disable button for overlapping class/reputation skills in enable options tab",
            "sets default sort so racial & class skills come after general skills to get closer to level progression sorting",
            "fixes Travel Window opening behind chat and Travel Button",
            "fixes missing Return to Dol Amroth (Western Gondor) in DE client",
            "significant code cleanup under the hood for more reliable and maintainable code"
        }
    },
}
