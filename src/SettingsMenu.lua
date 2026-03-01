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

    self.filterGen.action = "toggleFilter"
    self.filterGen.value = FilterId.GEN
    self.filterRace.action = "toggleFilter"
    self.filterRace.value = FilterId.RACE
    self.filterRep.action = "toggleFilter"
    self.filterRep.value = FilterId.REP
    self.filterClass.action = "toggleFilter"
    self.filterClass.value = FilterId.CLASS

    self.menuList.action = "setMode"
    self.menuList.value = TabId.LIST
    self.menuGrid.action = "setMode"
    self.menuGrid.value = TabId.GRID
    self.menuCaro.action = "setMode"
    self.menuCaro.value = TabId.CARO
    self.menuPull.action = "setMode"
    self.menuPull.value = TabId.PULL
    self.menuMap.action = "setMode"
    self.menuMap.value = TabId.MAP

    self.menuOptions.action = "openOptions"

    self.buttonIconDefault.action = "setButtonIcon"
    self.buttonIconDefault.value = TravelButtonIconId.DEFAULT
    self.buttonIconBoots.action = "setButtonIcon"
    self.buttonIconBoots.value = TravelButtonIconId.BOOTS
    self.buttonIconBackpack.action = "setButtonIcon"
    self.buttonIconBackpack.value = TravelButtonIconId.BACKPACK
    self.buttonIconHorse.action = "setButtonIcon"
    self.buttonIconHorse.value = TravelButtonIconId.HORSE
    self.buttonSize100.action = "setButtonSize"
    self.buttonSize100.value = TravelButtonSize.SMALL
    self.buttonSize150.action = "setButtonSize"
    self.buttonSize150.value = TravelButtonSize.MEDIUM
    self.buttonSize200.action = "setButtonSize"
    self.buttonSize200.value = TravelButtonSize.LARGE

    local function bindMenuItem(menuItem)
        menuItem.Click = function(sender, args)
            self:Update(sender.action, sender.value)
        end
    end

    bindMenuItem(self.filterGen)
    bindMenuItem(self.filterRace)
    bindMenuItem(self.filterRep)
    bindMenuItem(self.filterClass)
    bindMenuItem(self.menuList)
    bindMenuItem(self.menuGrid)
    bindMenuItem(self.menuCaro)
    bindMenuItem(self.menuPull)
    bindMenuItem(self.menuMap)
    bindMenuItem(self.menuOptions)
    bindMenuItem(self.buttonIconDefault)
    bindMenuItem(self.buttonIconBoots)
    bindMenuItem(self.buttonIconBackpack)
    bindMenuItem(self.buttonIconHorse)
    bindMenuItem(self.buttonSize100)
    bindMenuItem(self.buttonSize150)
    bindMenuItem(self.buttonSize200)

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

function SettingsMenu:Update(action, value)
    local shouldUpdateMainWindow = false

    if action == "toggleFilter" then
        Settings.filters = togglebit(Settings.filters, bit(value))
        shouldUpdateMainWindow = true
    elseif action == "setMode" then
        Settings.mode = value
        shouldUpdateMainWindow = true
    elseif action == "openOptions" then
        _G.options:SetVisible(true)
    elseif action == "setButtonIcon" then
        Settings.buttonIconStyle = value
        if ToggleButton ~= nil then
            ToggleButton:ApplyAppearance()
        end
    elseif action == "setButtonSize" then
        Settings.buttonSize = value
        if ToggleButton ~= nil then
            ToggleButton:ApplyAppearance()
        end
    else
        return
    end

    self:SetSelections()

    if _G.options ~= nil and _G.options.Panel ~= nil then
        _G.options.Panel:UpdateOptions()
    end

    if shouldUpdateMainWindow then
        self.parent.dirty = true
        self.parent:UpdateSettings()
    end
end
