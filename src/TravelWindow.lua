import "Turbine";
import "Turbine.Debug";
import "Turbine.Gameplay";
import "Turbine.UI";
import "Turbine.UI.Lotro";
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

    settings = {};
    SettingsStrings = {};
    TravelShortcuts = {}; -- put all the shortcuts into one table
    TrainedSkills = Turbine.Gameplay.SkillList;

    self.minWidth = 240;
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
    self.ToggleButton = TravelWindowII.src.TravelButton(self);
    self.ToggleButton:SetPosition(settings.buttonPositionX,
                                  settings.buttonPositionY);
    self.ToggleButton:SetVisible(settings.showButton == 1);
    self.ToggleButton:SetOpacity(settings.toggleMinOpacity);

    -- if the player has a PvMP map, then insert it into the list
    -- if ((settings.mapGlanVraig ~= nil) and (settings.mapGlanVraig ~= "nil")) then
    -- self.reloadGVMap = true;
    -- genLocations:InsertSkill(2, glanMapString, settings.mapGlanVraig, "skip");
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
    Menu:SetSettings(settings.mode, settings.filters);

    -- create the tabbed panel to hold all the other panels
    self.MainPanel = TravelWindowII.src.extensions.DPanel();
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

    optionsPanel = TravelWindowII.src.OptionsPanel(self);

    pcall(function()
        plugin.GetOptionsPanel = function(self) return optionsPanel; end
    end);

    --[[ Event Handlers ]] --

    -- make sure we listen for updates
    self:SetWantsUpdates(true);
    self:SetWantsKeyEvents(true);

    -- check if our position has changed, and save the settings if so
    self.PositionChanged = function(sender, args)
        local one, two = self:GetPosition();
        settings.positionX = one;
        settings.positionY = two;
        self:SaveSettings();
        self.PullTab:ClosePulldown();
    end

    -- manage hiding the UI
    self.KeyDown = function(sender, args)
        if (args.Action == Turbine.UI.Lotro.Action.Escape) then
            self:SetVisible(false);
            self:CloseOptions();
            self:CloseGondorMap();
            self:CloseMoorMap();
            self:CloseEriadorMap();
            self:CloseRhovanionMap();
        elseif (args.Action == 268435635) then
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
    IncombatChangedHandler = function(sender, args)
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
    AddCallback(player, "InCombatChanged", IncombatChangedHandler);

    -- if the visible status of the window changes, close the pulldown tab
    self.VisibleChanged = function(sender, args)
        if (self:IsVisible() == false) then self.PullTab:ClosePulldown(); end
    end

    -- go to full opacity if mouse is over
    self.MouseEnter = function(sender, args)
        self:SetOpacity(settings.mainMaxOpacity);
    end

    -- go to low opacity when mouse is not over
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
        if (self.disableResize) then return; end

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
        if (Turbine.Engine.GetGameTime() - self.lastMove > 0.1 and
            self:IsVisible() or self.lastMove == 0) then

            -- update the tabbed panels
            self.MainPanel:SetSize(self:GetWidth() - 20, self:GetHeight() - 60);
            self.MainPanel:UpdateTabs();
            self.lastMove = Turbine.Engine.GetGameTime();
        end
    end

    Plugins["Travel Window II"].Load = function(sender, args)
        Turbine.Shell.WriteLine("<u><rgb=#DAA520>Travel Window II " ..
                                    Plugins["Travel Window II"]:GetVersion() ..
                                    " by Hyoss</rgb></u>");
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
    else
        PlayerRaceKey = 1; -- default to man race to prevent errors
    end
end

