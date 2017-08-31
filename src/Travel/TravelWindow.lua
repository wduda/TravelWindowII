import "Turbine";
import "Turbine.Debug";
import "Turbine.Gameplay";
import "Turbine.UI";
import "Turbine.UI.Lotro";
import "DhorPlugins.Extensions";
import "DhorPlugins.Utils.BitOps";


--[[ This is the main window for the Travel Window UI      ]] --
--[[ It handles the loading and saving the settings,       ]] --
--[[ creating the lists of travel shortcuts, creates       ]] --
--[[ and handles the context menu.                         ]] --


TravelWindow = class(Turbine.UI.Lotro.Window);

function TravelWindow:Constructor()
    Turbine.UI.Lotro.Window.Constructor(self);

    settings = {};
    settingsStrings = {}; -- save the settings as strings due to locale issue
    travelShortcuts = {}; -- put all the shortcuts into one table
    trainedSkills = Turbine.Gameplay.SkillList;
    self.minWidth = 220;
    self.minHeight = 150;
    self.disableResize = false;
    self.reloadGVMap = false;
    self.options = nil;

    -- create the lists of travel locations and the shortcuts
    -- that are used to execute them
    TravelInfo = TravelDictionaries();

    -- load the player saved settings
    self:LoadSettings();

    -- configure the main window
    self:SetPosition(settings.positionX, settings.positionY);
    self:SetSize(settings.width, settings.height);
    self:SetBackColor(Turbine.UI.Color(0.0, 0, 0, 0));
    self:SetText(mainTitleString);
    self:SetZOrder(97);
    self:SetOpacity(1);
    if (settings.hideOnStart == 1) then
        self:SetVisible(false);
    else
        self:SetVisible(true);
    end

    -- configure the external toggle button
    self.ToggleButton = DhorPlugins.Travel.TravelButton(self);
    self.ToggleButton:SetPosition(settings.buttonPositionX,
    settings.buttonPositionY);
    self.ToggleButton:SetVisible(settings.showButton == 1);
    self.ToggleButton:SetOpacity(settings.toggleMinOpacity);

    -- check if a function that only exists in the newest update exists
    -- and don't add the map home skill if it does
    if (Turbine.UI.Control.IsDisplayed == nil) then
        -- if the player has set the map home skill, insert that
        -- into the list of locations
        if (settings.mapHome ~= nil) then
            genLocations:InsertData(1, mapHomeString, settings.mapHome);
        end
    end

    -- if the player has a PvMP map, then insert it into the list
    if ((settings.mapGlanVraig ~= nil) and (settings.mapGlanVraig ~= "nil")) then
        --self.reloadGVMap = true;
        genLocations:InsertData(2, glanMapString, settings.mapGlanVraig, "skip");
    end

    -- redo the counts
    TravelInfo:GetCounts();

    -- get the player class and race
    player = Turbine.Gameplay.LocalPlayer.GetInstance();
    playerClass = player:GetClass();
    playerAlignment = player:GetAlignment();
    playerRace = player:GetRace();
    self.racetype = 0;

    -- get the list of trained skills the player has
    if (Turbine.Gameplay.LocalPlayer.GetTrainedSkills ~= nil) then
        trainedSkills = player:GetTrainedSkills();
    end

    -- set the racial travel skill to add
    if (playerRace == Turbine.Gameplay.Race.Dwarf) then
        self.racetype = 3;
    elseif (playerRace == Turbine.Gameplay.Race.Elf) then
        self.racetype = 4;
    elseif (playerRace == Turbine.Gameplay.Race.Hobbit) then
        self.racetype = 2;
    elseif (playerRace == Turbine.Gameplay.Race.Man) then
        self.racetype = 1;
    elseif (playerRace == Turbine.Gameplay.Race.Beorning) then
        self.racetype = 5;
    elseif (playerRace == Turbine.Gameplay.Race.HighElf) then
        self.racetype = 6;
    else
        self.racetype = 7;
    end

    -- save the player's combat states for managing hiding the window
    -- when the player enters combat
    self.previousCombatState = false;
    self.wasOpenBeforeCombat = false;

    -- set up all the shortcuts
    self:CheckEnabledSettings();
    self:SetShortcuts();

    -- create a single context menu to use on all panels
    menu = SettingsMenu(self);
    menu:SetSettings(settings.race,
    settings.class,
    settings.mode,
    settings.filters);

    -- create the Tabbed Panel to hold all the other panels
    self.MainPanel = DhorPlugins.Extensions.DPanel();
    self.MainPanel:SetSize(settings.width - 20, settings.height - 60);
    self.MainPanel:SetPosition(10, 40);
    self.MainPanel:SetButtonsVisible(false) -- make sure to hide the tab buttons
    self.MainPanel:SetParent(self);

    -- create the tabs for each mode of display
    self.ListTab = TravelListTab(self);
    self.GridTab = TravelGridTab(self);
    self.CaroTab = TravelCaroTab(self);
    self.PullTab = TravelPulldownTab(self);

    -- add the tabs to the panel
    self.MainPanel:AddTab(self.ListTab);
    self.MainPanel:AddTab(self.GridTab);
    self.MainPanel:AddTab(self.CaroTab);
    self.MainPanel:AddTab(self.PullTab);

    -- create a control for resizing the window
    self.sizeControl = Turbine.UI.Control();
    self.sizeControl:SetParent(self);
    self.sizeControl:SetZOrder(100);
    self.sizeControl:SetSize(20, 20);
    self.sizeControl:SetBackColorBlendMode(Turbine.UI.BlendMode.Screen)
    self.sizeControl:SetBackColor(Turbine.UI.Color(0.1, 1, 1, 1));
    self.sizeControl:SetPosition(self:GetWidth() - self.sizeControl:GetWidth(),
    self:GetHeight() - self.sizeControl:GetHeight());

    -- display the tab that was last selected
    self.MainPanel:SetTab(settings.mode);
    self.MainPanel:SetSize(self:GetWidth() - 20, self:GetHeight() - 60);
    self.MainPanel:UpdateTabs();
    self:UpdateSettings();

    -- timers for events
    self.lastTime = 0;
    self.lastMove = 0;

    -- track the hidden state of the UI, manage previous states for window and
    -- the button
    self.hidden = false;
    self.currentVisState = self:IsVisible();

    optionsPanel = DhorPlugins.Travel.OptionsPanel(self);

    pcall(function()
        plugin.GetOptionsPanel = function(self)
            return optionsPanel;
        end
    end);

    --[[ Event Handlers ]] --

    -- make sure we listen for updates
    self:SetWantsUpdates(true);
    self:SetWantsKeyEvents(true);

    -- check if our position has changed, and save the settings if so
    self.PositionChanged = function(sender, args)
        one, two = self:GetPosition();
        settings.positionX = one;
        settings.positionY = two;
        self:SaveSettings();
        self.PullTab:ClosePulldown();
    end

    -- manage hiding the UI
    self.KeyDown = function(sender, args)
        if (args.Action == 268435635) then
            if (self.hidden == false) then
                self.currentVisState = self:IsVisible();
                self.hidden = true;
                self:SetVisible(false);
                self.ToggleButton:SetVisible(false);
            else
                self.hidden = false;
                self:SetVisible(self.currentVisState);
                self.ToggleButton:SetVisible(settings.showButton == 1);
            end
        else
        end
    end


    -- check if the combat state of the player changed, in case we want
    -- to hide the window
    incombatChangedHandler = function(sender, args)
        -- first check if we are going into combat
        if (self.previousCombatState == false) then

            -- then check if the window is visible already, and the player wishes
            -- to hide on combat
            if (settings.hideOnCombat == 1 and self:IsVisible()) then

                -- make sure we know we were open previously, then hide the window
                self.wasOpenBeforeCombat = true;
                self:SetVisible(false);
            end

            -- set the previous state for the next check
            self.previousCombatState = true;

            -- handle going out of combat
        else

            -- check that we were open before combat and the player wishes
            -- to hide on combat
            if (settings.hideOnCombat == 1 and self.wasOpenBeforeCombat == true) then

                -- clear the open status, and show the window
                self.wasOpenBeforeCombat = false;
                self:SetVisible(true);
            end

            -- set the previous state for the next check
            self.previousCombatState = false;
        end
    end
    AddCallback(player, "InCombatChanged", incombatChangedHandler);

    -- if the visible status of the window changes, close the pulldown tab
    self.VisibleChanged = function(sender, args)
        if (self:IsVisible() == false) then
            self.PullTab:ClosePulldown();
        end
    end

    -- go to full opacity if mouse is over
    self.MouseEnter = function(sender, args)
        self:SetOpacity(settings.mainMaxOpacity);
    end

    -- go to low opacity when mosue is not over
    self.MouseLeave = function(sender, args)
        self:SetOpacity(settings.mainMinOpacity);
    end

    -- change the background color of the resize button on entry to help
    -- show exactly where the button is
    self.sizeControl.MouseEnter = function(sender, args)
        self.sizeControl:SetBackColor(Turbine.UI.Color(0.9, 1, 1, 1));
    end

    -- return background color to normal on mouse leave
    self.sizeControl.MouseLeave = function(sender, args)
        self.sizeControl:SetBackColor(Turbine.UI.Color(0.1, 1, 1, 1));
    end

    -- check if someone is going to start dragging the resize control
    self.sizeControl.MouseDown = function(sender, args)

        -- check if resize has been disabled
        if (self.disableResize) then
            return;
        end

        -- set start location of resize and enable dragging
        sender.dragStartX = args.X;
        sender.dragStartY = args.Y;
        sender.dragging = true;
    end

    self.sizeControl.MouseUp = function(sender, args)
        -- disable dragging, then update settings
        sender.dragging = false;

        settings.width = self:GetWidth();
        settings.height = self:GetHeight();
        self:UpdateSettings();
    end

    -- perform the resize
    self.sizeControl.MouseMove = function(sender, args)
        local width, height = self:GetSize();

        -- if resize dragging, then resize the window
        if (sender.dragging) then
            self:SetSize(width + (args.X - sender.dragStartX),
            height + (args.Y - sender.dragStartY));
        end

        -- update the size of the window
        self:UpdateSize();

        -- check time since last move
        if (Turbine.Engine.GetGameTime() - self.lastMove > 0.1
        and self:IsVisible() or self.lastMove == 0) then

            -- update the tabbed panels
            self.MainPanel:SetSize(self:GetWidth() - 20, self:GetHeight() - 60);
            self.MainPanel:UpdateTabs();
            self.lastMove = Turbine.Engine.GetGameTime();
        end
    end

    Plugins["Travel Window"].Load = function(sender, args)
        Turbine.Shell.WriteLine("Travel Window v" .. Plugins["Travel Window"]:GetVersion() .. " loaded");
    end
