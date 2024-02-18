import "TravelWindowII.src.utils.BitOps";
import "TravelWindowII.src.extensions";

SettingsMenu = class(Turbine.UI.ContextMenu)

function SettingsMenu:Constructor(parentWindow)
    Turbine.UI.ContextMenu.Constructor(self);

    -- set the default values
    self.mode = 1;
    self.filters = 0x0F;

    self.parent = parentWindow;

    -- create the filter sub menu
    Filters = TravelWindowII.src.extensions.DMenuList(menuFiltersString);
    self.Filters1 = Turbine.UI.MenuItem(menuGenString);
    self.Filters2 = Turbine.UI.MenuItem(menuRaceString);
    self.Filters3 = Turbine.UI.MenuItem(menuRepString);
    self.Filters4 = Turbine.UI.MenuItem(menuClassString);
    FilterItems = Filters:GetItems();
    FilterItems:Add(self.Filters1);
    FilterItems:Add(self.Filters2);
    FilterItems:Add(self.Filters3);
    FilterItems:Add(self.Filters4);

    -- create the mode sub menu
    Mode = TravelWindowII.src.extensions.DMenuList(menuModeString);
    self.Mode1 = Turbine.UI.MenuItem(menuTextString);
    self.Mode2 = Turbine.UI.MenuItem(menuIconString);
    self.Mode3 = Turbine.UI.MenuItem(menuCaroString);
    self.Mode4 = Turbine.UI.MenuItem(menuPullString);
    local ModeItems = Mode:GetItems();
    ModeItems:Add(self.Mode1);
    ModeItems:Add(self.Mode2);
    ModeItems:Add(self.Mode3);
    ModeItems:Add(self.Mode4);

    -- create the items to open the map windows
    MoorMapMenu = TravelWindowII.src.extensions.DMenuList(moorMapString);
    MapWindows = TravelWindowII.src.extensions.DMenuList(mapWindowString);
    local MapItems = MapWindows:GetItems();
    MapItems:Add(Turbine.UI.MenuItem(eriadorMapString));
    MapItems:Add(Turbine.UI.MenuItem(rhovanionMapString));
    MapItems:Add(Turbine.UI.MenuItem(rohanMapString));
    MapItems:Add(Turbine.UI.MenuItem(gondorMapString));
    MapItems:Add(Turbine.UI.MenuItem(haradwaithMapString));

    -- create the menu item to add map home
    -- @TODO has to be reintroduced
    MapMenu = TravelWindowII.src.extensions.DMenuList("");

    -- create the menu item to open the options window
    OptionsMenu = TravelWindowII.src.extensions.DMenuList(menuOptionsString);
    SkillsMenu = TravelWindowII.src.extensions.DMenuList(menuSkillsString);

    -- add everything to the main menu
    MenuItems = self:GetItems();
    if (PlayerAlignment == Turbine.Gameplay.Alignment.MonsterPlayer) then
        MenuItems:Add(Mode);
        MenuItems:Add(OptionsMenu);
        MenuItems:Add(MoorMapMenu);
    else
        MenuItems:Add(Filters);
        MenuItems:Add(Mode);
        MenuItems:Add(MapWindows);
        MenuItems:Add(MapMenu); -- @TODO needs to be reintroduced
        MenuItems:Add(OptionsMenu);
        MenuItems:Add(SkillsMenu);
    end

    -- set up the event handler
    local startConnect = 2;
    if PlayerAlignment == Turbine.Gameplay.Alignment.MonsterPlayer then
        startConnect = 1;
    end
    -- loop through top level of menu
    for i = 1, MenuItems:GetCount(), 1 do
        local topItem = MenuItems:Get(i);
        if topItem:GetCount() > 0 then
            -- loop through the sub menu
            for j = 1, topItem:GetCount(), 1 do
                local menuItem = topItem:Get(j);

                -- set the function to handle the event
                menuItem.Click = function(sender, args)
                    self:Update(sender:GetText());
                end
            end
        elseif i > startConnect then
            topItem.Click = function(sender, args)
                self:Update(sender:GetText());
            end
        end
    end

    self:SetSelections();
end

