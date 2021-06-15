--[[ use a modified table to maintain data for travel skills
     specifically skill name, ID and label                   ]] IndexedDictionary =
    class()

function IndexedDictionary:Constructor()
    -- set default tables
    self.skillNames = {};
    self.skillIds = {};
    self.skillIdList = {};
    self.skillLabels = {};
    self.numberOfItems = 0;
end

-- function to get the total number of entries in the dictionary
function IndexedDictionary:GetCount() return self.numberOfItems; end

-- function to add a skills name, ID and label to the end of the dictionary
function IndexedDictionary:AddSkill(name, id, label)
    -- increase the number of datasets
    self.numberOfItems = self.numberOfItems + 1;

    -- insert the skill into the list of skills
    table.insert(self.skillNames, name);

    -- add the skill id and label into the table with name as index
    self.skillIds[name] = id;
    self.skillLabels[name] = label;

    -- add the skill id to a list of Ids
    self.skillIdList[id] = true;
end

-- function to add a skills name, and data pair of ID and label, to the dictionary at a specific index
function IndexedDictionary:InsertSkill(index, name, id, label)
    -- increase the number of datasets
    self.numberOfItems = self.numberOfItems + 1;

    -- add the skill name to the list of skills at the specified index
    table.insert(self.skillNames, index, name);

    -- add the skill id and label into the table with name as index
    self.skillIds[name] = id;
    self.skillLabels[name] = label;
end

-- function to remove a skills name, ID and label from the dictionary at a specific index
function IndexedDictionary:RemoveSkillAtIndex(index)

    local location = 0;
    local counter = 0;

    -- loop through the main table
    for k, v in pairs(self.skillIds) do
        counter = counter + 1;

        -- if the keys match, set the location to remove from the table
        if (k == self.skillNames[index]) then location = counter; end
    end

    -- remove the name, ID and label from the tables
    table.remove(self.skillIds, location);
    table.remove(self.skillLabels, location);
    table.remove(self.skillNames, index);

    -- decrease the counters
    self.numberOfItems = self.numberOfItems - 1;
end

-- function to get the skill name at a specified index
function IndexedDictionary:NameAtIndex(index)
    local string = self.skillNames[index];
    return string;
end

-- function to return the ID at a specified index
function IndexedDictionary:IdAtIndex(index)
    local string = self.skillNames[index];
    local data = self.skillIds[string];

    return data;
end

-- function to return the label at a specified index
function IndexedDictionary:LabelAtIndex(index)
    local string = self.skillNames[index];
    local data = self.skillLabels[string];

    return data;
end

-- function to return the skill name and ID at a specified index
function IndexedDictionary:PairAtIndex(index)
    local string = self.skillNames[index];
    local data = self.skillIds[string];

    return string, data;
end

-- function to get the ID by a name value
function IndexedDictionary:IdByName(name) return self.skillIds[name]; end

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

    -- return if the list of keys is empty
    if (self.skillNames == {}) then return -1; end

    -- loop through the list of names and search for the given value
    for i = 1, #self.skillNames, 1 do
        -- return the index value if a match is made
        if (self.skillNames[i] == name) then return i; end
    end

    -- return -1 since we did not find a key
    return -1;
end
