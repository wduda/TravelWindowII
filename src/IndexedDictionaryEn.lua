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

skillNotTrainedString = "Skills not trained:";

-- options window strings
generalTabString = "General";
selectTabString = "Enable";
sortTabString = "Sort";
hideString = "Hide main window at startup";
toggleString = "Show Toggle Button";
pulldownTravelString = "Travel when pulldown skill selected";
hideOnTravelString = "Hide main window on travel";
hideOnCombatString = "Hide main window when entering combat";
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
checkSkillsString = "Check Untrained Skills";

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
menuSkillsString = "Check Untrained Skills";

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
    marinerLocations = IndexedDictionary();

    -- a table to store the number of each type of travel skill
    travelCount = { 0, 0, 0, 0, 0, 0, 0 };
    LocationsTotal = 0;

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
    travelCount[7] = marinerLocations:GetCount();

    LocationsTotal = travelCount[1] + travelCount[2] + travelCount[3] + travelCount[4] + travelCount[5] + travelCount[6] + travelCount[7];
end

-- function to return the count of a specific type of travel
function TravelDictionaries:GetCount(index)
    return travelCount[index];
end

-- function to get the total number of travel skills
function TravelDictionaries:GetTotalCount()
    return LocationsTotal;
end

-- function to return the 5 tables containing the travel skills
function TravelDictionaries:GetLocations()
    return genLocations, hunterLocations, wardenLocations, racialLocations, repLocations, creepLocations, marinerLocations;
end

