--[[ string constants ]] --
--[[ put all the strings that might require translation in ]] --
--[[ one location for easier access ]] --
helpString = "Travel\n\ntrav show: Display the Travel Window\n" ..
"trav hide: Hides the Travel Window\n" ..
"trav toggle: Toggle the Travel Window\n";

-- window title strings
mainTitleString = "Travel";
optionsTitleString = "Travel Options";
moorMapTitleString = "Map Locations";
eriadorMapTitleString = "Eriador Locations";
rhovanionMapTitleString = "Rhovanion Locations";
gondorMapTitleString = "Gondor Locations"

-- strings for maps
mapHomeString = "Map Home";
glanMapString = "Glân Vraig Map";
glanMapItemString = "Map to Glân Vraig";

-- adding map strings
mapInstructionString = "Drag your maps from your inventory onto the " ..
"quickslot below.  Then press the button " ..
"to set your map home skills.";
mapErrorString = "No maps detected, no updates made.";

-- error messages
resetOrderString = "Your order settings have been reset due to a change in " ..
"the number of items saved.  This should only occur once.\n" ..
"Sorry for the inconvenience.";

resetEnabledString = "Your selected skills have been reset due to an error " ..
"in the number of items previously saved.\n";

skillNotTrainedString = "Skill not trained: ";

-- options window strings
generalTabString = "General";
selectTabString = "Select";
sortTabString = "Sort";
hideString = "Hide Travel Window at Startup";
toggleString = "Show Toggle Button";
pulldownTravelString = "Travel when pulldown skill selected";
hideOnCombatString = "Hide window when entering combat";
genericLabelString = "Generic Skills";
racialLabelString = "Racial Skills";
classLabelString = "Class Skills";
repLabelString = "Reputation Skills";
moveUpString = "Move Up";
moveDownString = "Move Down";
moveTopString = "Move To Top";
moveBottomString = "Move To Bottom";
toggleSlidersString = "Toggle Button Opacity";
mainSlidersString = "Main Window Opacity";
minString = "Min: ";
maxString = "Max: ";
resetSettingsString = "Reset all to default";
checkSkillsString = "Check untrained skills";

-- menu strings
menuFiltersString = "Filters";
menuGenString = "Show Generic Travels";
menuRaceString = "Show Racial Travels";
menuRepString = "Show Reputation Travels";
menuClassString = "Show Class Travels";
menuModeString = "Mode";
menuTextString = "Text List";
menuIconString = "Icon Grid";
menuCaroString = "Carousel";
menuPullString = "Pulldown List";
menuMapString = "Add Map";
menuOptionsString = "Options";
moorMapString = "Open Moor Map";
eriadorMapString = "Open Eriador Map";
rhovanionMapString = "Open Rhovanion Map";
gondorMapString = "Open Gondor Map"
menuSkillsString = "List Untrained Skills";

--[[ travel skills ]] --
--[[ Add all the travel skills ]] --
TravelDictionaries = class()

function TravelDictionaries:Constructor()

    -- create the indexed tables that store all the data
    genLocations = IndexedDictionary();
    hunterLocations = IndexedDictionary();
    wardenLocations = IndexedDictionary();
    racialLocations = IndexedDictionary();
    repLocations = IndexedDictionary();
    creepLocations = IndexedDictionary();

    -- a table to store the number of each type of travel skill
    travelCount = { 0, 0, 0, 0, 0, 0 };
    totalLocations = 0;

    self:CreateDictionaries();
    self:GetCounts();
end

-- function to count the number of skills in total
function TravelDictionaries:GetCounts()
    travelCount[1] = hunterLocations:GetCount();
    travelCount[2] = wardenLocations:GetCount();
    travelCount[3] = genLocations:GetCount();
    travelCount[4] = repLocations:GetCount();
    travelCount[5] = racialLocations:GetCount();
    travelCount[6] = creepLocations:GetCount();

    totalLocations = travelCount[1] + travelCount[2] + travelCount[3] + travelCount[4] + travelCount[5];
end

-- function to return the count of a specific type of travel
function TravelDictionaries:GetCount(index)
    return travelCount[index];
end

-- function to get the total number of travel skills
function TravelDictionaries:GetTotalCount()
    return totalLocations;
end

