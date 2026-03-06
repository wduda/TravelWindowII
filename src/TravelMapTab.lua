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
    local buttonWidth = 195
    local buttonHeight = 25
    self.mapWidth = 1024
    self.mapHeight = 768
    self.colWidth = 32
    self.navPanelHeight = buttonHeight + self.colWidth + 10
    self.navOffsetX = (not self.parent.isMinWindow) and 5 or 0
    self.navOffsetW = (not self.parent.isMinWindow) and 20 or 0
    self.totalWidth = 0
    self.quickslots = {}
    self.panelQuickslots = {}  -- For milestone/housing skills in nav panel

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

    -- Show the menu when right clicked
    self.MouseClick = function(_, args)
        if args.Button == Turbine.UI.MouseButton.Right then
            Menu:ShowMenu()
        end
    end

    -- Create the map display label (full size, no scrolling)
    self.mapLabel = Turbine.UI.Label()
    self.mapLabel:SetParent(self)
    self.mapLabel:SetVisible(true)
    self.mapLabel:SetMouseVisible(true)
    self.mapLabel.MouseClick = self.MouseClick
    self:UpdateMapSize(self:GetMinPixelSize())

    if self.navPanelHeight > 0 then
        -- Create navigation panel below the map
        self.navPanel = Turbine.UI.Control()
        self.navPanel:SetParent(self)
        self.navPanel:SetBackColor(Turbine.UI.Color(1, 0, 0, 0))
        self.navPanel:SetZOrder(99)
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
            if y < self.startQsY or y > self.navPanel:GetHeight() then return end
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

        -- Button configurations: {region, labelKey}
        local buttonConfigs = {
            {MapType.ERIADOR, "eriadorMapName"},
            {MapType.RHOVANION, "rhovanionMapName"},
            {MapType.ROHAN, "rohanMapName"},
            {MapType.GONDOR, "gondorMapName"},
            {MapType.HARADWAITH, "haradwaithMapName"}
        }

        for i, config in ipairs(buttonConfigs) do
            local button = Turbine.UI.Lotro.Button()
            button:SetParent(self.navPanel)
            button:SetSize(buttonWidth, buttonHeight)
            button:SetText(LC[config[2]])
            button.region = config[1]
            button.Click = function()
                self:SwitchRegion(config[1])
            end
            self.regionButtons[i] = button
        end
        self:UpdateNavPanelLayout(self:GetMinPixelSize())
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

    self.mapLabel:SetStretchMode(1)

    -- disable current region button
    if self.navPanelHeight ~= 0 then
        for _, btn in ipairs(self.regionButtons) do
            btn:SetEnabled(btn.region ~= self.currentRegion)
        end
    end
end

function TravelMapTab:GetGridIndex(x, y)
    local col = math.floor((x - self.startQsX) / self.colWidth) + 1
    local row = math.floor((y - self.startQsY) / self.colWidth)
    local numOfCols = math.floor(self.totalWidth / self.colWidth);
    if row < 0 then row = 0 end
    local index = row * numOfCols + col
    if index > #self.panelQuickslots then
        index = #self.panelQuickslots
    end
    return index
end

function TravelMapTab:UpdateMapSize(width, height)
    local mapX = width - self.navOffsetW
    local mapY = height - self.navPanelHeight
    self.mapLabel:SetPosition(self.navOffsetX, 0)
    self.mapLabel:SetSize(mapX, mapY)
end

function TravelMapTab:UpdateNavPanelLayout(width, height)
    if self.navPanelHeight == 0 then
        return
    end

    local navPanelH = height - self.navPanelHeight
    self.navPanel:SetPosition(self.navOffsetX, navPanelH)
    self.navPanel:SetSize(width - self.navOffsetW, self.navPanelHeight)

    local navBtnW = self.regionButtons[1]:GetWidth()
    local spacing = 5
    local totalWidth = (navBtnW * 5) + (spacing * 4)
    local startX = (width - self.navOffsetW - totalWidth) / 2
    for i, btn in ipairs(self.regionButtons) do
        local posX = startX + ((i - 1) * (navBtnW + spacing))
        btn:SetPosition(posX, 7)
    end

    self.startQsX = (self.parent:GetWidth() - self.totalWidth) / 2
    for i = 1, #self.panelQuickslots do
        local qs = self.panelQuickslots[i]
        local posX = self.startQsX + ((i - 1) * self.colWidth)
        qs:SetStretchMode(1)
        qs:SetSize(self.colWidth, self.colWidth)
        qs:SetPosition(posX, self.startQsY)
    end
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
                    if skill.shortcut:IsEnabled() then
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
    local qs = Turbine.UI.Lotro.Quickslot()
    qs:SetShortcut(shortcut)
    qs:SetOpacity(1)
    qs:SetParent(self.mapLabel)
    qs:SetMouseVisible(true)
    qs:SetUseOnRightClick(false)
    qs:SetAllowDrop(false)
    qs:SetStretchMode(1)
    qs:SetSize(self.colWidth, self.colWidth)
    qs:SetPosition(location[2], location[3])
    qs:SetZOrder(98)
    qs:SetVisible(true)

    qs.MouseClick = function(_, args)
        if args.Button == Turbine.UI.MouseButton.Right then
            Menu:ShowMenu()
        else
            if Settings.hideOnTravel == 1 then
                self.parent:SetVisible(false)
            end
        end
    end
    self.quickslots[index] = qs
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
    self.startQsY = self.regionButtons[1]:GetHeight() + 11

    -- Create quickslots
    for i = 1, #skills do
        local qs = Turbine.UI.Lotro.Quickslot()

        qs:SetShortcut(skills[i].shortcut)
        qs:SetOpacity(1)
        qs:SetParent(self.navPanel)
        qs:SetMouseVisible(true)
        qs:SetUseOnRightClick(false)
        qs:SetAllowDrop(false)
        qs:SetStretchMode(1)
        qs:SetSize(self.colWidth, self.colWidth)
        qs:SetZOrder(98)
        qs:SetVisible(true)

        qs.MouseClick = function(_, args)
            if args.Button == Turbine.UI.MouseButton.Right then
                Menu:ShowMenu()
            else
                if Settings.hideOnTravel == 1 then
                    self.parent:SetVisible(false)
                end
            end
        end
        self.panelQuickslots[i] = qs
    end
    self:UpdateNavPanelLayout(self.parent:GetSize())
end

function TravelMapTab:SetSize(width, height)
    Turbine.UI.Control.SetSize(self, width, height)
    self:UpdateMapSize(width, height)
    self:UpdateNavPanelLayout(width, height)
end

function TravelMapTab:GetMinPixelSize()
    local width = self.mapWidth + self.navOffsetW
    local height = self.mapHeight + self.navPanelHeight
    return width, height
end

function TravelMapTab:GetPixelSize()
    local scale = Settings.mapViewScale or 1
    local width = math.floor(self.mapWidth * scale + 0.5) + self.navOffsetW
    local height = math.floor(self.mapHeight * scale + 0.5) + self.navPanelHeight
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
