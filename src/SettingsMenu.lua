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
    ModeItems = Mode:GetItems();
    ModeItems:Add(self.Mode1);
    ModeItems:Add(self.Mode2);
    ModeItems:Add(self.Mode3);
    ModeItems:Add(self.Mode4);

    -- create the menu item to add map home
    -- @TODO has to be reintroduced
    MapMenu = TravelWindowII.src.extensions.DMenuList("");

    -- create the menu item to open the options window
    OptionsMenu = TravelWindowII.src.extensions.DMenuList(menuOptionsString);
    SkillsMenu = TravelWindowII.src.extensions.DMenuList(menuSkillsString);

    -- create the items to open the map windows
    MoorMapMenu = TravelWindowII.src.extensions.DMenuList(moorMapString);
    EriadorMapMenu = TravelWindowII.src.extensions.DMenuList(eriadorMapString);
    RhovanionMapMenu = TravelWindowII.src.extensions.DMenuList(rhovanionMapString);
    GondorMapMenu = TravelWindowII.src.extensions.DMenuList(gondorMapString);

    -- add everything to the main menu
    menuItems = self:GetItems();
    if (PlayerAlignment == Turbine.Gameplay.Alignment.MonsterPlayer) then
        menuItems:Add(Mode);
        menuItems:Add(OptionsMenu);
        menuItems:Add(MoorMapMenu);
    else
        menuItems:Add(Filters);
        menuItems:Add(Mode);
        menuItems:Add(MapMenu); -- @TODO needs to be reintroduced
        menuItems:Add(OptionsMenu);
        menuItems:Add(SkillsMenu);
        menuItems:Add(EriadorMapMenu);
        menuItems:Add(RhovanionMapMenu);
        menuItems:Add(GondorMapMenu);
    end

    -- set up the event handler
    -- loop through top level of menu
    for i = 1, menuItems:GetCount(), 1 do
        local menuList = menuItems:Get(i);

        -- loop through the sub menu
        for j = 1, menuList:GetCount(), 1 do
            local menuItem = menuList:Get(j);

            -- set the function to handle the event
            menuItem.Click = function(sender, args)
                self:Update(sender:GetText());
            end
        end
    end

    -- handle the last item's event
    if (PlayerAlignment == Turbine.Gameplay.Alignment.FreePeople) then
        menuItems:Get(3).Click = function(sender, args)
            self:Update(sender:GetText());
        end

        menuItems:Get(4).Click = function(sender, args)
            self:Update(sender:GetText());
        end

        menuItems:Get(5).Click = function(sender, args)
            self:Update(sender:GetText());
        end

        menuItems:Get(6).Click = function(sender, args)
            self:Update(sender:GetText());
        end

        menuItems:Get(7).Click = function(sender, args)
            self:Update(sender:GetText());
        end

        menuItems:Get(8).Click = function(sender, args)
            self:Update(sender:GetText());
        end
    else
        menuItems:Get(2).Click = function(sender, args)
            self:Update(sender:GetText());
        end

        menuItems:Get(3).Click = function(sender, args)
            self:Update(sender:GetText());
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
    --elseif (string == menuMapString) then @TODO has to be reintroduced
    --    self.parent:SetMapHome();
    elseif (string == menuOptionsString) then
        self.parent:OpenOptions();
    elseif (string == menuSkillsString) then
        self.parent:CheckSkills();
    elseif (string == moorMapString) then
        self.parent:OpenMoorMap();
    elseif (string == eriadorMapString) then
        self.parent:OpenEriadorMap();
    elseif (string == rhovanionMapString) then
        self.parent:OpenRhovanionMap();
    elseif (string == gondorMapString) then
        self.parent:OpenGondorMap();
    end

    -- set the selections
    self:SetSelections();

    -- update the main window settings
    self.parent:UpdateSettings();
    self.parent:SaveSettings();
end




