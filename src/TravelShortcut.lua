--[[ This is an extension of the Turbine Shortcut item 	]] --
--[[ that will maintain some extra data, such as name, type, index ]] --
--[[ and enabled status	]] --
TravelShortcut = class(Turbine.UI.Lotro.Shortcut);

function TravelShortcut:Constructor(sType, tType, data, name, skillLabel, desc)
    Turbine.UI.Lotro.Shortcut.Constructor(self);

    -- the data to keep track of
    self.Name = name;
    self.desc = desc;
    self.normalizedName = name:lower();
    self.normalizedLabel = skillLabel:lower();
    self.travelType = tType;
    self.Index = TableIndex(Settings.order, data);
    self.Enabled = Settings.enabled[data];
    self.skillLabel = skillLabel;
    self.found = false;

    self:SetType(sType);
    self:SetData(data);
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

-- function to set the name of the shortcut
function TravelShortcut:SetName(text)
    -- if the value is not a string, set an error
    if (type(text) ~= "string") then
        self.Name = "not a string";
        error(string.format("Invalid input arg for TravelShortcut:SetName"));
        return;
    end

    self.Name = text;
end

-- function to return the ingame skill name of the shortcut
function TravelShortcut:GetName()
    return self.Name;
end

-- function to return an optional skill description to disambiguate identical skill names
function TravelShortcut:GetDescription()
    return self.desc;
end

-- function to return the plugin specific skill label of the shortcut
function TravelShortcut:GetSkillLabel()
    return self.skillLabel;
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
                            TravelInfo.racial.id,
                            TravelInfo.racial.name,
                            TravelInfo.racial.label,
                            TravelInfo.racial.desc));

        -- set the reputation travel items
        AddTravelSkills(TravelInfo.rep, 3);
    else
        -- set the creep travel items
        AddTravelSkills(TravelInfo.creep, 3);
    end

    -- set the class travel items
    local classSkills = TravelInfo:GetClassSkills();
    if classSkills ~= nil then
        AddTravelSkills(classSkills, 4);
    end

    -- TODO: resolve the issue of different characters having different skills
    --       and loading those skills across characters
    -- remove Settings.order skills unused by this character
    for k, v in pairs(Settings.order) do
        local found = false
        for i = 1, #TravelShortcuts do
            if TravelShortcuts[i]:GetData() == v then
                found = true
                break
            end
        end
        if found == false then
            -- skill not used by this character
            table.remove(Settings.order, k)
        end
    end

    -- remove Settings.enabled skills unused by this character
    for k, v in pairs(Settings.enabled) do
        local found = false
        for i = 1, #TravelShortcuts do
            if TravelShortcuts[i]:GetData() == k then
                found = true
                break
            end
        end
        if found == false then
            -- skill not used by this character
            Settings.enabled[k] = nil
        end
    end

    SortShortcuts();
    CheckSkills(false);
end

function AddTravelSkills(skills, filter)
    for i = 1, skills:GetCount() do
        table.insert(TravelShortcuts,
                     TravelShortcut(
                        Turbine.UI.Lotro.ShortcutType.Skill,
                        filter,
                        skills:IdAtIndex(i),
                        skills:NameAtIndex(i),
                        skills:LabelAtIndex(i),
                        skills:DescAtIndex(i)));
    end
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
    Settings.order = {};
    for i = 1, #TravelShortcuts do
        table.insert(Settings.order, TravelShortcuts[i]:GetData());
    end
end

function SortByLabel()
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
    Settings.order = {};
    for i = 1, #TravelShortcuts do
        table.insert(Settings.order, TravelShortcuts[i]:GetData());
    end
end

function SortFromSettings()
    for i = 1, #TravelShortcuts do
        local id = TravelShortcuts[i]:GetData();
        TravelShortcuts[i].Index = TableIndex(Settings.order, id);
    end
    SortShortcuts();
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
end

function CheckSkills(report)
    local newShortcut = false;
    -- loop through all the shortcuts and list those those that are not learned
    for i = 1, #TravelShortcuts, 1 do
        local wasFound = TravelShortcuts[i].found;
        if (FindSkill(TravelShortcuts[i])) then
            if not wasFound then
                newShortcut = true;
            end
        elseif report then
            Turbine.Shell.WriteLine(LC.skillNotTrained .. TravelShortcuts[i]:GetName())
        end
    end

    if newShortcut and NewShortcutEvent then
        NewShortcutEvent();
    end
end

function FindSkill(shortcut)
    if shortcut.found then
        return true;
    end

    for i = 1, TrainedSkills:GetCount(), 1 do
        local skillInfo = TrainedSkills:GetItem(i):GetSkillInfo();
        if skillInfo:GetName() == shortcut:GetName() then
            local desc = shortcut:GetDescription();
            if desc ~= nil then
                if string.find(skillInfo:GetDescription(), desc, 1, true) ~= nil then
                    shortcut.found = true;
                    return true;
                end
            else
                shortcut.found = true;
                return true;
            end
        end
    end

    return false;
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
