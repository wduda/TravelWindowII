--[[ use a modified table to maintain data for travel skills
     specifically skill name, ID, label, description substring]]
IndexedDictionary = class()

local ValidSkillKeys = {
    "id", "name", "desc", "label", "label0", "listLabel", "detail", "zlabel", "zone", "tag",
    "EN", "DE", "FR", "RU",
    "map", "overlap", "level", "minLevel", "store", "autoLevel",
    "acquire", "cost", "amount", "token", "coords", "rep", "repLevel",
    "quest", "deed", "vendor", "allegiance", "rank"
}

function IndexedDictionary:Constructor(parent, title)
    self.parent = parent

    self.title = title

    -- init tables
    self.skills = {}
    self.skillIdList = {}
    self.numberOfItems = 0
end

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

        skill.listLabel = skill.label
        if tag ~= nil then
            skill.label = skill.label .. " (" .. tag .. ")"
            if Settings.useTagInListTab == 1 then
                skill.listLabel = skill.label
            end
        end
    end
    if skill.listLabel == nil then
        skill.listLabel = skill.label
    end
    return true
end

function IndexedDictionary:SetSkillLabels()
    for k, skill in pairs(self.skills) do
        self:SetSkillLabel(skill)
    end
end

function IndexedDictionary:SelectLCText(item)
    if item == nil then return end
    local langs = {
        {name="DE", lc=Turbine.Language.German},
        {name="FR", lc=Turbine.Language.French},
        {name="RU", lc=Turbine.Language.Russian},
        {name="EN", lc=nil}} -- unknown language types default to english
    for i = 1, #langs do
        local lang = langs[i]
        if lang.lc == nil or lang.lc == GLocale then
            local lcItem = item[lang.name]
            if type(lcItem) == "table" then
                -- only move localization values into 'item'
                for k, v in pairs(lcItem) do item[k] = v end
                -- done with localization data, remove it
                item.EN = nil
                item.DE = nil
                item.FR = nil
                item.RU = nil
                return item
            end
            return lcItem
        end
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

    local prevSkillTag = skill.tag
    self:SelectLCText(skill)

    skill.label0 = skill.label
    skill.label = nil
    if prevSkillTag ~= nil then
        skill.tag = prevSkillTag
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

    if skill.acquire ~= nil then
        local items = skill.acquire
        for i = 1, #items do
            self:SelectLCText(items[i])
        end
    end

    return true
end

function IndexedDictionary:AddLabelTag(tag)
    if tag.EN == nil or tag.DE == nil or tag.FR == nil or tag.RU == nil then
        return
    end
    self.tag = self:SelectLCText(tag)
end

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

function IndexedDictionary:RemoveSkillAtIndex(index)
    local id = self.skills[index].id;

    -- remove the data from the tables
    table.remove(self.skills, index);
    self.skillIdList[id] = nil;

    -- decrease the counters
    self.numberOfItems = self.numberOfItems - 1;
    self.parent.skillCount = self.parent.skillCount - 1;
end

function IndexedDictionary:Skill(index)
    return self.skills[index];
end

function IndexedDictionary:NameAtIndex(index)
    return self.skills[index].name;
end

function IndexedDictionary:IdAtIndex(index)
    return self.skills[index].id;
end

function IndexedDictionary:LabelAtIndex(index)
    return self.skills[index].label;
end

function IndexedDictionary:DescAtIndex(index)
    return self.skills[index].desc;
end

function IndexedDictionary:PairAtIndex(index)
    return self.skills[index].name, self.skills[index].id;
end

function IndexedDictionary:VerifyId(id)
    if (self.skillIdList[id] == true) then
        return true;
    else
        return false;
    end
end

function TableContains(tableToSearch, elementToSearchFor)
    for i, value in pairs(tableToSearch) do
        if (value == elementToSearchFor) then
            return true;
        end
    end
    return false;
end

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
