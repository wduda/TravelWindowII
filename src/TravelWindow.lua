import "Turbine";
import "Turbine.Debug";
import "Turbine.Gameplay";
import "Turbine.UI";
import "Turbine.UI.Lotro";
import "TravelWindowII.src.MapWindow"
import "TravelWindowII.src.extensions";
import "TravelWindowII.src.utils.BitOps";
import "TravelWindowII.src.VindarPatch";
import "TravelWindowII.src.EuroNormalize";

--[[ This is the main window for the Travel Window UI      ]] --
--[[ It handles the loading and saving the settings,       ]] --
--[[ creating the lists of travel shortcuts, creates       ]] --
--[[ and handles the context menu.                         ]] --

TravelWindow = class(Turbine.UI.Window);

function TravelWindow:Constructor()
    Turbine.UI.Window.Constructor(self);

    self.reloadGVMap = false;
    self.options = nil;
    self.dirty = true;
    self.isMouseDown = false;
    self.isDragging = false;
    self.isResizing = false;
    self.wPadding = 7;
    self.hPadding = 25;

    -- configure the main window
    self:SetPosition(Settings.positionX, Settings.positionY);
    self:SetSize(Settings.width, Settings.height);
    self:SetText(mainTitleString);
    self:SetBackColor(Turbine.UI.Color(1, 0, 0, 0));
    if (Settings.hideOnStart == 1) then
        self:SetVisible(false);
    else
        self:SetVisible(true);
    end

    -- configure the external toggle button
    self.ToggleButton = TravelWindowII.src.TravelButton(self);

    -- if the player has a PvMP map, then insert it into the list
    -- if ((.mapGlanVraig ~= nil) and (.mapGlanVraig ~= "nil")) then
    -- self.reloadGVMap = true;
    -- genLocations:InsertSkill(2, glanMapString, .mapGlanVraig, "skip");
    -- end

    -- save the player's combat states for managing hiding the window
    -- when the player enters combat
    self.previousCombatState = false;
    self.wasOpenBeforeCombat = false;

    -- create a single context menu to use on all panels
    Menu = SettingsMenu(self);
    Menu:SetSettings(Settings.mode, Settings.filters);

    -- create the tabbed panel to hold all the other panels
    self.MainPanel = TravelWindowII.src.extensions.DPanel();
    self.MainPanel:SetSize(Settings.width - self.wPadding, Settings.height - self.hPadding);
    self.MainPanel:SetPosition(3, 20);
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
    self.ListTab.tabId = 1;
    self.GridTab.tabId = 2;
    self.CaroTab.tabId = 3;
    self.PullTab.tabId = 4;

    -- display the tab that was last selected
    self.MainPanel:SetTab(Settings.mode);
    self.MainPanel:SetSize(self:GetWidth() - self.wPadding, self:GetHeight() - self.hPadding);
    self.MainPanel:UpdateTabs();
    self:UpdateSettings();
    self:SetOpacity(Settings.mainMinOpacity);

    -- track the hidden state of the UI, manage previous states for window and
    -- the button
    self.hidden = false;
    self.currentVisState = self:IsVisible();

    self.titleLabel = Turbine.UI.Label();
    self.titleLabel:SetParent(self);
    self.titleLabel:SetVisible(true);
    self.titleLabel:SetPosition(0, 0);
    self.titleLabel:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleCenter);
    self.titleLabel:SetFont(Turbine.UI.Lotro.Font.TrajanPro15);
    self.titleLabel:SetText("Travel Window II");

    self.resizeLabel = Turbine.UI.Label();
    self.resizeLabel:SetParent(self);
    self.resizeLabel:SetSize(13, 13);
    self.resizeLabel:SetOpacity(0);
    self.resizeLabel:SetZOrder(100); -- put above the shortcuts; which are set to 90

    self.optionsWindow = TravelWindowII.src.OptionsWindow(self);

    local PluginManagerOptionsPanel = Turbine.UI.Control()
    PluginManagerOptionsPanel:SetSize(500, 200)

    local OptionsButton = Turbine.UI.Lotro.Button()
    OptionsButton:SetParent(PluginManagerOptionsPanel)
    OptionsButton:SetPosition(100, 100)
    OptionsButton:SetSize(200,15)
    OptionsButton:SetText(menuOptionsString)
    OptionsButton:SetVisible(true)

    OptionsButton.Click = function()
        self.optionsWindow:SetVisible(true);
    end

    plugin.GetOptionsPanel = function(self)
        return PluginManagerOptionsPanel;
    end

    --[[ Event Handlers ]] --

    -- make sure we listen for updates
    self:SetWantsUpdates(true);
    self:SetWantsKeyEvents(true);

    -- check if our position has changed, and save the settings if so
    self.PositionChanged = function(sender, args)
        local one, two = self:GetPosition();
        Settings.positionX = one;
        Settings.positionY = two;
        self.PullTab:ClosePulldown();
    end

    -- manage hiding the UI
    self.KeyDown = function(sender, args)
        if (args.Action == Turbine.UI.Lotro.Action.Escape) then
            if Settings.ignoreEsc == 0 then
                self:SetVisible(false);
            end
            self.optionsWindow:SetVisible(false);
            self:CloseOptions();
            self:CloseMapWindow();
            if (self.hidden == true) then
                self.hidden = false;
                self:SetVisible(self.currentVisState);
                self.ToggleButton:SetVisible(Settings.showButton == 1);
            end
        elseif (args.Action == Turbine.UI.Lotro.Action.UI_Toggle) then
            if (self.hidden == false) then
                self.currentVisState = self:IsVisible();
                self.hidden = true;
                self:SetVisible(false);
                self.optionsWindow:SetVisible(false);
                self.ToggleButton:SetVisible(false);
                if self.mapWindow ~= nil then
                    self.mapWindow:SetVisible(false);
                end
            else
                self.hidden = false;
                self:SetVisible(self.currentVisState);
                self.ToggleButton:SetVisible(Settings.showButton == 1);
                if self.mapWindow ~= nil then
                    self.mapWindow:SetVisible(true);
                end
            end
        end
    end

    -- check if the combat state of the player changed, in case we want
    -- to hide the window
    IncombatChangedHandler = function(sender, args)
        -- first check if we are going into combat
        if (self.previousCombatState == false) then

            -- then check if the window is visible already, and the player wishes
            -- to hide on combat
            if (Settings.hideOnCombat == 1 and self:IsVisible()) then

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
            if (Settings.hideOnCombat == 1 and self.wasOpenBeforeCombat == true) then

                -- clear the open status, and show the window
                self.wasOpenBeforeCombat = false;
                self:SetVisible(true);
            end

            -- set the previous state for the next check
            self.previousCombatState = false;
        end
    end
    AddCallback(player, "InCombatChanged", IncombatChangedHandler);

    -- if the visible status of the window changes, close the pulldown tab
    self.VisibleChanged = function(sender, args)
        if (self:IsVisible() == false) then
            self.PullTab:ClosePulldown();
        end
    end

    self.MouseClick = function(sender, args)
        if args.Button == Turbine.UI.MouseButton.Right then
            Menu:ShowMenu();
        end

        if Settings.mode == 4 then
            self.PullTab:ClosePulldown();
        end
    end

    -- go to full opacity if mouse is over
    self.MouseEnter = function(sender, args)
        self:SetOpacity(Settings.mainMaxOpacity);
    end

    -- go to low opacity when mouse is not over
    self.MouseLeave = function(sender, args)
        local mX, mY = self:GetMousePosition();
        local winX, winY = self:GetSize();

        if not self.isMouseDown then
            self:SetOpacity(Settings.mainMinOpacity);
        end
    end

    self.MouseDown = function(sender, args)
        self.isMouseDown = true;
        if (args.Button == Turbine.UI.MouseButton.Left) then
            self.dragStartX, self.dragStartY = self:GetMousePosition();
            if Settings.mode == 1 or Settings.mode == 2 then
                local mX, mY = self:GetMousePosition();
                self.resizeStartX, self.resizeStartY = self:GetSize();
                if self.resizeStartX - mX < 14 and self.resizeStartY - mY < 14 then
                    self.isResizing = true;
                end
            end

            if not self.isResizing then
                self.isDragging = true;
            end
        end
    end
    self.MouseMove = function(sender, args)
        if self.isDragging then
            local left, top = self:GetPosition();
            local mX, mY = self:GetMousePosition();
            local x = left + (mX - self.dragStartX);
            local y = top + (mY - self.dragStartY);
            self:SetPosition(x, y);
        elseif self.isResizing then
            local sX, sY = self:GetSize();
            local mX, mY = self:GetMousePosition();
            sX = self.resizeStartX + (mX - self.dragStartX);
            sY = self.resizeStartY + (mY - self.dragStartY);
            if Settings.mode == 2 then
                sX, sY = self.GridTab:FitGridPixels(sX, sY);
            elseif Settings.mode == 1 then
                sX, sY = self.ListTab:FitListPixels(sX, sY);
            end
            self:SetSize(sX, sY);
        end
    end
    self.MouseUp = function(sender, args)
        local mX, mY = self:GetMousePosition();
        local winX, winY = self:GetSize();
        local outsideWindow = mX < 1 or mY < 1 or mX > winX - 1 or mY > winY - 1;
        if outsideWindow then
            self:SetOpacity(Settings.mainMinOpacity);
        end

        self.isMouseDown = false;
        self.isDragging = false;
        self.isResizing = false;
    end
    self.titleLabel.MouseDown = self.MouseDown;
    self.titleLabel.MouseMove = self.MouseMove;
    self.titleLabel.MouseUp = self.MouseUp;
    self.titleLabel.MouseClick = self.MouseClick;
    self.resizeLabel.MouseDown = self.MouseDown;
    self.resizeLabel.MouseMove = self.MouseMove;
    self.resizeLabel.MouseUp = self.MouseUp;
    self.resizeLabel.MouseClick = self.MouseClick;

    self.SizeChanged = function(sender, args)
        if Settings.mode == 1 or Settings.mode == 2 then
            -- only save dimensions for list & grid tabs
            Settings.width = self:GetWidth();
            Settings.height = self:GetHeight();
        end
        self.MainPanel:SetSize(self:GetWidth() - self.wPadding, self:GetHeight() - self.hPadding);
        self.MainPanel:UpdateTabs();
        self.titleLabel:SetSize(self:GetWidth(), 20);
        self.resizeLabel:SetPosition(self:GetWidth() - self.resizeLabel:GetWidth(),
                                     self:GetHeight() - self.resizeLabel:GetHeight());
    end
    self:SizeChanged(); -- explicitly call to ensure correct positioning
