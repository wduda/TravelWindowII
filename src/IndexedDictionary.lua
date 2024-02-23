--[[ use a modified table to maintain data for travel skills
     specifically skill name, ID, label, description substring]]
IndexedDictionary = class()

function IndexedDictionary:Constructor(parent)
    self.parent = parent;

    -- valid skill keys
    self.skillKeys = {
        "id", "name", "desc", "label",
        "nameEN", "descEN", "labelEN",
        "nameDE", "descDE", "labelDE",
        "nameFR", "descFR", "labelFR",
    }

    -- init tables
    self.skills = {};
    self.skillIdList = {};
    self.numberOfItems = 0;
end

-- function to get the total number of entries in the dictionary
function IndexedDictionary:GetCount()
    return self.numberOfItems;
end

function IndexedDictionary:verifySkill(skill)
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

    if skill.nameEN == nil or
            skill.nameDE == nil or
            skill.nameFR == nil then
        Turbine.Shell.WriteLine("Missing language " .. skill.id);
    end

    if skill.name == nil then
        Turbine.Shell.WriteLine("Skill missing name " .. skill.id);
        return false
    end

    if skill.label == nil then
        -- copy name, but make sure it is unique
        for i = 1, #self.skills do
            if self.skills[i].name == skill.name then
                Turbine.Shell.WriteLine("Invalid label: " .. name);
                return false
            end
        end
        skill.label = skill.name;
    end

    for k, v in pairs(skill) do
        if not TableContains(self.skillKeys, k) then
            Turbine.Shell.WriteLine("Invalid key " .. k);
            return false;
        end
    end

    return true
end

-- function to add a skills data to the end of the dictionary
function IndexedDictionary:AddSkill(skill)
    if GLocale == Turbine.Language.French then
        skill.name = skill.nameFR;
        skill.desc = skill.descFR;
        skill.label = skill.labelFR;
    elseif GLocale == Turbine.Language.German then
        skill.name = skill.nameDE;
        skill.desc = skill.descDE;
        skill.label = skill.labelDE;
    else
        skill.name = skill.nameEN;
        skill.desc = skill.descEN;
        skill.label = skill.labelEN;
    end

    if not self:verifySkill(skill) then return end

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
