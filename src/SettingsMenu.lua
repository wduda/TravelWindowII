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
        self.parent:OpenOptions();
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

    if (not SettingsStrings.gridCols or SettingsStrings.gridCols == "nil") then
        SettingsStrings.gridCols = tostring(0);
    end

    if (not SettingsStrings.gridRows or SettingsStrings.gridRows == "nil") then
        SettingsStrings.gridRows = tostring(0);
    end

    if (not SettingsStrings.listWidth or SettingsStrings.listWidth == "nil") then
        SettingsStrings.listWidth = tostring(0);
    end

    if (not SettingsStrings.listRows or SettingsStrings.listRows == "nil") then
        SettingsStrings.listRows = tostring(0);
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

    if (not SettingsStrings.useMinWindow or SettingsStrings.useMinWindow == "nil") then
        SettingsStrings.useMinWindow = tostring(0);
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
    if (type(SettingsStrings.gridCols) == "string") then
        Settings.gridCols = tonumber(SettingsStrings.gridCols);
    else
        Settings.gridCols = SettingsStrings.gridCols;
    end

    if (type(SettingsStrings.gridRows) == "string") then
        Settings.gridRows = tonumber(SettingsStrings.gridRows);
    else
        Settings.gridRows = SettingsStrings.gridRows;
    end

    if (type(SettingsStrings.listWidth) == "string") then
        Settings.listWidth = tonumber(SettingsStrings.listWidth);
    else
        Settings.listWidth = SettingsStrings.listWidth;
    end

    if (type(SettingsStrings.listRows) == "string") then
        Settings.listRows = tonumber(SettingsStrings.listRows);
    else
        Settings.listRows = SettingsStrings.listRows;
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

    if (type(SettingsStrings.useMinWindow) == "string") then
        Settings.useMinWindow = tonumber(SettingsStrings.useMinWindow);
    else
        Settings.useMinWindow = SettingsStrings.useMinWindow;
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
    SettingsStrings.gridCols = tostring(Settings.gridCols);
    SettingsStrings.gridRows = tostring(Settings.gridRows);
    SettingsStrings.listWidth = tostring(Settings.listWidth);
    SettingsStrings.listRows = tostring(Settings.listRows);
    SettingsStrings.positionX = tostring(Settings.positionX);
    SettingsStrings.positionY = tostring(Settings.positionY);
    SettingsStrings.buttonRelativeX = tostring(Settings.buttonRelativeX);
    SettingsStrings.buttonRelativeY = tostring(Settings.buttonRelativeY);
    SettingsStrings.useMinWindow = tostring(Settings.useMinWindow);
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