-- function to return the 5 tables containing the travel skills
function TravelDictionaries:GetLocations()
    return genLocations, hunterLocations, wardenLocations, racialLocations, repLocations;
end

-- add the data to custom dictionaries to maintain the order
function TravelDictionaries:CreateDictionaries()
    hunterLocations:AddData("Return to Camp", "0x7000A2C1", "Return to Camp");
    hunterLocations:AddData("Guide to Bree", "0x70003F42", "Guide to Bree");
    hunterLocations:AddData("Guide to Thorin's Hall", "0x70003F41", "Guide to Thorin's Hall");
    hunterLocations:AddData("Guide to Michel Delving", "0x7000A2C3", "Guide to Michel Delving");
    hunterLocations:AddData("Guide to Esteldín", "0x70003F43", "Guide to Esteldín");
    hunterLocations:AddData("Guide to Evendim", "0x7000A2C4", "Guide to Evendim");
    hunterLocations:AddData("Guide to Ost Guruth", "0x7000A2C2", "Guide to Ost Guruth");
    hunterLocations:AddData("Guide to Rivendell", "0x70003F44", "Guide to Rivendell");
    hunterLocations:AddData("Guide to Sûri-Kylä", "0x70017C82", "Guide to Sûri-kylä");
    hunterLocations:AddData("Guide to West Angmar", "0x7000A2C5", "Guide to West Angmar");
    hunterLocations:AddData("Guide to East Angmar", "0x7000A2C6", "Guide to East Angmar");
    hunterLocations:AddData("Guide to Echad Dúnann", "0x70017C81", "Guide to Echad Dúnann");
    hunterLocations:AddData("Guide to Twenty-First Hall", "0x70017C7A", "Guide to the Twenty-first Hall");
    hunterLocations:AddData("Guide to Mirk-Eaves", "0x7001F459", "Guide to Mirk-eaves");
    hunterLocations:AddData("Guide to Harndirion", "0x700235EF", "Guide to Harndirion");
    hunterLocations:AddData("Guide to Galtrev", "0x7002A93F", "Guide to Galtrev");
    hunterLocations:AddData("Guide to Stangard", "0x7002C62C", "Guide to Stangard");
    hunterLocations:AddData("Guide to Caras Galadhon", "0x7002E754", "Guide to Caras Galadhon");
    hunterLocations:AddData("Guide to the Misty Mountains", "0x7002E756", "Guide to the Misty Mountains");
    hunterLocations:AddData("Guide to Snowbourn", "0x7003198E", "Guide to Snowbourn");
    hunterLocations:AddData("Guide to Forlaw", "0x70036B5D", "Guide to Forlaw");
    hunterLocations:AddData("Guide to Aldburg", "0x7003DC71", "Guide to Aldburg");
    hunterLocations:AddData("Guide to Helm's Deep", "0x7003DC72", "Guide to Helm's Deep");
    hunterLocations:AddData("Guide to Dol Amroth", "0x70041197", "Guide to Dol Amroth");
    hunterLocations:AddData("Guide to Arnach", "0x70043A63", "Guide to Arnach");
    hunterLocations:AddData("Guide to Minas Tirith", "0x70044985", "Guide to Minas Tirith");
    hunterLocations:AddData("Guide to the War-stead", "0x700459AF", "Guide to the War-stead");
    hunterLocations:AddData("Guide to after-battle Minas Tirith", "0x70046CBB", "Guide to after-battle Minas Tirith");
    hunterLocations:AddData("Guide to Henneth Annûn", "0x70047077", "Guide to Henneth Annûn");
    hunterLocations:AddData("Guide to after-battle Osgiliath", "0x70047074", "Guide to after-battle Osgiliath");
    hunterLocations:AddData("Guide to the Camp of the Host", "0x70047BFA", "Guide to the Camp of the Host");
    hunterLocations:AddData("Guide to Haerondir", "0x70047C1D", "Guide to Haerondir");
    hunterLocations:AddData("Guide to the Udûn Foothold", "0x7004AE1E", "Guide to the Udûn Foothold");

    wardenLocations:AddData("Muster in Ost Guruth", "0x70014786", "Muster in Ost Guruth");
    wardenLocations:AddData("Muster in Esteldín", "0x70014798", "Muster in Esteldín");
    wardenLocations:AddData("Muster in Evendim", "0x7001478E", "Muster in Evendim");
    wardenLocations:AddData("Muster in Rivendell", "0x70014791", "Muster in Rivendell");
    wardenLocations:AddData("Muster in Sûri-Kylä", "0x700237D4", "Muster in Sûri-kylä");
    wardenLocations:AddData("Muster in Twenty-First Hall", "0x7001819E", "Muster in the Twenty-first Hall");
    wardenLocations:AddData("Muster in Mirk-Eaves", "0x7001F45C", "Muster in Mirk-eaves");
    wardenLocations:AddData("Muster in Harndirion", "0x700235EB", "Muster in Harndirion");
    wardenLocations:AddData("Muster in Galtrev", "0x7002A90A", "Muster in Galtrev");
    wardenLocations:AddData("Muster in Stangard", "0x7002C646", "Muster in Stangard");
    wardenLocations:AddData("Muster in Caras Galadhon", "0x700303DF", "Muster in Caras Galadhon");
    wardenLocations:AddData("Muster in the Misty Mountains", "0x700303DD", "Muster in the Misty Mountains");
    wardenLocations:AddData("Muster in Snowbourn", "0x7003198D", "Muster in Snowbourn");
    wardenLocations:AddData("Muster in Forlaw", "0x70036B5B", "Muster in Forlaw");
    wardenLocations:AddData("Muster in Aldburg", "0x7003DC7A", "Muster in Aldburg");
    wardenLocations:AddData("Muster in Helm's Deep", "0x7003DC79", "Muster in Helm's Deep");
    wardenLocations:AddData("Muster in Dol Amroth", "0x70041198", "Muster in Dol Amroth");
    wardenLocations:AddData("Muster in Arnach", "0x70043A66", "Muster in Arnach");
    wardenLocations:AddData("Muster in Minas Tirith", "0x70044982", "Muster in Minas Tirith");
    wardenLocations:AddData("Muster in the War-stead", "0x700459AA", "Muster in the War-stead");
    wardenLocations:AddData("Muster in after-battle Minas Tirith", "0x70046CBF", "Muster in after-battle Minas Tirith");
    wardenLocations:AddData("Muster in Henneth Annûn", "0x70047075", "Muster in Henneth Annûn");
    wardenLocations:AddData("Muster in after-battle Osgiliath", "0x70047076", "Muster in after-battle Osgiliath");
    wardenLocations:AddData("Muster in the Camp of the Host", "0x70047BFC", "Muster in the Camp of the Host");
    wardenLocations:AddData("Muster in Haerondir", "0x70047C23", "Muster in Haerondir");
    wardenLocations:AddData("Muster in the Udûn Foothold", "0x7004AE1F", "Muster in the Udûn Foothold");

    racialLocations:AddData("Return to Bree", "0x700062F6", "Return to Bree");
    racialLocations:AddData("Return to the Shire", "0x700062C8", "Return to the Shire");
    racialLocations:AddData("Return to Thorin's Gate", "0x70006346", "Return to Thorin's Gate");
    racialLocations:AddData("Return to Rivendell", "0x7000631F", "Return to Rivendell");
    racialLocations:AddData("Return Home (Racial)", "0x70041A22", "Return Home");
    racialLocations:AddData("Return to Caras Galadhon in Lothlórien", "0x70048C8C", "Return to Caras Galadhon in Lothlórien");

    -- check if a function that only exists in the newest update exists,
    -- if so, add the Return Home skills
    if (Turbine.UI.Control.IsDisplayed ~= nil) then
        genLocations:AddData("Return Home 1", "0x700256BA", "skip");
        genLocations:AddData("Return Home 2", "0x70025792", "skip");
        genLocations:AddData("Return Home 3", "0x70025793", "skip");
        genLocations:AddData("Return Home 4", "0x70025794", "skip");
        genLocations:AddData("Return Home 5", "0x70025795", "skip");
        genLocations:AddData("Return Home 6", "0x70025796", "skip");
        genLocations:AddData("Return Home 7", "0x7002FF5F", "skip");
        genLocations:AddData("Return Home 8", "0x7002FF60", "skip");
        genLocations:AddData("Return Home 9", "0x7002FF61", "skip");
        genLocations:AddData("Return Home 10", "0x7002FF62", "skip");
        genLocations:AddData("Return Home 11", "0x7002FF63", "skip");
        genLocations:AddData("Return Home 12", "0x7002FF64", "skip");
    end
    genLocations:AddData("Personal House", "0x7000D046", "Travel to Personal House");
    genLocations:AddData("Premium House", "0x70046EE4", "Travel to Premium House");
    genLocations:AddData("Kinship House", "0x7000D047", "Travel to Kinship House");

    repLocations:AddData("Return to Thorin's Gate (Rep)", "0x7001BF91", "Return to Thorin's Gate");
    repLocations:AddData("Return to Bree (Rep)", "0x7001BF90", "Return to Bree");
    repLocations:AddData("Return to Lalia's Market", "0x700364B1", "Return to Lalia's Market");
    repLocations:AddData("Return to the Shire (Rep)", "0x70023262", "Return to Michel Delving");
    repLocations:AddData("Return to Rivendell (Rep)", "0x70023263", "Return to Rivendell");
    repLocations:AddData("Return to Ost Guruth (Rep)", "0x70020441", "Return to Ost Guruth");
    repLocations:AddData("Return to Mirkwood (Rep)", "0x7001F374", "Return to Mirkwood");
    repLocations:AddData("Return to Enedwaith (Rep)", "0x70021FA2", "Return to Enedwaith");
    repLocations:AddData("Return to Galtrev (Rep)", "0x7002C647", "Return to Galtrev");
    repLocations:AddData("Return to Stangard (Rep)", "0x7002C65D", "Return to Stangard");
    repLocations:AddData("Return to Snowbourn (Rep)", "0x70031A46", "Return to Snowbourn");
    repLocations:AddData("Return to Forlaw (Rep)", "0x70036B5E", "Return to Forlaw");
    repLocations:AddData("Return to Aldburg (Rep)", "0x7003DC81", "Return to Aldburg");
    repLocations:AddData("Return to Derndingle (Rep)", "0x7004128F", "Return to Derndingle");
    repLocations:AddData("Return to Helm's Deep (Rep)", "0x7003DC82", "Return to Helm's Deep");
    repLocations:AddData("Return to Dol Amroth (Rep)", "0x700411AC", "Return to Dol Amroth");
    repLocations:AddData("Return to Arnach (Rep)", "0x70043A6A", "Return to Arnach");
    repLocations:AddData("Return to Minas Tirith (Rep)", "0x7004497E", "Return to Minas Tirith");
    repLocations:AddData("Return to the War-stead (Rep)", "0x700459A9", "Return to the War-stead");
    repLocations:AddData("Return to after-battle Minas Tirith (Rep)", "0x70046CC0", "Return to after-battle Minas Tirith");
    repLocations:AddData("Return to after-battle Henneth Annûn (Rep)", "0x70047080", "Return to after-battle Henneth Annûn");
    repLocations:AddData("Return to after-battle Osgiliath (Rep)", "0x7004707D", "Return to after-battle Osgiliath");
    repLocations:AddData("Return to the Camp of the Host (Rep)", "0x70047BF4", "Return to the Camp of the Host");
    repLocations:AddData("Return to Haerondir (Rep)", "0x70047C1B", "Return to Haerondir");
    repLocations:AddData("Return to the Udûn Foothold (Rep)", "0x7004AE1D", "Return to the Udûn Foothold");
    repLocations:AddData("Journey to the Court of Lothlórien", "0x7004B8C2", "Journey to the Court of Lothlórien");
    repLocations:AddData("Journey to the Hall of the King", "0x7004B8C3", "Journey to the Hall of the King");
    repLocations:AddData("Journey to the Hall Under the Mountain", "0x7004B8C4", "Journey to the Hall Under the Mountain");
    repLocations:AddData("Journey to Bâr Thorenion", "0x7004B8C5", "Journey to Bâr Thorenion");

    -- Crude Map to Gramsfoot for newb creeps
    creepLocations:AddData("Crude Map to Gramsfoot", "0x70028BBC");
    creepLocations:AddData("Map to Gramsfoot", "0x70028BC1");

    creepLocations:AddData("Crude Map to Isendeep", "0x70028BB3");
    creepLocations:AddData("Crude Map to Tol Ascarnen", "0x70028BB6");
    creepLocations:AddData("Crude Map to Lugazag", "0x70028BB7");
    creepLocations:AddData("Crude Map to Tirith Rhaw", "0x70028BBE");
    creepLocations:AddData("Crude Map to Grimwood", "0x70028BBF");

    creepLocations:AddData("Poor Map to Isendeep", "0x70028BAF");
    creepLocations:AddData("Poor Map to Tol Ascarnen", "0x70028BB1");
    creepLocations:AddData("Poor Map to Lugazag", "0x70028BB2");
    creepLocations:AddData("Poor Map to Tirith Rhaw", "0x70028BB4");
    creepLocations:AddData("Poor Map to Grimwood", "0x70028BB9");

    creepLocations:AddData("Good Map to Isendeep", "0x70028BC0");
    creepLocations:AddData("Good Map to Tol Ascarnen", "0x70028BC2");
    creepLocations:AddData("Good Map to Lugazag", "0x70028BB5");
    creepLocations:AddData("Good Map to Tirith Rhaw", "0x70028BB0");
    creepLocations:AddData("Good Map to Grimwood", "0x70028BBD");