-- add the data to custom dictionaries to maintain the order
function TravelDictionaries:CreateDictionaries()
    -- add the hunter locations
    hunterLocations:AddSkill("Return to Camp", "0x7000A2C1", "Return to Camp");
    hunterLocations:AddSkill("Guide to Bree", "0x70003F42", "Bree (Guide)");
    hunterLocations:AddSkill("Guide to Thorin's Hall", "0x70003F41", "Thorin's Hall (Guide)");
    hunterLocations:AddSkill("Guide to Michel Delving", "0x7000A2C3", "Michel Delving (Guide)");
    hunterLocations:AddSkill("Guide to Esteldín", "0x70003F43", "Esteldín (Guide)");
    hunterLocations:AddSkill("Guide to Evendim", "0x7000A2C4", "Evendim (Guide)");
    hunterLocations:AddSkill("Guide to Ost Guruth", "0x7000A2C2", "Ost Guruth (Guide)");
    hunterLocations:AddSkill("Guide to Rivendell", "0x70003F44", "Rivendell (Guide)");
    hunterLocations:AddSkill("Guide to Sûri-kylä", "0x70017C82", "Sûri-kylä (Guide)");
    hunterLocations:AddSkill("Guide to West Angmar", "0x7000A2C5", "West Angmar (Guide)");
    hunterLocations:AddSkill("Guide to East Angmar", "0x7000A2C6", "East Angmar (Guide)");
    hunterLocations:AddSkill("Guide to Echad Dúnann", "0x70017C81", "Echad Dúnann (Guide)");
    hunterLocations:AddSkill("Guide to the Twenty-first Hall", "0x70017C7A", "Twenty-first Hall (Guide)");
    hunterLocations:AddSkill("Guide to Mirk-eaves", "0x7001F459", "Mirk-eaves (Guide)");
    hunterLocations:AddSkill("Guide to Harndirion", "0x700235EF", "Harndirion (Guide)");
    hunterLocations:AddSkill("Guide to Galtrev", "0x7002A93F", "Galtrev (Guide)");
    hunterLocations:AddSkill("Guide to Stangard", "0x7002C62C", "Stangard (Guide)");
    hunterLocations:AddSkill("Guide to Caras Galadhon", "0x7002E754", "Caras Galadhon (Guide)");
    hunterLocations:AddSkill("Guide to the Misty Mountains", "0x7002E756", "Misty Mountains (Guide)");
    hunterLocations:AddSkill("Guide to Snowbourn", "0x7003198E", "Snowbourn (Guide)");
    hunterLocations:AddSkill("Guide to Forlaw", "0x70036B5D", "Forlaw (Guide)");
    hunterLocations:AddSkill("Guide to Aldburg", "0x7003DC71", "Aldburg (Guide)");
    hunterLocations:AddSkill("Guide to Helm's Deep", "0x7003DC72", "Helm's Deep (Guide)");
    hunterLocations:AddSkill("Guide to Dol Amroth", "0x70041197", "Dol Amroth (Guide)"); -- TODO: add desc
    hunterLocations:AddSkill("Guide to Arnach", "0x70043A63", "Arnach (Guide)");
    hunterLocations:AddSkill("Guide to Minas Tirith", "0x70044985", "Minas Tirith (Guide)");
    hunterLocations:AddSkill("Guide to the War-stead", "0x700459AF", "War-stead (Guide)");
    hunterLocations:AddSkill("Guide to after-battle Minas Tirith", "0x70046CBB", "Minas Tirith after battle (Guide)");
    hunterLocations:AddSkill("Guide to Henneth Annûn", "0x70047077", "Henneth Annûn (Guide)");
    hunterLocations:AddSkill("Guide to after-battle Osgiliath", "0x70047074", "Osgiliath after battle (Guide)");
    hunterLocations:AddSkill("Guide to the Camp of the Host", "0x70047BFA", "Camp of the Host (Guide)");
    hunterLocations:AddSkill("Guide to Haerondir", "0x70047C1D", "Haerondir (Guide)");
    hunterLocations:AddSkill("Guide to the Udûn Foothold", "0x7004AE1E", "Udûn Foothold (Guide)");
    hunterLocations:AddSkill("Guide to Dale", "0x7004D73B", "Dale (Guide)");
    hunterLocations:AddSkill("Guide to Járnfast", "0x7004FACC", "Járnfast (Guide)");
    hunterLocations:AddSkill("Guide to Skarháld", "0x7004FACB", "Skarháld (Guide)");
    hunterLocations:AddSkill("Guide to Beorninghús", "0x70052F07", "Beorninghús (Guide)");
    hunterLocations:AddSkill("Guide to Hultvís", "0x70052F08", "Hultvís (Guide)");
    hunterLocations:AddSkill("Guide to Estolad Lân", "0x700551F4", "Estolad Lân (Guide)");
    hunterLocations:AddSkill("Guide to Limlók", "0x7005762D", "Limlók (Guide)");
    hunterLocations:AddSkill("Guide to Annâk-khurfu", "0x70058571", "Annâk-khurfu (Guide)");
    hunterLocations:AddSkill("Guide to Trader's Wharf", "0x70059D0C", "Trader's Wharf (Guide)");
    hunterLocations:AddSkill("Guide to Trestlebridge", "0x70059D16", "Trestlebridge (Guide)");
    hunterLocations:AddSkill("Guide to Akrâz-zahar", "0x7005AA91", "Akrâz-zahar (Guide)");
    hunterLocations:AddSkill("Guide to Azanulbizar", "0x7005AA95", "Azanulbizar (Guide)");
    hunterLocations:AddSkill("Guide to the Noble Gate", "0x7005D487", "Noble Gate (Guide)");
    hunterLocations:AddSkill("Guide to Leitstáth", "0x7005D47D", "Leitstáth (Guide)");
    hunterLocations:AddSkill("Guide to Tornhad", "0x70060EA6", "Tornhad (Guide)");
    hunterLocations:AddSkill("Guide to Nobottle", "0x7006133F", "Nobottle (Guide)");
    hunterLocations:AddSkill("Guide to Andrath", "0x7006323C", "Andrath (Guide)");
    hunterLocations:AddSkill("Guide to Swanfleet", "0x700634AA", "Swanfleet (Guide)");
    hunterLocations:AddSkill("Guide to Cardolan", "0x700634A7", "Cardolan (Guide)");
    hunterLocations:AddSkill("Guide to Carn Dûm", "0x70064AC8", "Carn Dûm (Guide)");
    hunterLocations:AddSkill("Guide to Clegur", "0x70064F4C", "Clegur (Guide)");
    hunterLocations:AddSkill("Guide to Pelargir", "0x700658EA", "Pelargir (Guide)");
    hunterLocations:AddSkill("Guide to Dol Amroth", "0x70068711", "King's Dol Amroth (Guide U38)"); -- TODO: add desc
    hunterLocations:AddSkill("Guide to Halrax", "0x70068713", "Halrax (Guide)");
    hunterLocations:AddSkill("Guide to Lond Cirion", "0x70068717", "Lond Cirion (Guide)");
    hunterLocations:AddSkill("Guide to Umbar", "0x70068718", "Umbar (Guide)");
    hunterLocations:AddSkill("Guide to Jax Phanâl", "0x70068719", "Jax Phanâl (Guide)");

    -- add the Warden locations
    wardenLocations:AddSkill("Muster in Ost Guruth", "0x70014786", "Ost Guruth (Muster)");
    wardenLocations:AddSkill("Muster in Esteldín", "0x70014798", "Esteldín (Muster)");
    wardenLocations:AddSkill("Muster in Evendim", "0x7001478E", "Evendim (Muster)");
    wardenLocations:AddSkill("Muster in Rivendell", "0x70014791", "Rivendell (Muster)");
    wardenLocations:AddSkill("Muster in Sûri-kylä", "0x700237D4", "Sûri-kylä (Muster)");
    wardenLocations:AddSkill("Muster in the Twenty-first Hall", "0x7001819E", "Twenty-first Hall (Muster)");
    wardenLocations:AddSkill("Muster in Mirk-eaves", "0x7001F45C", "Mirk-Eaves (Muster)");
    wardenLocations:AddSkill("Muster in Harndirion", "0x700235EB", "Harndirion (Muster)");
    wardenLocations:AddSkill("Muster in Galtrev", "0x7002A90A", "Galtrev (Muster)");
    wardenLocations:AddSkill("Muster in Stangard", "0x7002C646", "Stangard (Muster)");
    wardenLocations:AddSkill("Muster in Caras Galadhon", "0x700303DF", "Caras Galadhon (Muster)");
    wardenLocations:AddSkill("Muster in the Misty Mountains", "0x700303DD", "Misty Mountains (Muster)");
    wardenLocations:AddSkill("Muster in Snowbourn", "0x7003198D", "Snowbourn (Muster)");
    wardenLocations:AddSkill("Muster in Forlaw", "0x70036B5B", "Forlaw (Muster)");
    wardenLocations:AddSkill("Muster in Aldburg", "0x7003DC7A", "Aldburg (Muster)");
    wardenLocations:AddSkill("Muster in Helm's Deep", "0x7003DC79", "Helm's Deep (Muster)");
    wardenLocations:AddSkill("Muster in Dol Amroth", "0x70041198", "Dol Amroth (Muster)");  -- TODO: add desc
    wardenLocations:AddSkill("Muster in Arnach", "0x70043A66", "Arnach (Muster)");
    wardenLocations:AddSkill("Muster in Minas Tirith", "0x70044982", "Minas Tirith (Muster)");
    wardenLocations:AddSkill("Muster in the War-stead", "0x700459AA", "War-stead (Muster)");
    wardenLocations:AddSkill("Muster in after-battle Minas Tirith", "0x70046CBF", "Minas Tirith after battle (Muster)");
    wardenLocations:AddSkill("Muster in Henneth Annûn", "0x70047075", "Henneth Annûn (Muster)");
    wardenLocations:AddSkill("Muster in after-battle Osgiliath", "0x70047076", "Osgiliath after battle (Muster)");
    wardenLocations:AddSkill("Muster in the Camp of the Host", "0x70047BFC", "Camp of the Host (Muster)");
    wardenLocations:AddSkill("Muster in Haerondir", "0x70047C23", "Haerondir (Muster)");
    wardenLocations:AddSkill("Muster in the Udûn Foothold", "0x7004AE1F", "Udûn Foothold (Muster)");
    wardenLocations:AddSkill("Muster in Dale", "0x7004D73A", "Dale (Muster)");
    wardenLocations:AddSkill("Muster in Járnfast", "0x7004FACA", "Járnfast (Muster)");
    wardenLocations:AddSkill("Muster in Skarháld", "0x7004FACD", "Skarháld (Muster)");
    wardenLocations:AddSkill("Muster in Beorninghús", "0x70052F0A", "Beorninghús (Muster)");
    wardenLocations:AddSkill("Muster in Hultvís", "0x70052F06", "Hultvís (Muster)");
    wardenLocations:AddSkill("Muster in Estolad Lân", "0x700551F2", "Estolad Lân (Muster)");
    wardenLocations:AddSkill("Muster in Limlók", "0x70057635", "Limlók (Muster)");
    wardenLocations:AddSkill("Muster in Annâk-khurfu", "0x70058572", "Annâk-khurfu (Muster)");
    wardenLocations:AddSkill("Muster in Trader's Wharf", "0x70059D09", "Trader's Wharf (Muster)");
    wardenLocations:AddSkill("Muster in Trestlebridge", "0x70059D10", "Trestlebridge (Muster)");
    wardenLocations:AddSkill("Muster in Akrâz-zahar", "0x7005AA8F", "Akrâz-zahar (Muster)");
    wardenLocations:AddSkill("Muster in Azanulbizar", "0x7005AA8C", "Azanulbizar (Muster)");
    wardenLocations:AddSkill("Muster at the Noble Gate", "0x7005D48A", "Noble Gate (Muster)");
    wardenLocations:AddSkill("Muster at Leitstáth", "0x7005D488", "Leitstáth (Muster)");
    wardenLocations:AddSkill("Muster at Tornhad", "0x70060EA5", "Tornhad (Muster)");
    wardenLocations:AddSkill("Muster at Nobottle", "0x7006133E", "Nobottle (Muster)");
    wardenLocations:AddSkill("Muster at Andrath", "0x70063242", "Andrath (Muster)");
    wardenLocations:AddSkill("Muster at Swanfleet", "0x700634B6", "Swanfleet (Muster)");
    wardenLocations:AddSkill("Muster at Cardolan", "0x700634AD", "Cardolan (Muster)");
    wardenLocations:AddSkill("Muster at Carn Dûm", "0x70064ACB", "Carn Dûm (Muster)");
    wardenLocations:AddSkill("Muster at Clegur", "0x70064F4D", "Clegur (Muster)");
    wardenLocations:AddSkill("Muster at Pelargir", "0x700658E8", "Pelargir (Muster)");
    wardenLocations:AddSkill("Muster at Jax Phanâl","0x7006870C", "Jax Phanâl (Muster)");
    wardenLocations:AddSkill("Muster at Umbar","0x7006870F","Umbar (Muster)");
    wardenLocations:AddSkill("Muster at Halrax","0x70068710", "Halrax (Muster)");
    wardenLocations:AddSkill("Muster at Dol Amroth","0x70068712", "King's Dol Amroth (Muster)"); -- TODO: add desc
    wardenLocations:AddSkill("Muster at Lond Cirion","0x70068715", "Lond Cirion (Muster)");

    -- add the Mariner locations
    marinerLocations:AddSkill("Sail to Celondim", "0x70066100", "Celondim (Sail)")
    marinerLocations:AddSkill("Sail to the Brown Lands", "0x70066101", "Brown Lands (Sail)")
    marinerLocations:AddSkill("Sail to Trader's Wharf", "0x70066105", "Trader's Wharf (Sail)")
    marinerLocations:AddSkill("Sail to after-battle Osgiliath", "0x70066109", "After-battle Osgiliath (Sail)")
    marinerLocations:AddSkill("Sail to Lake-town", "0x7006610C", "Lake-town (Sail)")
    marinerLocations:AddSkill("Sail to the Mirk-eaves", "0x7006610E", "Mirk-eaves (Sail)")
    marinerLocations:AddSkill("Sail to Tinnudir", "0x7006610F", "Tinnudir (Sail)")
    marinerLocations:AddSkill("Sail to Dol Amroth", "0x70066117", "Dol Amroth (Sail)") -- TODO: add desc arg
    marinerLocations:AddSkill("Sail to Buckland", "0x7006611A", "Buckland (Sail)")
    marinerLocations:AddSkill("Sail to Pelargir", "0x7006611B", "Pelargir (Sail)")
    marinerLocations:AddSkill("Sail to Sûri-kylä", "0x7006611C", "Sûri-kylä (Sail)")
    marinerLocations:AddSkill("Sail to Lothlórien", "0x7006611E", "Lothlórien (Sail)")
    marinerLocations:AddSkill("Sail to Tharbad", "0x70066120", "Tharbad (Sail)")
    marinerLocations:AddSkill("Sail to Snowbourn", "0x70066121", "Snowbourn (Sail)")
    marinerLocations:AddSkill("Sail to Umbar", "0x700687BB", "Umbar (Sail)")
    marinerLocations:AddSkill("Sail to Lond Cirion", "0x700687BD", "Lond Cirion (Sail)")
    marinerLocations:AddSkill("Sail to Jax Phanâl", "0x700687C0", "Jax Phanâl (Sail)")
    marinerLocations:AddSkill("Sail to Dol Amroth", "0x700687C1", "King's Dol Amroth (Sail)")  -- TODO: add desc arg
    marinerLocations:AddSkill("Sail to Halrax", "0x700687C3", "Halrax (Sail)")

    -- add the racial travel skills
    racialLocations:AddSkill("Return to Bree", "0x700062F6", "Bree (Racial)",
                             "This enables you to quickly return"); -- human
    racialLocations:AddSkill("Return to the Shire", "0x700062C8", "Shire (Racial)"); -- hobbit
    racialLocations:AddSkill("Return to Thorin's Gate", "0x70006346", "Thorin's Gate (Racial)",
                             "This enables you to quickly return"); -- dwarf
    racialLocations:AddSkill("Return to Rivendell", "0x7000631F", "Rivendell (Racial)",
                             "This enables you to quickly return"); --elf
    racialLocations:AddSkill("Return Home", "0x70041A22", "Beorning Home (Racial)"); -- beorning
    racialLocations:AddSkill("Travel to Caras Galadhon in Lothlórien", "0x70048C8C", "Caras Galadhon (Racial)"); -- high-elf
    racialLocations:AddSkill("Travel to Thorin's Hall", "0x70053C0F", "Thorin's Hall (Racial)"); -- stoutaxe
    racialLocations:AddSkill("Return to Lyndelby", "0x70066D31", "Lyndelby (Racial)") -- river hobbit

    -- add the Return Home and housing skills
    genLocations:AddSkill("Return Home",    "0x700256BA", "Return Home");
    genLocations:AddSkill("Return Home 2",  "0x70025792", "Return Home 2");
    genLocations:AddSkill("Return Home 3",  "0x70025793", "Return Home 3");
    genLocations:AddSkill("Return Home 4",  "0x70025794", "Return Home 4");
    genLocations:AddSkill("Return Home 5",  "0x70025795", "Return Home 5");
    genLocations:AddSkill("Return Home 6",  "0x70025796", "Return Home 6");
    genLocations:AddSkill("Return Home 7",  "0x7002FF62", "Return Home 7");
    genLocations:AddSkill("Return Home 8",  "0x7002FF61", "Return Home 8");
    genLocations:AddSkill("Return Home 9",  "0x7002FF60", "Return Home 9");
    genLocations:AddSkill("Return Home 10", "0x7002FF5F", "Return Home 10");
    genLocations:AddSkill("Return Home 11", "0x7002FF63", "Return Home 11");
    genLocations:AddSkill("Travel to Personal House", "0x7000D046", "Personal House");
    genLocations:AddSkill("Travel to Premium House", "0x70046EE4", "Premium House");
    genLocations:AddSkill("Travel to Kinship House", "0x7000D047", "Kinship House");
    genLocations:AddSkill("Travel to Kinship Member's House", "0x70057C36", "Kinship Member's House");

    -- add the obtainable travel skills
    repLocations:AddSkill("Return to Thorin's Gate", "0x7001BF91", "Thorin's Gate (Rep)",
                          "Thanks to your friendship");
    repLocations:AddSkill("Return to Bree", "0x7001BF90", "Bree (Rep)",
                          "Thanks to your friendship");
    repLocations:AddSkill("Return to Lalia's Market", "0x700364B1", "Lalia's Market (Mithril)");
    repLocations:AddSkill("Return to Michel Delving", "0x70023262", "Shire (Store)");
    repLocations:AddSkill("Return to Rivendell", "0x70023263", "Rivendell (Store)",
                          "Thanks to your friendship");
    repLocations:AddSkill("Return to Ost Guruth", "0x70020441", "Ost Guruth (Rep)");
    repLocations:AddSkill("Return to Mirkwood", "0x7001F374", "Mirkwood (Rep)");
    repLocations:AddSkill("Return to Enedwaith", "0x70021FA2", "Enedwaith (Rep)");
    repLocations:AddSkill("Return to Galtrev", "0x7002C647", "Galtrev (Rep)");
    repLocations:AddSkill("Return to Stangard", "0x7002C65D", "Stangard (Rep)");
    repLocations:AddSkill("Return to Snowbourn", "0x70031A46", "Snowbourn (Rep)");
    repLocations:AddSkill("Return to Forlaw", "0x70036B5E", "Forlaw (Rep)");
    repLocations:AddSkill("Return to Aldburg", "0x7003DC81", "Aldburg (Rep)");
    repLocations:AddSkill("Return to Derndingle", "0x7004128F", "Derndingle (Rep)");
    repLocations:AddSkill("Return to Helm's Deep", "0x7003DC82", "Helm's Deep (Rep)");
    repLocations:AddSkill("Return to Dol Amroth", "0x700411AC", "Dol Amroth (Rep)",
                          "quickly return to Dol Amroth in western Gondor");
    repLocations:AddSkill("Return to Arnach", "0x70043A6A", "Arnach (Rep)");
    repLocations:AddSkill("Return to Minas Tirith", "0x7004497E", "Minas Tirith (Rep)");
    repLocations:AddSkill("Return to the War-stead", "0x700459A9", "War-stead (Rep)");
    repLocations:AddSkill("Return to after-battle Minas Tirith", "0x70046CC0", "Minas Tirith after-battle (Rep)");
    repLocations:AddSkill("Return to Henneth Annûn", "0x70047080", "Henneth Annûn (Rep)");
    repLocations:AddSkill("Return to after-battle Osgiliath", "0x7004707D", "Osgiliath after-battle (Rep)");
    repLocations:AddSkill("Return to the Camp of the Host", "0x70047BF4", "Camp of the Host (Rep)");
    repLocations:AddSkill("Return to Haerondir", "0x70047C1B", "Haerondir (Rep)");
    repLocations:AddSkill("Return to the Udûn Foothold", "0x7004AE1D", "Udûn Foothold (Rep)");
    repLocations:AddSkill("Journey to the Court of Lothlórien", "0x7004B8C2", "Court of Lothlórien (Rep)");
    repLocations:AddSkill("Journey to the Hall of the King", "0x7004B8C3", "Hall of the King (Rep)");
    repLocations:AddSkill("Journey to the Hall Under the Mountain", "0x7004B8C4", "Hall Under the Mountain (Rep)");
    repLocations:AddSkill("Journey to Bâr Thorenion", "0x7004B8C5", "Bâr Thorenion (Rep)");
    repLocations:AddSkill("Return to Dale", "0x7004D738", "Dale (Rep)");
    repLocations:AddSkill("Return to Járnfast", "0x7004FAC3", "Járnfast (Rep)");
    repLocations:AddSkill("Return to Skarháld", "0x7004FAC5", "Skarháld (Rep)");
    repLocations:AddSkill("Return to Beorninghús", "0x70052F12", "Beorninghús (Rep)");
    repLocations:AddSkill("Return to Hultvís", "0x70052F04", "Hultvís (Rep)");
    repLocations:AddSkill("Return to Estolad Lân", "0x700551F8", "Estolad Lân (Rep)");
    repLocations:AddSkill("Return to Limlók", "0x70057629", "Limlók (Rep)");
    repLocations:AddSkill("Return to Annâk-khurfu", "0x7005856F", "Annâk-khurfu (Rep)");
    repLocations:AddSkill("Return to Trader's Wharf", "0x70059D0E", "Trader's Wharf (Rep)");
    repLocations:AddSkill("Return to Trestlebridge", "0x70059D12", "Trestlebridge (Rep)");
    repLocations:AddSkill("Return to Akrâz-zahar", "0x7005AA90", "Akrâz-zahar (Rep)");
    repLocations:AddSkill("Return to Azanulbizar", "0x7005AA92", "Azanulbizar (Rep)");
    repLocations:AddSkill("Journey to the Hall of Vérnozal", "0x7005A596", "Vérnozal (Quest)");
    repLocations:AddSkill("Return to the Noble Gate", "0x7005D47C", "Noble Gate (Rep)");
    repLocations:AddSkill("Return to Leitstáth", "0x7005D484", "Leitstáth (Rep)");
    repLocations:AddSkill("Return to Tornhad", "0x70060EA8", "Tornhad (Rep)");
    repLocations:AddSkill("Return to Nobottle", "0x70061340", "Nobottle (Rep)");
    repLocations:AddSkill("Return to Andrath", "0x7006323D", "Andrath (Rep)");
    repLocations:AddSkill("Return to Swanfleet", "0x700634A4", "Swanfleet (Rep)");
    repLocations:AddSkill("Return to Cardolan", "0x700634AE", "Cardolan (Rep)");
    repLocations:AddSkill("Return to the Tracery Archives in Rivendell", "0x700634A5", "Tracery Archive (Delving)");
    repLocations:AddSkill("Return to Carn Dûm", "0x70064ACA", "Carn Dûm (Rep)");
    repLocations:AddSkill("Return to Clegur", "0x70064F47", "Clegur (Rep)");
    repLocations:AddSkill("Return to Glân Vraig", "0x7005B38E", "Glân Vraig (Quest)");
    repLocations:AddSkill("Return to Pelargir", "0x700658EB", "Pelargir (Rep)");
    repLocations:AddSkill("Return to the Order of the Eagle", "0x700686FE", "Order of the Eagle (Rep)");
    repLocations:AddSkill("Return to Umbar", "0x700686FF", "Umbar (Rep)");
    repLocations:AddSkill("Return to Dol Amroth", "0x70068700", "King's Dol Amroth (Rep U38)", "King's Gondor");
    repLocations:AddSkill("Return to Jax Phanâl", "0x70068701", "Jax Phanâl (Rep)");
    repLocations:AddSkill("Return to Halrax", "0x70068702", "Halrax (Rep)");
    repLocations:AddSkill("Return to Lond Cirion", "0x70068703", "Lond Cirion (Rep)");
    repLocations:AddSkill("Return to the Ledger-Keepers", "0x70068704", "Ledger-Keepers (Rep)");

    -- monster player maps
    creepLocations:AddSkill("Crude Map to Gramsfoot", "0x70028BBC");
    creepLocations:AddSkill("Map to Gramsfoot", "0x70028BC1");

    creepLocations:AddSkill("Crude Map to Isendeep", "0x70028BB3");
    creepLocations:AddSkill("Crude Map to Tol Ascarnen", "0x70028BB6");
    creepLocations:AddSkill("Crude Map to Lugazag", "0x70028BB7");
    creepLocations:AddSkill("Crude Map to Tirith Rhaw", "0x70028BBE");
    creepLocations:AddSkill("Crude Map to Grimwood", "0x70028BBF");

    creepLocations:AddSkill("Poor Map to Isendeep", "0x70028BAF");
    creepLocations:AddSkill("Poor Map to Tol Ascarnen", "0x70028BB1");
    creepLocations:AddSkill("Poor Map to Lugazag", "0x70028BB2");
    creepLocations:AddSkill("Poor Map to Tirith Rhaw", "0x70028BB4");
    creepLocations:AddSkill("Poor Map to Grimwood", "0x70028BB9");

    creepLocations:AddSkill("Good Map to Isendeep", "0x70028BC0");
    creepLocations:AddSkill("Good Map to Tol Ascarnen", "0x70028BC2");
    creepLocations:AddSkill("Good Map to Lugazag", "0x70028BB5");
    creepLocations:AddSkill("Good Map to Tirith Rhaw", "0x70028BB0");
    creepLocations:AddSkill("Good Map to Grimwood", "0x70028BBD");
end
