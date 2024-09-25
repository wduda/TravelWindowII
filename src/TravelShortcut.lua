--[[ This is an extension of the Turbine Shortcut item 	]] --
--[[ that will maintain some extra data, such as name, type, index ]] --
--[[ and enabled status	]] --
TravelShortcut = class(Turbine.UI.Lotro.Shortcut);

local NextDefaultIndex = 1

function TravelShortcut:Constructor(sType, tType, skill)
    Turbine.UI.Lotro.Shortcut.Constructor(self);

    -- the data to keep track of
    self.found = false;
    self.skill = skill;
    self.skill.shortcut = self;
    self.normalizedName = skill.name:lower();
    self.normalizedLabel = self:GetLabel():lower();
    self.travelType = tType;
    self.acquireText = nil
    self.acquireLines = 0

    self.defaultIndex = NextDefaultIndex;
    NextDefaultIndex = NextDefaultIndex + 1;

    self:InitOrder();
    self:InitEnabled();

    self:SetType(sType);
    self:SetData(skill.id);
end

function TravelShortcut:InitOrder()
    if LoadOrder == nil or LoadOrderNext == nil then
        -- error fallback
        self.Index = self.defaultIndex
        return
    end

    self.Index = LoadOrder[self.skill.id];
    if self.Index == nil then
        self.Index = LoadOrderNext;
        LoadOrderNext = LoadOrderNext + 1;
    end
end

function TravelShortcut:InitEnabled()
    if LoadEnabled == nil then
        -- error fallback
        self.Enabled = true
        return
    end

    self.Enabled = LoadEnabled[self.skill.id];
    if self.Enabled == nil then
        self.Enabled = true;
    end
end

-- function to set the enabled status
function TravelShortcut:SetEnabled(value)
    -- if the value type is not boolean, set an error
    if (type(value) ~= "boolean") then
        self.Enabled = nil;
        error(string.format("Invalid input arg for TravelShortcut:SetEnabled: %q", value));
        return;
    end

    -- else, set the value
    self.Enabled = value;
end

-- function to check the enabled status of the shortcut
function TravelShortcut:IsEnabled()
    return self.Enabled;
end

-- function to return the ingame skill name of the shortcut
function TravelShortcut:GetName()
    return self.skill.name;
end

-- function to return an optional skill description to disambiguate identical skill names
function TravelShortcut:GetDescription()
    return self.skill.desc;
end

-- function to return the plugin specific skill label of the shortcut
function TravelShortcut:GetLabel()
    return self.skill.label;
end

-- function to set the index of the shortcut
function TravelShortcut:SetIndex(value)
    self.Index = value;
end

-- function to return the index of the shortcut
function TravelShortcut:GetIndex()
    return self.Index;
end

-- function to set the type of the shortcut
function TravelShortcut:SetTravelType(type)
    -- for future use
end

-- function to get the type of shortcut
function TravelShortcut:GetTravelType()
    return self.travelType;
end

function TravelShortcut:GetAcquireText()
    if self.acquireText == nil then
        local lines = 0
        self.acquireText = ""
        if self.skill.minLevel then
            local text = LC.minLevel .. tostring(self.skill.minLevel)
            self.acquireText = self.acquireText .. text
            lines = lines + 1
        end
        if self.skill.rep and self.skill.repLevel then
            local text = LC.requires .. self.skill.repLevel .. LC.with .. self.skill.rep
            if self.acquireText ~= "" then text = "\n" .. text end
            self.acquireText = self.acquireText .. text
            lines = lines + 1
        end
        local items = self.skill.acquire
        for i = 1, #items do
            self:SelectLCText(items[i])
            if items[i].zone == nil then
                items[i].zone = self.skill.zone
            end
            local text, skillLines = self:InitAcquireText(items[i])
            if text ~= "" and self.acquireText ~= "" then
                text = "\n\n" .. text
                skillLines = skillLines + 1
            end
            self.acquireText = self.acquireText .. text
            lines = lines + skillLines
        end
        self.acquireLines = lines
    end
    return self.acquireText, self.acquireLines
end

function TravelShortcut:SelectLCText(item)
    local langs = {
        {name="DE", lc=Turbine.Language.German},
        {name="FR", lc=Turbine.Language.French},
        {name="RU", lc=Turbine.Language.Russian},
        {name="EN", lc=nil}} -- unknown language types default to english
    for i = 1, #langs do
        local lang = langs[i]
        if lang.lc == nil or lang.lc == GLocale then
            local lcItem = item[lang.name]
            if lcItem and type(lcItem) == "table" then
                -- only move localization values into 'item' if it is available
                for k, v in pairs(lcItem) do item[k] = v end
            end
            -- done with localization data, remove it
            item.EN = nil
            item.DE = nil
            item.FR = nil
            item.RU = nil
            return
        end
    end
end