function SettingsMenu:SetSelections()

    -- set the filters using the BitOps functions
    self.Filters1:SetChecked(hasbit(self.filters, bit(1)));
    self.Filters2:SetChecked(hasbit(self.filters, bit(2)));
    self.Filters3:SetChecked(hasbit(self.filters, bit(3)));
    self.Filters4:SetChecked(hasbit(self.filters, bit(4)));

    -- set the mode
    self.Mode1:SetChecked(self.mode == 1);
    self.Mode2:SetChecked(self.mode == 2);
    self.Mode3:SetChecked(self.mode == 3);
    self.Mode4:SetChecked(self.mode == 4);
end

-- get the setting from the main window
function SettingsMenu:GetSettings()
    return self.mode, self.filters;
end

-- function to change the settings of the menu programmatically
function SettingsMenu:SetSettings(s1, s2)
    self.mode = s1;
    self.filters = s2;

    self:SetSelections();
end

function SettingsMenu:Update(string)

    -- update the window based on which item was selected
    if (string == menuGenString) then
        self.filters = togglebit(self.filters, bit(1));
    elseif (string == menuRaceString) then
        self.filters = togglebit(self.filters, bit(2));
    elseif (string == menuRepString) then
        self.filters = togglebit(self.filters, bit(3));
    elseif (string == menuClassString) then
        self.filters = togglebit(self.filters, bit(4));
    elseif (string == menuTextString) then
        self.mode = 1;
    elseif (string == menuIconString) then
        self.mode = 2;
    elseif (string == menuCaroString) then
        self.mode = 3;
    elseif (string == menuPullString) then
        self.mode = 4;
        -- elseif (string == menuMapString) then @TODO has to be reintroduced
        --    self.parent:SetMapHome();
    elseif (string == menuOptionsString) then
        OptionsWindow:SetVisible(true);
    elseif (string == menuSkillsString) then
        CheckSkills(true);
    elseif (string == moorMapString) then
        self.parent:OpenMapWindow(MapType.CREEPS);
    elseif (string == eriadorMapString) then
        self.parent:OpenMapWindow(MapType.ERIADOR);
    elseif (string == rhovanionMapString) then
        self.parent:OpenMapWindow(MapType.RHOVANION);
    elseif (string == rohanMapString) then
        self.parent:OpenMapWindow(MapType.ROHAN);
    elseif (string == gondorMapString) then
        self.parent:OpenMapWindow(MapType.GONDOR);
    elseif (string == haradwaithMapString) then
        self.parent:OpenMapWindow(MapType.HARADWAITH);
    end

    -- set the selections
    self:SetSelections();

    -- update the main window settings
    self.parent.dirty = true;
    self.parent:UpdateSettings();
    self.parent:SetOpacity(Settings.mainMinOpacity);
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

function InitDefaultSettings()
    -- set all settings to default values
    Settings = {};
    Settings.lastLoadedVersion = Plugins["Travel Window II"]:GetVersion();
    Settings.gridCols = 0;
    Settings.gridRows = 0;
    Settings.listWidth = 0;
    Settings.listRows = 0;
    Settings.positionX = Turbine.UI.Display.GetWidth() * 0.75;
    Settings.positionY = Turbine.UI.Display.GetHeight() * 0.75;
    Settings.buttonRelativeX = 0.95;
    Settings.buttonRelativeY = 0.75;
    Settings.useMinWindow = 0;
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
    Settings.fadeOutSteps = 1;
    Settings.fadeOutDelay = 0;
    Settings.toggleMaxOpacity = 1;
    Settings.toggleMinOpacity = 0.5;

    -- clear the maps
    Settings.mapGlanVraig = nil;
end

function InitNumberSetting(strTable, name, forceDefault)
    if not strTable[name] or strTable[name] == "nil" then
        if forceDefault == nil then
            strTable[name] = tostring(Settings[name]);
        else
            strTable[name] = tostring(forceDefault);
        end
    end
    if type(strTable[name]) == "string" then
        Settings[name] = tonumber(strTable[name]);
    else
        Settings[name] = strTable[name];
    end
end

