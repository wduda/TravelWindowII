This plugin creates a single window that contains available travel skills, including race, class, housing, and reputation skills. It is a further development of the "Travel Window" plugin, that has been worked on by multiple authors before.

[B]Since this plugin is a 100% replacement for "Travel Window" you should not have both enabled at the same time. You can keep them both installed though.[/B]

The plugin has four modes of operation - icon grid, text list, pulldown list and carousel. These can be switched from the menu that opens when you right-click the plugin. This menu also gives you access to the options window. 

[SIZE="3"]Installation:[/SIZE]
This is a full plugin and can be installed standalone. Follow the general plugin installation instructions to install Travel Window II or update the install (depends on your OS).
I recommend you install and manage your plugins with the LOTRO Plugin Compendium found at this URL, since it will install plugins cleanly and take care of installing the Turbine utilities for you: [URL="http://www.lotrointerface.com/downloads/info663-LOTROPluginCompendium.html"]LOTRO Plugin Compendium App[/URL]

If you do not use Plugin Compendium, you need to manually install Turbine utilities that are available at:
[URL="http://content.turbine.com/sites/lotro/lua/Beta_LuaPlugins.7z"]http://content.turbine.com/sites/lotro/lua/Beta_LuaPlugins.7z[/URL]
This has to be extracted to your "Documents\The Lord of the Rings Online\Plugins" folder (if you are on Windows) so two folders called Turbine and TurbinePlugins show up there.

[SIZE="3"]FAQ:[/SIZE]
How can I make a newly learned skill show up in Travel Window II?
These three options work:
[LIST]
[*] right-click anywhere on TW II, select "Check untrained skills" from the menu, the skill will show up
[*] open options window, go to Enable tab, click "Check untrained skills" button, the skill will show up
[*] relog the character
[/LIST]

Why does my racial skill show up even though I do not have the racial trait equipped?
[LIST]
[*]Because once the trait is acquired, it is classified as a "learned" skill by LOTRO itself, even though it is greyed out. Travel Window II, unfortunately, has no way of knowing if you have the racial trait equipped and the skill is usable. If you are not using the skill permanently, you can use the Enable/Disable options to hide it like any other skill.
[/LIST]

Why does a reputation or store version of my racial skill show up even though I have not obtained or bought it?
[LIST]
[*]This is because the racial and those store-bought skills have identical names ingame (i.e. "Return to Bree") and the plugin obtains a list of learned skills for your character that includes that particular name at least once. Based on that name alone the plugin cannot know which of the two skills you have obtained, while you can get both through the Racial+Store combo. You can use the Enable/Disable options to hide the skill you do not have that is greyed out.
[/LIST]

How do I use the Carousel mode?
[LIST]
Use the mousewheel while hovering over the travel skill icon to change the selected skill.
[/LIST]

Version history:
v1.0.28alpha
- added support for Mariner Sail skills in EN/DE/FR
- added support for River Hobbits racial travel
- fixed rare bug in hunter skills sorting

Rest of changelog found [URL="https://github.com/wduda/TravelWindowII/blob/master/CHANGELOG.md"]here[/URL].