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

TravelWindow = class(Turbine.UI.Lotro.Window);

function TravelWindow:Constructor()
    Turbine.UI.Lotro.Window.Constructor(self);

    DefAlpha = 0.92;
    Settings = {};
    SettingsStrings = {};
    TravelShortcuts = {}; -- put all the shortcuts into one table
    TrainedSkills = Turbine.Gameplay.SkillList; -- TODO: update list on window open or maybe a timer

    self.reloadGVMap = false;
    self.options = nil;
    self.dirty = true;
    self.isMouseDown = false;
    self.isResizing = false;

    -- create the lists of travel locations and the shortcuts
    -- that are used to execute them
    TravelInfo = TravelDictionaries();

    -- load the player saved settings
    self:LoadSettings();

    -- configure the main window
    self:SetPosition(Settings.positionX, Settings.positionY);
    self:SetSize(Settings.width, Settings.height);
    self:SetText(mainTitleString);
    self:SetOpacity(Settings.mainMinOpacity);
    self:SetResizable(true);
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

    -- redo the counts
    TravelInfo:GetCounts();

    -- get the player class and race
    player = Turbine.Gameplay.LocalPlayer.GetInstance();
    PlayerClass = player:GetClass();
    PlayerAlignment = player:GetAlignment();
    PlayerRace = player:GetRace();

    -- set the racial index used later in multiple places
    self:SetPlayerRaceKey();

    -- get the list of trained skills the player has
    if (Turbine.Gameplay.LocalPlayer.GetTrainedSkills ~= nil) then
        TrainedSkills = player:GetTrainedSkills();
    end

    -- save the player's combat states for managing hiding the window
    -- when the player enters combat
    self.previousCombatState = false;
    self.wasOpenBeforeCombat = false;

    -- set up all the shortcuts
    self:CheckEnabledSettings();
    self:SetShortcuts();

    -- create a single context menu to use on all panels
    Menu = SettingsMenu(self);
    Menu:SetSettings(Settings.mode, Settings.filters);

    -- create the tabbed panel to hold all the other panels
    self.MainPanel = TravelWindowII.src.extensions.DPanel();
    self.MainPanel:SetSize(Settings.width - 20, Settings.height - 60);
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
    self.ListTab.tabId = 1;
    self.GridTab.tabId = 2;
    self.CaroTab.tabId = 3;
    self.PullTab.tabId = 4;

    -- display the tab that was last selected
    self.MainPanel:SetTab(Settings.mode);
    self.MainPanel:SetSize(self:GetWidth() - 20, self:GetHeight() - 60);
    self.MainPanel:UpdateTabs();
    self:CheckSkills(false);
    self:UpdateSettings();

    -- track the hidden state of the UI, manage previous states for window and
    -- the button
    self.hidden = false;
    self.currentVisState = self:IsVisible();

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
            self:SetVisible(false);
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
        else
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
    end

    self.MouseUp = function(sender, args)
        local mX, mY = self:GetMousePosition();
        local winX, winY = self:GetSize();
        local outsideWindow = mX < 1 or mY < 1 or mX > winX - 1 or mY > winY - 1;

        if outsideWindow then
            self:SetOpacity(Settings.mainMinOpacity);
        end

        self.isMouseDown = false;
        self.isResizing = false;
    end

    self.SizeChanged = function(sender, args)
        if self.isMouseDown then
            self.isResizing = true;
        end
        if Settings.mode == 1 or Settings.mode == 2 then
            -- only save dimensions for list & grid tabs
            Settings.width = self:GetWidth();
            Settings.height = self:GetHeight();
        end
        self.MainPanel:SetSize(self:GetWidth() - 20, self:GetHeight() - 60);
        self.MainPanel:UpdateTabs();
    end

    Plugins["Travel Window II"].Load = function(sender, args)
        Turbine.Shell.WriteLine("<u><rgb=#DAA520>Travel Window II " .. Plugins["Travel Window II"]:GetVersion() ..
                                " by Hyoss</rgb></u>");

        MapWindow:VerifyMapSkillIds("Hunter");
        MapWindow:VerifyMapSkillIds("Warden");
        MapWindow:VerifyMapSkillIds("Mariner");
        MapWindow:VerifyMapSkillIds("Reputation");
    end
