# CHANGELOG

## v4.0.0

- MAJOR: introducing a brand new view mode called Map Mode, check it out by right-clicking the TW II window, select MODE and then MAP VIEW
- enhance: adding new notification window notifying of changes in installed update
- enhance: adding some region labels to U46 skill data for EN/DE/FR/RU
- enhance: vendor and skillname updates from U46.0.1 for FR

## v3.2.0

- enhance: window positioning is happening now relative to screen rather than absolute - positioning will work now much better if screen resolutions changes
- enhance: add new skills from U46 in EN/DE/FR
- enhance: add skills from U45.X in RU
- enhance: adjust Annak-Khurfu map location
- fix: updated to support skills renamed in U45.X in EN/DE/FR/RU

## v3.1.0

- enhance: the skill type is now an optional part of the skill label and can be turned off  - affects text list and tab pulldown view only
- enhance: the text list view now does not force line breaks forcing inconsistent line height
- enhance: the pulldown tab view can now be resized horizontally
- fix: map window is again loading for creep characters
- fix: the reputation requirement for King's Gondor version of Dol Amroth is correctly shown as friend
- fix: the Find tab now shows updated lower levels for Hunter skills learned earlier after rework
- fix: all skills for travel to King's Gondor version of Dol Amroth will be recognized again in all languages official languagaes

## v3.0.0

- enhance: the Find tab in options now has information on all obtainable skills and their sources
- enhance: the Find tab in options now has full support for all four supported langauges
- enhance: the Find tab in options now has better formatting of source entries
- enhance: added new travel skills from U44 in EN/DE/FR
- enhance: mini window can now be scaled down to width of one skill
- fix: Mariner skill for Lothlorien now has proper duplicate detection

## v2.6.0

- enhance: added new travel skills from U43 in EN/DE/FR
- enhance: adding labels for eight more barter currencies for skill source tab

## v2.5.1

- enhance: added Ikorbani faction, adding rep level required for U42 skills
- enhance: adding some tokennames to DE and FR to start filling the acquisition tab
- enhance: open pull-down list upwards/downwards based on screen check so it does not go off screen
- fix: wrong label for Guide to Jirush

## v2.5.0

- enhance: U42 travel skills added for EN/FR/DE for all classes, with map coords, overlap settings and aquisition source
- enhance: removed no longer needed buttons and options menu for "Check Trained Skills" as TW II now reliably autodetects skill acquisition
- fix: Dol Amroth and Halrax now have correct coordinates on Haradwaith map for guide/muster/sail skills
- fix: Bej Magha skills will now be detected again after being renamed by SSG in U42

## v2.4.4

- enhance: UI texts in RU - skill acquisition data tab should now be complete

## v2.4.3

- enhance: minor enhancements to skill acquisition data for Find Skills tab in EN (skill acquisition data data should now be complete)
- enhance: updated most UI texts in DE (skill acquisition data still not fully supported)
- enhance: updated most UI texts in RU (skill acquisition data should now be complete)

## v2.4.2

- enhance: plugin will be more resilient against mistakes by authors when adding new text for labels
- enhance: added many new text labels for RU client support (RU support is still unfinished and in beta status)
- enhance: skill info labels on learnable skills tab will be more readable (tab is fully functional in EN only, beta in DE/FR/RU)
- fix: new skill acquisition detection will now work in RU client
- fix: Ledger-Keepers in DE client now have a German label
- fix: multiple fixes to currency names and minor typos

## v2.4.1

- fix: plugin will no longer fail to load in DE and FR client

## v2.4.0

- add: newly learned skills will be detected automatically and become visible and usable in TW II
- add: new option to use skill name as label instead of location name
- add: incorporated RU translations by Svertalf
- add: new options tab with list of still learnable travel skills
- add: acquisition method for skills on still learnable skills tab (beta, EN only)
- enhance: checkboxes in options now have better labels so checkbox marked means "turned on"
- enhance: minor improvements to main window, mostly fixing scaling issues

## v2.3.1

- add: option to turn off zone names in labels
- fix: icons on maps sometimes not turning on/off properly

## v2.3.0

- add: grid tab sorting through drag & drop
- add: all travel skill labels now also have data for the zone (i.e. "Michel Delving" is in zone "Shire")
- add: enabled list now has labelled sections
- add: options window position can be locked now
- add: toggle button position can be locked now
- add: Bej Maghda travel skill and map location in EN/DE/FR client
- enhance: code cleanup in multiple methods under the hood
- fix: rare case for window width snapping that was adding extra padding
- fix: scroll height calculation for scroll bar
- fix: ambiguity in Beorning racial skill in EN/DE/FR client
- fix: Mariner Tharbad skill name & label in FR client

## v2.2.0

- add: sorting alphabetically by skill label
- add: sorting by zone level
- add: move skill in sort list up/down by 10 slots
- enhance: saving globals properly remembers hunter/mariner/warden skills for those classes
- enhance: smooth out grid resize snapping around a column midpoint
- enhance: remove dependency on Turbine utils, these can be removed if you do not need them for other plugins
- enhance: significantly improved skill data storage in codebase to prevent human mistakes when creating new releases
- fix: saving and loading globals will save properly every time and not mess up sort order
- fix: plugin will load again for creep characters
- fix: updated creep travel skills in EN/DE/FR

