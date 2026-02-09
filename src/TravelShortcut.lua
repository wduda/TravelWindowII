--[[ This is an extension of the Turbine Shortcut item 	]] --
--[[ that will maintain some extra data, such as name, type, index ]] --
--[[ and enabled status	]] --
TravelShortcut = class(Turbine.UI.Lotro.Shortcut);

local NextDefaultIndex = 1
local NextDefaultMapIndex = 1

function TravelShortcut:Constructor(sType, tType, skill)
    Turbine.UI.Lotro.Shortcut.Constructor(self)

    self.found = false
    self.skill = skill
    self.skill.shortcut = self
    self.normalizedName = skill.name:lower()
    self.normalizedLabel = self:GetLabel():lower()
    self.travelType = tType;
    self.acquireText = nil

    self.defaultIndex = NextDefaultIndex
    NextDefaultIndex = NextDefaultIndex + 1

    self:InitOrder()
    self:InitMapTray()
    self:InitEnabled()

    self:SetType(sType)
    self:SetData(skill.id)
end

function TravelShortcut:InitOrder()
    if LoadOrder == nil then
        -- error fallback
        self.Index = self.defaultIndex
        return
    end

    self.Index = LoadOrder[self.skill.id]
    if self.Index == nil then
        self.Index = LoadOrderNext
        LoadOrderNext = LoadOrderNext + 1
    end
end

function TravelShortcut:InitMapTray()
    self.IsMapNone = false
    self.IsAllegiance = false
    if self.skill.map and #self.skill.map > 0 then
        local mapEntry = self.skill.map[1]
        self.IsMapNone = mapEntry[1] == MapType.NONE
    end

    local acquireList = self.skill.acquire
    for i = 1, #acquireList do
        local item = acquireList[i]
        if item.allegiance ~= nil then
            self.IsAllegiance = true
        end
    end

    if self.IsMapNone or self.IsAllegiance then
        self.defaultMapIndex = NextDefaultMapIndex
        NextDefaultMapIndex = NextDefaultMapIndex + 1
    end
end

function TravelShortcut:InitEnabled()
    if LoadEnabled == nil then
        self.Enabled = true
        return
    end

    self.Enabled = LoadEnabled[self.skill.id];
    if self.Enabled == nil then
        self.Enabled = true;
    end
end

function TravelShortcut:SetEnabled(value)
    if (type(value) ~= "boolean") then
        self.Enabled = nil;
        error(string.format("Invalid input arg for TravelShortcut:SetEnabled: %q", value));
        return;
    end

    self.Enabled = value;
end

function TravelShortcut:IsEnabled()
    return self.Enabled;
end

function TravelShortcut:GetName()
    return self.skill.name;
end

function TravelShortcut:GetDescription()
    return self.skill.desc;
end

function TravelShortcut:GetLabel()
    return self.skill.label;
end

function TravelShortcut:GetListLabel()
    return self.skill.listLabel;
end

function TravelShortcut:SetIndex(value)
    self.Index = value;
end

function TravelShortcut:GetIndex()
    return self.Index;
end

function TravelShortcut:SetTravelType(type)
    -- for future use
end

function TravelShortcut:GetTravelType()
    return self.travelType;
end

function TravelShortcut:GetAcquireText()
    if self.acquireText == nil then
        self.acquireText = ""
        if self.skill.minLevel then
            local text = LC.minLevel .. tostring(self.skill.minLevel)
            self.acquireText = self.acquireText .. text
        end
        if self.skill.rep and self.skill.repLevel then
            local text = LC.requires .. self.skill.repLevel .. LC.with .. self.skill.rep
            if self.acquireText ~= "" then text = "\n" .. text end
            self.acquireText = self.acquireText .. text
        end
        local items = self.skill.acquire
        for i = 1, #items do
            if items[i].zone == nil then
                items[i].zone = self.skill.zone
            end
            local text = self:InitAcquireText(items[i])
            if text ~= "" and self.acquireText ~= "" then
                text = "\n\n" .. text
            end
            self.acquireText = self.acquireText .. text
        end
    end
    return self.acquireText
end

function TravelShortcut:GetVendorText(item)
    local text = LC.source .. item.vendor
    if item.zone then
        text = text .. ", " .. item.zone
    end
    if item.coords then
        text = text .. " " .. item.coords
    end
    if item.desc ~= nil and item.desc ~= "" then
        text = text .. "\n" .. item.desc
    end
    return text
end

