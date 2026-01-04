import "Turbine.Gameplay"
import "Turbine.UI"
import "Turbine.UI.Lotro"
import "TravelWindowII.src.extensions"
import "TravelWindowII.src.SettingsMenu"
import "TravelWindowII.src.utils.BitOps"

--[[ This is the window for the map tab of the Travel UI.  ]] --
--[[ It displays a regional map with travel skill shortcuts ]] --
--[[ positioned on the map. Users can cycle through regions ]] --
--[[ using left/right arrow buttons.                        ]] --

TravelMapTab = class(Turbine.UI.Control)

function TravelMapTab:Constructor(toplevel)
    Turbine.UI.Control.Constructor(self)

    -- need top level window in order to close it
    self.parent = toplevel

    -- Map configuration
    self.mapWidth = 1024
    self.mapHeight = 768
    self.quickslots = {}

    MapType = {
        NONE = 1,
        CREEPS = 2,
        ERIADOR = 3,
        RHOVANION = 4,
        ROHAN = 5,
        GONDOR = 6,
        HARADWAITH = 7,
    }

    -- Set initial region (will be loaded from settings)
    if PlayerAlignment == Turbine.Gameplay.Alignment.MonsterPlayer then
        self.currentRegion = MapType.CREEPS
        self.regions = {MapType.CREEPS}
    else
        self.currentRegion = Settings.mapViewRegion or MapType.ERIADOR
        self.regions = {
            MapType.ERIADOR,
            MapType.RHOVANION,
            MapType.ROHAN,
            MapType.GONDOR,
            MapType.HARADWAITH
        }
    end

    -- Region names for display (just use simple names)
    self.regionNames = {
        [MapType.NONE] = "None",
        [MapType.CREEPS] = "Ettenmoors",
        [MapType.ERIADOR] = "Eriador",
        [MapType.RHOVANION] = "Rhovanion",
        [MapType.ROHAN] = "Rohan",
        [MapType.GONDOR] = "Gondor",
        [MapType.HARADWAITH] = "Haradwaith"
    }

    -- Create a subwindow (now a control) for containing the map
    self.SubWindow = Turbine.UI.Control()
    self.SubWindow:SetPosition(0, 0)
    self.SubWindow:SetParent(self)
    self.SubWindow:SetMouseVisible(true)

    -- Create the map display label
    self.mapLabel = Turbine.UI.Label()
    self.mapLabel:SetSize(self.mapWidth, self.mapHeight)
    self.mapLabel:SetParent(self.SubWindow)
    self.mapLabel:SetVisible(true)
    self.mapLabel:SetMouseVisible(true)
    self.mapLabel:SetPosition(0, 0)

    -- Set up horizontal scrollbar
    self.hScrollBar = Turbine.UI.Lotro.ScrollBar()
    self.hScrollBar:SetOrientation(Turbine.UI.Orientation.Horizontal)
    self.hScrollBar:SetParent(self)
    self.hScrollBar:SetMinimum(0)
    self.hScrollBar:SetMaximum(0)
    self.hScrollBar:SetVisible(false)

    self.hScrollBar.ValueChanged = function(sender, args)
        self:UpdateSubWindow()
    end

    self.hScrollBar.MouseClick = function(sender, args)
        if (args.Button == Turbine.UI.MouseButton.Right) then
            Menu:ShowMenu()
        end
    end

    -- Set up vertical scrollbar
    self.vScrollBar = Turbine.UI.Lotro.ScrollBar()
    self.vScrollBar:SetOrientation(Turbine.UI.Orientation.Vertical)
    self.vScrollBar:SetParent(self)
    self.vScrollBar:SetMinimum(0)
    self.vScrollBar:SetMaximum(0)
    self.vScrollBar:SetVisible(false)

    self.vScrollBar.ValueChanged = function(sender, args)
        self:UpdateSubWindow()
    end

    self.vScrollBar.MouseClick = function(sender, args)
        if (args.Button == Turbine.UI.MouseButton.Right) then
            Menu:ShowMenu()
        end
    end

    -- Create navigation panel at bottom
    self.navPanel = Turbine.UI.Control()
    self.navPanel:SetParent(self)
    self.navPanel:SetSize(self.mapWidth, 30)
    self.navPanel:SetBackColor(Turbine.UI.Color(0.8, 0, 0, 0))

    -- Create left arrow button
    self.leftArrow = Turbine.UI.Lotro.Button()
    self.leftArrow:SetParent(self.navPanel)
    self.leftArrow:SetSize(100, 25)
    self.leftArrow:SetText("◄ " .. (LC.menuPrevious or "Previous"))
    self.leftArrow.Click = function()
        self:CycleRegion(-1)
    end

    -- Create region name label
    self.regionLabel = Turbine.UI.Label()
    self.regionLabel:SetParent(self.navPanel)
    self.regionLabel:SetSize(300, 25)
    self.regionLabel:SetFont(Turbine.UI.Lotro.Font.TrajanPro15)
    self.regionLabel:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleCenter)
    self.regionLabel:SetForeColor(Turbine.UI.Color.White)

    -- Create right arrow button
    self.rightArrow = Turbine.UI.Lotro.Button()
    self.rightArrow:SetParent(self.navPanel)
    self.rightArrow:SetSize(100, 25)
    self.rightArrow:SetText((LC.menuNext or "Next") .. " ►")
    self.rightArrow.Click = function()
        self:CycleRegion(1)
    end

    -- Add mouse wheel support
    self.SubWindow.MouseWheel = function(sender, args)
        self:DoScroll(sender, args)
    end

    -- Show the menu when right clicked
    self.MouseClick = function(sender, args)
        if (args.Button == Turbine.UI.MouseButton.Right) then
            Menu:ShowMenu()
        end
    end

    self.mapLabel.MouseClick = function(sender, args)
        if (args.Button == Turbine.UI.MouseButton.Right) then
            Menu:ShowMenu()
        end
    end

    -- Load the initial map
    self:LoadMap()
