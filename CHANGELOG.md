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