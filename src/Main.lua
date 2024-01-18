import "TravelWindowII.src";

-- create shortcuts to the bitop functions
bit = TravelWindowII.bit;
hasbit = TravelWindowII.hasbit;
setbit = TravelWindowII.setbit;
clearbit = TravelWindowII.clearbit;
togglebit = TravelWindowII.togglebit;

DefAlpha = 0.92;
Settings = {};
SettingsStrings = {};
TravelShortcuts = {}; -- put all the shortcuts into one table
TrainedSkills = Turbine.Gameplay.SkillList;

-- get the player class and race
player = Turbine.Gameplay.LocalPlayer.GetInstance();
PlayerClass = player:GetClass();
PlayerAlignment = player:GetAlignment();
PlayerRace = player:GetRace();
-- set the racial index used later in multiple places
SetPlayerRaceKey();
-- get the list of trained skills the player has
if (Turbine.Gameplay.LocalPlayer.GetTrainedSkills ~= nil) then
    TrainedSkills = player:GetTrainedSkills();
end

-- load the player saved settings
LoadSettings();

-- create the lists of travel locations and the shortcuts
-- that are used to execute them
TravelInfo = TravelDictionary();

-- set up all the shortcuts
SetShortcuts();

local PluginManagerOptionsPanel = Turbine.UI.Control()
PluginManagerOptionsPanel:SetSize(500, 200)

plugin.GetOptionsPanel = function()
    return PluginManagerOptionsPanel;
end

OptionsWindow = TravelWindowII.src.OptionsWindow();
local OptionsButton = Turbine.UI.Lotro.Button()
OptionsButton:SetParent(PluginManagerOptionsPanel)
OptionsButton:SetPosition(100, 100)
OptionsButton:SetSize(200,15)
OptionsButton:SetText(menuOptionsString)
OptionsButton:SetVisible(true)

OptionsButton.Click = function()
    OptionsWindow:SetVisible(true);
end

-- configure the external toggle button
ToggleButton = TravelWindowII.src.TravelButton();

-- create the travel window
_G.travel = TravelWindow(Settings.useMinWindow);

NewShortcutEvent = function()
    _G.travel.dirty = true; -- reset list of shortcuts
    _G.travel:SetItems(); -- redraw current window
end

MapWindow:VerifyMapSkillIds("Hunter");
MapWindow:VerifyMapSkillIds("Warden");
MapWindow:VerifyMapSkillIds("Mariner");
MapWindow:VerifyMapSkillIds("Reputation");

Plugins["Travel Window II"].Load = function(sender, args)
    Turbine.Shell.WriteLine("<u><rgb=#DAA520>Travel Window II " .. Plugins["Travel Window II"]:GetVersion() ..
                            " by Hyoss</rgb></u>");
end

-- handle unload event and save settings
plugin.Unload = function()
    SaveSettings();
end

-- create a new command line command for the travel window
TravelCommand = Turbine.ShellCommand();

-- handle the travel commands
function TravelCommand:Execute(command, arguments)
    if (arguments == "show") then
        CheckSkills(false);
        _G.travel:SetVisible(true);
    elseif (arguments == "hide") then
        _G.travel:SetVisible(false);
    elseif (arguments == "toggle") then
        _G.travel:SetVisible(not _G.travel:IsVisible());
    elseif (arguments == "dump") then
        _G.travel:DoDump();
    elseif (arguments == "scan") then
        _G.travel:ManualSkillScan();
    elseif (arguments ~= nil) then
        TravelCommand:GetHelp();
    end
end

function TravelCommand:GetHelp()
    Turbine.Shell.WriteLine(helpString);
end

-- add the command to the shell
Turbine.Shell.AddCommand("trav,travel", TravelCommand);