end

-- Handle mouse wheel scrolling
function TravelMapTab:DoScroll(sender, args)
    if args.Direction == -1 then
        -- Scroll down
        local newValue = self.vScrollBar:GetValue() + 50
        if newValue > self.vScrollBar:GetMaximum() then
            newValue = self.vScrollBar:GetMaximum()
        end
        self.vScrollBar:SetValue(newValue)
    else
        -- Scroll up
        local newValue = self.vScrollBar:GetValue() - 50
        if newValue < 0 then
            newValue = 0
        end
        self.vScrollBar:SetValue(newValue)
    end
end

-- Update the subwindow position based on scrollbar values
function TravelMapTab:UpdateSubWindow()
    local x = -self.hScrollBar:GetValue()
    local y = -self.vScrollBar:GetValue()
    self.mapLabel:SetPosition(x, y)
end

-- Update scrollbar visibility and ranges
function TravelMapTab:UpdateScrollBars()
    local width = self:GetWidth()
    local height = self:GetHeight() - 30  -- Leave room for nav panel

    -- Calculate scrollbar visibility and ranges
    local hMax = self.mapWidth - width
    local vMax = self.mapHeight - height

    if hMax > 0 then
        self.hScrollBar:SetVisible(true)
        self.hScrollBar:SetMaximum(hMax)
        height = height - 10  -- Reduce height for horizontal scrollbar
    else
        self.hScrollBar:SetVisible(false)
        self.hScrollBar:SetMaximum(0)
        self.hScrollBar:SetValue(0)
    end

    if vMax > 0 then
        self.vScrollBar:SetVisible(true)
        self.vScrollBar:SetMaximum(vMax)
        if self.hScrollBar:IsVisible() then
            width = width - 10  -- Reduce width for vertical scrollbar
        end
    else
        self.vScrollBar:SetVisible(false)
        self.vScrollBar:SetMaximum(0)
        self.vScrollBar:SetValue(0)
    end

    -- Position scrollbars
    self.hScrollBar:SetPosition(0, height)
    self.hScrollBar:SetSize(width, 10)

    self.vScrollBar:SetPosition(width, 0)
    self.vScrollBar:SetSize(10, height)

    -- Size the subwindow
    self.SubWindow:SetSize(width, height)
end

-- Cycle to next/previous region
function TravelMapTab:CycleRegion(direction)
    -- Find current region index
    local currentIndex = 1
    for i = 1, #self.regions do
        if self.regions[i] == self.currentRegion then
            currentIndex = i
            break
        end
    end

    -- Calculate new index with wrapping
    local newIndex = currentIndex + direction
    if newIndex < 1 then
        newIndex = #self.regions
    elseif newIndex > #self.regions then
        newIndex = 1
    end

    -- Update current region
    self.currentRegion = self.regions[newIndex]
    Settings.mapViewRegion = self.currentRegion

    -- Reload map and shortcuts
    self:LoadMap()
    self:SetItems()
end

-- Load the map background for current region
function TravelMapTab:LoadMap()
    if self.currentRegion == MapType.ERIADOR then
        self.mapLabel:SetBackground(0x41008138)
    elseif self.currentRegion == MapType.RHOVANION then
        self.mapLabel:SetBackground(0x411C2DE4)
    elseif self.currentRegion == MapType.ROHAN then
        self.mapLabel:SetBackground(0x411c2de5)
    elseif self.currentRegion == MapType.GONDOR then
        self.mapLabel:SetBackground(0x41154336)
    elseif self.currentRegion == MapType.HARADWAITH then
        self.mapLabel:SetBackground(0x4124bcd0)
    elseif self.currentRegion == MapType.CREEPS then
        self.mapLabel:SetBackground(0x41008133)
    end

    -- Update region label
    self.regionLabel:SetText(self.regionNames[self.currentRegion] or "Unknown")

    -- Update arrow button visibility (hide if only one region)
    local showArrows = #self.regions > 1
    self.leftArrow:SetVisible(showArrows)
    self.rightArrow:SetVisible(showArrows)
end