end

function TravelWindow:UpdateSize()
    -- check that the window is not smaller than min width
    if (self:GetWidth() < self.minWidth) then
        self:SetWidth(self.minWidth);
    end

    -- check that the window is not smaller than min height
    if (self:GetHeight() < self.minHeight) then
        self:SetHeight(self.minHeight);
    end

    -- set the new location of the resize control
    self.sizeControl:SetPosition(self:GetWidth() - self.sizeControl:GetWidth(),
    self:GetHeight() - self.sizeControl:GetHeight());
end

function TravelWindow:LoadSettings()
    -- load the self.settings.  If a value is not available, set a default value

    settings = {};

    pcall(function()
        settingsString = Turbine.PluginData.Load(Turbine.DataScope.Character,
        "TravelWindowSettings");
    end);

    if (type(settingsString) ~= "table") then
        settingsString = {};
    end

    if (not settingsString.width or settingsString.width == "nil") then
        settingsString.width = tostring(self.minWidth);
    end

    if (not settingsString.height or settingsString.height == "nil") then
        settingsString.height = tostring(self.minHeight);
    end

    if (not settingsString.positionX or settingsString.positionX == "nil") then
        settingsString.positionX = tostring(Turbine.UI.Display.GetWidth()
        - self:GetWidth() - 50);
    end

    if (not settingsString.positionY or settingsString.positionY == "nil") then
        settingsString.positionY = tostring(Turbine.UI.Display.GetHeight()
        - self:GetHeight() - 50 * 1.5);
    end

    if (not settingsString.buttonPositionX or settingsString.buttonPositionX == "nil") then
        settingsString.buttonPositionX = tostring(Turbine.UI.Display.GetWidth()
        - self:GetWidth() - 50);
    end

    if (not settingsString.buttonPositionY or settingsString.buttonPositionY == "nil") then
        settingsString.buttonPositionY = tostring(Turbine.UI.Display.GetHeight()
        - self:GetHeight() - 50 * 1.5);
    end

    if (not settingsString.hideOnStart or settingsString.hideOnStart == "nil") then
        settingsString.hideOnStart = tostring(0);
    end

    if (not settingsString.hideOnCombat or settingsString.hideOnCombat == "nil") then
        settingsString.hideOnCombat = tostring(0);
    end

    if (not settingsString.pulldownTravel or settingsString.pulldownTravel == "nil") then
        settingsString.pulldownTravel = tostring(0);
    end

    if (not settingsString.showButton or settingsString.showButton == "nil") then
        settingsString.showButton = tostring(1);
    end

    if (not settingsString.class or settingsString.class == "nil") then
        settingsString.class = tostring(1);
    end

    if (not settingsString.race or settingsString.race == "nil") then
        settingsString.race = tostring(1);
    end

    if (not settingsString.mode or settingsString.mode == "nil") then
        settingsString.mode = tostring(1);
    end

    if (not settingsString.filters or settingsString.filters == "nil") then
        settingsString.filters = tostring(0x0F);
    end

    if (not settingsString.enabled) then
        settingsString.enabled = {};
    end

    if (not settingsString.order) then
        settingsString.order = {};
    end

    if (not settingsString.mainMaxOpacity or settingsString.mainMaxOpacity == "nil") then
        settingsString.mainMaxOpacity = tostring(1);
    end

    if (not settingsString.mainMinOpacity or settingsString.mainMinOpacity == "nil") then
        settingsString.mainMinOpacity = tostring(0.5);
    end

    if (not settingsString.toggleMaxOpacity or settingsString.toggleMaxOpacity == "nil") then
        settingsString.toggleMaxOpacity = tostring(1);
    end

    if (not settingsString.toggleMinOpacity or settingsString.toggleMinOpacity == "nil") then
        settingsString.toggleMinOpacity = tostring(0.2);
    end

    -- convert from strings if necessary
    if (type(settingsString.width) == "string") then
        settings.width = tonumber(settingsString.width);
    else
        settings.width = settingsString.width;
    end

    if (type(settingsString.height) == "string") then
        settings.height = tonumber(settingsString.height);
    else
        settings.height = settingsString.height;
    end

    if (type(settingsString.positionX) == "string") then
        settings.positionX = tonumber(settingsString.positionX);
    else
        settings.positionX = settingsString.positionX;
    end

    if (type(settingsString.positionY) == "string") then
        settings.positionY = tonumber(settingsString.positionY);
    else
        settings.positionY = settingsString.positionY;
    end

    if (type(settingsString.buttonPositionX) == "string") then
        settings.buttonPositionX = tonumber(settingsString.buttonPositionX);
    else
        settings.buttonPositionX = settingsString.buttonPositionX;
    end

    if (type(settingsString.positionY) == "string") then
        settings.buttonPositionY = tonumber(settingsString.buttonPositionY);
    else
        settings.buttonPositionY = settingsString.buttonPositionY;
    end

    if (type(settingsString.hideOnStart) == "string") then
        settings.hideOnStart = tonumber(settingsString.hideOnStart);
    else
        settings.hideOnStart = settingsString.hideOnStart;
    end

    if (type(settingsString.hideOnCombat) == "string") then
        settings.hideOnCombat = tonumber(settingsString.hideOnCombat);
    else
        settings.hideOnCombat = settingsString.hideOnCombat;
    end

    if (type(settingsString.pulldownTravel) == "string") then
        settings.pulldownTravel = tonumber(settingsString.pulldownTravel);
    else
        settings.pulldownTravel = settingsString.pulldownTravel;
    end

    if (type(settingsString.showButton) == "string") then
        settings.showButton = tonumber(settingsString.showButton);
    else
        settings.showButton = settingsString.showButton;
    end

    if (type(settingsString.class) == "string") then
        settings.class = tonumber(settingsString.class);
    else
        settings.class = settingsString.class;
    end

    if (type(settingsString.race) == "string") then
        settings.race = tonumber(settingsString.race);
    else
        settings.race = settingsString.race;
    end

    if (type(settingsString.mode) == "string") then
        settings.mode = tonumber(settingsString.mode);
    else
        settings.mode = settingsString.mode;
    end

    if (type(settingsString.filters) == "string") then
        settings.filters = tonumber(settingsString.filters);
    else
        settings.filters = settingsString.filters;
    end

    if (type(settingsString.class) == "string") then
        settings.class = tonumber(settingsString.class);
    else
        settings.class = settingsString.class;
    end

    if (type(settingsString.race) == "string") then
        settings.race = tonumber(settingsString.race);
    else
        settings.race = settingsString.race;
    end

    if (type(settingsString.mainMaxOpacity) == "string") then
        settings.mainMaxOpacity = tonumber(settingsString.mainMaxOpacity);
    else
        settings.mainMaxOpacity = settingsString.mainMaxOpacity;
    end

    if (type(settingsString.mainMinOpacity) == "string") then
        settings.mainMinOpacity = tonumber(settingsString.mainMinOpacity);
    else
        settings.mainMinOpacity = settingsString.mainMinOpacity;
    end

    if (type(settingsString.toggleMaxOpacity) == "string") then
        settings.toggleMaxOpacity = tonumber(settingsString.toggleMaxOpacity);
    else
        settings.toggleMaxOpacity = settingsString.toggleMaxOpacity;
    end

    if (type(settingsString.toggleMinOpacity) == "string") then
        settings.toggleMinOpacity = tonumber(settingsString.toggleMinOpacity);
    else
        settings.toggleMinOpacity = settingsString.toggleMinOpacity;
    end

    if (settingsString.mapGlanVraig ~= nil) then
        settings.mapGlanVraig = settingsString.mapGlanVraig;
    end

    settings.enabled = settingsString.enabled;

    local convertTableIndex = false;
    for i, v in pairs(settingsString.order) do
        if (type(i) == "string") then
            convertTableIndex = true;
        end
    end

    if (convertTableIndex) then
        self:OrderTableNumberIndex();
    else
        settings.order = settingsString.order;
    end
