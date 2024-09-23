--[[ use a modified table to maintain data for travel skills
     specifically skill name, ID, label, description substring]]
IndexedDictionary = class()

local ValidSkillKeys = {
    "id", "name", "desc", "label", "label0", "detail", "zlabel", "zone", "tag",
    "EN", "DE", "FR", "RU",
    "map", "overlap", "level", "hasSameText", "minLevel", "store", "autoRep", "autoLevel",
    "acquire", "cost", "amount", "token", "coords", "rep", "repLevel",
    "drop", "quest", "deed", "vendor", "vendors", "allegiance", "rank"
}

function IndexedDictionary:Constructor(parent, title)
    self.parent = parent

    self.title = title

    -- init tables
    self.skills = {}
    self.skillIdList = {}
    self.numberOfItems = 0
end

-- function to get the total number of entries in the dictionary
function IndexedDictionary:GetCount()
    return self.numberOfItems;
end

function IndexedDictionary:SetSkillLabel(skill)
    skill.label = skill.label0
    if skill.label == nil then
        skill.label = skill.name;
    elseif skill.zone ~= nil then
        local tag = nil
        if skill.tag ~= nil then
            tag = skill.tag
        elseif self.tag ~= nil then
            tag = self.tag
        end

        if Settings.useZoneNames == 1 then
            if Settings.useSkillNames ~= 1 then
                if skill.detail ~= nil then
                    skill.label = skill.detail
                elseif skill.zlabel ~= nil then
                    skill.label = skill.zlabel
                end
            elseif skill.label ~= skill.zone then
                if skill.zlabel ~= nil then
                    skill.label = skill.zlabel
                end
            end
            skill.label = skill.zone .. ": " .. skill.label
        elseif Settings.useSkillNames ~= 1 and skill.detail ~= nil then
            skill.label = skill.detail
        end

        if tag ~= nil then
            skill.label = skill.label .. " (" .. tag .. ")"
        end
    end
    return true
end

function IndexedDictionary:SetSkillLabels()
    for k, skill in pairs(self.skills) do
        self:SetSkillLabel(skill)
    end
end

function IndexedDictionary:VerifySkill(skill)
    if skill.id == nil then
        Turbine.Shell.WriteLine("Skill missing id")
        return false
    else
        -- fixup any possible typos
        local orig = skill.id;
        skill.id = string.upper(skill.id)
        skill.id = "0x" .. skill.id:sub(3)
        if orig ~= skill.id then
            Turbine.Shell.WriteLine("Bad skill id format " .. orig)
        end
    end

    if skill.EN == nil or
            skill.DE == nil or
            skill.FR == nil or
            skill.RU == nil then
        Turbine.Shell.WriteLine("Skill missing language " .. skill.id)
    end

    local lang;
    if GLocale == Turbine.Language.German then
        lang = skill.DE
    elseif GLocale == Turbine.Language.French then
            lang = skill.FR
    elseif GLocale == Turbine.Language.Russian then
        lang = skill.RU
    else
        lang = skill.EN
    end
    skill.name = lang.name
    skill.desc = lang.desc
    skill.detail = lang.detail
    skill.zlabel = lang.zlabel
    skill.label0 = lang.label
    skill.zone = lang.zone
    if skill.tag == nil then
        skill.tag = lang.tag
    end

    if skill.name == nil then
        Turbine.Shell.WriteLine("Skill missing name " .. skill.id);
        return false
    end

    if skill.level == nil then
        Turbine.Shell.WriteLine("Skill missing level " .. skill.id);
    end

    for k, v in pairs(skill) do
        if not TableContains(ValidSkillKeys, k) then
            Turbine.Shell.WriteLine("Invalid key " .. k);
            return false;
        end
    end

    if skill.map == nil then
        Turbine.Shell.WriteLine(skill.name .. "(" .. skill.id .. ") coords not set")
    end

    return true
end

function IndexedDictionary:AddLabelTag(tag)
    if tag.EN == nil or tag.DE == nil or tag.FR == nil or tag.RU == nil then
        return
    end
    if GLocale == Turbine.Language.German then
        self.tag = tag.DE
    elseif GLocale == Turbine.Language.French then
        self.tag = tag.FR
    elseif GLocale == Turbine.Language.Russian then
        self.tag = tag.RU
    else
        self.tag = tag.EN
    end
end

-- function to add a skills data to the end of the dictionary
function IndexedDictionary:AddSkill(skill)
    if not self:VerifySkill(skill) then return end

    -- increase the number of datasets
    self.numberOfItems = self.numberOfItems + 1;
    self.parent.skillCount = self.parent.skillCount + 1;

    -- append the skill the list of skills
    table.insert(self.skills, skill);

    -- add the skill id to a list of Ids
    self.skillIdList[skill.id] = true;
end

-- function to remove a skills data from the dictionary at a specific index
function IndexedDictionary:RemoveSkillAtIndex(index)
    local id = self.skills[index].id;

    -- remove the data from the tables
    table.remove(self.skills, index);
    self.skillIdList[id] = nil;

    -- decrease the counters
    self.numberOfItems = self.numberOfItems - 1;
    self.parent.skillCount = self.parent.skillCount - 1;
end

-- function to get the skill at a specified index
function IndexedDictionary:Skill(index)
    return self.skills[index];
end

-- function to get the skill name at a specified index
function IndexedDictionary:NameAtIndex(index)
    return self.skills[index].name;
end

-- function to return the ID at a specified index
function IndexedDictionary:IdAtIndex(index)
    return self.skills[index].id;
end

-- function to return the label at a specified index
function IndexedDictionary:LabelAtIndex(index)
    return self.skills[index].label;
end

function IndexedDictionary:DescAtIndex(index)
    return self.skills[index].desc;
end

-- function to return the skill name and ID at a specified index
function IndexedDictionary:PairAtIndex(index)
    return self.skills[index].name, self.skills[index].id;
end

-- function to check if ID exists
function IndexedDictionary:VerifyId(id)
    if (self.skillIdList[id] == true) then
        return true;
    else
        return false;
    end
end

-- function to check if a table contains a specific element
function TableContains(tableToSearch, elementToSearchFor)
    for i, value in pairs(tableToSearch) do
        if (value == elementToSearchFor) then
            return true;
        end
    end
    return false;
end

-- function to check if a table contains a specific element index
function TableIndex(tableToSearch, elementToSearchFor)
    for i, value in pairs(tableToSearch) do
        if (value == elementToSearchFor) then
            return i;
        end
    end
    return 0;
end

function TableCopy(obj, seen)
    if type(obj) ~= 'table' then return obj end
    if seen and seen[obj] then return seen[obj] end
    local s = seen or {}
    local res = setmetatable({}, getmetatable(obj))
    s[obj] = res
    for k, v in pairs(obj) do res[TableCopy(k, s)] = TableCopy(v, s) end
    return res
end
