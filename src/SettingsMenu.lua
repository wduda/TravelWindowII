import "TravelWindowII.src.SettingsManager"
import "TravelWindowII.src.utils.BitOps"
import "TravelWindowII.src.extensions"

SettingsMenu = class(Turbine.UI.ContextMenu)

function SettingsMenu:Constructor(parentWindow)
    Turbine.UI.ContextMenu.Constructor(self)

    self.parent = parentWindow

    Filters = TravelWindowII.src.extensions.DMenuList(LC.menuFilters)
    self.filterGen = Turbine.UI.MenuItem(LC.menuGen)
    self.filterRace = Turbine.UI.MenuItem(LC.menuRace)
    self.filterRep = Turbine.UI.MenuItem(LC.menuRep)
    self.filterClass = Turbine.UI.MenuItem(LC.menuClass)
    local filterItems = Filters:GetItems()
    filterItems:Add(self.filterGen)
    filterItems:Add(self.filterRace)
    filterItems:Add(self.filterRep)
    filterItems:Add(self.filterClass)

    Mode = TravelWindowII.src.extensions.DMenuList(LC.menuMode)
    self.menuList = Turbine.UI.MenuItem(LC.menuText)
    self.menuGrid = Turbine.UI.MenuItem(LC.menuIcon)
    self.menuCaro = Turbine.UI.MenuItem(LC.menuCaro)
    self.menuPull = Turbine.UI.MenuItem(LC.menuPull)
    self.menuMap  = Turbine.UI.MenuItem(LC.menuMap)
    local modeItems = Mode:GetItems()
    modeItems:Add(self.menuList)
    modeItems:Add(self.menuGrid)
    modeItems:Add(self.menuCaro)
    modeItems:Add(self.menuPull)
    modeItems:Add(self.menuMap)

    ButtonMenu = TravelWindowII.src.extensions.DMenuList(LC.menuButton)
    self.menuButtonIcon = TravelWindowII.src.extensions.DMenuList(LC.menuButtonIcon)
    self.menuButtonSize = TravelWindowII.src.extensions.DMenuList(LC.menuButtonSize)
    self.menuOptions = Turbine.UI.MenuItem(LC.menuOptions)

    self.buttonIconDefault = Turbine.UI.MenuItem(LC.buttonIconDefault)
    self.buttonIconBoots = Turbine.UI.MenuItem(LC.buttonIconBoots)
    self.buttonIconBackpack = Turbine.UI.MenuItem(LC.buttonIconBackpack)
    self.buttonIconHorse = Turbine.UI.MenuItem(LC.buttonIconHorse)
    self.buttonSize100 = Turbine.UI.MenuItem(LC.buttonSize100)
    self.buttonSize150 = Turbine.UI.MenuItem(LC.buttonSize150)
    self.buttonSize200 = Turbine.UI.MenuItem(LC.buttonSize200)

    local buttonMenuItems = ButtonMenu:GetItems()
    buttonMenuItems:Add(self.menuButtonIcon)
    buttonMenuItems:Add(self.menuButtonSize)

    local buttonIconItems = self.menuButtonIcon:GetItems()
    buttonIconItems:Add(self.buttonIconDefault)
    buttonIconItems:Add(self.buttonIconBoots)
    buttonIconItems:Add(self.buttonIconBackpack)
    buttonIconItems:Add(self.buttonIconHorse)

    local buttonSizeItems = self.menuButtonSize:GetItems()
    buttonSizeItems:Add(self.buttonSize100)
    buttonSizeItems:Add(self.buttonSize150)
    buttonSizeItems:Add(self.buttonSize200)

    MenuItems = self:GetItems()
    if (PlayerAlignment == Turbine.Gameplay.Alignment.MonsterPlayer) then
        MenuItems:Add(Mode)
        MenuItems:Add(ButtonMenu)
        MenuItems:Add(self.menuOptions)
    else
        MenuItems:Add(Filters)
        MenuItems:Add(Mode)
        MenuItems:Add(ButtonMenu)
        MenuItems:Add(self.menuOptions)
    end

    local function bindMenuItem(menuItem, callback)
        menuItem.Click = function()
            callback()
        end
    end

    bindMenuItem(self.filterGen, function()
        Settings.filters = togglebit(Settings.filters, bit(FilterId.GEN))
        self:RefreshAfterChange(true)
    end)
    bindMenuItem(self.filterRace, function()
        Settings.filters = togglebit(Settings.filters, bit(FilterId.RACE))
        self:RefreshAfterChange(true)
    end)
    bindMenuItem(self.filterRep, function()
        Settings.filters = togglebit(Settings.filters, bit(FilterId.REP))
        self:RefreshAfterChange(true)
    end)
    bindMenuItem(self.filterClass, function()
        Settings.filters = togglebit(Settings.filters, bit(FilterId.CLASS))
        self:RefreshAfterChange(true)
    end)

    bindMenuItem(self.menuList, function()
        Settings.mode = TabId.LIST
        self:RefreshAfterChange(true)
    end)
    bindMenuItem(self.menuGrid, function()
        Settings.mode = TabId.GRID
        self:RefreshAfterChange(true)
    end)
    bindMenuItem(self.menuCaro, function()
        Settings.mode = TabId.CARO
        self:RefreshAfterChange(true)
    end)
    bindMenuItem(self.menuPull, function()
        Settings.mode = TabId.PULL
        self:RefreshAfterChange(true)
    end)
    bindMenuItem(self.menuMap, function()
        Settings.mode = TabId.MAP
        self:RefreshAfterChange(true)
    end)

    bindMenuItem(self.menuOptions, function()
        if _G.options ~= nil then
            _G.options:SetVisible(true)
        end
        self:RefreshAfterChange(false)
    end)

    bindMenuItem(self.buttonIconDefault, function()
        Settings.buttonIconStyle = TravelButtonIconId.DEFAULT
        self:ApplyToggleButtonAppearance()
        self:RefreshAfterChange(false)
    end)
    bindMenuItem(self.buttonIconBoots, function()
        Settings.buttonIconStyle = TravelButtonIconId.BOOTS
        self:ApplyToggleButtonAppearance()
        self:RefreshAfterChange(false)
    end)
    bindMenuItem(self.buttonIconBackpack, function()
        Settings.buttonIconStyle = TravelButtonIconId.BACKPACK
        self:ApplyToggleButtonAppearance()
        self:RefreshAfterChange(false)
    end)
    bindMenuItem(self.buttonIconHorse, function()
        Settings.buttonIconStyle = TravelButtonIconId.HORSE
        self:ApplyToggleButtonAppearance()
        self:RefreshAfterChange(false)
    end)

    bindMenuItem(self.buttonSize100, function()
        Settings.buttonSize = TravelButtonSize.SMALL
        self:ApplyToggleButtonAppearance()
        self:RefreshAfterChange(false)
    end)
    bindMenuItem(self.buttonSize150, function()
        Settings.buttonSize = TravelButtonSize.MEDIUM
        self:ApplyToggleButtonAppearance()
        self:RefreshAfterChange(false)
    end)
    bindMenuItem(self.buttonSize200, function()
        Settings.buttonSize = TravelButtonSize.LARGE
        self:ApplyToggleButtonAppearance()
        self:RefreshAfterChange(false)
    end)

    self:SetSelections()