function TravelWindow:UpdateSize()
    -- check that the window is not smaller than min width
    if (self:GetWidth() < self.minWidth) then self:SetWidth(self.minWidth); end

    -- check that the window is not smaller than min height
    if (self:GetHeight() < self.minHeight) then
        self:SetHeight(self.minHeight);
    end

    -- set the new location of the resize control
    self.sizeControl:SetPosition(self:GetWidth() - self.sizeControl:GetWidth(),
                                 self:GetHeight() - self.sizeControl:GetHeight());
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

    -- add a label to the window for instructions
    self.mapLabel = Turbine.UI.Label();
    self.mapLabel:SetForeColor(Turbine.UI.Color(1, 0.2, 0.2, 0.6));
    self.mapLabel:SetPosition(0, 15);
    self.mapLabel:SetSize(settings.width - 20, self.MapWindow:GetHeight() - 90);
    self.mapLabel:SetParent(self.MapWindow);
    self.mapLabel:SetVisible(true);
    self.mapLabel:SetFont(Turbine.UI.Lotro.Font.Verdana14);
    self.mapLabel:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleLeft);
    self.mapLabel:SetMultiline(true);
    self.mapLabel:SetText("@TODO");

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

    -- do this if it is the glan vraig map
    if (string.find(mapItem:GetName(), glanMapItemString)) then

        -- remove the old shortcut if it exists
        if (genLocations:IndexByName(glanMapString) == 2) then
            genLocations:RemoveSkillAtIndex(2);
        end

        -- set the value
        settings.mapGlanVraig = shortcut:GetData();

        -- update the location lists
        genLocations:InsertData(2, glanMapString, settings.mapGlanVraig);
        TravelInfo:GetCounts();

        -- else, do nothing but report the error
    else
        Turbine.Shell.WriteLine("@TODO");
    end
    -- update and save everything
    self:UpdateSettings();
    self:SaveSettings();
end

