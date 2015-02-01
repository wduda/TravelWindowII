import "DhorPlugins.Utils.BitOps";
import "DhorPlugins.Extensions";

SettingsMenu = class(Turbine.UI.ContextMenu)

function SettingsMenu:Constructor(parentWindow)
    Turbine.UI.ContextMenu.Constructor(self);

    -- create shortcuts to the bitop functions
    bit = DhorPlugins.bit;
    hasbit = DhorPlugins.hasbit;
    setbit = DhorPlugins.setbit;
    clearbit = DhorPlugins.clearbit;
    togglebit = DhorPlugins.togglebit;

    -- set the default values
    self.race = 1;
    self.class = 1;
    self.mode = 1;
    self.filters = 0x0F;

    self.parent = parentWindow;

    -- create the filter sub menu
    Filters = DhorPlugins.Extensions.DMenuList(menuFiltersString);
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
    Mode = DhorPlugins.Extensions.DMenuList(menuModeString);
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
    MapMenu = DhorPlugins.Extensions.DMenuList(menuMapString);

    -- create the menu tiem to open the options window
    OptionsMenu = DhorPlugins.Extensions.DMenuList(menuOptionsString);
    SkillsMenu = DhorPlugins.Extensions.DMenuList(menuSkillsString);

    -- create the item to opem the moors map window
    MoorMapMenu = DhorPlugins.Extensions.DMenuList(moorMapString);
    EriadorMapMenu = DhorPlugins.Extensions.DMenuList(eriadorMapString);
    RhovanionMapMenu = DhorPlugins.Extensions.DMenuList(rhovanionMapString);
    GondorMapMenu = DhorPlugins.Extensions.DMenuList(gondorMapString);

    -- add everything to the main menu
    menuItems = self:GetItems();
    if (playerAlignment == Turbine.Gameplay.Alignment.MonsterPlayer) then
        menuItems:Add(Mode);
        menuItems:Add(OptionsMenu);
        menuItems:Add(MoorMapMenu);
    else
        menuItems:Add(Filters);
        menuItems:Add(Mode);
        menuItems:Add(MapMenu);
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
    if (playerAlignment == Turbine.Gameplay.Alignment.FreePeople) then
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
    return self.race, self.class, self.mode, self.filters;
end

-- function to change the settings of the menu programmatically
function SettingsMenu:SetSettings(s1, s2, s3, s4)
    self.race = s1;
    self.class = s2;
    self.mode = s3;
    self.filters = s4;

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
    elseif (string == menuMapString) then
        self.parent:SetMapHome();
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
end




