--[[ string constants ]] --
--[[ put all the strings that might require translation in ]] --
--[[ one location for easier access ]] --
helpString = "Travel\n\ntrav show: Display the Travel Window\n" ..
"trav hide: Hides the Travel Window\n" ..
"trav toggle: Toggle the Travel Window\n";

-- window title strings
mainTitleString = "Travel";
optionsTitleString = "Travel Options";
moorMapTitleString = "Moors Destinations";
eriadorMapTitleString = "Eriador Destinations";
rhovanionMapTitleString = "Rhovanion Destinations";
gondorMapTitleString = "Gondor Destinations"

-- strings for maps
glanMapString = "Glân Vraig Map";
glanMapItemString = "Map to Glân Vraig";

-- error messages
resetOrderString = "Your order settings have been reset due to a change in " ..
"the number of items previously saved. This should only occur once.\n" ..
"Sorry for the inconvenience.";

resetEnabledString = "Your selected skills have been reset due to a change in " ..
"the number of items previously saved.\n" ..
"Sorry for the inconvenience.";

skillNotTrainedString = "Skills not trained: ";

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
    hunterLocations:AddData("Guide to Bree", "0x70003F42", "Bree (Guide)");
    hunterLocations:AddData("Guide to Thorin's Hall", "0x70003F41", "Thorin's Hall (Guide)");
    hunterLocations:AddData("Guide to Michel Delving", "0x7000A2C3", "Michel Delving (Guide)");
    hunterLocations:AddData("Guide to Esteldín", "0x70003F43", "Esteldín (Guide)");
    hunterLocations:AddData("Guide to Evendim", "0x7000A2C4", "Evendim (Guide)");
    hunterLocations:AddData("Guide to Ost Guruth", "0x7000A2C2", "Ost Guruth (Guide)");
    hunterLocations:AddData("Guide to Rivendell", "0x70003F44", "Rivendell (Guide)");
    hunterLocations:AddData("Guide to Sûri-Kylä", "0x70017C82", "Sûri-kylä (Guide)");
    hunterLocations:AddData("Guide to West Angmar", "0x7000A2C5", "West Angmar (Guide)");
    hunterLocations:AddData("Guide to East Angmar", "0x7000A2C6", "East Angmar (Guide)");
    hunterLocations:AddData("Guide to Echad Dúnann", "0x70017C81", "Echad Dúnann (Guide)");
    hunterLocations:AddData("Guide to Twenty-First Hall", "0x70017C7A", "Twenty-First Hall (Guide)");
    hunterLocations:AddData("Guide to Mirk-Eaves", "0x7001F459", "Mirk-eaves (Guide)");
    hunterLocations:AddData("Guide to Harndirion", "0x700235EF", "Harndirion (Guide)");
    hunterLocations:AddData("Guide to Galtrev", "0x7002A93F", "Galtrev (Guide)");
    hunterLocations:AddData("Guide to Stangard", "0x7002C62C", "Stangard (Guide)");
    hunterLocations:AddData("Guide to Caras Galadhon", "0x7002E754", "Caras Galadhon (Guide)");
    hunterLocations:AddData("Guide to the Misty Mountains", "0x7002E756", "Misty Mountains (Guide)");
    hunterLocations:AddData("Guide to Snowbourn", "0x7003198E", "Snowbourn (Guide)");
    hunterLocations:AddData("Guide to Forlaw", "0x70036B5D", "Forlaw (Guide)");
    hunterLocations:AddData("Guide to Aldburg", "0x7003DC71", "Aldburg");
    hunterLocations:AddData("Guide to Helm's Deep", "0x7003DC72", "Helm's Deep (Guide)");
    hunterLocations:AddData("Guide to Dol Amroth", "0x70041197", "Dol Amroth (Guide)");
    hunterLocations:AddData("Guide to Arnach", "0x70043A63", "Arnach (Guide)");
    hunterLocations:AddData("Guide to Minas Tirith", "0x70044985", "Minas Tirith (Guide)");
    hunterLocations:AddData("Guide to the War-stead", "0x700459AF", "War-stead (Guide)");
    hunterLocations:AddData("Guide to after-battle Minas Tirith", "0x70046CBB", "Minas Tirith after battle (Guide)");
    hunterLocations:AddData("Guide to Henneth Annûn", "0x70047077", "Henneth Annûn (Guide)");
    hunterLocations:AddData("Guide to after-battle Osgiliath", "0x70047074", "Osgiliath after battle (Guide)");
    hunterLocations:AddData("Guide to the Camp of the Host", "0x70047BFA", "Camp of the Host (Guide)");
    hunterLocations:AddData("Guide to Haerondir", "0x70047C1D", "Haerondir (Guide)");
    hunterLocations:AddData("Guide to the Udûn Foothold", "0x7004AE1E", "Udûn Foothold (Guide)");
    hunterLocations:AddData("Guide to Dale", "0x7004d73b", "Dale (Guide)");
	hunterLocations:AddData("Guide to Járnfast", "0x7004FACC", "Járnfast (Guide)");
    hunterLocations:AddData("Guide to Skarháld", "0x7004FACB", "Skarháld (Guide)");
	hunterLocations:AddData("Guide to Beorninghús", "0x70052F07", "Beorninghús (Guide)");
    hunterLocations:AddData("Guide to Hultvís", "0x70052F08", "Hultvís (Guide)");
    hunterLocations:AddData("Guide to Estolad Lân", "0x700551F4", "Estolad Lân (Guide)"); -- Need to get the right Skill-ID
    hunterLocations:AddData("Guide to Limlók", "0x7005762D", "Limlók (Guide)");
    hunterLocations:AddData("Guide to Annâk-khurfu", "0x70058571", "Annâk-khurfu (Guide)");

    wardenLocations:AddData("Muster in Ost Guruth", "0x70014786", "Ost Guruth (Muster)");
    wardenLocations:AddData("Muster in Esteldín", "0x70014798", "Esteldín (Muster)");
    wardenLocations:AddData("Muster in Evendim", "0x7001478E", "Evendim (Muster)");
    wardenLocations:AddData("Muster in Rivendell", "0x70014791", "Rivendell (Muster)");
    wardenLocations:AddData("Muster in Sûri-Kylä", "0x700237D4", "Sûri-kylä (Muster)");
    wardenLocations:AddData("Muster in Twenty-First Hall", "0x7001819E", "Twenty-First Hall (Muster)");
    wardenLocations:AddData("Muster in Mirk-Eaves", "0x7001F45C", "Mirk-Eaves (Muster)");
    wardenLocations:AddData("Muster in Harndirion", "0x700235EB", "Harndirion (Muster)");
    wardenLocations:AddData("Muster in Galtrev", "0x7002A90A", "Galtrev (Muster)");
    wardenLocations:AddData("Muster in Stangard", "0x7002C646", "Stangard (Muster)");
    wardenLocations:AddData("Muster in Caras Galadhon", "0x700303DF", "Caras Galadhon (Muster)");
    wardenLocations:AddData("Muster in the Misty Mountains", "0x700303DD", "Misty Mountains (Muster)");
    wardenLocations:AddData("Muster in Snowbourn", "0x7003198D", "Snowbourn (Muster)");
    wardenLocations:AddData("Muster in Forlaw", "0x70036B5B", "Forlaw (Muster)");
    wardenLocations:AddData("Muster in Aldburg", "0x7003DC7A", "Aldburg (Muster)");
    wardenLocations:AddData("Muster in Helm's Deep", "0x7003DC79", "Helm's Deep (Muster)");
    wardenLocations:AddData("Muster in Dol Amroth", "0x70041198", "Dol Amroth (Muster)");
    wardenLocations:AddData("Muster in Arnach", "0x70043A66", "Arnach (Muster)");
    wardenLocations:AddData("Muster in Minas Tirith", "0x70044982", "Minas Tirith (Muster)");
    wardenLocations:AddData("Muster in the War-stead", "0x700459AA", "War-stead (Muster)");
    wardenLocations:AddData("Muster in after-battle Minas Tirith", "0x70046CBF", "Minas Tirith after battle (Muster)");
    wardenLocations:AddData("Muster in Henneth Annûn", "0x70047075", "Henneth Annûn (Muster)");
    wardenLocations:AddData("Muster in after-battle Osgiliath", "0x70047076", "Osgiliath after battle (Muster)");
    wardenLocations:AddData("Muster in the Camp of the Host", "0x70047BFC", "Camp of the Host (Muster)");
    wardenLocations:AddData("Muster in Haerondir", "0x70047C23", "Haerondir (Muster)");
    wardenLocations:AddData("Muster in the Udûn Foothold", "0x7004AE1F", "Udûn Foothold (Muster)");
    wardenLocations:AddData("Muster in Dale", "0x7004d73a", "Dale (Muster)");
	wardenLocations:AddData("Muster in Járnfast", "0x7004FACA", "Járnfast (Muster)");
    wardenLocations:AddData("Muster in Skarháld", "0x7004FACD", "Skarháld (Muster)");
	wardenLocations:AddData("Muster in Beorninghús", "0x70052F0A", "Beorninghús (Muster)");
    wardenLocations:AddData("Muster in Hultvís", "0x70052F06", "Hultvís (Muster)");
    wardenLocations:AddData("Muster in Estolad Lân", "0x700551F2", "Estolad Lân (Muster)");
    wardenLocations:AddData("Muster in Limlók", "0x70057635", "Limlók (Muster)");
    wardenLocations:AddData("Muster in Annâk-khurfu", "0x70058572", "Annâk-khurfu (Muster)");

    racialLocations:AddData("Return to Bree", "0x700062F6", "Bree (Racial)");
    racialLocations:AddData("Return to the Shire", "0x700062C8", "Shire (Racial)");
    racialLocations:AddData("Return to Thorin's Gate", "0x70006346", "Thorin's Gate (Racial Dwarf)");
    racialLocations:AddData("Return to Rivendell", "0x7000631F", "Rivendell (Racial)");
    racialLocations:AddData("Return Home (Racial)", "0x70041A22", "Beorning Home (Racial)");
    racialLocations:AddData("Travel to Caras Galadhon in Lothlórien", "0x70048C8C", "Caras Galadhon (Racial)");
    racialLocations:AddData("Travel to Thorin's Hall", "0x70053C0F", "Thorin's Hall (Racial StoutAxe)");

    -- add the Return Home and housing skills
    genLocations:AddData("Return Home", "0x700256BA", "Return Home");
    genLocations:AddData("Return Home 2", "0x70025792", "Return Home 2");
    genLocations:AddData("Return Home 3", "0x70025793", "Return Home 3");
    genLocations:AddData("Return Home 4", "0x70025794", "Return Home 4");
    genLocations:AddData("Return Home 5", "0x70025795", "Return Home 5");
    genLocations:AddData("Return Home 6", "0x70025796", "Return Home 6");
    genLocations:AddData("Return Home 7", "0x7002FF5F", "Return Home 7");
    genLocations:AddData("Return Home 8", "0x7002FF60", "Return Home 8");
    genLocations:AddData("Return Home 9", "0x7002FF61", "Return Home 9");
    genLocations:AddData("Return Home 10", "0x7002FF62", "Return Home 10");
    genLocations:AddData("Return Home 11", "0x7002FF63", "Return Home 11");
    genLocations:AddData("Travel to Personal House", "0x7000D046", "Personal House");
    genLocations:AddData("Travel to Premium House", "0x70046EE4", "Premium House");
    genLocations:AddData("Travel to Kinship House", "0x7000D047", "Kinship House");
    genLocations:AddData("Travel to Kinship Member's House", "0x70057C36", "Kinship Member's House");

    -- add the obtainable travel skills
    repLocations:AddData("Return to Thorin's Gate", "0x7001BF91", "Thorin's Gate (Rep)");
    repLocations:AddData("Return to Bree", "0x7001BF90", "Bree (Rep)");
    repLocations:AddData("Return to Lalia's Market", "0x700364B1", "Lalia's Market (Mithril)");
    repLocations:AddData("Return to Michel Delving", "0x70023262", "Shire (Store)");
    repLocations:AddData("Return to Rivendell", "0x70023263", "Rivendell (Store)");
    repLocations:AddData("Return to Ost Guruth", "0x70020441", "Ost Guruth (Rep)");
    repLocations:AddData("Return to Mirkwood", "0x7001F374", "Mirkwood (Rep)");
    repLocations:AddData("Return to Enedwaith", "0x70021FA2", "Enedwaith (Rep)");
    repLocations:AddData("Return to Galtrev", "0x7002C647", "Galtrev (Rep)");
    repLocations:AddData("Return to Stangard", "0x7002C65D", "Stangard (Rep)");
    repLocations:AddData("Return to Snowbourn", "0x70031A46", "Snowbourn (Rep)");
    repLocations:AddData("Return to Forlaw", "0x70036B5E", "Forlaw (Rep)");
    repLocations:AddData("Return to Aldburg", "0x7003DC81", "Aldburg (Rep)");
    repLocations:AddData("Return to Derndingle", "0x7004128F", "Derndingle (Rep)");
    repLocations:AddData("Return to Helm's Deep", "0x7003DC82", "Helm's Deep (Rep)");
    repLocations:AddData("Return to Dol Amroth", "0x700411AC", "Dol Amroth (Rep)");
    repLocations:AddData("Return to Arnach", "0x70043A6A", "Arnach (Rep)");
    repLocations:AddData("Return to Minas Tirith", "0x7004497E", "Minas Tirith (Rep)");
    repLocations:AddData("Return to the War-stead", "0x700459A9", "War-stead (Rep)");
    repLocations:AddData("Return to after-battle Minas Tirith", "0x70046CC0", "Minas Tirith after-battle (Rep)");
    repLocations:AddData("Return to Henneth Annûn", "0x70047080", "Henneth Annûn (Rep)");
    repLocations:AddData("Return to after-battle Osgiliath", "0x7004707D", "Osgiliath after-battle (Rep)");
    repLocations:AddData("Return to the Camp of the Host", "0x70047BF4", "Camp of the Host (Rep)");
    repLocations:AddData("Return to Haerondir", "0x70047C1B", "Haerondir (Rep)");
    repLocations:AddData("Return to the Udûn Foothold", "0x7004AE1D", "Udûn Foothold (Rep)");
    repLocations:AddData("Journey to the Court of Lothlórien", "0x7004B8C2", "Court of Lothlórien (Rep)");
    repLocations:AddData("Journey to the Hall of the King", "0x7004B8C3", "Hall of the King (Rep)");
    repLocations:AddData("Journey to the Hall Under the Mountain", "0x7004B8C4", "Hall Under the Mountain (Rep)");
    repLocations:AddData("Journey to Bâr Thorenion", "0x7004B8C5", "Bâr Thorenion (Rep)");
    repLocations:AddData("Return to Dale", "0x7004d738", "Dale (Rep)");
	repLocations:AddData("Return to Járnfast", "0x7004FAC3", "Járnfast (Rep)");
    repLocations:AddData("Return to Skarháld", "0x7004FAC5", "Skarháld (Rep)");
	repLocations:AddData("Return to Beorninghús", "0x70052F12", "Beorninghús (Rep)");
    repLocations:AddData("Return to Hultvís", "0x70052F04", "Hultvís (Rep)");
    repLocations:AddData("Return to Estolad Lân", "0x700551F8", "Estolad Lân (Rep)");	
    repLocations:AddData("Return to Limlók", "0x70057629", "Limlók (Rep)");
    repLocations:AddData("Return to Annâk-khurfu", "0x7005856F", "Annâk-khurfu (Rep)");
    
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
    self.skillLabels = {};
    self.numberOfPairs = 0;