end

function SetPlayerRaceKey()
    -- map player race to racial travel skill index for insertion into available travel skills
    if (PlayerRace == Turbine.Gameplay.Race.Dwarf) then
        PlayerRaceKey = 3;
    elseif (PlayerRace == Turbine.Gameplay.Race.Elf) then
        PlayerRaceKey = 4;
    elseif (PlayerRace == Turbine.Gameplay.Race.Hobbit) then
        PlayerRaceKey = 2;
    elseif (PlayerRace == Turbine.Gameplay.Race.Man) then
        PlayerRaceKey = 1;
    elseif (PlayerRace == Turbine.Gameplay.Race.Beorning) then
        PlayerRaceKey = 5;
    elseif (PlayerRace == Turbine.Gameplay.Race.HighElf) then
        PlayerRaceKey = 6;
    elseif (PlayerRace == Turbine.Gameplay.Race.StoutAxe) then
        PlayerRaceKey = 7;
    elseif (PlayerRace == Turbine.Gameplay.Race.RiverHobbit) then
        PlayerRaceKey = 8;
    else
        PlayerRaceKey = 1; -- default to man race to prevent errors
    end
end

function TravelWindow:SetItems()
    if Settings.mode == 1 then
        self.ListTab:SetItems();
    elseif Settings.mode == 2 then
        self.GridTab:SetItems();
    elseif Settings.mode == 3 then
        self.CaroTab:SetItems();
    else
        self.PullTab:SetItems();
    end