end

function TravelWindow:OrderTableStringIndex()

    settingsString.order = {};

    for i, v in ipairs(settings.order) do
        settingsString.order[tostring(i)] = v;
    end
end

function TravelWindow:OrderTableNumberIndex()

    settings.order = {};

    for i, v in pairs(settingsString.order) do
        settings.order[tonumber(i)] = v;
    end
end

function TravelWindow:SaveSettings()

    -- convert the settings to strings
    settingsString.height = tostring(settings.height);
    settingsString.width = tostring(settings.width);
    settingsString.positionX = tostring(settings.positionX);
    settingsString.positionY = tostring(settings.positionY);
    settingsString.buttonPositionX = tostring(settings.buttonPositionX);
    settingsString.buttonPositionY = tostring(settings.buttonPositionY);
    settingsString.hideOnStart = tostring(settings.hideOnStart);
    settingsString.hideOnCombat = tostring(settings.hideOnCombat);
    settingsString.pulldownTravel = tostring(settings.pulldownTravel);
    settingsString.showButton = tostring(settings.showButton);
    settingsString.class = tostring(settings.class);
    settingsString.race = tostring(settings.race);
    settingsString.mode = tostring(settings.mode);
    settingsString.filters = tostring(settings.filters);
    settingsString.mainMaxOpacity = tostring(settings.mainMaxOpacity);
    settingsString.mainMinOpacity = tostring(settings.mainMinOpacity);
    settingsString.toggleMaxOpacity = tostring(settings.toggleMaxOpacity);
    settingsString.toggleMinOpacity = tostring(settings.toggleMinOpacity);
    settingsString.enabled = settings.enabled;
    settingsString.mapGlanVraig = tostring(settings.mapGlanVraig);

    self:OrderTableStringIndex();


    -- save the settings
    Turbine.PluginData.Save(Turbine.DataScope.Character,
    "TravelWindowSettings", settingsString);