## v2.1.0

- add: default and alphabetic ordering buttons in sorting tab (note: sort by name sorts by ingame name, not by TW II label)
- add: a fade out delay and option slider to control duration of that delay
- enhance: mini and legacy windows having the same minimum size
- enhance: resize hitbox now has highlight on hover
- enhance: increased size for mini-window resize hitbox
- enhance: overlapping skills button no longer turns off Lalia's market
- enhance: enable/disable overlapping skills buttons only show up if character has overlapping skills
- enhance: updated labels for King's Gondor Dol Amroth in EN/DE/FR
- enhance: download size of plugin reduced from 2MB+ to 200kb
- fix: last entry in text list being not visible in legacy window
- fix: made row snapping much smoother
- fix: multiple small resizing issues

## v2.0.0

- adds a mini window option offering an alternative interface with minimal window size
- adds skills snapping for cleaner resizing of main and mini windows
- adds slider to control speed of fadeout to min opacity
- adds the ability to save a global preset so main options can be transferred to alts
- adds option to control whether Esc closes main Travel window
- adds enable/disable all buttons in enable options tab
- adds enable/disable button for overlapping class/reputation skills in enable options tab
- sets default sort so racial & class skills come after general skills to get closer to level progression sorting
- fixes Travel Window opening behind chat and Travel Button
- fixes missing Return to Dol Amroth (Western Gondor) in DE client
- significant code cleanup under the hood for more reliable and maintainable code

## v1.4.0

- reintroduces a rewritten Map Window feature - thanks to @whiterabbit963
- toggle button will no longer be out of bounds after reducing client resolution - thanks to @whiterabbit963
- fixes error message on check untrained skills in options - thanks to @whiterabbit963
- fixes Muster in Dale skill in DE client properly this time - thanks to @whiterabbit963

## v1.3.0

- fixed Warden Muster to Dale in DE client
- fixed Bloody Eagle Tavern skill in DE client
- fixed more sorting issues for Hunter, Warden and DE/FR clients caused by duplicate skillnames - thanks to @whiterabbit963
- options window now hides on pressing Esc or UI toggle button - thanks to @whiterabbit963
- spacing around borders of window reduced to look nicer when resizing into a small window - thanks to @whiterabbit963
- improved layout and resizing for pulldown tab - thanks to @whiterabbit963
- more consistent and performant setting of window opacity and options window opacity - thanks to @whiterabbit963
- vast amounts of code quality improvements that should result in stability, faster loading and no stutters when resizing TW II - thanks to @whiterabbit963

## v1.2.0

- fixed U38 allegiance travel skills in EN/FR/DE client
- added new U38.1.1 skill in EN/FR/DE client
- fixed duplicate skillnames causing all kinds of sorting issues - thanks to @whiterabbit963
- minor performance improvement - thanks to @whiterabbit963

## v1.1.0

- fixed two U38 reputation travel skills in EN client
- added U38 Mariner skills in FR client
- added U38 Mariner skills in DE client
- cleaned up duplicate Mariner skills in EN/DE/FR files
- fixed Swanfleet label in DE client
- fixed River-Hobbit racial in DE client
- fixed Mariner skills in DE client
- fixed all Mariner skills not showing up in Enabled and Sort options tabs
- fixed newly learned Mariner skills not being found when checking trained skills

## v1.0.29alpha

- fixed Mariner skills showing up twice in DE client
- adding U38 skills in EN/FR

## v1.0.28alpha

- added support for Mariner Sail skills in EN/DE/FR
- added support for River Hobbits racial travel
- fixed rare bug in hunter skills sorting

## v1.0.27

- fixed typo in init.lua causing crash on load

## v1.0.26