end

function TravelWindow:UpdateSize()
    -- update the page that is showing
    if Settings.mode == 1 then
        self.minWidth = 245;
        self.minHeight = 150;
    elseif Settings.mode == 2 then
        self.minWidth = 100;
        self.minHeight = 40;
    elseif Settings.mode == 3 then
        self.minWidth = 150;
        self.minHeight = 75;
    else
        self.minWidth = 360;
        self.minHeight = 65;
    end

    self:SetMinimumSize(self.minWidth, self.minHeight);

    if Settings.mode == 3 or Settings.mode == 4 then
        self:SetSize(self.minWidth, self.minHeight);
    else
        -- check that the window is not smaller than min width
        if (self:GetWidth() < self.minWidth) then
            self:SetWidth(self.minWidth);
        end

        -- check that the window is not smaller than min height
        if (self:GetHeight() < self.minHeight) then
            self:SetHeight(self.minHeight);
        end
        if Settings.mode == 2 then
            self:SetSize(self.GridTab:FitGridPixels(self:GetSize()));
        elseif Settings.mode == 1 then
            self:SetSize(self.ListTab:FitListPixels(self:GetSize()));
        end
    end
end

function TravelWindow:SetMapHome()

    -- also close the options window
    self:CloseOptions();

    -- create the window used to add the map
    self.MapWindow = Turbine.UI.Control();
    self.MapWindow:SetPosition(10, 35);
    self.MapWindow:SetSize(Settings.width - 20, Settings.height - 60);
    self.MapWindow:SetBackColor(Turbine.UI.Color(1, 0.1, 0.1, 0.1));
    self.MapWindow:SetParent(self);
    self.MapWindow:SetZOrder(300);

    -- add a label to the window for instructions
    self.mapLabel = Turbine.UI.Label();
    self.mapLabel:SetForeColor(Turbine.UI.Color(1, 0.2, 0.2, 0.6));
    self.mapLabel:SetPosition(0, 15);
    self.mapLabel:SetSize(Settings.width - 20, self.MapWindow:GetHeight() - 90);
    self.mapLabel:SetParent(self.MapWindow);
    self.mapLabel:SetVisible(true);
    self.mapLabel:SetFont(Turbine.UI.Lotro.Font.Verdana14);
    self.mapLabel:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleLeft);
    self.mapLabel:SetMultiline(true);
    self.mapLabel:SetText("@TODO");

    -- add an empty quickslot to the window
    self.mapQuickSlot1 = Turbine.UI.Lotro.Quickslot();
    self.mapQuickSlot1:SetPosition(self.MapWindow:GetWidth() / 2 - 18, self.MapWindow:GetHeight() - 80);
    self.mapQuickSlot1:SetSize(36, 36);
    self.mapQuickSlot1:SetParent(self.MapWindow);
    self.mapQuickSlot1:SetUseOnRightClick(false);
    self.mapQuickSlot1:SetVisible(true);

    -- add a button to the window
    self.mapButton = Turbine.UI.Lotro.Button();
    self.mapButton:SetSize(60, 50);
    self.mapButton:SetPosition(self.MapWindow:GetWidth() / 2 - self.mapButton:GetWidth() / 2,
                               self.MapWindow:GetHeight() - 35);
    self.mapButton:SetText("OK");
    self.mapButton:SetParent(self.MapWindow);
    self.mapButton:SetVisible(true);

    -- when the button is pressed, update the settings
    -- with the new skill, and reset everything
    self.mapButton.Click = function(sender, args)

        -- check if there is a shortcut in the quickslot
        if (self.mapQuickSlot1:GetShortcut():GetType() ~= Turbine.UI.Lotro.ShortcutType.Undef) then

            -- save the shortcut data to the settings
            self:SaveMapHome(self.mapQuickSlot1:GetShortcut());
        end

        -- update the shortcuts list
        self:UpdateSettings();

        -- close this window
        self.MapWindow:SetVisible(false);
        self.MapWindow = nil;
    end
end