end

function TravelWindow:UpdateSettings()

    -- get the settings from the menu
    settings.race,
    settings.class, settings.mode, settings.filters = menu:GetSettings();

    -- save the settings
    self:SaveSettings();

    -- set which page of the tab panel to show
    self.MainPanel:SetTab(settings.mode);

    -- update the page that is showing
    if (settings.mode == 1) then
        self.minWidth = 245;
        self.minHeight = 150;
        self.ListTab:SetItems();
    elseif (settings.mode == 2) then
        self.minWidth = 120;
        self.minHeight = 130;
        self.GridTab:SetItems();
    elseif (settings.mode == 3) then
        self.minWidth = 120;
        self.minHeight = 130;
        self.CaroTab:SetItems();
    else
        self.minWidth = 220;
        self.minHeight = 150;
        self.PullTab:SetItems();
    end

    self:UpdateSize();

    self.MainPanel:SetSize(self:GetWidth() - 20, self:GetHeight() - 60);
    self.MainPanel:UpdateTabs();
end

function TravelWindow:SetMapHome()

    -- disable the resize while the map update window is open
    -- also close the options window
    self.disableResize = true;
    self:CloseOptions();

    -- create the window used to add the map
    self.MapWindow = Turbine.UI.Control();
    self.MapWindow:SetPosition(10, 35);
    self.MapWindow:SetSize(settings.width - 20, settings.height - 60);
    self.MapWindow:SetBackColor(Turbine.UI.Color(1, 0.1, 0.1, 0.1));
    self.MapWindow:SetParent(self);
    self.MapWindow:SetZOrder(300);

    -- add an label to the window for instructions
    self.mapLabel = Turbine.UI.Label();
    self.mapLabel:SetForeColor(Turbine.UI.Color(1, 0.2, 0.2, 0.6));
    self.mapLabel:SetPosition(0, 15);
    self.mapLabel:SetSize(settings.width - 20, self.MapWindow:GetHeight() - 90);
    self.mapLabel:SetParent(self.MapWindow);
    self.mapLabel:SetVisible(true);
    self.mapLabel:SetFont(Turbine.UI.Lotro.Font.Verdana14);
    self.mapLabel:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleLeft);
    self.mapLabel:SetMultiline(true);
    self.mapLabel:SetText(mapInstructionString);

    -- add an empty quickslot to the window
    self.mapQuickSlot1 = Turbine.UI.Lotro.Quickslot();
    self.mapQuickSlot1:SetPosition(self.MapWindow:GetWidth() / 2 - 18,
    self.MapWindow:GetHeight() - 80);
    self.mapQuickSlot1:SetSize(36, 36);
    self.mapQuickSlot1:SetParent(self.MapWindow);
    self.mapQuickSlot1:SetUseOnRightClick(false);
    self.mapQuickSlot1:SetVisible(true);

    -- add a button to the window
    self.mapButton = Turbine.UI.Lotro.Button();
    self.mapButton:SetSize(60, 50);
    self.mapButton:SetPosition(self.MapWindow:GetWidth() / 2 -
    self.mapButton:GetWidth() / 2,
    self.MapWindow:GetHeight() - 35);
    self.mapButton:SetText("OK");
    self.mapButton:SetParent(self.MapWindow);
    self.mapButton:SetVisible(true);

    -- when the button is pressed, update the settings
    -- with the new skill, and reset everything
    self.mapButton.Click = function(sender, args)

        -- check if there is a shortcut in the quickslot
        if (self.mapQuickSlot1:GetShortcut():GetType() ~=
        Turbine.UI.Lotro.ShortcutType.Undef) then

            -- save the shortcut data to the settings
            self:SaveMapHome(self.mapQuickSlot1:GetShortcut());
        end

        -- enable resize again
        self.disableResize = false;

        -- update the shortcuts list
        self:CheckEnabledSettings()
        self:SetShortcuts();
        self:UpdateSettings();

        -- close this window
        self.MapWindow:SetVisible(false);
        self.MapWindow = nil;
    end