-- Update navigation panel layout based on window size
function TravelMapTab:UpdateNavPanel()
    local width = self:GetWidth()
    local navPanelY = self:GetHeight() - 30

    self.navPanel:SetPosition(0, navPanelY)
    self.navPanel:SetWidth(width)

    -- Center the navigation elements
    local totalWidth = 100 + 300 + 100  -- left button + label + right button
    local startX = (width - totalWidth) / 2

    self.leftArrow:SetPosition(startX, 2)
    self.regionLabel:SetPosition(startX + 105, 2)
    self.rightArrow:SetPosition(startX + 410, 2)
end

-- Add shortcuts to the map
function TravelMapTab:SetItems()
    if self.tabId ~= self.parent.MainPanel.selectedPage then
        return
    end

    -- Clear existing shortcuts
    self:ClearItems()

    -- Add shortcuts based on current region
    if self.currentRegion == MapType.CREEPS then
        self:AddCreepShortcuts()
    else
        self:AddClassLocations()
        self:AddReputationLocations()
        self:AddRacialLocation()
    end

    self.parent.dirty = false
end

-- Clear all quickslots
function TravelMapTab:ClearItems()
    for i = 1, #self.quickslots do
        self.quickslots[i]:SetParent(nil)
    end
    self.quickslots = {}
end

-- Add class-specific locations
function TravelMapTab:AddClassLocations()
    if PlayerClass == Turbine.Gameplay.Class.Hunter then
        self:AddLocations(TravelInfo.hunter.skills)
    elseif PlayerClass == Turbine.Gameplay.Class.Warden then
        self:AddLocations(TravelInfo.warden.skills)
    elseif PlayerClass == Turbine.Gameplay.Class.Mariner then
        self:AddLocations(TravelInfo.mariner.skills)
    end
end

-- Add reputation-based locations
function TravelMapTab:AddReputationLocations()
    self:AddLocations(TravelInfo.rep.skills)
end

-- Add racial location
function TravelMapTab:AddRacialLocation()
    local racial = TravelInfo.racial
    if racial.map and #racial.map > 0 and racial.map[1] == self.currentRegion then
        local id = racial.id
        if IsShortcutTrained(id) then
            local sType = Turbine.UI.Lotro.ShortcutType.Skill
            local shortcut = Turbine.UI.Lotro.Shortcut(sType, id)
            self:AddSingleShortcut(racial.map, shortcut)
        end
    end
end

-- Add creep shortcuts
function TravelMapTab:AddCreepShortcuts()
    local sType = Turbine.UI.Lotro.ShortcutType.Skill
    local creep = TravelInfo.creep
    for i = 1, #creep.skills do
        local map = creep.skills[i].map
        local id = creep.skills[i].id
        if map and #map > 0 then
            self:AddSingleShortcut(map[1], Turbine.UI.Lotro.Shortcut(sType, id))
        end
    end
end

-- Add locations from a skill list
function TravelMapTab:AddLocations(skills)
    local sType = Turbine.UI.Lotro.ShortcutType.Skill
    for i = 1, #skills do
        local skill = skills[i]
        if skill.map ~= nil then
            for r = 1, #skill.map do
                local item = skill.map[r]
                if item ~= nil and #item == 3 and self.currentRegion == item[1] then
                    local id = skill.id
                    self:AddSingleShortcut(item, Turbine.UI.Lotro.Shortcut(sType, id))
                end
            end
        end
    end
end

-- Add a single shortcut to the map
function TravelMapTab:AddSingleShortcut(location, shortcut)
    local index = #self.quickslots + 1
    self.quickslots[index] = Turbine.UI.Lotro.Quickslot()

    self.quickslots[index]:SetShortcut(shortcut)
    self.quickslots[index]:SetOpacity(1)
    self.quickslots[index]:SetParent(self.mapLabel)
    self.quickslots[index]:SetMouseVisible(true)
    self.quickslots[index]:SetUseOnRightClick(false)
    self.quickslots[index]:SetAllowDrop(false)
    self.quickslots[index]:SetStretchMode(1)
    self.quickslots[index]:SetSize(32, 32)
    self.quickslots[index]:SetPosition(location[2], location[3])
    self.quickslots[index]:SetZOrder(98)
    self.quickslots[index]:SetVisible(IsShortcutEnabled(shortcut:GetData()))

    self.quickslots[index].MouseClick = function(sender, args)
        if (args.Button == Turbine.UI.MouseButton.Right) then
            Menu:ShowMenu()
        else
            if (Settings.hideOnTravel == 1) then
                self.parent:SetVisible(false)
            end
        end
    end
end

-- Handle tab size changes
function TravelMapTab:SetSize(width, height)
    Turbine.UI.Control.SetSize(self, width, height)

    -- Update scrollbars
    self:UpdateScrollBars()

    -- Update navigation panel
    self:UpdateNavPanel()
end

-- Get pixel size for this tab
function TravelMapTab:GetPixelSize()
    local width = self.mapWidth + self.parent.wPadding + 20  -- +20 for scrollbar
    local height = self.mapHeight + 30 + self.parent.hPadding  -- +30 for nav panel
    return width, height
end