function TravelWindow:SaveMapHome(shortcut)

    local mapItem = shortcut:GetItem();

    -- do this if it is the glan vraig map
    if (string.find(mapItem:GetName(), glanMapItemString)) then

        -- remove the old shortcut if it exists
        if (TravelInfo.gen:IndexByName(glanMapString) == 2) then
            TravelInfo.gen:RemoveSkillAtIndex(2);
        end

        -- set the value
        Settings.mapGlanVraig = shortcut:GetData();

        -- update the location lists
        TravelInfo.gen:InsertSkill(2, glanMapString, Settings.mapGlanVraig);

        -- else, do nothing but report the error
    else
        Turbine.Shell.WriteLine("@TODO");
    end
    -- update and save everything
    self:UpdateSettings();
end

function SetShortcuts()
    CheckEnabledSettings();

    -- set default values
    TravelShortcuts = {};

    -- set the either the travel skills for free people or monsters
    if (PlayerAlignment == Turbine.Gameplay.Alignment.FreePeople) then
        -- set the generic travel items
        AddTravelSkills(TravelInfo.gen, 1);

        -- add the race travel to the list
        table.insert(TravelShortcuts,
                     TravelShortcut(
                            Turbine.UI.Lotro.ShortcutType.Skill,
                            2,
                            TravelInfo.racial.id,
                            TravelInfo.racial.name,
                            TravelInfo.racial.label,
                            TravelInfo.racial.desc));

        -- set the reputation travel items
        AddTravelSkills(TravelInfo.rep, 3);
    else
        -- set the creep travel items
        AddTravelSkills(TravelInfo.creep, 3);
    end

    -- set the class travel items
    local classSkills = TravelInfo:GetClassSkills();
    if classSkills ~= nil then
        AddTravelSkills(classSkills, 4);
    end

    SortShortcuts();
    CheckSkills(false);
end

function AddTravelSkills(skills, filter)
    for i = 1, skills:GetCount() do
        table.insert(TravelShortcuts,
                     TravelShortcut(
                        Turbine.UI.Lotro.ShortcutType.Skill,
                        filter,
                        skills:IdAtIndex(i),
                        skills:NameAtIndex(i),
                        skills:LabelAtIndex(i),
                        skills:DescAtIndex(i)));
    end
end

function CheckEnabledSettings()
    if (PlayerAlignment == Turbine.Gameplay.Alignment.FreePeople) then
        -- update generic travel settings
        AddNewSettings(TravelInfo.gen);

        -- update reputation travel settings
        AddNewSettings(TravelInfo.rep);

        -- update racial travel settings
        local racialId = TravelInfo.racial.id;
        if (Settings.enabled[racialId] == nil) then
            Settings.enabled[racialId] = true;
        end
        if (TableContains(Settings.order, racialId) == false) then
            table.insert(Settings.order, racialId);
        end

        local classSkills = TravelInfo:GetClassSkills();
        if classSkills ~= nil then
            AddNewSettings(classSkills);
        end
    else
        -- update creep travel settings
        AddNewSettings(TravelInfo.creep);
    end
end

function AddNewSettings(skills)
    for i = 1, skills:GetCount() do
        local id = skills:IdAtIndex(i);
        -- if the enabled setting for the skill is nil, set it to true as default
        if (Settings.enabled[id] == nil) then
            Settings.enabled[id] = true;
        end

        -- if the skill is not in the order list, add it
        if (TableContains(Settings.order, id) == false) then
            table.insert(Settings.order, id);
        end
    end
end

-- simple function to open the options window
function TravelWindow:OpenOptions()
    self.optionsWindow:SetVisible(true);
end

-- function to close the options window if it exists
function TravelWindow:CloseOptions()
    if (self.options ~= nil) then
        self.options:SetVisible(false);
    end
    self.options = nil;
end

function TravelWindow:OpenMapWindow(map)
    self:CloseMapWindow();
    self.mapWindow = TravelWindowII.src.MapWindow(self, map);
    self.mapWindow:SetVisible(true);
end

-- function to close the current map window
function TravelWindow:CloseMapWindow()
    if (self.mapWindow ~= nil) then
        self.mapWindow:SetVisible(false);
        self.mapWindow:Close();
    end
    self.mapWindow = nil;
end

-- function to check if a table contains a specific element
function TableContains(tableToSearch, elementToSearchFor)
    for i, value in pairs(tableToSearch) do
        if (value == elementToSearchFor) then
            return true;
        end
    end
    return false;
end

-- function to check if a table contains a specific element index
function TableIndex(tableToSearch, elementToSearchFor)
    for i, value in pairs(tableToSearch) do
        if (value == elementToSearchFor) then
            return i;
        end
    end
    return 0;
end

-- TravelShortcuts are sorted by an internal index value
function SortShortcuts()
    -- perform an optimized bubble sort
    local n = #TravelShortcuts;
    while n > 2 do
        local new_n = 1;
        for i = 2, n do
            if TravelShortcuts[i - 1]:GetIndex() > TravelShortcuts[i]:GetIndex() then
                local temp = TravelShortcuts[i - 1];
                TravelShortcuts[i - 1] = TravelShortcuts[i];
                TravelShortcuts[i] = temp;
                new_n = i;
            end
        end
        n = new_n;
    end
end

function TravelWindow:UpdateOpacity()
    self:SetOpacity(Settings.mainMinOpacity);
    self.ToggleButton:UpdateOpacity();
end

function TravelWindow:SetOpacity(value)
    Turbine.UI.Window.SetOpacity(self, value);
    -- quickslots in stretch mode do not get updated opacity from
    -- the parent; update them here
    self.CaroTab:SetOpacityItems(value);
end