end

function TravelWindow:SaveMapHome(shortcut)

    local mapItem = shortcut:GetItem();

    -- do this if it is the basic map home item
    if (mapItem:GetName() == mapHomeString) then

        -- remove the old shortcut if it exists
        if (genLocations:IndexByKey(mapHomeString) == 1) then
            genLocations:RemoveAtIndex(1);
        end

        -- set the value
        settings.mapHome = shortcut:GetData();

        -- update the location lists
        genLocations:InsertData(1, mapHomeString, settings.mapHome);
        TravelInfo:GetCounts();

        -- else do this if it is the glan vrag map
    elseif (string.find(mapItem:GetName(), glanMapItemString)) then

        -- remove the old shortcut if it exists
        if (genLocations:IndexByKey(glanMapString) == 2) then
            genLocations:RemoveAtIndex(2);
        end

        -- set the value
        settings.mapGlanVraig = shortcut:GetData();

        -- update the location lists
        genLocations:InsertData(2, glanMapString, settings.mapGlanVraig);
        TravelInfo:GetCounts();

        -- else, do nothing but report the error
    else
        Turbine.Shell.WriteLine(mapErrorString);
    end
    -- update and save everything
    self:UpdateSettings();
    self:SaveSettings();
end

-- for debug purposes
function TravelWindow:DoDump()
    Turbine.Debug.Table.Dump(DhorPlugins.Travel);
end

