import "Turbine.Gameplay"
import "Turbine.UI"
import "Turbine.UI.Lotro"
import "TravelWindowII.src.extensions"
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
    self.navPanelHeight = 68
    self.colWidth = 32
    self.quickslots = {}
    self.panelQuickslots = {}  -- For milestone/housing skills in nav panel

    -- Add border padding around map content when using Lotro window
    self.mapBorder = (not self.parent.isMinWindow) and 5 or 0

    -- Set initial region (will be loaded from settings)
    if PlayerAlignment == Turbine.Gameplay.Alignment.MonsterPlayer then
        self.currentRegion = MapType.CREEPS
        self.regions = {MapType.CREEPS}
        self.navPanelHeight = 0
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
        [MapType.CREEPS] = LC.moorMapName,
        [MapType.ERIADOR] = LC.eriadorMapName,
        [MapType.RHOVANION] = LC.rhovanionMapName,
        [MapType.ROHAN] = LC.rohanMapName,
        [MapType.GONDOR] = LC.gondorMapName,
        [MapType.HARADWAITH] = LC.haradwaithMapName
    }

    -- Show the menu when right clicked
    self.MouseClick = function(sender, args)
        if (args.Button == Turbine.UI.MouseButton.Right) then
            Menu:ShowMenu()
        end
    end

    -- Create the map display label (full size, no scrolling)
    self.mapLabel = Turbine.UI.Label()
    self.mapLabel:SetSize(self.mapWidth - (self.mapBorder * 2), self.mapHeight - (self.mapBorder * 2))
    self.mapLabel:SetParent(self)
    self.mapLabel:SetVisible(true)
    self.mapLabel:SetMouseVisible(true)
    self.mapLabel:SetPosition(self.mapBorder, self.mapBorder)
    self.mapLabel.MouseClick = self.MouseClick

    if self.navPanelHeight ~= 0 then
        -- Create navigation panel below the map
        self.navPanel = Turbine.UI.Control()
        self.navPanel:SetParent(self)
        self.navPanel:SetSize(self.mapWidth - (self.mapBorder * 2), self.navPanelHeight)
        self.navPanel:SetBackColor(Turbine.UI.Color(0.8, 0, 0, 0))
        self.navPanel:SetZOrder(99)
        self.navPanel:SetPosition(self.mapBorder, self.mapHeight + self.mapBorder)  -- Position below the map with border
        self.navPanel.MouseClick = self.MouseClick

        -- logic for reordering shortcuts in the navigation panel
        self.DragDrop = function(_, args)
            if BlockUIChange(self) then return end

            local shortcut = args.DragDropInfo:GetShortcut()
            if shortcut == nil then return end
            local srcSkill = GetTravelSkill(shortcut:GetData())
            if srcSkill == nil then return end
            local x, y = self.navPanel:GetMousePosition()
            if x < 0 or x > self.navPanel:GetWidth() then return end
            if y < self.startY or y > self.navPanel:GetHeight() then return end
            local gridIndex = self:GetGridIndex(x, y)
            local quickslot = self.panelQuickslots[gridIndex]
            if quickslot == nil then return end
            shortcut = quickslot:GetShortcut()
            if shortcut == nil then return end
            local dstSkill = GetTravelSkill(shortcut:GetData())
            if dstSkill == nil then return end

            local srcIndex = srcSkill.shortcut.MapIndex
            local dstIndex = dstSkill.shortcut.MapIndex
            if srcIndex == nil or dstIndex == nil then return end
            if srcIndex == dstIndex then return end
            if srcIndex > dstIndex then
                while dstIndex - 1 >= 1 do
                    if NavPanelShortcuts[dstIndex - 1].found then
                        break
                    end
                    dstIndex = dstIndex - 1
                end
                while srcIndex > dstIndex do
                    SwapNavPanelSkill(srcIndex, srcIndex - 1)
                    srcIndex = srcIndex - 1
                end
            end

            if srcIndex < dstIndex then
                local maxIndex = #NavPanelShortcuts
                while dstIndex + 1 <= maxIndex do
                    if NavPanelShortcuts[dstIndex + 1].found then
                        break
                    end
                    dstIndex = dstIndex + 1
                end

                while srcIndex < dstIndex do
                    SwapNavPanelSkill(srcIndex, srcIndex + 1)
                    srcIndex = srcIndex + 1
                end
            end
            self.parent:UpdateSettings();
        end

        -- Create 5 region buttons for direct access
        self.regionButtons = {}
        local buttonWidth = 195
        local buttonHeight = 25
        local spacing = 5
        local totalWidth = (buttonWidth * 5) + (spacing * 4)
        local startX = ((self.mapWidth - (self.mapBorder * 2)) - totalWidth) / 2
        local startY = 5

        -- Button configurations: {region, labelKey}
        local buttonConfigs = {
            {MapType.ERIADOR, "eriadorMapName"},
            {MapType.RHOVANION, "rhovanionMapName"},
            {MapType.ROHAN, "rohanMapName"},
            {MapType.GONDOR, "gondorMapName"},
            {MapType.HARADWAITH, "haradwaithMapName"}
        }

        for i = 1, 5 do
            local config = buttonConfigs[i]
            local button = Turbine.UI.Lotro.Button()
            button:SetParent(self.navPanel)
            button:SetSize(buttonWidth, buttonHeight)
            button:SetText(LC[config[2]])
            button:SetPosition(startX + ((i - 1) * (buttonWidth + spacing)), startY)
            button.region = config[1]
            button.Click = function()
                self:SwitchRegion(config[1])
            end
            self.regionButtons[config[1]] = button
        end
    end

    -- Load the initial map
    self:LoadMap()