function LoadSettings()
    -- load the self.settings
    -- if a value is not available, set a default value

    -- load TWII settings file
    pcall(function()
        SettingsStrings = PatchDataLoad(Turbine.DataScope.Character, "TravelWindowIISettings");
    end);

    -- save a daily backup of settings
    if (SettingsStrings) then
        SettingsStrings.backupTime = "#" .. Turbine.Engine.GetGameTime();
        local dateInfo = Turbine.Engine.GetDate();
        PatchDataSave(Turbine.DataScope.Character, "TravelWindowIISettings_backup" .. dateInfo.DayOfWeek,
                      SettingsStrings);
    end

    -- try importing Travel Window I settings if new settings were not found
    local importOldSettings = false;
    if (SettingsStrings == nil) then
        local result;
        importOldSettings, result = pcall(function()
            SettingsStrings = PatchDataLoad(Turbine.DataScope.Character, "TravelWindowSettings");
        end);
    end

    if (type(SettingsStrings) ~= "table") then
        SettingsStrings = {};
    end

    if (not SettingsStrings.lastLoadedVersion or SettingsStrings.lastLoadedVersion == "nil") then
        SettingsStrings.lastLoadedVersion = tostring(Plugins["Travel Window II"]:GetVersion());
    end

    if (not SettingsStrings.width or SettingsStrings.width == "nil") then
        SettingsStrings.width = tostring(0);
    end

    if (not SettingsStrings.height or SettingsStrings.height == "nil") then
        SettingsStrings.height = tostring(0);
    end

    if (not SettingsStrings.positionX or SettingsStrings.positionX == "nil") then
        SettingsStrings.positionX = tostring(Turbine.UI.Display.GetWidth() * 0.75);
    end

    if (not SettingsStrings.positionY or SettingsStrings.positionY == "nil") then
        SettingsStrings.positionY = tostring(Turbine.UI.Display.GetHeight() * 0.75);
    end

    local screenWidth = Turbine.UI.Display.GetWidth();
    local screenHeight = Turbine.UI.Display.GetHeight();
    if not SettingsStrings.buttonRelativeX or SettingsStrings.buttonRelativeX == "nil" then
        if SettingsStrings.buttonPositionX and SettingsStrings.buttonPositionX ~= "nil" and
                tonumber(SettingsStrings.buttonPositionX) < screenWidth then
            -- not perfect, but assuming the same resolution, this will approximately convert to a relative value
            SettingsStrings.buttonRelativeX = tonumber(SettingsStrings.buttonPositionX) / screenWidth;
            if SettingsStrings.buttonRelativeX > 1.0 then
                SettingsStrings.buttonRelativeX = 0.95;
            end
            SettingsStrings.buttonRelativeX = tostring(SettingsStrings.buttonRelativeX);
        else
            SettingsStrings.buttonRelativeX = "0.95";
        end
    end

    if not SettingsStrings.buttonRelativeY or SettingsStrings.buttonRelativeY == "nil" then
        if SettingsStrings.buttonPositionY and SettingsStrings.buttonPositionY ~= "nil" and
                tonumber(SettingsStrings.buttonPositionY) < screenHeight then
            -- not perfect, but assuming the same resolution, this will approximately convert to a relative value
            SettingsStrings.buttonRelativeY = tonumber(SettingsStrings.buttonPositionY) / screenHeight;
            if SettingsStrings.buttonRelativeY > 1.0 then
                SettingsStrings.buttonRelativeY = 0.75;
            end
            SettingsStrings.buttonRelativeY = tostring(SettingsStrings.buttonRelativeY);
        else
            SettingsStrings.buttonRelativeY = "0.75";
        end
    end

    if (not SettingsStrings.hideOnStart or SettingsStrings.hideOnStart == "nil") then
        SettingsStrings.hideOnStart = tostring(0);
    end

    if (not SettingsStrings.hideOnCombat or SettingsStrings.hideOnCombat == "nil") then
        SettingsStrings.hideOnCombat = tostring(0);
    end

    if (not SettingsStrings.pulldownTravel or SettingsStrings.pulldownTravel == "nil") then
        SettingsStrings.pulldownTravel = tostring(0);
    end

    if (not SettingsStrings.hideOnTravel or SettingsStrings.hideOnTravel == "nil") then
        SettingsStrings.hideOnTravel = tostring(0);
    end

    if (not SettingsStrings.ignoreEsc or SettingsStrings.ignoreEsc == "nil") then
        SettingsStrings.ignoreEsc = tostring(0);
    end

    if (not SettingsStrings.showButton or SettingsStrings.showButton == "nil") then
        SettingsStrings.showButton = tostring(1);
    end

    if (not SettingsStrings.mode or SettingsStrings.mode == "nil") then
        SettingsStrings.mode = tostring(2);
    end

    if (not SettingsStrings.filters or SettingsStrings.filters == "nil") then
        SettingsStrings.filters = tostring(0x0F);
    end

    if (not SettingsStrings.enabled or importOldSettings) then
        SettingsStrings.enabled = {};
    end

    if ((not SettingsStrings.order) or importOldSettings) then
        SettingsStrings.order = {};
    end

    if (not SettingsStrings.mainMaxOpacity or SettingsStrings.mainMaxOpacity == "nil") then
        SettingsStrings.mainMaxOpacity = tostring(1);
    end

    if (not SettingsStrings.mainMinOpacity or SettingsStrings.mainMinOpacity == "nil") then
        SettingsStrings.mainMinOpacity = tostring(0.5);
    end

    if (not SettingsStrings.toggleMaxOpacity or SettingsStrings.toggleMaxOpacity == "nil") then
        SettingsStrings.toggleMaxOpacity = tostring(1);
    end

    if (not SettingsStrings.toggleMinOpacity or SettingsStrings.toggleMinOpacity == "nil") then
        SettingsStrings.toggleMinOpacity = tostring(0.2);
    end

    -- convert from strings if necessary
    if (type(SettingsStrings.width) == "string") then
        Settings.width = tonumber(SettingsStrings.width);
    else
        Settings.width = SettingsStrings.width;
    end

    if (type(SettingsStrings.height) == "string") then
        Settings.height = tonumber(SettingsStrings.height);
    else
        Settings.height = SettingsStrings.height;
    end

    if (type(SettingsStrings.positionX) == "string") then
        Settings.positionX = tonumber(SettingsStrings.positionX);
    else
        Settings.positionX = SettingsStrings.positionX;
    end

    if (type(SettingsStrings.positionY) == "string") then
        Settings.positionY = tonumber(SettingsStrings.positionY);
    else
        Settings.positionY = SettingsStrings.positionY;
    end

    if (type(SettingsStrings.buttonRelativeX) == "string") then
        Settings.buttonRelativeX = tonumber(SettingsStrings.buttonRelativeX);
    else
        Settings.buttonRelativeX = SettingsStrings.buttonRelativeX;
    end

    if (type(SettingsStrings.buttonRelativeY) == "string") then
        Settings.buttonRelativeY = tonumber(SettingsStrings.buttonRelativeY);
    else
        Settings.buttonRelativeY = SettingsStrings.buttonRelativeY;
    end

    if (type(SettingsStrings.hideOnStart) == "string") then
        Settings.hideOnStart = tonumber(SettingsStrings.hideOnStart);
    else
        Settings.hideOnStart = SettingsStrings.hideOnStart;
    end

    if (type(SettingsStrings.hideOnCombat) == "string") then
        Settings.hideOnCombat = tonumber(SettingsStrings.hideOnCombat);
    else
        Settings.hideOnCombat = SettingsStrings.hideOnCombat;
    end

    if (type(SettingsStrings.pulldownTravel) == "string") then
        Settings.pulldownTravel = tonumber(SettingsStrings.pulldownTravel);
    else
        Settings.pulldownTravel = SettingsStrings.pulldownTravel;
    end

    if (type(SettingsStrings.hideOnTravel) == "string") then
        Settings.hideOnTravel = tonumber(SettingsStrings.hideOnTravel);
    else
        Settings.hideOnTravel = SettingsStrings.hideOnTravel;
    end

    if (type(SettingsStrings.ignoreEsc) == "string") then
        Settings.ignoreEsc = tonumber(SettingsStrings.ignoreEsc);
    else
        Settings.ignoreEsc = SettingsStrings.ignoreEsc;
    end

    if (type(SettingsStrings.showButton) == "string") then
        Settings.showButton = tonumber(SettingsStrings.showButton);
    else
        Settings.showButton = SettingsStrings.showButton;
    end

    if (type(SettingsStrings.mode) == "string") then
        Settings.mode = tonumber(SettingsStrings.mode);
    else
        Settings.mode = SettingsStrings.mode;
    end

    if (type(SettingsStrings.filters) == "string") then
        Settings.filters = tonumber(SettingsStrings.filters);
    else
        Settings.filters = SettingsStrings.filters;
    end

    if (type(SettingsStrings.mainMaxOpacity) == "string") then
        Settings.mainMaxOpacity = EuroNormalize(SettingsStrings.mainMaxOpacity);
    else
        Settings.mainMaxOpacity = SettingsStrings.mainMaxOpacity;
    end

    if (type(SettingsStrings.mainMinOpacity) == "string") then
        Settings.mainMinOpacity = EuroNormalize(SettingsStrings.mainMinOpacity);
    else
        Settings.mainMinOpacity = SettingsStrings.mainMinOpacity;
    end

    if (type(SettingsStrings.toggleMaxOpacity) == "string") then
        Settings.toggleMaxOpacity = EuroNormalize(SettingsStrings.toggleMaxOpacity);
    else
        Settings.toggleMaxOpacity = SettingsStrings.toggleMaxOpacity;
    end

    if (type(SettingsStrings.toggleMinOpacity) == "string") then
        Settings.toggleMinOpacity = EuroNormalize(SettingsStrings.toggleMinOpacity);
    else
        Settings.toggleMinOpacity = SettingsStrings.toggleMinOpacity;
    end

    if (SettingsStrings.mapGlanVraig ~= nil) then
        Settings.mapGlanVraig = SettingsStrings.mapGlanVraig;
    end

    Settings.lastLoadedVersion = SettingsStrings.lastLoadedVersion;
    Settings.enabled = SettingsStrings.enabled;

    local convertTableIndex = false;
    for i, v in pairs(SettingsStrings.order) do
        if (type(i) == "string") then
            convertTableIndex = true;
        end
    end

    if (convertTableIndex) then
        OrderTableNumberIndex();
    else
        Settings.order = SettingsStrings.order;
    end