function TravelWindow:SetShortcuts()
    -- set default values
    travelShortcuts = {};
    counter = 1;
    racetype = 1;

    -- set the travel skills for free people
    if (playerAlignment == Turbine.Gameplay.Alignment.FreePeople) then
        -- set the generic travel items
        for i = 1, travelCount[3], 1 do
            -- get the order number for the item
            counter = self:TableIndex(settings.order, genLocations:KeyAtIndex(i));

            -- set the shortcut for the quickslot, check
            -- if the shortcut is the map home or not
            if (string.len(genLocations:DataAtIndex(i)) > 12) then
                table.insert(travelShortcuts, TravelShortcut(2.0,
                genLocations:DataAtIndex(i),
                genLocations:KeyAtIndex(i),
                1,
                counter,
                settings.enabled[genLocations:KeyAtIndex(i)],
                genLocations:NameAtIndex(i)));
            else
                table.insert(travelShortcuts, TravelShortcut(6.0,
                genLocations:DataAtIndex(i),
                genLocations:KeyAtIndex(i),
                1,
                counter,
                settings.enabled[genLocations:KeyAtIndex(i)],
                genLocations:NameAtIndex(i)));
            end
        end

        -- add the race travel to the list
        counter = self:TableIndex(settings.order, racialLocations:KeyAtIndex(self.racetype));
        table.insert(travelShortcuts, TravelShortcut(6.0,
        racialLocations:DataAtIndex(self.racetype),
        racialLocations:KeyAtIndex(self.racetype),
        2,
        counter,
        settings.enabled[racialLocations:KeyAtIndex(self.racetype)],
        racialLocations:NameAtIndex(self.racetype)));

        -- set the reputation travel items
        for i = 1, travelCount[4], 1 do
            counter = self:TableIndex(settings.order, repLocations:KeyAtIndex(i));
            table.insert(travelShortcuts, TravelShortcut(6.0,
            repLocations:DataAtIndex(i),
            repLocations:KeyAtIndex(i),
            3,
            counter,
            settings.enabled[repLocations:KeyAtIndex(i)],
            repLocations:NameAtIndex(i)));
        end
    else
        -- set the creep travel items
        for i = 1, travelCount[6], 1 do
            counter = self:TableIndex(settings.order, creepLocations:KeyAtIndex(i));
            table.insert(travelShortcuts, TravelShortcut(6.0,
            creepLocations:DataAtIndex(i),
            creepLocations:KeyAtIndex(i),
            3,
            counter,
            settings.enabled[creepLocations:KeyAtIndex(i)],
            creepLocations:NameAtIndex(i)));
        end
    end

    -- set the hunter travel items
    if (playerClass == Turbine.Gameplay.Class.Hunter) then
        for i = 1, travelCount[1], 1 do
            counter = self:TableIndex(settings.order, hunterLocations:KeyAtIndex(i));
            table.insert(travelShortcuts, TravelShortcut(6.0,
            hunterLocations:DataAtIndex(i),
            hunterLocations:KeyAtIndex(i),
            4,
            counter,
            settings.enabled[hunterLocations:KeyAtIndex(i)],
            hunterLocations:NameAtIndex(i)));
        end
    end

    -- set the warden travel items
    if (playerClass == 194) then
        for i = 1, travelCount[2], 1 do
            counter = self:TableIndex(settings.order, wardenLocations:KeyAtIndex(i));
            table.insert(travelShortcuts, TravelShortcut(6.0,
            wardenLocations:DataAtIndex(i),
            wardenLocations:KeyAtIndex(i),
            4,
            counter,
            settings.enabled[wardenLocations:KeyAtIndex(i)],
            wardenLocations:NameAtIndex(i)));
        end
    end

    -- sort the shortcuts
    self:SortShortcuts()
end

