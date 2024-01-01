--[[ use a modified table to maintain data for travel skills
     specifically skill name, ID and label                   ]]
IndexedDictionary = class()

function IndexedDictionary:Constructor()
    -- set default tables
    self.skillNames = {}; -- must be a list of unique names!
    self.skillIds = {};
    self.skillIdList = {};
    self.skillLabels = {};
    self.skillDesc = {}; -- used to disambiguate identical skillNames
    self.numberOfItems = 0;
end

-- function to get the total number of entries in the dictionary
function IndexedDictionary:GetCount()
    return self.numberOfItems;
end

-- function to add a skills name, ID and label to the end of the dictionary
function IndexedDictionary:AddSkill(name, id, label, desc)
    if label == nil then
        if self.skillLabels[name] ~= nil then
            Turbine.Shell.WriteLine("Invalid label: " .. name);
            return
        end
        label = name;
    end

    -- increase the number of datasets
    self.numberOfItems = self.numberOfItems + 1;

    -- insert the unique label into the list of skills
    table.insert(self.skillLabels, label);

    -- add the skill id, name, and description into the table with label as index
    self.skillIds[label] = id;
    self.skillNames[label] = name;
    self.skillDesc[label] = desc;

    -- add the skill id to a list of Ids
    self.skillIdList[id] = true;
end

-- function to add a skills name, and data pair of ID and label, to the dictionary at a specific index
function IndexedDictionary:InsertSkill(index, name, id, label, desc)
    if label == nil then
        if self.skillLabels[name] ~= nil then
            Turbine.Shell.WriteLine("Invalid label: " .. name);
            return
        end
        label = name;
    end

    -- increase the number of datasets
    self.numberOfItems = self.numberOfItems + 1;

    -- insert the unique label into the list of skills at the specified index
    table.insert(self.skillLabels, index, label);

    -- add the skill id, name, and description into the table with label as index
    self.skillIds[label] = id;
    self.skillNames[label] = name;
    self.skillDesc[label] = desc;

    -- add the skill id to a list of Ids
    self.skillIdList[id] = true;
end

-- function to remove a skills name, ID and label from the dictionary at a specific index
function IndexedDictionary:RemoveSkillAtIndex(index)

    local label = self.skillLabels[index];
    local id = self.skillIds[label];

    -- remove the name, ID and label from the tables
    table.remove(self.skillLabels, index);
    self.skillIds[label] = nil;
    self.skillNames[label] = nil;
    self.skillDesc[label] = nil;
    self.skillIdList[id] = nil;

    -- decrease the counters
    self.numberOfItems = self.numberOfItems - 1;
end

-- function to get the skill name at a specified index
function IndexedDictionary:NameAtIndex(index)
    local label = self.skillLabels[index];
    local name = self.skillNames[label];
    return name;
end

-- function to return the ID at a specified index
function IndexedDictionary:IdAtIndex(index)
    local label = self.skillLabels[index];
    local id = self.skillIds[label];
    return id;
end

-- function to return the label at a specified index
function IndexedDictionary:LabelAtIndex(index)
    local label = self.skillLabels[index];
    return label;
end

function IndexedDictionary:DescAtIndex(index)
    local label = self.skillLabels[index];
    local desc = self.skillDesc[label];
    return desc;
end

-- function to return the skill name and ID at a specified index
function IndexedDictionary:PairAtIndex(index)
    local label = self.skillLabels[index];
    local id = self.skillIds[label];
    local name = self.skillNames[label];
    return name, id;
end

-- function to get the ID by a name value
function IndexedDictionary:IdByName(name)
    for k, v in pairs(self.skillNames) do
        if v == name then
            return self.skillIds[k];
        end
    end
    return nil;
end

-- function to check if ID exists
function IndexedDictionary:VerifyId(id)
    if (self.skillIdList[id] == true) then
        return true;
    else
        return false;
    end
end

-- function to find the index value based on a key
function IndexedDictionary:IndexByName(name)
    for k, v in pairs(self.skillNames) do
        if v == name then
            for i = 1, #self.skillLabels, 1 do
                if self.skillLabels[i] == k then
                    return i;
                end
            end
        end
    end

    -- return -1 since we did not find a key
    return -1;
end