end

function SaveSettings()

    -- make sure to delete old settings to delete unused fields
    SettingsStrings = {};
    -- convert the settings to strings
    SettingsStrings.lastLoadedVersion = tostring(Settings.lastLoadedVersion);
    SettingsStrings.height = tostring(Settings.height);
    SettingsStrings.width = tostring(Settings.width);
    SettingsStrings.positionX = tostring(Settings.positionX);
    SettingsStrings.positionY = tostring(Settings.positionY);
    SettingsStrings.buttonRelativeX = tostring(Settings.buttonRelativeX);
    SettingsStrings.buttonRelativeY = tostring(Settings.buttonRelativeY);
    SettingsStrings.hideOnStart = tostring(Settings.hideOnStart);
    SettingsStrings.hideOnCombat = tostring(Settings.hideOnCombat);
    SettingsStrings.pulldownTravel = tostring(Settings.pulldownTravel);
    SettingsStrings.hideOnTravel = tostring(Settings.hideOnTravel);
    SettingsStrings.ignoreEsc = tostring(Settings.ignoreEsc);
    SettingsStrings.showButton = tostring(Settings.showButton);
    SettingsStrings.mode = tostring(Settings.mode);
    SettingsStrings.filters = tostring(Settings.filters);
    SettingsStrings.mainMaxOpacity = tostring(Settings.mainMaxOpacity);
    SettingsStrings.mainMinOpacity = tostring(Settings.mainMinOpacity);
    SettingsStrings.toggleMaxOpacity = tostring(Settings.toggleMaxOpacity);
    SettingsStrings.toggleMinOpacity = tostring(Settings.toggleMinOpacity);
    SettingsStrings.enabled = Settings.enabled;
    SettingsStrings.mapGlanVraig = tostring(Settings.mapGlanVraig);

    OrderTableStringIndex();

    -- save the settings
    PatchDataSave(Turbine.DataScope.Character, "TravelWindowIISettings", SettingsStrings);
