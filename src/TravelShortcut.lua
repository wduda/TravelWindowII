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

    Turbine.Shell.WriteLine("\n\nTrained Skills\n\n");

    for i = 1, TrainedSkills:GetCount(), 1 do
        local skill = Turbine.Gameplay.Skill;
        local skillInfo = Turbine.Gameplay.SkillInfo;
        skill = TrainedSkills:GetItem(i);

        Turbine.Shell.WriteLine(skill:GetSkillInfo():GetName());
    end
end