function TravelWindow:CheckEnabledSettings()
    -- count the min number of items that should be in the list
    local itemCount = 0;
    if (playerAlignment == Turbine.Gameplay.Alignment.FreePeople) then
        itemCount = travelCount[3] + travelCount[4] + 1;
        if (playerClass == Turbine.Gameplay.Class.Hunter) then
            itemCount = itemCount + travelCount[1];
        elseif (playerClass == 194) then
            itemCount = itemCount + travelCount[2]
        end
    else
        itemCount = travelCount[6] + 1;
    end

    -- reset the order if there are too many items in the previously saved
    -- list.  This should only be true once, when folks update to version 6.0
    if (#settings.order > itemCount) then
        Turbine.Shell.WriteLine(resetOrderString);
        settings.order = {};
    end

    -- same as the order settings, reset if necessary
    if (#settings.enabled > itemCount) then
        Turbine.Shell.WriteLine(resetEnabledString);
        settings.enabled = {};
    end

    -- need to find the highest sort number now
    local counter = table.getn(settings.order) + 1;

    if (playerAlignment == Turbine.Gameplay.Alignment.FreePeople) then
        -- update generic travel settings
        for i = 1, travelCount[3], 1 do
            -- if the setting for the skill is nil, set it to default
            if (settings.enabled[genLocations:KeyAtIndex(i)] == nil) then
                settings.enabled[genLocations:KeyAtIndex(i)] = true;
            end

            -- if the skill is not in the order list, add it and increase the counter
            if (self:TableContains(settings.order,
            genLocations:KeyAtIndex(i)) == false) then
                table.insert(settings.order, counter, genLocations:KeyAtIndex(i));
                counter = counter + 1;
            end
        end

        -- update reputation travel settings
        for i = 1, travelCount[4], 1 do
            if (settings.enabled[repLocations:KeyAtIndex(i)] == nil) then
                settings.enabled[repLocations:KeyAtIndex(i)] = true;
            end
            if (self:TableContains(settings.order, repLocations:KeyAtIndex(i)) == false) then
                table.insert(settings.order, counter, repLocations:KeyAtIndex(i));
                counter = counter + 1;
            end
        end

        -- update racial travel settings
        if (settings.enabled[racialLocations:KeyAtIndex(self.racetype)] == nil) then
            settings.enabled[racialLocations:KeyAtIndex(self.racetype)] = true;
        end
        if (self:TableContains(settings.order, racialLocations:KeyAtIndex(self.racetype)) == false) then
            table.insert(settings.order, counter, racialLocations:KeyAtIndex(self.racetype));
            counter = counter + 1;
        end

        -- update hunter travel settings
        if (playerClass == Turbine.Gameplay.Class.Hunter) then
            for i = 1, travelCount[1], 1 do
                if (settings.enabled[hunterLocations:KeyAtIndex(i)] == nil) then
                    settings.enabled[hunterLocations:KeyAtIndex(i)] = true;
                end
                if (self:TableContains(settings.order, hunterLocations:KeyAtIndex(i)) == false) then
                    table.insert(settings.order, counter, hunterLocations:KeyAtIndex(i));
                    counter = counter + 1;
                end
            end
        end

        -- update warden travel settings
        if (playerClass == 194) then
            for i = 1, travelCount[2], 1 do
                if (settings.enabled[wardenLocations:KeyAtIndex(i)] == nil) then
                    settings.enabled[wardenLocations:KeyAtIndex(i)] = true;
                end
                if (self:TableContains(settings.order, wardenLocations:KeyAtIndex(i)) == false) then
                    table.insert(settings.order, counter, wardenLocations:KeyAtIndex(i));
                    counter = counter + 1;
                end
            end
        end
    else
        -- update creep travel settings
        for i = 1, travelCount[6], 1 do
            if (settings.enabled[creepLocations:KeyAtIndex(i)] == nil) then
                settings.enabled[creepLocations:KeyAtIndex(i)] = true;
            end
            if (self:TableContains(settings.order, creepLocations:KeyAtIndex(i)) == false) then
                table.insert(settings.order, counter, creepLocations:KeyAtIndex(i));
                counter = counter + 1;
            end
        end
    end
end

-- simple function to open the options window
function TravelWindow:OpenOptions()
    self.options = DhorPlugins.Travel.OptionsWindow(self);
end

-- function to close the options window if it exists
function TravelWindow:CloseOptions()
    if (self.options ~= nil) then
        self.options:SetVisible(false);
    end
    self.options = nil;
end

function TravelWindow:OpenMoorMap()
    self.moorMapWindow = DhorPlugins.Travel.MoorMapWindow(self);
end

-- function to close the moor map window if it exists
function TravelWindow:CloseMoorMap()
    if (self.moorMapWindow ~= nil) then
        self.moorMapWindow:SetVisible(false);
    end
    self.moorMapWindow = nil;
end

function TravelWindow:OpenEriadorMap()
    self.eriadorMapWindow = DhorPlugins.Travel.EriadorMapWindow(self, playerClass, self.racetype, travelShortcuts);
end

-- function to close the eriador map window if it exists
function TravelWindow:CloseEriadorMap()
    if (self.eriadorMapWindow ~= nil) then
        self.eriadorMapWindow:SetVisible(false);
    end
    self.eriadorMapWindow = nil;
end

function TravelWindow:OpenRhovanionMap()
    self.rhovanionMapWindow = DhorPlugins.Travel.RhovanionMapWindow(self, playerClass, self.racetype, travelShortcuts);
end

-- function to close the rhovanion map window if it exists
function TravelWindow:CloseRhovanionMap()
    if (self.rhovanionMapWindow ~= nil) then
        self.rhovanionMapWindow:SetVisible(false);
    end
    self.rhovanionMapWindow = nil;
end

function TravelWindow:OpenGondorMap()
    self.gondorMapWindow = DhorPlugins.Travel.GondorMapWindow(self, playerClass, self.racetype, travelShortcuts);
end

-- function to close the gondor map window if it exists
function TravelWindow:CloseGondorMap()
    if (self.gondorMapWindow ~= nil) then
        self.gondorMapWindow:SetVisible(false);
    end
    self.gondorMapWindow = nil;
end

-- function to check if a table contains a specific element
function TravelWindow:TableContains(data, element)
    for i, value in pairs(data) do
        if (value == element) then
            return true;
        end
    end
    return false;
end

-- function to check if a table contains a specific element index
function TravelWindow:TableIndex(data, element)
    for i, value in pairs(data) do
        if (value == element) then
            return i;
        end
    end
    return 0;
end

function TravelWindow:SortShortcuts()

    -- ensure we have more than 2 shortcuts
    if #travelShortcuts < 2 then
        Turbine.Engine.WriteLine("Table does not have enough data in it");
        return;
    end

    -- perform the bubble sort
    for i = 1, #travelShortcuts do
        for j = 2, #travelShortcuts do

            -- if the index of the second shortcut is lower than the index of
            -- the first, switch the shortcuts
            if travelShortcuts[j]:GetIndex() < travelShortcuts[j - 1]:GetIndex() then
                temp = travelShortcuts[j - 1];
                travelShortcuts[j - 1] = travelShortcuts[j];
                travelShortcuts[j] = temp;
            end
        end
    end

    return;
end

function TravelWindow:UpdateOpacity()
    self:SetOpacity(settings.mainMinOpacity);
    self.ToggleButton:UpdateOpacity();
end

function TravelWindow:ResetSettings()

    -- close the option window
    self:CloseOptions()

    -- set all saved settings to default values
    settings = {};
    settings.width = self.minWidth;
    settings.height = self.minHeight;
    settings.positionX = Turbine.UI.Display.GetWidth()
    - self:GetWidth() - 50;
    settings.positionY = Turbine.UI.Display.GetHeight()
    - self:GetHeight() - 50 * 1.5;
    settings.buttonPositionX = Turbine.UI.Display.GetWidth()
    - self:GetWidth() - 50;
    settings.buttonPositionY = Turbine.UI.Display.GetHeight()
    - self:GetHeight() - 50 * 1.5;
    settings.hideOnStart = 0;
    settings.hideOnCombat = 0;
    settings.pulldownTravel = 0;
    settings.showButton = 1;
    settings.class = 1;
    settings.race = 1;
    settings.mode = 1;
    settings.filters = 0x0F;
    settings.enabled = {};
    settings.order = {};
    settings.mainMaxOpacity = 1;
    settings.mainMinOpacity = 0.5;
    settings.toggleMaxOpacity = 1;
    settings.toggleMinOpacity = 0.2;

    -- clear the maps
    settings.mapHome = nil;
    settings.mapGlanVraig = nil;

    -- move the toggle button and main window
    self.ToggleButton:SetPosition(settings.buttonPositionX,
    settings.buttonPositionY);
    self:SetPosition(settings.positionX, settings.positionY);
    self:SetSize(settings.width, settings.height);


    -- get the player class and race
    player = Turbine.Gameplay.LocalPlayer.GetInstance();
    playerClass = player:GetClass();
    playerRace = player:GetRace();
    self.racetype = 0;

    -- set the racial travel skill to add
    if (playerRace == Turbine.Gameplay.Race.Dwarf) then
        self.racetype = 3;
    elseif (playerRace == Turbine.Gameplay.Race.Elf) then
        self.racetype = 4;
    elseif (playerRace == Turbine.Gameplay.Race.Hobbit) then
        self.racetype = 2;
    elseif (playerRace == Turbine.Gameplay.Race.Man) then
        self.racetype = 1;
    elseif (playerRace == Turbine.Gameplay.Race.Beorning) then
        self.racetype = 5;
    elseif (playerRace == Turbine.Gameplay.Race.Highelf) then
        self.racetype = 6;
    else
        Turbine.Engine.WriteLine("What race are you?");
        return;
    end

    -- update everything
    self:CheckEnabledSettings()
    self:SetShortcuts();
    self:UpdateSettings();
end

function TravelWindow:AddGVMap()
    -- if the player has a PvMP map, then insert it into the list
    if ((settings.mapGlanVraig ~= nil) and (settings.mapGlanVraig ~= "nil")) then
        self.reloadGVMap = false;
        genLocations:InsertData(2, glanMapString, settings.mapGlanVraig);
    end
end

function TravelWindow:CheckSkills()
    -- loop through all the shortcuts and add those that are enabled
    counter = 1;
    for i = 1, table.getn(travelShortcuts), 1 do
        --if(travelShortcuts[i]:IsEnabled()) then
        --if(hasbit(settings.filters,bit(travelShortcuts[i]:GetTravelType()))) then

        if (TravelWindow:FindSkill(travelShortcuts[i]:GetSkillName())) then
            -- do nothing
        elseif (travelShortcuts[i]:GetSkillName() == "skip") then
            -- do nothing
        else
            Turbine.Shell.WriteLine(skillNotTrainedString .. travelShortcuts[i]:GetName())
        end
        --end
        --end
    end
end

function TravelWindow:FindSkill(name)
    for i = 1, trainedSkills:GetCount(), 1 do
        local skill = Turbine.Gameplay.Skill;
        local skillInfo = Turbine.Gameplay.SkillInfo;
        skill = trainedSkills:GetItem(i);

        if (skill:GetSkillInfo():GetName() == name) then
            return true;
        end
    end

    return false;
end

function TravelWindow:ListTrainedSkills()

    Turbine.Shell.WriteLine("\n\nTrained Skills\n\n");

    for i = 1, trainedSkills:GetCount(), 1 do
        local skill = Turbine.Gameplay.Skill;
        local skillInfo = Turbine.Gameplay.SkillInfo;
        skill = trainedSkills:GetItem(i);

        Turbine.Shell.WriteLine(skill:GetSkillInfo():GetName());
    end
end

function AddCallback(object, event, callback)
    if (object[event] == nil) then
        object[event] = callback;
    else
        if (type(object[event]) == "table") then
            table.insert(object[event], callback);
        else
            object[event] = { object[event], callback };
        end
    end
    return callback;
end