function LoadSettings()
    -- if a value is not available, use a default value
    InitDefaultSettings();

    -- load TWII settings file
    local settingsStrings = PatchDataLoad(Turbine.DataScope.Character, "TravelWindowIISettings");
    AccountSettingsStrings = PatchDataLoad(Turbine.DataScope.Account, "TravelWindowIISettings");

    -- save a daily backup of settings
    if (settingsStrings) then
        settingsStrings.backupTime = "#" .. Turbine.Engine.GetGameTime();
        local dateInfo = Turbine.Engine.GetDate();
        PatchDataSave(Turbine.DataScope.Character, "TravelWindowIISettings_backup" .. dateInfo.DayOfWeek,
                      settingsStrings);
    end

    -- try importing Travel Window I settings if new settings were not found
    local importOldSettings = false;
    if (settingsStrings == nil) then
        local result;
        importOldSettings, result = pcall(function()
            settingsStrings = PatchDataLoad(Turbine.DataScope.Character, "TravelWindowSettings");
        end);
    end

    AccountSettingsStrings = SetSettings(AccountSettingsStrings);
    SetSettings(settingsStrings, importOldSettings);
    CheckEnabledSettings();
end

function SetSettings(settingsArg, importOldSettings)
    -- initialze any uninitialized settings strings
    if (type(settingsArg) ~= "table") then
        settingsArg = {};
    end

    if (not settingsArg.lastLoadedVersion or settingsArg.lastLoadedVersion == "nil") then
        settingsArg.lastLoadedVersion = tostring(Plugins["Travel Window II"]:GetVersion());
    end

    -- fixup deprecated buttonPositionX
    local buttonRelativeX = Settings.buttonRelativeX;
    if settingsArg.buttonPositionX and settingsArg.buttonPositionX ~= "nil" then
        local screenWidth = Turbine.UI.Display.GetWidth();
        if tonumber(settingsArg.buttonPositionX) < screenWidth then
            -- not perfect, but assuming the same resolution, this will approximately convert to a relative value
            buttonRelativeX = tonumber(settingsArg.buttonPositionX) / screenWidth;
            if buttonRelativeX > 1.0 then
                buttonRelativeX = Settings.buttonRelativeX;
            end
        end
        settingsArg.buttonPositionX = nil;
    end

    -- fixup deprecated buttonPositionY
    local buttonRelativeY = Settings.buttonRelativeY;
    if settingsArg.buttonPositionY and settingsArg.buttonPositionY ~= "nil" then
        local screenHeight = Turbine.UI.Display.GetHeight();
        if tonumber(settingsArg.buttonPositionY) < screenHeight then
            -- not perfect, but assuming the same resolution, this will approximately convert to a relative value
            buttonRelativeY = tonumber(settingsArg.buttonPositionY) / screenHeight;
            if buttonRelativeY > 1.0 then
                buttonRelativeY = Settings.buttonRelativeY;
            end
        end
        settingsArg.buttonPositionY = nil;
    end

    InitNumberSetting(settingsArg, "gridCols");
    InitNumberSetting(settingsArg, "gridRows");
    InitNumberSetting(settingsArg, "listWidth");
    InitNumberSetting(settingsArg, "listRows");
    InitNumberSetting(settingsArg, "positionX");
    InitNumberSetting(settingsArg, "positionY");
    InitNumberSetting(settingsArg, "buttonRelativeX", buttonRelativeX);
    InitNumberSetting(settingsArg, "buttonRelativeY", buttonRelativeY);
    InitNumberSetting(settingsArg, "useMinWindow");
    InitNumberSetting(settingsArg, "hideOnStart");
    InitNumberSetting(settingsArg, "hideOnCombat");
    InitNumberSetting(settingsArg, "pulldownTravel");
    InitNumberSetting(settingsArg, "hideOnTravel");
    InitNumberSetting(settingsArg, "ignoreEsc");
    InitNumberSetting(settingsArg, "showButton");
    InitNumberSetting(settingsArg, "mode");
    InitNumberSetting(settingsArg, "filters");
    InitNumberSetting(settingsArg, "mainMaxOpacity");
    InitNumberSetting(settingsArg, "mainMinOpacity");
    InitNumberSetting(settingsArg, "fadeOutSteps");
    InitNumberSetting(settingsArg, "fadeOutDelay");
    InitNumberSetting(settingsArg, "toggleMaxOpacity");
    InitNumberSetting(settingsArg, "toggleMinOpacity");

    if (settingsArg.mapGlanVraig ~= nil) then
        Settings.mapGlanVraig = settingsArg.mapGlanVraig;
    end

    if (not settingsArg.enabled or importOldSettings) then
        settingsArg.enabled = {};
    end

    if ((not settingsArg.order) or importOldSettings) then
        settingsArg.order = {};
    end

    Settings.lastLoadedVersion = settingsArg.lastLoadedVersion;
    Settings.enabled = TableCopy(settingsArg.enabled);

    local convertTableIndex = false;
    for i, v in pairs(settingsArg.order) do
        if (type(i) == "string") then
            convertTableIndex = true;
        end
    end

    if (convertTableIndex) then
        Settings.order = OrderTableNumberIndex(settingsArg);
    else
        Settings.order = TableCopy(settingsArg.order);
    end
    return settingsArg;
