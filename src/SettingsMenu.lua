import "TravelWindowII.src.utils.BitOps";
import "TravelWindowII.src.extensions";

SettingsMenu = class(Turbine.UI.ContextMenu)

function SettingsMenu:Constructor(parentWindow)
    Turbine.UI.ContextMenu.Constructor(self);

    -- create shortcuts to the bitop functions
    bit = TravelWindowII.bit;
    hasbit = TravelWindowII.hasbit;
    setbit = TravelWindowII.setbit;
    clearbit = TravelWindowII.clearbit;
    togglebit = TravelWindowII.togglebit;

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
        self.parent:CheckSkills(true);
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