end

--[[ use a modified table that can maintain a key value for each entry ]] --
IndexedDictionary = class()

function IndexedDictionary:Constructor()

    -- set default tables
    self.listOfKeys = {};
    self.dataPairs = {};
    self.skillNames = {};
    self.numberOfPairs = 0;
end

-- function to get the total number of entries in the dictionary
function IndexedDictionary:GetCount()
    return self.numberOfPairs;
end

-- function to add a key/data pair to the end of the dictionary
function IndexedDictionary:AddData(key, data, name)
    -- increase the counter
    self.numberOfPairs = self.numberOfPairs + 1;

    -- insert the key into the list of keys
    table.insert(self.listOfKeys, key);
    -- add the key/data into the table
    self.dataPairs[key] = data;
    self.skillNames[key] = name;
end

-- function to add a key/data pair at a specific index
function IndexedDictionary:InsertData(index, key, data, name)
    -- increase the counter
    self.numberOfPairs = self.numberOfPairs + 1;

    -- add the key to the list of keys at the specified index
    table.insert(self.listOfKeys, index, key);
    -- add the key/data into the table
    self.dataPairs[key] = data;
    self.skillNames[key] = name;
end

-- function to remove a key/data pair at an index
function IndexedDictionary:RemoveAtIndex(index)

    self.location = 0;
    self.counter = 0;

    -- loop through the main table
    for k, v in pairs(self.dataPairs) do
        self.counter = self.counter + 1;

        -- if the keys match, set the location to remove from the table
        if (k == self.listOfKeys[index]) then
            self.location = self.counter;
        end
    end

    -- remove the item and the key from the tables
    table.remove(self.dataPairs, self.location);
    table.remove(self.listOfKeys, index);

    -- decrease the counters
    self.numberOfPairs = self.numberOfPairs - 1;
end

-- function to get the key at a specified index
function IndexedDictionary:KeyAtIndex(index)
    local string = self.listOfKeys[index];
    return string;
end

-- function to return the data at a specified index
function IndexedDictionary:DataAtIndex(index)
    local string = self.listOfKeys[index];
    local data = self.dataPairs[string];

    return data;
end

-- function to return the name at a specified index
function IndexedDictionary:NameAtIndex(index)
    local string = self.listOfKeys[index];
    local data = self.skillNames[string];

    return data;
end

-- function to return the data pair at an index
function IndexedDictionary:PairAtIndex(index)
    local string = self.listOfKeys[index];
    local data = self.dataPairs[string];

    return string, data;
end

-- function to get the data by a key value
function IndexedDictionary:DataByKey(key)
    return self.dataPairs[key];
end

-- function to find the index value based on a key
function IndexedDictionary:IndexByKey(key)

    -- return if the list of keys is empty
    if (self.listOfKeys == {}) then
        return -1;
    end

    -- loop through the list of keys and search for the key value
    for i = 1, table.getn(self.listOfKeys), 1 do
        -- return the index value if a match is made
        if (self.listOfKeys[i] == key) then
            return i;
        end
    end

    -- return -1 since we did not find a key
    return -1;
end