function TravelWindow:SetShortcuts()
    -- set default values
    TravelShortcuts = {};
    local shortcutIndex = 1;

    -- set the either the travel skills for free people or monsters
    if (PlayerAlignment == Turbine.Gameplay.Alignment.FreePeople) then
        -- set the generic travel items
        for i = 1, travelCount[3], 1 do
            -- get the order number for the item
            shortcutIndex = self:TableIndex(settings.order,
                                            genLocations:IdAtIndex(i));

            -- set the shortcut for the quickslot, check
            -- if the shortcut is the map home or not
            if (string.len(genLocations:IdAtIndex(i)) > 12) then
                table.insert(TravelShortcuts,
                             TravelShortcut(2.0, genLocations:IdAtIndex(i),
                                            genLocations:NameAtIndex(i), 1,
                                            shortcutIndex,
                                            settings.enabled[genLocations:IdAtIndex(
                                                i)],
                                            genLocations:LabelAtIndex(i)));
            else
                table.insert(TravelShortcuts,
                             TravelShortcut(6.0, genLocations:IdAtIndex(i),
                                            genLocations:NameAtIndex(i), 1,
                                            shortcutIndex,
                                            settings.enabled[genLocations:IdAtIndex(
                                                i)],
                                            genLocations:LabelAtIndex(i)));
            end
        end

        -- add the race travel to the list
        local racialShortcutIndex = self:TableIndex(settings.order,
                                                    racialLocations:IdAtIndex(
                                                        PlayerRaceKey));
        table.insert(TravelShortcuts,
                     TravelShortcut(6.0,
                                    racialLocations:IdAtIndex(PlayerRaceKey),
                                    racialLocations:NameAtIndex(PlayerRaceKey),
                                    2, racialShortcutIndex,
                                    settings.enabled[racialLocations:IdAtIndex(
                                        PlayerRaceKey)],
                                    racialLocations:LabelAtIndex(PlayerRaceKey)));

        -- set the reputation travel items
        for i = 1, travelCount[4], 1 do
            shortcutIndex = self:TableIndex(settings.order,
                                            repLocations:IdAtIndex(i));
            table.insert(TravelShortcuts,
                         TravelShortcut(6.0, repLocations:IdAtIndex(i),
                                        repLocations:NameAtIndex(i), 3,
                                        shortcutIndex,
                                        settings.enabled[repLocations:IdAtIndex(
                                            i)], repLocations:LabelAtIndex(i)));
        end
    else
        -- set the creep travel items
        for i = 1, travelCount[6], 1 do
            shortcutIndex = self:TableIndex(settings.order,
                                            creepLocations:IdAtIndex(i));
            table.insert(TravelShortcuts,
                         TravelShortcut(6.0, creepLocations:IdAtIndex(i),
                                        creepLocations:NameAtIndex(i), 3,
                                        shortcutIndex,
                                        settings.enabled[creepLocations:IdAtIndex(
                                            i)], creepLocations:LabelAtIndex(i)));
        end
    end

    -- set the hunter travel items
    if (PlayerClass == Turbine.Gameplay.Class.Hunter) then
        for i = 1, travelCount[1], 1 do
            shortcutIndex = self:TableIndex(settings.order,
                                            hunterLocations:IdAtIndex(i));
            table.insert(TravelShortcuts,
                         TravelShortcut(6.0, hunterLocations:IdAtIndex(i),
                                        hunterLocations:NameAtIndex(i), 4,
                                        shortcutIndex,
                                        settings.enabled[hunterLocations:IdAtIndex(
                                            i)], hunterLocations:LabelAtIndex(i)));
        end
    end

    -- set the warden travel items
    if (PlayerClass == Turbine.Gameplay.Class.Warden) then
        for i = 1, travelCount[2], 1 do
            shortcutIndex = self:TableIndex(settings.order,
                                            wardenLocations:IdAtIndex(i));
            table.insert(TravelShortcuts,
                         TravelShortcut(6.0, wardenLocations:IdAtIndex(i),
                                        wardenLocations:NameAtIndex(i), 4,
                                        shortcutIndex,
                                        settings.enabled[wardenLocations:IdAtIndex(
                                            i)], wardenLocations:LabelAtIndex(i)));
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
        end
    else
        -- monster player skills
        ItemCount = travelCount[6] + 1;
    end

    -- remove superfluous entries in order list in case skills get deleted from game
    if (#settings.order > ItemCount) then
        for id, order in pairs(settings.order) do
            if (not genLocations:VerifyId(id) and
                not wardenLocations:VerifyId(id) and
                not repLocations:VerifyId(id) and not genLocations:VerifyId(id)) then
                settings.order[id] = nil;
            end
        end
    end

    -- remove superfluous entries in enabled list in case skills get deleted from game
    if (#settings.enabled > ItemCount) then
        for id, status in pairs(settings.enabled) do
            if (not genLocations:VerifyId(id) and
                not wardenLocations:VerifyId(id) and
                not repLocations:VerifyId(id) and not genLocations:VerifyId(id)) then
                settings.enabled[id] = nil;
            end
        end
    end

    -- need to find the highest sort number now
    local counter = #settings.order + 1;

    if (PlayerAlignment == Turbine.Gameplay.Alignment.FreePeople) then
        -- update generic travel settings
        for i = 1, travelCount[3], 1 do
            -- if the enabled setting for the skill is nil, set it to true as default
            if (settings.enabled[genLocations:IdAtIndex(i)] == nil) then
                settings.enabled[genLocations:IdAtIndex(i)] = true;
            end

            -- if the skill is not in the order list, add it and increase the counter
            if (self:TableContains(settings.order, genLocations:IdAtIndex(i)) ==
                false) then
                table.insert(settings.order, counter, genLocations:IdAtIndex(i));
                counter = counter + 1;
            end
        end

        -- update reputation travel settings
        for i = 1, travelCount[4], 1 do
            if (settings.enabled[repLocations:IdAtIndex(i)] == nil) then
                settings.enabled[repLocations:IdAtIndex(i)] = true;
            end
            if (self:TableContains(settings.order, repLocations:IdAtIndex(i)) ==
                false) then
                table.insert(settings.order, counter, repLocations:IdAtIndex(i));
                counter = counter + 1;
            end
        end

        -- update racial travel settings
        if (settings.enabled[racialLocations:IdAtIndex(PlayerRaceKey)] == nil) then
            settings.enabled[racialLocations:IdAtIndex(PlayerRaceKey)] = true;
        end
        if (self:TableContains(settings.order,
                               racialLocations:IdAtIndex(PlayerRaceKey)) ==
            false) then
            table.insert(settings.order, counter,
                         racialLocations:IdAtIndex(PlayerRaceKey));
            counter = counter + 1;
        end

        -- update hunter travel settings
        if (PlayerClass == Turbine.Gameplay.Class.Hunter) then
            for i = 1, travelCount[1], 1 do
                if (settings.enabled[hunterLocations:IdAtIndex(i)] == nil) then
                    settings.enabled[hunterLocations:IdAtIndex(i)] = true;
                end
                if (self:TableContains(settings.order,
                                       hunterLocations:IdAtIndex(i)) == false) then
                    table.insert(settings.order, counter,
                                 hunterLocations:IdAtIndex(i));
                    counter = counter + 1;
                end
            end
        end

        -- update warden travel settings
        if (PlayerClass == Turbine.Gameplay.Class.Warden) then
            for i = 1, travelCount[2], 1 do
                if (settings.enabled[wardenLocations:IdAtIndex(i)] == nil) then
                    settings.enabled[wardenLocations:IdAtIndex(i)] = true;
                end
                if (self:TableContains(settings.order,
                                       wardenLocations:IdAtIndex(i)) == false) then
                    table.insert(settings.order, counter,
                                 wardenLocations:IdAtIndex(i));
                    counter = counter + 1;
                end
            end
        end
    else
        -- update creep travel settings
        for i = 1, travelCount[6], 1 do
            if (settings.enabled[creepLocations:IdAtIndex(i)] == nil) then
                settings.enabled[creepLocations:IdAtIndex(i)] = true;
            end
            if (self:TableContains(settings.order, creepLocations:IdAtIndex(i)) ==
                false) then
                table.insert(settings.order, counter,
                             creepLocations:IdAtIndex(i));
                counter = counter + 1;
            end
        end
    end
end

-- simple function to open the options window
function TravelWindow:OpenOptions()
    self.options = TravelWindowII.src.OptionsWindow(self);
end

-- function to close the options window if it exists
function TravelWindow:CloseOptions()
    if (self.options ~= nil) then
        self:SaveSettings();
        self.options:SetVisible(false);
    end
    self.options = nil;
end

function TravelWindow:OpenMoorMap()
    self.moorMapWindow = TravelWindowII.src.MoorMapWindow(self);
end

-- function to close the moor map window if it exists
function TravelWindow:CloseMoorMap()
    if (self.moorMapWindow ~= nil) then self.moorMapWindow:SetVisible(false); end
    self.moorMapWindow = nil;
end

function TravelWindow:OpenEriadorMap()
    self.eriadorMapWindow = TravelWindowII.src.EriadorMapWindow(self,
                                                                PlayerClass,
                                                                PlayerRaceKey,
                                                                TravelShortcuts);
end

-- function to close the eriador map window if it exists
function TravelWindow:CloseEriadorMap()
    if (self.eriadorMapWindow ~= nil) then
        self.eriadorMapWindow:SetVisible(false);
    end
    self.eriadorMapWindow = nil;
end

function TravelWindow:OpenRhovanionMap()
    self.rhovanionMapWindow = TravelWindowII.src.RhovanionMapWindow(self,
                                                                    PlayerClass,
                                                                    PlayerRaceKey,
                                                                    TravelShortcuts);
end

-- function to close the rhovanion map window if it exists
function TravelWindow:CloseRhovanionMap()
    if (self.rhovanionMapWindow ~= nil) then
        self.rhovanionMapWindow:SetVisible(false);
    end
    self.rhovanionMapWindow = nil;
end

function TravelWindow:OpenGondorMap()
    self.gondorMapWindow = TravelWindowII.src.GondorMapWindow(self, PlayerClass,
                                                              PlayerRaceKey,
                                                              TravelShortcuts);
end

-- function to close the gondor map window if it exists
function TravelWindow:CloseGondorMap()
    if (self.gondorMapWindow ~= nil) then
        self.gondorMapWindow:SetVisible(false);
    end
    self.gondorMapWindow = nil;
end

-- function to check if a table contains a specific element
function TravelWindow:TableContains(tableToSearch, elementToSearchFor)
    for i, value in pairs(tableToSearch) do
        if (value == elementToSearchFor) then return true; end
    end
    return false;
end

-- function to check if a table contains a specific element index
function TravelWindow:TableIndex(tableToSearch, elementToSearchFor)
    for i, value in pairs(tableToSearch) do
        if (value == elementToSearchFor) then return i; end
    end
    return 0;
end

function TravelWindow:SortShortcuts()
    -- do not sort if there is one or less shortcuts
    if #TravelShortcuts < 2 then return; end

    -- perform a bubble sort
    for i = 1, #TravelShortcuts do
        for j = 2, #TravelShortcuts do
            -- if the index of the second shortcut is lower than the index of
            -- the first, switch the shortcuts
            if TravelShortcuts[j]:GetIndex() < TravelShortcuts[j - 1]:GetIndex() then
                local temp = TravelShortcuts[j - 1];
                TravelShortcuts[j - 1] = TravelShortcuts[j];
                TravelShortcuts[j] = temp;
            end
        end
    end

    return;
end

function TravelWindow:UpdateOpacity()
    self:SetOpacity(settings.mainMinOpacity);
    self.ToggleButton:UpdateOpacity();
end

function TravelWindow:LoadSettings()
    -- load the self.settings
    -- if a value is not available, set a default value

    -- load TWII settings file
    pcall(function()
        SettingsStrings = PatchDataLoad(Turbine.DataScope.Character,
                                        "TravelWindowIISettings");
    end);

    -- save a daily backup of settings
    if (SettingsStrings) then
        SettingsStrings.backupTime = "#" .. Turbine.Engine.GetGameTime();
        local dateInfo = Turbine.Engine.GetDate();
        PatchDataSave(Turbine.DataScope.Account,
                      "TravelWindowIISettings_backup" .. dateInfo.DayOfWeek,
                      SettingsStrings);
    end

    -- try importing Travel Window I settings if new settings were not found
    local importOldSettings = false;
    if (SettingsStrings == nil) then
        local result;
        importOldSettings, result = pcall(
                                        function()
                SettingsStrings = PatchDataLoad(Turbine.DataScope.Character,
                                                "TravelWindowSettings");
            end);
    end

    if (type(SettingsStrings) ~= "table") then SettingsStrings = {}; end

    if (not SettingsStrings.width or SettingsStrings.width == "nil") then
        SettingsStrings.width = tostring(self.minWidth);
    end

    if (not SettingsStrings.height or SettingsStrings.height == "nil") then
        SettingsStrings.height = tostring(self.minHeight);
    end

    if (not SettingsStrings.positionX or SettingsStrings.positionX == "nil") then
        SettingsStrings.positionX = tostring(
                                        Turbine.UI.Display.GetWidth() -
                                            self:GetWidth() - 50);
    end

    if (not SettingsStrings.positionY or SettingsStrings.positionY == "nil") then
        SettingsStrings.positionY = tostring(
                                        Turbine.UI.Display.GetHeight() -
                                            self:GetHeight() - 50 * 1.5);
    end

    if (not SettingsStrings.buttonPositionX or SettingsStrings.buttonPositionX ==
        "nil") then
        SettingsStrings.buttonPositionX =
            tostring(Turbine.UI.Display.GetWidth() - self:GetWidth() - 50);
    end

    if (not SettingsStrings.buttonPositionY or SettingsStrings.buttonPositionY ==
        "nil") then
        SettingsStrings.buttonPositionY =
            tostring(Turbine.UI.Display.GetHeight() - self:GetHeight() - 50 *
                         1.5);
    end

    if (not SettingsStrings.hideOnStart or SettingsStrings.hideOnStart == "nil") then
        SettingsStrings.hideOnStart = tostring(0);
    end

    if (not SettingsStrings.hideOnCombat or SettingsStrings.hideOnCombat ==
        "nil") then SettingsStrings.hideOnCombat = tostring(0); end

    if (not SettingsStrings.pulldownTravel or SettingsStrings.pulldownTravel ==
        "nil") then SettingsStrings.pulldownTravel = tostring(0); end

    if (not SettingsStrings.showButton or SettingsStrings.showButton == "nil") then
        SettingsStrings.showButton = tostring(1);
    end

    if (not SettingsStrings.mode or SettingsStrings.mode == "nil") then
        SettingsStrings.mode = tostring(1);
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

    if (not SettingsStrings.mainMaxOpacity or SettingsStrings.mainMaxOpacity ==
        "nil") then SettingsStrings.mainMaxOpacity = tostring(1); end

    if (not SettingsStrings.mainMinOpacity or SettingsStrings.mainMinOpacity ==
        "nil") then SettingsStrings.mainMinOpacity = tostring(0.5); end

    if (not SettingsStrings.toggleMaxOpacity or SettingsStrings.toggleMaxOpacity ==
        "nil") then SettingsStrings.toggleMaxOpacity = tostring(1); end

    if (not SettingsStrings.toggleMinOpacity or SettingsStrings.toggleMinOpacity ==
        "nil") then SettingsStrings.toggleMinOpacity = tostring(0.2); end

    -- convert from strings if necessary
    if (type(SettingsStrings.width) == "string") then
        settings.width = tonumber(SettingsStrings.width);
    else
        settings.width = SettingsStrings.width;
    end

    if (type(SettingsStrings.height) == "string") then
        settings.height = tonumber(SettingsStrings.height);
    else
        settings.height = SettingsStrings.height;
    end

    if (type(SettingsStrings.positionX) == "string") then
        settings.positionX = tonumber(SettingsStrings.positionX);
    else
        settings.positionX = SettingsStrings.positionX;
    end

    if (type(SettingsStrings.positionY) == "string") then
        settings.positionY = tonumber(SettingsStrings.positionY);
    else
        settings.positionY = SettingsStrings.positionY;
    end

    if (type(SettingsStrings.buttonPositionX) == "string") then
        settings.buttonPositionX = tonumber(SettingsStrings.buttonPositionX);
    else
        settings.buttonPositionX = SettingsStrings.buttonPositionX;
    end

    if (type(SettingsStrings.positionY) == "string") then
        settings.buttonPositionY = tonumber(SettingsStrings.buttonPositionY);
    else
        settings.buttonPositionY = SettingsStrings.buttonPositionY;
    end

    if (type(SettingsStrings.hideOnStart) == "string") then
        settings.hideOnStart = tonumber(SettingsStrings.hideOnStart);
    else
        settings.hideOnStart = SettingsStrings.hideOnStart;
    end

    if (type(SettingsStrings.hideOnCombat) == "string") then
        settings.hideOnCombat = tonumber(SettingsStrings.hideOnCombat);
    else
        settings.hideOnCombat = SettingsStrings.hideOnCombat;
    end

    if (type(SettingsStrings.pulldownTravel) == "string") then
        settings.pulldownTravel = tonumber(SettingsStrings.pulldownTravel);
    else
        settings.pulldownTravel = SettingsStrings.pulldownTravel;
    end

    if (type(SettingsStrings.showButton) == "string") then
        settings.showButton = tonumber(SettingsStrings.showButton);
    else
        settings.showButton = SettingsStrings.showButton;
    end

    if (type(SettingsStrings.mode) == "string") then
        settings.mode = tonumber(SettingsStrings.mode);
    else
        settings.mode = SettingsStrings.mode;
    end

    if (type(SettingsStrings.filters) == "string") then
        settings.filters = tonumber(SettingsStrings.filters);
    else
        settings.filters = SettingsStrings.filters;
    end

    if (type(SettingsStrings.mainMaxOpacity) == "string") then
        settings.mainMaxOpacity = EuroNormalize(SettingsStrings.mainMaxOpacity);
    else
        settings.mainMaxOpacity = SettingsStrings.mainMaxOpacity;
    end

    if (type(SettingsStrings.mainMinOpacity) == "string") then
        settings.mainMinOpacity = EuroNormalize(SettingsStrings.mainMinOpacity);
    else
        settings.mainMinOpacity = SettingsStrings.mainMinOpacity;
    end

    if (type(SettingsStrings.toggleMaxOpacity) == "string") then
        settings.toggleMaxOpacity = EuroNormalize(
                                        SettingsStrings.toggleMaxOpacity);
    else
        settings.toggleMaxOpacity = SettingsStrings.toggleMaxOpacity;
    end

    if (type(SettingsStrings.toggleMinOpacity) == "string") then
        settings.toggleMinOpacity = EuroNormalize(
                                        SettingsStrings.toggleMinOpacity);
    else
        settings.toggleMinOpacity = SettingsStrings.toggleMinOpacity;
    end

    if (SettingsStrings.mapGlanVraig ~= nil) then
        settings.mapGlanVraig = SettingsStrings.mapGlanVraig;
    end

    settings.enabled = SettingsStrings.enabled;

    local convertTableIndex = false;
    for i, v in pairs(SettingsStrings.order) do
        if (type(i) == "string") then convertTableIndex = true; end
    end

    if (convertTableIndex) then
        self:OrderTableNumberIndex();
    else
        settings.order = SettingsStrings.order;
    end
end

function TravelWindow:SaveSettings()

    -- convert the settings to strings
    SettingsStrings.height = tostring(settings.height);
    SettingsStrings.width = tostring(settings.width);
    SettingsStrings.positionX = tostring(settings.positionX);
    SettingsStrings.positionY = tostring(settings.positionY);
    SettingsStrings.buttonPositionX = tostring(settings.buttonPositionX);
    SettingsStrings.buttonPositionY = tostring(settings.buttonPositionY);
    SettingsStrings.hideOnStart = tostring(settings.hideOnStart);
    SettingsStrings.hideOnCombat = tostring(settings.hideOnCombat);
    SettingsStrings.pulldownTravel = tostring(settings.pulldownTravel);
    SettingsStrings.showButton = tostring(settings.showButton);
    SettingsStrings.mode = tostring(settings.mode);
    SettingsStrings.filters = tostring(settings.filters);
    SettingsStrings.mainMaxOpacity = tostring(settings.mainMaxOpacity);
    SettingsStrings.mainMinOpacity = tostring(settings.mainMinOpacity);
    SettingsStrings.toggleMaxOpacity = tostring(settings.toggleMaxOpacity);
    SettingsStrings.toggleMinOpacity = tostring(settings.toggleMinOpacity);
    SettingsStrings.enabled = settings.enabled;
    SettingsStrings.mapGlanVraig = tostring(settings.mapGlanVraig);

    self:OrderTableStringIndex();

    -- save the settings
    PatchDataSave(Turbine.DataScope.Character, "TravelWindowIISettings",
                  SettingsStrings);
end

function TravelWindow:UpdateSettings()

    -- get some settings from the menu
    settings.mode, settings.filters = Menu:GetSettings();

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

function TravelWindow:ResetSettings()
    -- close the option window
    self:CloseOptions()

    -- set all saved settings to default values
    settings = {};
    settings.width = self.minWidth;
    settings.height = self.minHeight;
    settings.positionX = Turbine.UI.Display.GetWidth() - self:GetWidth() - 50;
    settings.positionY =
        Turbine.UI.Display.GetHeight() - self:GetHeight() - 50 * 1.5;
    settings.buttonPositionX = Turbine.UI.Display.GetWidth() - self:GetWidth() -
                                   50;
    settings.buttonPositionY =
        Turbine.UI.Display.GetHeight() - self:GetHeight() - 50 * 1.5;
    settings.hideOnStart = 0;
    settings.hideOnCombat = 0;
    settings.pulldownTravel = 0;
    settings.showButton = 1;
    settings.mode = 1;
    settings.filters = 0x0F;
    settings.enabled = {};
    settings.order = {};
    settings.mainMaxOpacity = 1;
    settings.mainMinOpacity = 0.5;
    settings.toggleMaxOpacity = 1;
    settings.toggleMinOpacity = 0.5;

    -- clear the maps
    settings.mapGlanVraig = nil;

    -- move the toggle button and main window
    self.ToggleButton:SetPosition(settings.buttonPositionX,
                                  settings.buttonPositionY);
    self:SetPosition(settings.positionX, settings.positionY);
    self:SetSize(settings.width, settings.height);

    -- get the player class and race
    player = Turbine.Gameplay.LocalPlayer.GetInstance();
    PlayerClass = player:GetClass();
    PlayerRace = player:GetRace();
    self:DetermineRaceKey();

    -- update everything
    self:CheckEnabledSettings()
    self:SetShortcuts();
    self:UpdateSettings();
end

function TravelWindow:OrderTableStringIndex()

    SettingsStrings.order = {};

    for i, v in ipairs(settings.order) do
        SettingsStrings.order[tostring(i)] = v;
    end
end

function TravelWindow:OrderTableNumberIndex()

    settings.order = {};

    for i, v in pairs(SettingsStrings.order) do
        settings.order[tonumber(i)] = v;
    end
end

function TravelWindow:AddGVMap()
    -- if the player has a PvMP map, then insert it into the list
    if ((settings.mapGlanVraig ~= nil) and (settings.mapGlanVraig ~= "nil")) then
        self.reloadGVMap = false;
        genLocations:InsertData(2, glanMapString, settings.mapGlanVraig);
    end
end

function TravelWindow:CheckSkills()
    -- loop through all the shortcuts and list those those that are not learned
    for i = 1, #TravelShortcuts, 1 do
        if (TravelWindow:FindSkill(TravelShortcuts[i]:GetName())) then
            -- do nothing, skill is known
        else
            Turbine.Shell.WriteLine(skillNotTrainedString ..
                                        TravelShortcuts[i]:GetName())
        end
    end

    -- make sure list of shortcuts is rescanned and new skills added
    self:SetShortcuts();
end

function TravelWindow:FindSkill(name)
    for i = 1, TrainedSkills:GetCount(), 1 do
        local skill = Turbine.Gameplay.Skill;
        skill = TrainedSkills:GetItem(i);

        if (skill:GetSkillInfo():GetName() == name) then return true; end
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
function TravelWindow:DoDump() Turbine.Debug.Table.Dump(TravelWindowII.src); end

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