function TravelShortcut:GetVendorText(item)
    local text = LC.source .. item.vendor
    local lines = 1
    if item.zone then
        text = text .. ", " .. item.zone
    end
    if item.coords then
        text = text .. " " .. item.coords
    end
    if item.desc ~= nil and item.desc ~= "" then
        text = text .. "\n" .. item.desc
        lines = lines + 1
    end
    return text, lines
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
        return text, 0
    end

    local lines = 0
    if item.deed then
        text = LC.deed .. item.deed
        lines = lines + 1
    elseif item.allegiance then
        text = LC.allegiance .. item.allegiance
        if item.quest ~= nil and item.quest ~= "" then
            text = text .. "\n" .. LC.quest .. item.quest
            lines = lines + 1
        elseif item.rank ~= nil then
            text = text .. "\n" .. LC.rank .. item.rank
            lines = lines + 1
        end
        lines = lines + 1
    elseif item.quest then
        text = LC.quest .. item.quest
        lines = lines + 1
    elseif item.drop then
        text = LC.source .. item.drop
        lines = lines + 1
    elseif item.vendor then
        text, lines = self:GetVendorText(item)
    elseif item.vendors then
        for i = 1, #item.vendors do
            if item.vendors[i].zone == nil then
                item.vendors[i].zone = item.zone
            end
            local t, l = self:GetVendorText(item.vendors[i])
            lines = lines + l
            if i == 1 then
                text = text .. t
            else
                text = text .. "\n" .. t
            end
        end
    elseif item.desc then
        text = LC.source .. item.desc
        lines = lines + 1
    else
        if item.vendors then
            lines = lines + 1
        elseif item.vendor then
            lines = lines + 1
        end
    end

    if item.cost then
        text = text .. "\n" .. LC.cost
        local cost = item.cost
        for i = 1, #cost do
            if cost[i].token == nil then
                Turbine.Shell.WriteLine(self.skill.name)
            end

            text = text .. cost[i].amount .. " " .. cost[i].token
            if i == #cost - 1 then
                text = text .. " and "
            elseif i ~= #cost then
                text = text .. ", "
            end
        end
        lines = lines + 1
    end
    return text, lines
end

function InitShortcuts()
    -- set default values
    TravelShortcuts = {};

    -- set the either the travel skills for free people or monsters
    if (PlayerAlignment == Turbine.Gameplay.Alignment.FreePeople) then
        -- set the generic travel items
        AddTravelSkills(TravelInfo.gen, 1);

        -- add the race travel to the list
        table.insert(TravelShortcuts,
                     TravelShortcut(
                            Turbine.UI.Lotro.ShortcutType.Skill,
                            2,
                            TravelInfo.racial));

        -- set the class travel items
        AddTravelSkills(TravelInfo.hunter, 4);
        AddTravelSkills(TravelInfo.warden, 4);
        AddTravelSkills(TravelInfo.mariner, 4);

        -- set the reputation travel items
        AddTravelSkills(TravelInfo.rep, 3);
    else
        -- set the creep travel items
        AddTravelSkills(TravelInfo.creep, 3);
    end

    ClearLoaders();
    SortShortcuts();
    CheckSkills();
end

function AddTravelSkills(skills, filter)
    if filter == 4 then
        if TravelInfo:GetClassSkills() ~= skills then
            filter = 8
        end
    end
    for i = 1, skills:GetCount() do
        table.insert(TravelShortcuts,
                     TravelShortcut(
                        Turbine.UI.Lotro.ShortcutType.Skill,
                        filter,
                        skills:Skill(i)));
    end
end

function IsShortcutEnabled(id)
    for i = 1, #TravelShortcuts do
        local shortcut = TravelShortcuts[i]
        if shortcut:GetData() == id then
            return shortcut:IsEnabled()
        end
    end

    return false;
end

function IsShortcutTrained(id)
    for i = 1, #TravelShortcuts do
        local shortcut = TravelShortcuts[i]
        if shortcut:GetData() == id then
            if shortcut.found then
                return true;
            end
            return false;
        end
    end

    return false;
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
    shortcut1:SetIndex(second)
    shortcut2:SetIndex(first)
    TravelShortcuts[first] = shortcut2
    TravelShortcuts[second] = shortcut1

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
    SortShortcuts(comp);
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
    SortShortcuts(comp);
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
    SortShortcuts(comp);
end

function SortByDefault()
    local comp = function(a, b)
        return a.defaultIndex > b.defaultIndex
    end
    SortShortcuts(comp);
end

function SortShortcuts(comp)
    if comp == nil then
        -- By default TravelShortcuts are sorted by an internal index value
        comp = function(a, b)
            return a:GetIndex() > b:GetIndex();
        end
    end

    -- perform an optimized bubble sort
    local n = #TravelShortcuts;
    while n > 2 do
        local new_n = 1;
        for i = 2, n do
            if comp(TravelShortcuts[i - 1], TravelShortcuts[i]) then
                local temp = TravelShortcuts[i - 1];
                TravelShortcuts[i - 1] = TravelShortcuts[i];
                TravelShortcuts[i] = temp;
                new_n = i;
            end
        end
        n = new_n;
    end

    -- cleanup internal Index values to be sequential
    for i = 1, #TravelShortcuts do
        TravelShortcuts[i].Index = i;
    end
end

function CheckSkills()
    -- loop through all the shortcuts and list those those that are not learned
    local newShortcut = false
    for i = 1, #TravelShortcuts do
        local shortcut = TravelShortcuts[i]
        if not shortcut.found and shortcut:GetTravelType() ~= 8 then
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
    local newShortcut = false
    for i = 1, #TravelShortcuts do
        local shortcut = TravelShortcuts[i]
        if not shortcut.found and shortcut:GetTravelType() ~= 8 then
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
