import "TravelWindowII.src";

-- create the travel window
_G.travel = TravelWindow();

-- handle unload event and save settings
plugin.Unload = function()
    _G.travel:SaveSettings();
end

-- create a new command line command for the travel window
TravelCommand = Turbine.ShellCommand();

-- handle the travel commands
function TravelCommand:Execute(command, arguments)
    if (arguments == "show") then
        _G.travel:CheckSkills(false);
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
