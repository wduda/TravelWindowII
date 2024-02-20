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

How do I use the Carousel mode?
[LIST]
Use the mousewheel while hovering over the travel skill icon to change the selected skill.
[/LIST]

Version history:
v2.0.0
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

Huge kudos to @whiterabbit963 for making this release possible!

Rest of changelog found [URL="https://github.com/wduda/TravelWindowII/blob/master/CHANGELOG.md"]here[/URL].