end

function SettingsMenu:SetSelections()
    local selectedIconId = GetTravelButtonIconOption(Settings.buttonIconStyle).id
    local selectedSizeValue = GetTravelButtonSizeOption(Settings.buttonSize).value

    self.filterGen:SetChecked(hasbit(Settings.filters, bit(FilterId.GEN)))
    self.filterRace:SetChecked(hasbit(Settings.filters, bit(FilterId.RACE)))
    self.filterRep:SetChecked(hasbit(Settings.filters, bit(FilterId.REP)))
    self.filterClass:SetChecked(hasbit(Settings.filters, bit(FilterId.CLASS)))

    self.menuList:SetChecked(Settings.mode == TabId.LIST)
    self.menuGrid:SetChecked(Settings.mode == TabId.GRID)
    self.menuCaro:SetChecked(Settings.mode == TabId.CARO)
    self.menuPull:SetChecked(Settings.mode == TabId.PULL)
    self.menuMap:SetChecked(Settings.mode == TabId.MAP)

    self.buttonIconDefault:SetChecked(selectedIconId == TravelButtonIconId.DEFAULT)
    self.buttonIconBoots:SetChecked(selectedIconId == TravelButtonIconId.BOOTS)
    self.buttonIconBackpack:SetChecked(selectedIconId == TravelButtonIconId.BACKPACK)
    self.buttonIconHorse:SetChecked(selectedIconId == TravelButtonIconId.HORSE)
    self.buttonSize100:SetChecked(selectedSizeValue == TravelButtonSize.SMALL)
    self.buttonSize150:SetChecked(selectedSizeValue == TravelButtonSize.MEDIUM)
    self.buttonSize200:SetChecked(selectedSizeValue == TravelButtonSize.LARGE)
end

function SettingsMenu:ApplyToggleButtonAppearance()
    if ToggleButton ~= nil then
        ToggleButton:ApplyAppearance()
    end
end

function SettingsMenu:RefreshAfterChange(shouldUpdateMainWindow)
    self:SetSelections()

    if _G.options ~= nil and _G.options.Panel ~= nil then
        _G.options.Panel:UpdateOptions()
    end

    if shouldUpdateMainWindow then
        self.parent.dirty = true
        self.parent:UpdateSettings()
    end
end
