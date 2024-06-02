import "TravelWindowII.src";

-- create shortcuts to the bitop functions
bit = TravelWindowII.bit;
hasbit = TravelWindowII.hasbit;
setbit = TravelWindowII.setbit;
clearbit = TravelWindowII.clearbit;
togglebit = TravelWindowII.togglebit;

DefAlpha = 0.92;
Settings = {};
AccountSettingsStrings = {};
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

-- create the lists of travel locations and the shortcuts
-- that are used to execute them
TravelInfo = TravelDictionary();

-- load the player saved settings
LoadSettings();

TravelInfo:SetSkillLabels()

-- set up all the shortcuts
InitShortcuts();

CreateOptionsWindow();

-- create the external toggle button
ToggleButton = TravelWindowII.src.TravelButton();

-- create the travel window
_G.travel = TravelWindow();

NewShortcutEvent = function()
    _G.travel.dirty = true; -- reset list of shortcuts
    _G.travel:SetItems(); -- redraw current window
end

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
        _G.travel:Activate();
    elseif (arguments == "hide") then
        _G.travel:SetVisible(false);
    elseif (arguments == "toggle") then
        _G.travel:SetVisible(not _G.travel:IsVisible());
        _G.travel:Activate();
    elseif (arguments == "scan") then
        _G.travel:ManualSkillScan();
    elseif (arguments ~= nil) then
        TravelCommand:GetHelp();
    end
end

function TravelCommand:GetHelp()
    Turbine.Shell.WriteLine(LC.help);
end

-- add the command to the shell
Turbine.Shell.AddCommand("trav,travel", TravelCommand);
