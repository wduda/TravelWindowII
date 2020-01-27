Travel Plugin
This plugin creates a single window that contains all the available travel skills, including the race, class and reputation skills.

Install
To install, unzip the downloaded file into the C:\Users\{username}\Documents\The Lord of the Rings Online\Plugins folder.

This plugin also requires the Turbine utilities file that is available at: 

http://content.turbine.com/sites/lotro/lua/Beta_LuaPlugins.7z

The folders will look similiar to the folder layout screenshot.

NOTE: You can safely merge the DhorPlugins folder with an existing folder if you have one of my other plugins installed. It will not break anything.

Start
To start the plugin, type /plugins load Travel.
To show or hide the window, you can type /travel toggle (or /trav toggle)

The Menu
You can right-click almost anywhere on the window to open the context menu for selecting which mode and to filter what type of skills you want to show. You can also open the window for adding your own map home.

General
At the top of the window is a display of how many travel rations you currently have in your inventory.

At the bottom right corner is a slightly lighter box. This is the area where you can grab to resize the window. If we get access to change the mouse cursor, I will remove the box.

There is also an option for a button to use to toggle the window. This button can be moved by holding down the mouse button for a few moments. Once the icon turns blue, the button can be moved.

Modes

Text List - All the travel skills are listed as text. Click on one to activate the skill.

Icon Grid - Display all the skills displayed as icons in a grid, much like inventory bags.

Carousel - Use your mouse wheel to scroll through your skills. Only the middle icon will actually work.

Pulldown List - All the skills are in a dropdown list. Open the list, select the locations, then click on the icon to go. You can now also set the option to automatically start the travel as soon as you select a location.

Moors Map - If you are playing Creep, you can right click on the button and select 'Open Moor Map' to show a map of the moors and the approximate location for each creep travel skill. Each location is a clickable shortcut.

Map Home
Click on the Add Map selection in the menu. This opens a window with a quickslot and a button. 

If you drag your map from your inventory to this quickslot, then press the button, your map home will be saved.

This works for maps to Glan Vraig.

10.9 Changes
- fixed more travel skill code errors
- added skills to Rhovanion map
- added button to option panel and context menu to list untrained travel skills
- removed automatic not trained messages

10.8 Changes
- fixed more travel skill code errors
- fixed issue causing shortcut on pulldown mode to disappear
- all modes should now hide the window when a destination is selected

10.6 & 10.7 Changes
- bug fixes

10.5 Changes
- plugin now detects what skills you have trained (but needs to be improved)
- added new skills

10.3 Changes
- window should appear on top
- added option to hide window when a travel skill is selected

10.1 Changes
- added Eriador and Rhovanion maps, right click and select from the context menu to open them

9.10 Changes
- restored normal Glan Vraig map loading since Turbine Manager appears to be working proplerly now.

9.9 Changes
- added Stangard travel skills (hunter, warden and rep)

9.8 Changes
- added Galtrev Reputation travel skill


Future things.....
Still hope to one day get access to the skills the characters have learned.
The sorting is very basic at the moment, I am thinking different methods of sorting that I might implement.

The Button
I don't really like the icon I have for the button. But, I am not an artist, so for me to make something original is difficult. If anyone out there would like to contribute a tiny bit, and can come up with a 32x32 graphic to use, I would greatly appreciate it. However, I do have a couple of important 'rules' about the icon. It cannot be something taken from the game already, such as an existing button/skill icon. Also, it somehow needs to be related to travel....

Credits
I would like to thank some folks for ideas and help:
Orendar - For a solution to the dropdown list
Frell - For some initial modifications to the dropdown, and ideas for selecting skills
Paulino - For the carousel idea
Rushl - For the request to add a button to toggle the window.
magill - For the folder layout description.
