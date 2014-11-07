
import "DhorPlugins.Travel";

-- create the travel window
travel = TravelWindow();

-- create a new command line command for the travel window
travelCommand = Turbine.ShellCommand();

-- handle the travel commands
function travelCommand:Execute( command, arguments )
	if ( arguments == "show" ) then
		travel:SetVisible( true );
	elseif ( arguments == "hide" ) then
		travel:SetVisible( false );
	elseif ( arguments == "toggle" ) then
		travel:SetVisible( not travel:IsVisible() );
	elseif ( arguments == "dump" ) then
		travel:DoDump();
	elseif ( arguments ~= nil ) then
		travelCommand:GetHelp();
	end
end

function travelCommand:GetHelp()
	Turbine.Shell.WriteLine( helpString );
end

-- add the command to the shell
Turbine.Shell.AddCommand( "trav,travel", travelCommand );