end

function TravelWindow:SetPlayerRaceKey()
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
        self.minWidth = 200;
        self.minHeight = 100;
    elseif Settings.mode == 3 then
        self.minWidth = 200;
        self.minHeight = 110;
    else
        self.minWidth = 360;
        self.minHeight = 150;
    end

    self:SetMinimumSize(self.minWidth, self.minHeight);

    if Settings.mode == 3 or Settings.mode == 4 then
        self:SetResizable(false);
        self:SetSize(self.minWidth, self.minHeight);
    else
        self:SetResizable(true);

        -- check that the window is not smaller than min width
        if (self:GetWidth() < self.minWidth) then
            self:SetWidth(self.minWidth);
        end

        -- check that the window is not smaller than min height
        if (self:GetHeight() < self.minHeight) then
            self:SetHeight(self.minHeight);
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
        if (genLocations:IndexByName(glanMapString) == 2) then
            genLocations:RemoveSkillAtIndex(2);
        end

        -- set the value
        Settings.mapGlanVraig = shortcut:GetData();

        -- update the location lists
        genLocations:InsertData(2, glanMapString, Settings.mapGlanVraig);
        TravelInfo:GetCounts();

        -- else, do nothing but report the error
    else
        Turbine.Shell.WriteLine("@TODO");
    end
    -- update and save everything
    self:UpdateSettings();
end

function TravelWindow:SetShortcuts()
    -- set default values
    TravelShortcuts = {};
    local sType = Turbine.UI.Lotro.ShortcutType.Skill;
    local shortcutIndex = 1;

    -- set the either the travel skills for free people or monsters
    if (PlayerAlignment == Turbine.Gameplay.Alignment.FreePeople) then
        -- set the generic travel items
        for i = 1, travelCount[3], 1 do
            -- get the order number for the item
            shortcutIndex = self:TableIndex(Settings.order, genLocations:IdAtIndex(i));

            -- set the shortcut for the quickslot, check
            -- if the shortcut is the glan vraig map or not
            if (string.len(genLocations:IdAtIndex(i)) > 12) then
                local sItem = Turbine.UI.Lotro.ShortcutType.Item;
                table.insert(TravelShortcuts,
                             TravelShortcut(sItem, genLocations:IdAtIndex(i), genLocations:NameAtIndex(i), 1,
                                            shortcutIndex, Settings.enabled[genLocations:IdAtIndex(i)],
                                            genLocations:LabelAtIndex(i)));
            else
                table.insert(TravelShortcuts,
                             TravelShortcut(sType, genLocations:IdAtIndex(i), genLocations:NameAtIndex(i), 1,
                                            shortcutIndex, Settings.enabled[genLocations:IdAtIndex(i)],
                                            genLocations:LabelAtIndex(i)));
            end
        end

        -- add the race travel to the list
        local racialShortcutIndex = self:TableIndex(Settings.order, racialLocations:IdAtIndex(PlayerRaceKey));
        table.insert(TravelShortcuts,
                     TravelShortcut(sType, racialLocations:IdAtIndex(PlayerRaceKey),
                                    racialLocations:NameAtIndex(PlayerRaceKey), 2, racialShortcutIndex,
                                    Settings.enabled[racialLocations:IdAtIndex(PlayerRaceKey)],
                                    racialLocations:LabelAtIndex(PlayerRaceKey)));

        -- set the reputation travel items
        for i = 1, travelCount[4], 1 do
            shortcutIndex = self:TableIndex(Settings.order, repLocations:IdAtIndex(i));
            table.insert(TravelShortcuts,
                         TravelShortcut(sType, repLocations:IdAtIndex(i), repLocations:NameAtIndex(i), 3, shortcutIndex,
                                        Settings.enabled[repLocations:IdAtIndex(i)], repLocations:LabelAtIndex(i),
                                        repLocations:DescAtIndex(i)));
        end
    else
        -- set the creep travel items
        for i = 1, travelCount[6], 1 do
            shortcutIndex = self:TableIndex(Settings.order, creepLocations:IdAtIndex(i));
            table.insert(TravelShortcuts,
                         TravelShortcut(sType, creepLocations:IdAtIndex(i), creepLocations:NameAtIndex(i), 3,
                                        shortcutIndex, Settings.enabled[creepLocations:IdAtIndex(i)],
                                        creepLocations:LabelAtIndex(i)));
        end
    end

    -- set the hunter travel items
    if (PlayerClass == Turbine.Gameplay.Class.Hunter) then
        for i = 1, travelCount[1], 1 do
            shortcutIndex = self:TableIndex(Settings.order, hunterLocations:IdAtIndex(i));
            table.insert(TravelShortcuts,
                         TravelShortcut(sType, hunterLocations:IdAtIndex(i), hunterLocations:NameAtIndex(i), 4,
                                        shortcutIndex, Settings.enabled[hunterLocations:IdAtIndex(i)],
                                        hunterLocations:LabelAtIndex(i), hunterLocations:DescAtIndex(i)));
        end
    end

    -- set the warden travel items
    if (PlayerClass == Turbine.Gameplay.Class.Warden) then
        for i = 1, travelCount[2], 1 do
            shortcutIndex = self:TableIndex(Settings.order, wardenLocations:IdAtIndex(i));
            table.insert(TravelShortcuts,
                         TravelShortcut(sType, wardenLocations:IdAtIndex(i), wardenLocations:NameAtIndex(i), 4,
                                        shortcutIndex, Settings.enabled[wardenLocations:IdAtIndex(i)],
                                        wardenLocations:LabelAtIndex(i), wardenLocations:DescAtIndex(i)));
        end
    end

    -- set the mariner travel items
    if (PlayerClass == Turbine.Gameplay.Class.Mariner) then
        for i = 1, travelCount[7], 1 do
            shortcutIndex = self:TableIndex(Settings.order, marinerLocations:IdAtIndex(i));
            table.insert(TravelShortcuts,
                         TravelShortcut(sType, marinerLocations:IdAtIndex(i), marinerLocations:NameAtIndex(i), 4,
                                        shortcutIndex, Settings.enabled[marinerLocations:IdAtIndex(i)],
                                        marinerLocations:LabelAtIndex(i), marinerLocations:DescAtIndex(i)));
        end
    end

    -- sort the shortcuts
    self:SortShortcuts()