end

function TravelWindow:UpdateSettings()

    -- get some settings from the menu
    local prevMode = Settings.mode;
    Settings.mode, Settings.filters = Menu:GetSettings();
    if prevMode ~= Settings.mode then
        self.dirty = true;
        if (prevMode == 3 or prevMode == 4) and (Settings.mode == 1 or Settings.mode == 2) then
            -- restore previous size
            self:SetSize(Settings.width, Settings.height);
        end
    end

    -- set which page of the tab panel to show
    self.MainPanel:SetTab(Settings.mode);
    self:SetItems();
    self:UpdateSize();

    self.MainPanel:SetSize(self:GetWidth() - self.wPadding, self:GetHeight() - self.hPadding);
    self.MainPanel:UpdateTabs();
end

function TravelWindow:ResetSettings()
    -- close the option window
    self:CloseOptions()

    -- set all saved settings to default values
    Settings = {};
    Settings.lastLoadedVersion = Plugins["Travel Window II"]:GetVersion();
    Settings.width = self.minWidth;
    Settings.height = self.minHeight;
    Settings.positionX = Turbine.UI.Display.GetWidth() - self:GetWidth() - 50;
    Settings.positionY = Turbine.UI.Display.GetHeight() - self:GetHeight() - 50 * 1.5;
    Settings.buttonRelativeX = 0.95;
    Settings.buttonRelativeY = 0.75;
    Settings.hideOnStart = 0;
    Settings.hideOnCombat = 0;
    Settings.pulldownTravel = 0;
    Settings.hideOnTravel = 0;
    Settings.ignoreEsc = 0;
    Settings.showButton = 1;
    Settings.mode = 2;
    Settings.filters = 0x0F;
    Settings.enabled = {};
    Settings.order = {};
    Settings.mainMaxOpacity = 1;
    Settings.mainMinOpacity = 0.5;
    Settings.toggleMaxOpacity = 1;
    Settings.toggleMinOpacity = 0.5;

    -- clear the maps
    Settings.mapGlanVraig = nil;

    -- move the toggle button and main window
    local buttonPositionX = Turbine.UI.Display.GetWidth() * SettingsStrings.buttonRelativeX;
    local buttonPositionY = Turbine.UI.Display.GetHeight() * SettingsStrings.buttonRelativeY;
    self.ToggleButton:SetPosition(buttonPositionX, buttonPositionY);
    self:SetPosition(Settings.positionX, Settings.positionY);
    self:SetSize(Settings.width, Settings.height);

    -- update everything
    SetShortcuts();
    self:UpdateSettings();
end

function OrderTableStringIndex()

    SettingsStrings.order = {};

    for i, v in ipairs(Settings.order) do
        SettingsStrings.order[tostring(i)] = v;
    end
end

function OrderTableNumberIndex()

    Settings.order = {};

    for i, v in pairs(SettingsStrings.order) do
        Settings.order[tonumber(i)] = v;
    end
end

function TravelWindow:AddGVMap()
    -- if the player has a PvMP map, then insert it into the list
    if ((Settings.mapGlanVraig ~= nil) and (Settings.mapGlanVraig ~= "nil")) then
        self.reloadGVMap = false;
        TravelInfo.gen:InsertSkill(2, glanMapString, Settings.mapGlanVraig, "Glan Vraig");
    end
end

function CheckSkills(report)
    local newShortcut = false;
    -- loop through all the shortcuts and list those those that are not learned
    for i = 1, #TravelShortcuts, 1 do
        local wasFound = TravelShortcuts[i].found;
        if (FindSkill(TravelShortcuts[i])) then
            if not wasFound then
                newShortcut = true;
            end
        elseif report then
            Turbine.Shell.WriteLine(skillNotTrainedString .. TravelShortcuts[i]:GetName())
        end
    end

    if newShortcut and NewShortcutEvent then
        NewShortcutEvent();
    end
end