end

-- function to get the total number of entries in the dictionary
function IndexedDictionary:GetCount()
    return self.numberOfPairs;
end

-- function to add a key/data pair to the end of the dictionary
function IndexedDictionary:AddData(key, data, label)
    -- increase the counter
    self.numberOfPairs = self.numberOfPairs + 1;

    -- insert the key into the list of keys
    table.insert(self.listOfKeys, key);
    -- add the key/data into the table
    self.dataPairs[key] = data;
    self.skillLabels[key] = label;
end

-- function to add a key/data pair at a specific index
function IndexedDictionary:InsertData(index, key, data, label)
    -- increase the counter
    self.numberOfPairs = self.numberOfPairs + 1;

    -- add the key to the list of keys at the specified index
    table.insert(self.listOfKeys, index, key);
    -- add the key/data into the table
    self.dataPairs[key] = data;
    self.skillLabels[key] = label;
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

-- function to return the label at a specified index
function IndexedDictionary:LabelAtIndex(index)
    local string = self.listOfKeys[index];
    local data = self.skillLabels[string];

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
    for i = 1, #self.listOfKeys, 1 do
        -- return the index value if a match is made
        if (self.listOfKeys[i] == key) then
            return i;
        end
    end

    -- return -1 since we did not find a key
    return -1;
end