end

-- Switch to a specific region
function TravelMapTab:SwitchRegion(newRegion)
    if self.currentRegion == newRegion then
        return  -- Already on this region
    end

    self.currentRegion = newRegion
    Settings.mapViewRegion = self.currentRegion

    -- Reload map and shortcuts (SetItems will clear old ones)
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
        self.mapLabel:SetBackground(0x411c2DE5)
    elseif self.currentRegion == MapType.GONDOR then
        self.mapLabel:SetBackground(0x41154336)
    elseif self.currentRegion == MapType.HARADWAITH then
        self.mapLabel:SetBackground(0x4124BCD0)
    elseif self.currentRegion == MapType.CREEPS then
        self.mapLabel:SetBackground(0x41008133)
    end

    -- Highlight current region button
    if self.navPanelHeight ~= 0 then
        for region, button in pairs(self.regionButtons) do
            if region == self.currentRegion then
                button:SetEnabled(false)  -- Disabled state shows as pressed/selected
            else
                button:SetEnabled(true)
            end
        end
    end
end

function TravelMapTab:GetGridIndex(x, y)
    local col = math.floor((x - self.startX) / self.colWidth) + 1
    local row = math.floor((y - self.startY) / self.colWidth)
    local numOfCols = math.floor(self.totalWidth / self.colWidth);
    if row < 0 then row = 0 end
    local index = row * numOfCols + col
    if index > #self.panelQuickslots then
        index = #self.panelQuickslots
    end
    return index
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

    -- Add milestone/housing skills to navigation panel
    -- Only recreate when skills/settings change, not on region switch
    if self.parent.dirty then
        self:AddPanelQuickslots()
    end

    self.parent.dirty = false
end