function FindSkill(shortcut)
    if shortcut.found then
        return true;
    end

    for i = 1, TrainedSkills:GetCount(), 1 do
        local skillInfo = TrainedSkills:GetItem(i):GetSkillInfo();
        if skillInfo:GetName() == shortcut:GetName() then
            local desc = shortcut:GetDescription();
            if desc ~= nil then
                if string.match(skillInfo:GetDescription(), desc) then
                    shortcut.found = true;
                    return true;
                end
            else
                shortcut.found = true;
                return true;
            end
        end
    end

    return false;
end

function ListTrainedSkills()

    Turbine.Shell.WriteLine("\n\nTrained Skills\n\n");

    for i = 1, TrainedSkills:GetCount(), 1 do
        local skill = Turbine.Gameplay.Skill;
        local skillInfo = Turbine.Gameplay.SkillInfo;
        skill = TrainedSkills:GetItem(i);

        Turbine.Shell.WriteLine(skill:GetSkillInfo():GetName());

    end
end

-- for debug purposes
function TravelWindow:DoDump()
    Turbine.Debug.Table.Dump(TravelWindowII.src);
end

function AddCallback(object, event, callback)
    if (object[event] == nil) then
        object[event] = callback;
    else
        if (type(object[event]) == "table") then
            table.insert(object[event], callback);
        else
            object[event] = {object[event], callback};
        end
    end
    return callback;
end

-- for debug purposes
function TravelWindow:ManualSkillScan()
    local last = 0;
    skillWindow=Turbine.UI.Lotro.Window()
    skillWindow.cols=math.floor((Turbine.UI.Display:GetWidth()-10)/100)
    skillWindow.rows=math.floor((Turbine.UI.Display:GetHeight()-105)/62)
    skillWindow:SetSize(Turbine.UI.Display:GetWidth(),Turbine.UI.Display:GetHeight())
    skillWindow:SetText("Skill Explorer")
    skillWindow.StartCaption=Turbine.UI.Label()
    skillWindow.StartCaption:SetParent(skillWindow)
    skillWindow.StartCaption:SetText("Start:")
    skillWindow.StartCaption:SetPosition(10,45)
    skillWindow.StartCaption:SetSize(50,20)
    skillWindow.Start=Turbine.UI.Lotro.TextBox()
    skillWindow.Start:SetParent(skillWindow)
    skillWindow.Start:SetPosition(65,45)
    skillWindow.Start:SetSize(100,20)
    skillWindow.Start:SetFont(Turbine.UI.Lotro.Font.Verdana16)
    skillWindow.Prev=Turbine.UI.Lotro.Button()
    skillWindow.Prev:SetParent(skillWindow)
    skillWindow.Prev:SetSize(100,20)
    skillWindow.Prev:SetPosition(170,45)
    skillWindow.Prev:SetText("Previous")
    skillWindow.Prev.Click=function()
        local start=tonumber(skillWindow.Start:GetText())
        if start==nil then start=0 end
        start=start-skillWindow.rows*skillWindow.cols
        if start<0 then start=0 end
        skillWindow.Start:SetText(string.format("0x%x",start))
        skillWindow.refresh()
    end
    skillWindow.Show=Turbine.UI.Lotro.Button()
    skillWindow.Show:SetParent(skillWindow)
    skillWindow.Show:SetSize(100,20)
    skillWindow.Show:SetPosition(275,45)
    skillWindow.Show:SetText("Refresh")
    skillWindow.Show.Click=function()
        skillWindow.refresh()
    end
    skillWindow.Next=Turbine.UI.Lotro.Button()
    skillWindow.Next:SetParent(skillWindow)
    skillWindow.Next:SetSize(100,20)
    skillWindow.Next:SetPosition(380,45)
    skillWindow.Next:SetText("Next")
    skillWindow.Next.Click=function()
        local start=tonumber(skillWindow.Start:GetText())
        if start==nil then start=0 end
        if last == 0 then
            start=start+skillWindow.rows*skillWindow.cols
        else
            start = last
        end
        skillWindow.Start:SetText(string.format("0x%x",start))
        skillWindow.refresh()
    end
    skillWindow:SetVisible(true)
    skillWindow.QS={}
    for row=1,skillWindow.rows do
        skillWindow.QS[row]={}
        for col=1,skillWindow.cols do
            skillWindow.QS[row][col]=Turbine.UI.Lotro.Quickslot()
            local qs=skillWindow.QS[row][col]
            qs:SetParent(skillWindow)
            qs:SetSize(34,34)
            qs:SetPosition(col*100-32, row*62+23)
            qs.label=Turbine.UI.Label()
            qs.label:SetParent(skillWindow)
            qs.label:SetSize(100,20)
            qs.label:SetPosition(col*100-32, row*62+57)
        end
    end
    skillWindow.refresh=function()
        local start=tonumber(skillWindow.Start:GetText())
        if start==nil then start=0 end

        for row=1,skillWindow.rows do
            local err = 0;
            for col=1,skillWindow.cols do
                repeat
                    local qs=skillWindow.QS[row][col]
                    local sc=Turbine.UI.Lotro.Shortcut();
                    sc:SetType(Turbine.UI.Lotro.ShortcutType.Skill)
                    local val=string.format("0x%x",start);
                    start = start + 1;
                    sc:SetData(val)
                    local success, result=pcall(Turbine.UI.Lotro.Quickslot.SetShortcut,qs,sc)
                    qs:SetVisible(success)
                    qs.label:SetText(val)
                    if not success then err = err + 1 end
                until success or err > 10000
            end
        end
        last = start;
    end
    skillWindow.Start:SetText("0x700697F2")
end
