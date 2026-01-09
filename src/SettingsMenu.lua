import "TravelWindowII.src.SettingsManager"
import "TravelWindowII.src.utils.BitOps"
import "TravelWindowII.src.extensions"

SettingsMenu = class(Turbine.UI.ContextMenu)

function SettingsMenu:Constructor(parentWindow)
    Turbine.UI.ContextMenu.Constructor(self);

    -- set the default values
    self.mode = TabId.GRID;
    self.filters = 0x0F;

    self.parent = parentWindow;

    FilterId = {
        GEN = 1,
        RACE = 2,
        REP = 3,
        CLASS = 4,
    }

    -- create the filter sub menu
    Filters = TravelWindowII.src.extensions.DMenuList(LC.menuFilters)
    self.filterGen = Turbine.UI.MenuItem(LC.menuGen)
    self.filterRace = Turbine.UI.MenuItem(LC.menuRace)
    self.filterRep = Turbine.UI.MenuItem(LC.menuRep)
    self.filterClass = Turbine.UI.MenuItem(LC.menuClass)
    FilterItems = Filters:GetItems()
    FilterItems:Add(self.filterGen)
    FilterItems:Add(self.filterRace)
    FilterItems:Add(self.filterRep)
    FilterItems:Add(self.filterClass)

    -- create the mode sub menu
    Mode = TravelWindowII.src.extensions.DMenuList(LC.menuMode)
    self.menuList = Turbine.UI.MenuItem(LC.menuText)
    self.menuGrid = Turbine.UI.MenuItem(LC.menuIcon)
    self.menuCaro = Turbine.UI.MenuItem(LC.menuCaro)
    self.menuPull = Turbine.UI.MenuItem(LC.menuPull)
    self.menuMap = Turbine.UI.MenuItem(LC.menuMap)
    local ModeItems = Mode:GetItems()
    ModeItems:Add(self.menuList)
    ModeItems:Add(self.menuGrid)
    ModeItems:Add(self.menuCaro)
    ModeItems:Add(self.menuPull)
    ModeItems:Add(self.menuMap)

    -- create the menu item to open the options window
    OptionsMenu = TravelWindowII.src.extensions.DMenuList(LC.menuOptions);

    -- add everything to the main menu
    MenuItems = self:GetItems();
    if (PlayerAlignment == Turbine.Gameplay.Alignment.MonsterPlayer) then
        MenuItems:Add(Mode);
        MenuItems:Add(OptionsMenu);
    else
        MenuItems:Add(Filters);
        MenuItems:Add(Mode);
        MenuItems:Add(OptionsMenu);
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
    self.filterGen:SetChecked(hasbit(self.filters, bit(FilterId.GEN)))
    self.filterRace:SetChecked(hasbit(self.filters, bit(FilterId.RACE)))
    self.filterRep:SetChecked(hasbit(self.filters, bit(FilterId.REP)))
    self.filterClass:SetChecked(hasbit(self.filters, bit(FilterId.CLASS)))

    -- set the mode
    self.menuList:SetChecked(self.mode == TabId.LIST)
    self.menuGrid:SetChecked(self.mode == TabId.GRID)
    self.menuCaro:SetChecked(self.mode == TabId.CARO)
    self.menuPull:SetChecked(self.mode == TabId.PULL)
    self.menuMap:SetChecked(self.mode == TabId.MAP)
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
    if (string == LC.menuGen) then
        self.filters = togglebit(self.filters, bit(FilterId.GEN))
    elseif (string == LC.menuRace) then
        self.filters = togglebit(self.filters, bit(FilterId.RACE))
    elseif (string == LC.menuRep) then
        self.filters = togglebit(self.filters, bit(FilterId.REP))
    elseif (string == LC.menuClass) then
        self.filters = togglebit(self.filters, bit(FilterId.CLASS))
    elseif (string == LC.menuText) then
        self.mode = TabId.LIST
    elseif (string == LC.menuIcon) then
        self.mode = TabId.GRID
    elseif (string == LC.menuCaro) then
        self.mode = TabId.CARO
    elseif (string == LC.menuPull) then
        self.mode = TabId.PULL
    elseif (string == LC.menuMap) then
        self.mode = TabId.MAP
    elseif (string == LC.menuOptions) then
        OptionsWindow:SetVisible(true);
    end

    -- set the selections
    self:SetSelections();

    -- update the main window settings
    self.parent.dirty = true;
    self.parent:UpdateSettings();
    self.parent:SetOpacity(Settings.mainMinOpacity)
end