- added support for U36 skills (Pelargir in King's Gondor) in EN/DE/FR

## v1.0.25beta

- fixed typo in Carn Dum skills introduced in v1.0.24beta
- added Glan Vraig skill in EN/DE/FR
- fixed some DE/FR skill labels to better reflect the source of the skill

## v1.0.24beta

- added Clegur skills from U35 in EN/DE/FR
- added Carn Dum skills from U35 in EN/DE/FR
- fixed some DE/FR skills that had their names changed

## v1.0.23beta

- saving options is now reliably done on every logout

## v1.0.22beta

- fixed bug with duplicate skillID affecting hunters trying to sort their travel skills
- fixed TWII button not saving position when being moved
- fixed error message when resetting skills to default

## v1.0.21beta

- added U34 skills for EN/DE/FR
- fixed two Muster skills in DE
- PluginManager button for options no longer opens a second copy of options window
- Maps open again but are still buggy in terms of showing travel locations
- error message when using dropdown view should no longer show up

## v1.0.20beta

- added Yondershire port
- worked around plugin manager causing client crash; replaced the manager options with a button opening the actual options window

## v1.0.19beta

- added new option to close Travel Window when using a travel skill regardless of window mode
- updated behaviour of Travel Window when using function key and escape to hide the UI, should now handle all cases correctly
- added Tornhad travel skills
- fixed many French Warden skills that were renamed by SSG

## v1.0.18beta

- fixed changed Gundabad translations for FR

## v1.0.17beta

- added 7 new skills for U31

## v1.0.16beta

- added 7 new skills for U31

## v1.0.15beta

- made the icon grid the default view on new characters
- fixed bug causing window size not being saved on logout
- cleaned code from references to Map Home item that existed before Milestone skills

## v1.0.14beta

- added new travel skills for U30 in EN, DE, FR

## v1.0.13beta

- fixed plugin crash for Wardens with travel to Trestlebridge learned (bugfix)

## v1.0.12beta

- fixed unloadable settings for 64bit DE and FR clients (bugfix)
- fixed label of Hultvis hunter guide in FR client (enhancement)

## v1.0.11hotfix2

- fixing plugincompendium version data

## v1.0.11hotfix1

- fixed one French U29 skill - thanks homeopatix for the bug report

## v1.0.11beta

- full U29 travel skills support for DE and FR (enhancement)

## v1.0.10beta

- U29 travel skills support for EN (enhancement)
- attempted U29 travel skills support for DE and FR - no translations for skills were available on Bullroarer (enhancement)
- checking for untrained skills both through options button and menu item will now add newly learned skills immediately (enhancement)
- fixed bug in textlist mode where only last skill was highlighted on mouseover (bugfix)
- fixed bug that caused skill enabled list and skill order to reset after SSG releases an update (bugfix)
- automated github builds to create github releases for easy access to finished zip (internal)
- cleaned up a lot of global/local internal variables and names (internal)

## v1.0.9beta

- fixed bug where pressing Esc did not close the options window (bugfix)
- fixed bug where changing options was lagging the client, especially on changing opacity sliders (bugfix)
- automated github builds for faster releases (internal)
- cleaned up settings stored by plugin to remove unused data (internal)
- cleaned up some code for better readability (internal)

## v1.0.8beta

- made it so the plugin can attempt to import all settings from v1.06beta or earlier if new settings file is not present, so an import can be forced by deleting TravelWindowII.plugindata - see FAQ
- fixed German travel to Dale

## v1.0.7beta

- changed enabled/disabled function to identify skills by ID - fixes problems with skills sharing names, like racial/rep, map home/Beorning racial (bugfix) closes #25 #17
- changed sorting identify skills by ID - sorting will now work and save its settings properly (bugfix) closes #15
- fixed wrong order of milestone skills (bugfix) closes #9
- made it so Travel Window II has its own config file - settings will reset once! (enhancement)
- verified all 151 skills in English client, fixed 7 broken skills, with some fixed by Drono
- verified all 151 skills in the German client, fixed 41 broken skills
- verified all 151 skills in the German client, fixed 74 (!) broken skills, with some help from Adra
- updated English localization (enhancement)
- updated French localization thanks to Adra (enhancement)
- updated German localization (enhancement)
- reduced code duplication in indexedDictionaries so future development will become easier (internal)

## v1.0.6beta

- Plugin Compendium will now install Turbine libraries if they are not installed yet when you install Travel Window (enhancement)
- changed Shire and Rivendell skill labels to be closer to user expectations (they are now Shire (Store), Shire (Racial), Rivendell (Store)) (bugfix)
- fixed Premium house skill in German client (bugfix)
- fixed about 30 skills in German client that were not working before (bugfix)

## v1.0.5beta

- removed references to setting the glan vraig map and the obsolete map home for now (GUI improvement)
- cleaned up internal naming of variables to better differentiate skill names and skill labels used by plugin (internal)
- made pulldownlist, enable options and sort options use labels instead of skill names (GUI improvement)
- changed sort list box to use the full option window size better (GUI improvement)
- redid all English skill labels and hopefully fixed all English skill names so skills should work (bugfix/improvement)
- fixed some German skill names, most of these are still broken (bugfix)
- added temporary labels for French Return Home skills (improvement)
- dropped support for Russian translation since that is obsolete (internal)
- removed unobtainable Return Home 12 skill (bugfix)
- introduced support for Travel To Kinship members home skill (improvement)
- made plugin run in own memory compartment for more stability (internal)
- reintroduced Warden class enum (internal)
- improved check for unlearned skills to include Return Home skills (improvement)
- cleaned up the handling of character race so only one racial skill shows up in options and code is cleaner (bugfix/internal)
- replaced some deprecated methods

## v1.0.3beta

- fixed Plugin Compendium confusing TravelWindow and TravelWindowII

## v1.0.2beta

- included French client fixes from Adra
- some internal code cleanup

## v1.0.1beta

- added racial skills to sort options while not functioning yet
- created lotrocompendium capability

## v1.0beta

- based off of v28.2 last worked on by Thaliruth
- fixed Eriador/Rhovannion/Eriador maps with overlays
- fixed High Elf racial travel skill that was broken since U28.2
- cleaned up a few English and German translations
- started reorganizing code