function TravelShortcut:InitAcquireText(item)
    local text = ""
    if item.store then
        text = LC.source .. LC.store .. "\n"
        if self.travelType == 1 then
            return text .. LC.cost .. "350 " .. LC.token.LOTRO_POINT, 2
        else
            return text .. LC.cost .. "295 " .. LC.token.LOTRO_POINT, 2
        end
    end

    if item.autoLevel then
        return text
    end

    if item.deed then
        text = LC.deed .. item.deed
    elseif item.allegiance then
        text = LC.allegiance .. item.allegiance
        if item.quest ~= nil and item.quest ~= "" then
            text = text .. "\n" .. LC.quest .. item.quest
        elseif item.rank ~= nil then
            text = text .. "\n" .. LC.rank .. item.rank
        end
    elseif item.quest then
        text = LC.quest .. item.quest
    elseif item.vendor then
        text = self:GetVendorText(item)
    elseif item.desc then
        text = LC.source .. item.desc
    end

    if item.cost then
        text = text .. "\n" .. LC.cost
        local cost = item.cost
        for i = 1, #cost do
            if cost[i].token ~= nil and cost[i].amount ~= nil then
                text = text .. cost[i].amount .. " " .. cost[i].token
                if i == #cost - 1 then
                    text = text .. " and "
                elseif i ~= #cost then
                    text = text .. ", "
                end
            end
        end
    end
    return text
end

function InitShortcuts()
    -- set default values
    TravelShortcuts = {}
    NavPanelShortcuts = {}

    -- set the either the travel skills for free people or monsters
    if (PlayerAlignment == Turbine.Gameplay.Alignment.FreePeople) then
        -- set the generic travel items
        AddTravelSkills(TravelInfo.gen, FilterId.GEN);

        -- add the race travel to the list
        table.insert(TravelShortcuts,
                     TravelShortcut(
                            Turbine.UI.Lotro.ShortcutType.Skill,
                            2,
                            TravelInfo.racial))

        -- set the class travel items
        AddTravelSkills(TravelInfo:GetClassSkills(), FilterId.CLASS)

        -- set the reputation travel items
        AddTravelSkills(TravelInfo.rep, FilterId.REP)

        AddNavPanelSkills()
    else
        -- set the creep travel items
        AddTravelSkills(TravelInfo.creep, FilterId.REP)
    end

    ClearLoaders()
    SortShortcuts(TravelShortcuts)
    SortNavPanelShortcuts()
    CheckSkills()
end

function AddTravelSkills(skills, filter)
    if skills == nil then return end
    for i = 1, skills:GetCount() do
        table.insert(TravelShortcuts,
            TravelShortcut(
                Turbine.UI.Lotro.ShortcutType.Skill,
                filter,
                skills:Skill(i)));
    end
end

function AddNavPanelSkills()
    for i = 1, #TravelShortcuts do
        local shortcut = TravelShortcuts[i]
        if shortcut.IsMapNone or shortcut.IsAllegiance then
            if LoadMapTrayOrder then
                shortcut.MapIndex = LoadMapTrayOrder[shortcut.skill.id]
            end
            if shortcut.MapIndex == nil then
                shortcut.MapIndex = shortcut.defaultMapIndex
            end
            table.insert(NavPanelShortcuts, shortcut)
        end
    end
end

function IsShortcutEnabled(id)
    for i = 1, #TravelShortcuts do
        local shortcut = TravelShortcuts[i]
        if shortcut:GetData() == id then
            return shortcut:IsEnabled()
        end
    end

    return false
end

function IsShortcutTrained(id)
    for i = 1, #TravelShortcuts do
        local shortcut = TravelShortcuts[i]
        if shortcut:GetData() == id then
            if shortcut.found then
                return true
            end
            return false
        end
    end

    return false
end

function GetTravelOrder(scope)
    local order = {}
    for i = 1, #TravelShortcuts do
        local shortcut = TravelShortcuts[i]
        local id = shortcut:GetData()
        if scope == Turbine.DataScope.Account and shortcut.skill.isRacial then
            -- replace racial id with the racial id tag
            id = TravelInfo.racialIDTag
        end
        table.insert(order, id)
    end
    return order
end

function GetNavPanelOrder()
    local order = {}
    for i = 1, #NavPanelShortcuts do
        local shortcut = NavPanelShortcuts[i]
        local id = shortcut:GetData()
        table.insert(order, id)
    end
    return order
end

function GetTravelEnabled(scope)
    local enabled = {}
    for i = 1, #TravelShortcuts do
        local shortcut = TravelShortcuts[i]
        local id = shortcut:GetData()
        if scope == Turbine.DataScope.Account and shortcut.skill.isRacial then
            -- replace racial id with the racial id tag
            id = TravelInfo.racialIDTag
        end
        enabled[id] = shortcut.Enabled
    end

    return enabled
end

function GetTravelSkill(id)
    for i = 1, #TravelShortcuts do
        local shortcut = TravelShortcuts[i]
        if id == shortcut:GetData() then
            return shortcut.skill
        end
    end
    return nil
end

