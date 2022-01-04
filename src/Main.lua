import "TravelWindowII.src";

-- create the travel window
travel = TravelWindow();

-- create a new command line command for the travel window
TravelCommand = Turbine.ShellCommand();

-- handle the travel commands
function TravelCommand:Execute(command, arguments)
    if (arguments == "show") then
        travel:SetVisible(true);
    elseif (arguments == "hide") then
        travel:SetVisible(false);
    elseif (arguments == "toggle") then
        travel:SetVisible(not travel:IsVisible());
    elseif (arguments == "dump") then
        travel:DoDump();
    elseif (arguments ~= nil) then
        TravelCommand:GetHelp();
    end
end

function TravelCommand:GetHelp()
    Turbine.Shell.WriteLine(helpString);
end

-- add the command to the shell
Turbine.Shell.AddCommand("trav,travel", TravelCommand);