end

function TravelWindow:CheckEnabledSettings()
    -- count the min number of items that should be in the list
    ItemCount = 0;
    if (PlayerAlignment == Turbine.Gameplay.Alignment.FreePeople) then
        -- generic skills + reputation skills + one racial skill
        ItemCount = travelCount[3] + travelCount[4] + 1;
        if (PlayerClass == Turbine.Gameplay.Class.Hunter) then
            -- hunters have hunter skills
            ItemCount = ItemCount + travelCount[1];
        elseif (PlayerClass == Turbine.Gameplay.Class.Warden) then
            -- wardens have warden skills
            ItemCount = ItemCount + travelCount[2]
        elseif (PlayerClass == Turbine.Gameplay.Class.Mariner) then
            -- mariners have mariner skills
            ItemCount = ItemCount + travelCount[7]
        end
    else
        -- monster player skills
        ItemCount = travelCount[6] + 1;
    end

    -- remove superfluous entries in order list in case skills get deleted from game
    if (#Settings.order > ItemCount) then
        for id, order in pairs(Settings.order) do
            if (not genLocations:VerifyId(id) and not wardenLocations:VerifyId(id) and not repLocations:VerifyId(id) and
                not hunterLocations:VerifyId(id) and not marinerLocations:VerifyId(id)) then
                Settings.order[id] = nil;
            end
        end
    end

    -- remove superfluous entries in enabled list in case skills get deleted from game
    if (#Settings.enabled > ItemCount) then
        for id, status in pairs(Settings.enabled) do
            if (not genLocations:VerifyId(id) and not wardenLocations:VerifyId(id) and not repLocations:VerifyId(id) and
                not hunterLocations:VerifyId(id) and not marinerLocations:VerifyId(id)) then
                Settings.enabled[id] = nil;
            end
        end
    end

    -- need to find the highest sort number now
    local counter = #Settings.order + 1;

    if (PlayerAlignment == Turbine.Gameplay.Alignment.FreePeople) then
        -- update generic travel settings
        for i = 1, travelCount[3], 1 do
            -- if the enabled setting for the skill is nil, set it to true as default
            if (Settings.enabled[genLocations:IdAtIndex(i)] == nil) then
                Settings.enabled[genLocations:IdAtIndex(i)] = true;
            end

            -- if the skill is not in the order list, add it and increase the counter
            if (self:TableContains(Settings.order, genLocations:IdAtIndex(i)) == false) then
                table.insert(Settings.order, counter, genLocations:IdAtIndex(i));
                counter = counter + 1;
            end
        end

        -- update reputation travel settings
        for i = 1, travelCount[4], 1 do
            if (Settings.enabled[repLocations:IdAtIndex(i)] == nil) then
                Settings.enabled[repLocations:IdAtIndex(i)] = true;
            end
            if (self:TableContains(Settings.order, repLocations:IdAtIndex(i)) == false) then
                table.insert(Settings.order, counter, repLocations:IdAtIndex(i));
                counter = counter + 1;
            end
        end

        -- update racial travel settings
        if (Settings.enabled[racialLocations:IdAtIndex(PlayerRaceKey)] == nil) then
            Settings.enabled[racialLocations:IdAtIndex(PlayerRaceKey)] = true;
        end
        if (self:TableContains(Settings.order, racialLocations:IdAtIndex(PlayerRaceKey)) == false) then
            table.insert(Settings.order, counter, racialLocations:IdAtIndex(PlayerRaceKey));
            counter = counter + 1;
        end

        -- update hunter travel settings
        if (PlayerClass == Turbine.Gameplay.Class.Hunter) then
            for i = 1, travelCount[1], 1 do
                if (Settings.enabled[hunterLocations:IdAtIndex(i)] == nil) then
                    Settings.enabled[hunterLocations:IdAtIndex(i)] = true;
                end
                if (self:TableContains(Settings.order, hunterLocations:IdAtIndex(i)) == false) then
                    table.insert(Settings.order, counter, hunterLocations:IdAtIndex(i));
                    counter = counter + 1;
                end
            end
        end

        -- update warden travel settings
        if (PlayerClass == Turbine.Gameplay.Class.Warden) then
            for i = 1, travelCount[2], 1 do
                if (Settings.enabled[wardenLocations:IdAtIndex(i)] == nil) then
                    Settings.enabled[wardenLocations:IdAtIndex(i)] = true;
                end
                if (self:TableContains(Settings.order, wardenLocations:IdAtIndex(i)) == false) then
                    table.insert(Settings.order, counter, wardenLocations:IdAtIndex(i));
                    counter = counter + 1;
                end
            end
        end

        -- update mariner travel settings
        if (PlayerClass == Turbine.Gameplay.Class.Mariner) then
            for i = 1, travelCount[7], 1 do
                if (Settings.enabled[marinerLocations:IdAtIndex(i)] == nil) then
                    Settings.enabled[marinerLocations:IdAtIndex(i)] = true;
                end
                if (self:TableContains(Settings.order, marinerLocations:IdAtIndex(i)) == false) then
                    table.insert(Settings.order, counter, marinerLocations:IdAtIndex(i));
                    counter = counter + 1;
                end
            end
        end
    else
        -- update creep travel settings
        for i = 1, travelCount[6], 1 do
            if (Settings.enabled[creepLocations:IdAtIndex(i)] == nil) then
                Settings.enabled[creepLocations:IdAtIndex(i)] = true;
            end
            if (self:TableContains(Settings.order, creepLocations:IdAtIndex(i)) == false) then
                table.insert(Settings.order, counter, creepLocations:IdAtIndex(i));
                counter = counter + 1;
            end
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
    self.mapWindow = TravelWindowII.src.MapWindow(self, map, PlayerClass, PlayerRaceKey);
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
function TravelWindow:TableContains(tableToSearch, elementToSearchFor)
    for i, value in pairs(tableToSearch) do
        if (value == elementToSearchFor) then
            return true;
        end
    end
    return false;
end

-- function to check if a table contains a specific element index
function TravelWindow:TableIndex(tableToSearch, elementToSearchFor)
    for i, value in pairs(tableToSearch) do
        if (value == elementToSearchFor) then
            return i;
        end
    end
    return 0;
end

function TravelWindow:SortShortcuts()
    -- perform an optimized bubble sort
    local n = #TravelShortcuts;
    while n > 2 do
        local new_n = 1;
        for i = 2, n do
            if TravelShortcuts[i - 1]:GetIndex() > TravelShortcuts[i]:GetIndex() then
                self.dirty = true;
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

function TravelWindow:LoadSettings()
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
        if self.minWidth == nil then self.minWidth = 245; end
        SettingsStrings.width = tostring(self.minWidth);
    end

    if (not SettingsStrings.height or SettingsStrings.height == "nil") then
        if self.minHeight == nil then self.minHeight = 150; end
        SettingsStrings.height = tostring(self.minHeight);
    end

    if (not SettingsStrings.positionX or SettingsStrings.positionX == "nil") then
        SettingsStrings.positionX = tostring((Turbine.UI.Display.GetWidth() - self:GetWidth()) * 0.75);
    end

    if (not SettingsStrings.positionY or SettingsStrings.positionY == "nil") then
        SettingsStrings.positionY = tostring((Turbine.UI.Display.GetHeight() - self:GetHeight()) * 0.75);
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
        self:OrderTableNumberIndex();
    else
        Settings.order = SettingsStrings.order;
    end


end

function TravelWindow:SaveSettings()

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
    SettingsStrings.showButton = tostring(Settings.showButton);
    SettingsStrings.mode = tostring(Settings.mode);
    SettingsStrings.filters = tostring(Settings.filters);
    SettingsStrings.mainMaxOpacity = tostring(Settings.mainMaxOpacity);
    SettingsStrings.mainMinOpacity = tostring(Settings.mainMinOpacity);
    SettingsStrings.toggleMaxOpacity = tostring(Settings.toggleMaxOpacity);
    SettingsStrings.toggleMinOpacity = tostring(Settings.toggleMinOpacity);
    SettingsStrings.enabled = Settings.enabled;
    SettingsStrings.mapGlanVraig = tostring(Settings.mapGlanVraig);

    self:OrderTableStringIndex();

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
    self:UpdateSize();
    self:SetItems();

    self.MainPanel:SetSize(self:GetWidth() - 20, self:GetHeight() - 60);
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

    -- get the player class and race
    player = Turbine.Gameplay.LocalPlayer.GetInstance();
    PlayerClass = player:GetClass();
    PlayerRace = player:GetRace();
    self:SetPlayerRaceKey();

    -- update everything
    self:CheckEnabledSettings()
    self:SetShortcuts();
    self:CheckSkills(false)
    self:UpdateSettings();
end

function TravelWindow:OrderTableStringIndex()

    SettingsStrings.order = {};

    for i, v in ipairs(Settings.order) do
        SettingsStrings.order[tostring(i)] = v;
    end
end

function TravelWindow:OrderTableNumberIndex()

    Settings.order = {};

    for i, v in pairs(SettingsStrings.order) do
        Settings.order[tonumber(i)] = v;
    end
end

function TravelWindow:AddGVMap()
    -- if the player has a PvMP map, then insert it into the list
    if ((Settings.mapGlanVraig ~= nil) and (Settings.mapGlanVraig ~= "nil")) then
        self.reloadGVMap = false;
        genLocations:InsertSkill(2, glanMapString, Settings.mapGlanVraig, "Glan Vraig");
    end
end

function TravelWindow:CheckSkills(report)
    local newShortcut = false;
    -- loop through all the shortcuts and list those those that are not learned
    for i = 1, #TravelShortcuts, 1 do
        local wasFound = TravelShortcuts[i].found;
        if (TravelWindow:FindSkill(TravelShortcuts[i])) then
            if not wasFound then
                newShortcut = true;
            end
        elseif report then
            Turbine.Shell.WriteLine(skillNotTrainedString .. TravelShortcuts[i]:GetName())
        end
    end

    if newShortcut then
        self.dirty = true; -- reset list of shortcuts
        self:SetItems(); -- redraw current window
    end
end

function TravelWindow:FindSkill(shortcut)
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

function TravelWindow:ListTrainedSkills()

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