end

function SaveSettings(scope)
    local settingsStrings = {};
    settingsStrings.lastLoadedVersion = tostring(Settings.lastLoadedVersion);
    settingsStrings.gridCols = tostring(Settings.gridCols);
    settingsStrings.gridRows = tostring(Settings.gridRows);
    settingsStrings.listWidth = tostring(Settings.listWidth);
    settingsStrings.listRows = tostring(Settings.listRows);
    settingsStrings.positionX = tostring(Settings.positionX);
    settingsStrings.positionY = tostring(Settings.positionY);
    settingsStrings.buttonRelativeX = tostring(Settings.buttonRelativeX);
    settingsStrings.buttonRelativeY = tostring(Settings.buttonRelativeY);
    settingsStrings.useMinWindow = tostring(Settings.useMinWindow);
    settingsStrings.hideOnStart = tostring(Settings.hideOnStart);
    settingsStrings.hideOnCombat = tostring(Settings.hideOnCombat);
    settingsStrings.pulldownTravel = tostring(Settings.pulldownTravel);
    settingsStrings.hideOnTravel = tostring(Settings.hideOnTravel);
    settingsStrings.ignoreEsc = tostring(Settings.ignoreEsc);
    settingsStrings.showButton = tostring(Settings.showButton);
    settingsStrings.mode = tostring(Settings.mode);
    settingsStrings.filters = tostring(Settings.filters);
    settingsStrings.mainMaxOpacity = tostring(Settings.mainMaxOpacity);
    settingsStrings.mainMinOpacity = tostring(Settings.mainMinOpacity);
    settingsStrings.fadeOutSteps = tostring(Settings.fadeOutSteps);
    settingsStrings.fadeOutDelay = tostring(Settings.fadeOutDelay);
    settingsStrings.toggleMaxOpacity = tostring(Settings.toggleMaxOpacity);
    settingsStrings.toggleMinOpacity = tostring(Settings.toggleMinOpacity);
    settingsStrings.enabled = TableCopy(Settings.enabled);
    settingsStrings.mapGlanVraig = tostring(Settings.mapGlanVraig);

    settingsStrings.order = OrderTableStringIndex();

    if scope == nil then
        scope = Turbine.DataScope.Character;
    end
    if scope == Turbine.DataScope.Character then
        CharacterSettingsStrings = settingsStrings;
    elseif scope == Turbine.DataScope.Account then
        AccountSettingsStrings = settingsStrings;
    end

    -- save the settings
    PatchDataSave(scope, "TravelWindowIISettings", settingsStrings);
end

function OrderTableStringIndex()
    order = {}
    for i, v in ipairs(Settings.order) do
        order[tostring(i)] = v;
    end
    return order;
end

function OrderTableNumberIndex(settingsArg)
    order = {};

    for i, v in pairs(settingsArg.order) do
        order[tonumber(i)] = v;
    end
    return order;
end

-- this method influences the default sorting order of skills
function CheckEnabledSettings()
    if (PlayerAlignment == Turbine.Gameplay.Alignment.FreePeople) then
        -- update generic travel settings
        AddNewSettings(TravelInfo.gen);

        -- update racial travel settings
        local racialId = TravelInfo.racial.id;
        if (Settings.enabled[racialId] == nil) then
            Settings.enabled[racialId] = true;
        end
        if (TableContains(Settings.order, racialId) == false) then
            table.insert(Settings.order, racialId);
        end

        -- update class travel settings
        AddNewSettings(TravelInfo:GetClassSkills());

        -- update reputation travel settings
        AddNewSettings(TravelInfo.rep);
    else
        -- update creep travel settings
        AddNewSettings(TravelInfo.creep);
    end
end

function AddNewSettings(skills)
    if skills == nil then return end
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