function SwapTravelSkill(first, second)
    local shortcut1 = TravelShortcuts[first]
    local shortcut2 = TravelShortcuts[second]
    shortcut1.Index = second
    shortcut2.Index = first
    TravelShortcuts[first] = shortcut2
    TravelShortcuts[second] = shortcut1

    _G.travel.dirty = true
end

function SwapNavPanelSkill(first, second)
    local shortcut1 = NavPanelShortcuts[first]
    local shortcut2 = NavPanelShortcuts[second]
    shortcut1.MapIndex = second
    shortcut2.MapIndex = first
    NavPanelShortcuts[first] = shortcut2
    NavPanelShortcuts[second] = shortcut1

    _G.travel.dirty = true
end

function SortByName()
    local comp = function(a, b)
        if a.normalizedName > b.normalizedName then
            return true;
        elseif a.normalizedName == b.normalizedName then
            return a:GetData() > b:GetData();
        else
            return false;
        end
    end
    SortShortcuts(TravelShortcuts, comp)
end

function SortByLabel()
    local comp = function(a, b)
        if a.normalizedLabel > b.normalizedLabel then
            return true;
        elseif a.normalizedName == b.normalizedName then
            return a:GetData() > b:GetData();
        else
            return false;
        end
    end
    SortShortcuts(TravelShortcuts, comp)
end

function SortByLevel()
    local comp = function(a, b)
        if a.skill.level > b.skill.level then
            return true;
        elseif a.skill.level == b.skill.level then
            return a.defaultIndex > b.defaultIndex;
        else
            return false;
        end
    end
    SortShortcuts(TravelShortcuts, comp)
end

function SortByDefault()
    local comp = function(a, b)
        return a.defaultIndex > b.defaultIndex
    end
    SortShortcuts(TravelShortcuts, comp)
end

function SortShortcuts(sc, comp)
    if comp == nil then
        -- By default shortcuts are sorted by an internal index value
        comp = function(a, b)
            return a:GetIndex() > b:GetIndex();
        end
    end

    -- perform an optimized bubble sort
    local n = #sc;
    while n > 2 do
        local new_n = 1;
        for i = 2, n do
            if comp(sc[i - 1], sc[i]) then
                local temp = sc[i - 1];
                sc[i - 1] = sc[i];
                sc[i] = temp;
                new_n = i;
            end
        end
        n = new_n;
    end

    -- cleanup internal Index values to be sequential
    for i = 1, #sc do
        sc[i].Index = i;
    end
end

function SortNavPanelShortcuts()
    local comp = function(a, b)
        return a.MapIndex > b.MapIndex
    end
    SortShortcuts(NavPanelShortcuts, comp)
end

function CheckSkills()
    -- loop through all the shortcuts and list those those that are not learned
    local newShortcut = false
    for i = 1, #TravelShortcuts do
        local shortcut = TravelShortcuts[i]
        if not shortcut.found then
            if FindSkill(shortcut) then
                newShortcut = true
            end
        end
    end

    if newShortcut and NewShortcutEvent then
        NewShortcutEvent()
    end
end

function MatchSkillInfo(skillInfo, shortcut)
    if skillInfo:GetName() == shortcut:GetName() then
        local desc = shortcut:GetDescription()
        if desc ~= nil then
            if string.find(skillInfo:GetDescription(), desc, 1, true) ~= nil then
                shortcut.found = true
                return true
            end
        else
            shortcut.found = true
            return true
        end
    end
    return false
end

function FindSkill(shortcut)
    for i = 1, TrainedSkills:GetCount() do
        local skillInfo = TrainedSkills:GetItem(i):GetSkillInfo()
        if MatchSkillInfo(skillInfo, shortcut) then
            return true
        end
    end

    return false;
end

function CheckSkill(name)
    -- collect matching skill names
    local skills = {}
    for i = 1, TrainedSkills:GetCount() do
        local skillInfo = TrainedSkills:GetItem(i):GetSkillInfo()
        if skillInfo:GetName() == name then
            table.insert(skills, skillInfo)
        end
    end

    -- loop through all the shortcuts and match against skills
    for i = 1, #TravelShortcuts do
        local shortcut = TravelShortcuts[i]
        if not shortcut.found then
            for j = 1, #skills do
                if MatchSkillInfo(skills[j], shortcut) then
                    if NewShortcutEvent then
                        NewShortcutEvent()
                    end
                    return
                end
            end
        end
    end
end

function ListTrainedSkills()

    Turbine.Shell.WriteLine("\n\nTrained Skills (" .. TrainedSkills:GetCount() .. ")\n\n");

    for i = 1, TrainedSkills:GetCount(), 1 do
        local skill = Turbine.Gameplay.Skill;
        local skillInfo = Turbine.Gameplay.SkillInfo;
        skill = TrainedSkills:GetItem(i);

        Turbine.Shell.WriteLine(skill:GetSkillInfo():GetName());
    end
end