-- Clear all quickslots
function TravelMapTab:ClearItems()
    for i = 1, #self.quickslots do
        self.quickslots[i]:SetVisible(false)
        self.quickslots[i]:SetParent(nil)
    end
    self.quickslots = {}
    -- Note: panelQuickslots are NOT cleared here, only in AddPanelQuickslots when dirty
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
    if racial.map == nil or #racial.map == 0 or #racial.map[1] == 0 then
        Turbine.Shell.WriteLine("Warning: ill-defined map location")
        return
    end
    if racial.map[1][1] == self.currentRegion then
        local id = racial.id
        if IsShortcutTrained(id) then
            local sType = Turbine.UI.Lotro.ShortcutType.Skill
            local shortcut = Turbine.UI.Lotro.Shortcut(sType, id)
            self:AddSingleShortcut(racial.map[1], shortcut)
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
                    -- Only add shortcut if it's enabled
                    if IsShortcutEnabled(id) then
                        self:AddSingleShortcut(item, Turbine.UI.Lotro.Shortcut(sType, id))
                    end
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
    self.quickslots[index]:SetSize(self.colWidth, self.colWidth)
    self.quickslots[index]:SetPosition(location[2], location[3])
    self.quickslots[index]:SetZOrder(98)
    self.quickslots[index]:SetVisible(true)

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

function GetNavPanelSkills()
    local skills = {}
    for i = 1, #NavPanelShortcuts do
        local shortcut = NavPanelShortcuts[i]
        if shortcut.found and shortcut:IsEnabled() then
            table.insert(skills, shortcut.skill)
        end
    end
    return skills
end

-- Add milestone/housing skills with no map location to the map tray
function TravelMapTab:AddPanelQuickslots()
    if self.navPanelHeight == 0 then
        return  -- No panel for monster players
    end

    -- Clear existing panel quickslots
    for i = 1, #self.panelQuickslots do
        self.panelQuickslots[i]:SetVisible(false)
        self.panelQuickslots[i]:SetParent(nil)
    end
    self.panelQuickslots = {}

    local skills = GetNavPanelSkills()

    -- Calculate centered layout
    self.totalWidth = (#skills * self.colWidth) + #skills - 1
    self.startX = ((self.mapWidth - (self.mapBorder * 2)) - self.totalWidth) / 2
    self.startY = 31

    -- Create quickslots
    for i = 1, #skills do
        local index = #self.panelQuickslots + 1
        self.panelQuickslots[index] = Turbine.UI.Lotro.Quickslot()

        self.panelQuickslots[index]:SetShortcut(skills[i].shortcut)
        self.panelQuickslots[index]:SetOpacity(1)
        self.panelQuickslots[index]:SetParent(self.navPanel)
        self.panelQuickslots[index]:SetMouseVisible(true)
        self.panelQuickslots[index]:SetUseOnRightClick(false)
        self.panelQuickslots[index]:SetAllowDrop(false)
        self.panelQuickslots[index]:SetStretchMode(1)
        self.panelQuickslots[index]:SetSize(self.colWidth, self.colWidth)

        local posX = self.startX + ((i - 1) * self.colWidth)
        self.panelQuickslots[index]:SetPosition(posX, self.startY)
        self.panelQuickslots[index]:SetZOrder(98)
        self.panelQuickslots[index]:SetVisible(true)

        self.panelQuickslots[index].MouseClick = function(sender, args)
            if (args.Button == Turbine.UI.MouseButton.Right) then
                Menu:ShowMenu()
            else
                if (Settings.hideOnTravel == 1) then
                    self.parent:SetVisible(false)
                end
            end
        end
    end
end

-- Handle tab size changes
function TravelMapTab:SetSize(width, height)
    Turbine.UI.Control.SetSize(self, width, height)
end

-- Get pixel size for this tab
function TravelMapTab:GetPixelSize()
    local width = self.mapWidth + self.parent.wPadding + (self.mapBorder * 2)
    local height = self.mapHeight + self.parent.hPadding + self.navPanelHeight + (self.mapBorder * 2)
    return width, height
end

function TravelMapTab:SetOpacityItems(value)
    -- quickslots in stretch mode do not get updated opacity from
    -- the parent; update them here
    for i = 1, #self.quickslots do
        self.quickslots[i]:SetOpacity(value)
    end
    -- Also update panel quickslots
    for i = 1, #self.panelQuickslots do
        self.panelQuickslots[i]:SetOpacity(value)
    end
end
