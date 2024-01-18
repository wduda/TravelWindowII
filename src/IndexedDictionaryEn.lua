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

skillNotTrainedString = "Skills not trained: ";

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
enableRepSkillsString = "Enable Overlapping";
disableRepSkillsString = "Disable Overlapping";
enableAllString = "Enable All";
disableAllString = "Disable All";
ignoreEscString = "Ignore Escape to close main window";
minWindowString = "Use Mini-Window";

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
mapWindowString = "Maps";
menuOptionsString = "Options";
moorMapString = "Open Moor Map";
eriadorMapString = "Open Eriador Map";
rhovanionMapString = "Open Rhovanion Map";
rohanMapString = "Open Rohan Map";
gondorMapString = "Open Gondor Map"
haradwaithMapString = "Open Haradwaith Map";
menuSkillsString = "Check Untrained Skills";

--[[ travel skills ]] --
--[[ Add all the travel skills ]] --
-- add the data to custom dictionaries to maintain the order
function TravelDictionary:CreateDictionaries()
    -- add the hunter locations
    self.hunter:AddSkill("Return to Camp", "0x7000A2C1", "Return to Camp");
    self.hunter:AddSkill("Guide to Bree", "0x70003F42", "Bree (Guide)");
    self.hunter:AddSkill("Guide to Thorin's Hall", "0x70003F41", "Thorin's Hall (Guide)");
    self.hunter:AddSkill("Guide to Michel Delving", "0x7000A2C3", "Michel Delving (Guide)");
    self.hunter:AddSkill("Guide to Esteldín", "0x70003F43", "Esteldín (Guide)");
    self.hunter:AddSkill("Guide to Evendim", "0x7000A2C4", "Evendim (Guide)");
    self.hunter:AddSkill("Guide to Ost Guruth", "0x7000A2C2", "Ost Guruth (Guide)");
    self.hunter:AddSkill("Guide to Rivendell", "0x70003F44", "Rivendell (Guide)");
    self.hunter:AddSkill("Guide to Sûri-kylä", "0x70017C82", "Sûri-kylä (Guide)");
    self.hunter:AddSkill("Guide to West Angmar", "0x7000A2C5", "West Angmar (Guide)");
    self.hunter:AddSkill("Guide to East Angmar", "0x7000A2C6", "East Angmar (Guide)");
    self.hunter:AddSkill("Guide to Echad Dúnann", "0x70017C81", "Echad Dúnann (Guide)");
    self.hunter:AddSkill("Guide to the Twenty-first Hall", "0x70017C7A", "Twenty-first Hall (Guide)");
    self.hunter:AddSkill("Guide to Mirk-eaves", "0x7001F459", "Mirk-eaves (Guide)");
    self.hunter:AddSkill("Guide to Harndirion", "0x700235EF", "Harndirion (Guide)");
    self.hunter:AddSkill("Guide to Galtrev", "0x7002A93F", "Galtrev (Guide)");
    self.hunter:AddSkill("Guide to Stangard", "0x7002C62C", "Stangard (Guide)");
    self.hunter:AddSkill("Guide to Caras Galadhon", "0x7002E754", "Caras Galadhon (Guide)");
    self.hunter:AddSkill("Guide to the Misty Mountains", "0x7002E756", "Misty Mountains (Guide)");
    self.hunter:AddSkill("Guide to Snowbourn", "0x7003198E", "Snowbourn (Guide)");
    self.hunter:AddSkill("Guide to Forlaw", "0x70036B5D", "Forlaw (Guide)");
    self.hunter:AddSkill("Guide to Aldburg", "0x7003DC71", "Aldburg (Guide)");
    self.hunter:AddSkill("Guide to Helm's Deep", "0x7003DC72", "Helm's Deep (Guide)");
    self.hunter:AddSkill("Guide to Dol Amroth", "0x70041197", "Dol Amroth (Guide)", "Dol Amroth in western Gondor");
    self.hunter:AddSkill("Guide to Arnach", "0x70043A63", "Arnach (Guide)");
    self.hunter:AddSkill("Guide to Minas Tirith", "0x70044985", "Minas Tirith (Guide)");
    self.hunter:AddSkill("Guide to the War-stead", "0x700459AF", "War-stead (Guide)");
    self.hunter:AddSkill("Guide to after-battle Minas Tirith", "0x70046CBB", "Minas Tirith after battle (Guide)");
    self.hunter:AddSkill("Guide to Henneth Annûn", "0x70047077", "Henneth Annûn (Guide)");
    self.hunter:AddSkill("Guide to after-battle Osgiliath", "0x70047074", "Osgiliath after battle (Guide)");
    self.hunter:AddSkill("Guide to the Camp of the Host", "0x70047BFA", "Camp of the Host (Guide)");
    self.hunter:AddSkill("Guide to Haerondir", "0x70047C1D", "Haerondir (Guide)");
    self.hunter:AddSkill("Guide to the Udûn Foothold", "0x7004AE1E", "Udûn Foothold (Guide)");
    self.hunter:AddSkill("Guide to Dale", "0x7004D73B", "Dale (Guide)");
    self.hunter:AddSkill("Guide to Járnfast", "0x7004FACC", "Járnfast (Guide)");
    self.hunter:AddSkill("Guide to Skarháld", "0x7004FACB", "Skarháld (Guide)");
    self.hunter:AddSkill("Guide to Beorninghús", "0x70052F07", "Beorninghús (Guide)");
    self.hunter:AddSkill("Guide to Hultvís", "0x70052F08", "Hultvís (Guide)");
    self.hunter:AddSkill("Guide to Estolad Lân", "0x700551F4", "Estolad Lân (Guide)");
    self.hunter:AddSkill("Guide to Limlók", "0x7005762D", "Limlók (Guide)");
    self.hunter:AddSkill("Guide to Annâk-khurfu", "0x70058571", "Annâk-khurfu (Guide)");
    self.hunter:AddSkill("Guide to Trader's Wharf", "0x70059D0C", "Trader's Wharf (Guide)");
    self.hunter:AddSkill("Guide to Trestlebridge", "0x70059D16", "Trestlebridge (Guide)");
    self.hunter:AddSkill("Guide to Akrâz-zahar", "0x7005AA91", "Akrâz-zahar (Guide)");
    self.hunter:AddSkill("Guide to Azanulbizar", "0x7005AA95", "Azanulbizar (Guide)");
    self.hunter:AddSkill("Guide to the Noble Gate", "0x7005D487", "Noble Gate (Guide)");
    self.hunter:AddSkill("Guide to Leitstáth", "0x7005D47D", "Leitstáth (Guide)");
    self.hunter:AddSkill("Guide to Tornhad", "0x70060EA6", "Tornhad (Guide)");
    self.hunter:AddSkill("Guide to Nobottle", "0x7006133F", "Nobottle (Guide)");
    self.hunter:AddSkill("Guide to Andrath", "0x7006323C", "Andrath (Guide)");
    self.hunter:AddSkill("Guide to Swanfleet", "0x700634AA", "Swanfleet (Guide)");
    self.hunter:AddSkill("Guide to Cardolan", "0x700634A7", "Cardolan (Guide)");
    self.hunter:AddSkill("Guide to Carn Dûm", "0x70064AC8", "Carn Dûm (Guide)");
    self.hunter:AddSkill("Guide to Clegur", "0x70064F4C", "Clegur (Guide)");
    self.hunter:AddSkill("Guide to Pelargir", "0x700658EA", "Pelargir (Guide)");
    self.hunter:AddSkill("Guide to Dol Amroth", "0x70068711", "King's Dol Amroth (Guide U38)", "King's Gondor");
    self.hunter:AddSkill("Guide to Halrax", "0x70068713", "Halrax (Guide)");
    self.hunter:AddSkill("Guide to Lond Cirion", "0x70068717", "Lond Cirion (Guide)");
    self.hunter:AddSkill("Guide to Umbar", "0x70068718", "Umbar (Guide)");
    self.hunter:AddSkill("Guide to Jax Phanâl", "0x70068719", "Jax Phanâl (Guide)");
    self.hunter:AddSkill("Guide to the Bloody Eagle Tavern", "0x700697EF", "Bloody Eagle Tavern (Guide)");

    -- add the Warden locations
    self.warden:AddSkill("Muster in Ost Guruth", "0x70014786", "Ost Guruth (Muster)");
    self.warden:AddSkill("Muster in Esteldín", "0x70014798", "Esteldín (Muster)");
    self.warden:AddSkill("Muster in Evendim", "0x7001478E", "Evendim (Muster)");
    self.warden:AddSkill("Muster in Rivendell", "0x70014791", "Rivendell (Muster)");
    self.warden:AddSkill("Muster in Sûri-kylä", "0x700237D4", "Sûri-kylä (Muster)");
    self.warden:AddSkill("Muster in the Twenty-first Hall", "0x7001819E", "Twenty-first Hall (Muster)");
    self.warden:AddSkill("Muster in Mirk-eaves", "0x7001F45C", "Mirk-Eaves (Muster)");
    self.warden:AddSkill("Muster in Harndirion", "0x700235EB", "Harndirion (Muster)");
    self.warden:AddSkill("Muster in Galtrev", "0x7002A90A", "Galtrev (Muster)");
    self.warden:AddSkill("Muster in Stangard", "0x7002C646", "Stangard (Muster)");
    self.warden:AddSkill("Muster in Caras Galadhon", "0x700303DF", "Caras Galadhon (Muster)");
    self.warden:AddSkill("Muster in the Misty Mountains", "0x700303DD", "Misty Mountains (Muster)");
    self.warden:AddSkill("Muster in Snowbourn", "0x7003198D", "Snowbourn (Muster)");
    self.warden:AddSkill("Muster in Forlaw", "0x70036B5B", "Forlaw (Muster)");
    self.warden:AddSkill("Muster in Aldburg", "0x7003DC7A", "Aldburg (Muster)");
    self.warden:AddSkill("Muster in Helm's Deep", "0x7003DC79", "Helm's Deep (Muster)");
    self.warden:AddSkill("Muster in Dol Amroth", "0x70041198", "Dol Amroth (Muster)", "Dol Amroth in western Gondor");
    self.warden:AddSkill("Muster in Arnach", "0x70043A66", "Arnach (Muster)");
    self.warden:AddSkill("Muster in Minas Tirith", "0x70044982", "Minas Tirith (Muster)");
    self.warden:AddSkill("Muster in the War-stead", "0x700459AA", "War-stead (Muster)");
    self.warden:AddSkill("Muster in after-battle Minas Tirith", "0x70046CBF", "Minas Tirith after battle (Muster)");
    self.warden:AddSkill("Muster in Henneth Annûn", "0x70047075", "Henneth Annûn (Muster)");
    self.warden:AddSkill("Muster in after-battle Osgiliath", "0x70047076", "Osgiliath after battle (Muster)");
    self.warden:AddSkill("Muster in the Camp of the Host", "0x70047BFC", "Camp of the Host (Muster)");
    self.warden:AddSkill("Muster in Haerondir", "0x70047C23", "Haerondir (Muster)");
    self.warden:AddSkill("Muster in the Udûn Foothold", "0x7004AE1F", "Udûn Foothold (Muster)");
    self.warden:AddSkill("Muster in Dale", "0x7004D73A", "Dale (Muster)");
    self.warden:AddSkill("Muster in Járnfast", "0x7004FACA", "Járnfast (Muster)");
    self.warden:AddSkill("Muster in Skarháld", "0x7004FACD", "Skarháld (Muster)");
    self.warden:AddSkill("Muster in Beorninghús", "0x70052F0A", "Beorninghús (Muster)");
    self.warden:AddSkill("Muster in Hultvís", "0x70052F06", "Hultvís (Muster)");
    self.warden:AddSkill("Muster in Estolad Lân", "0x700551F2", "Estolad Lân (Muster)");
    self.warden:AddSkill("Muster in Limlók", "0x70057635", "Limlók (Muster)");
    self.warden:AddSkill("Muster in Annâk-khurfu", "0x70058572", "Annâk-khurfu (Muster)");
    self.warden:AddSkill("Muster in Trader's Wharf", "0x70059D09", "Trader's Wharf (Muster)");
    self.warden:AddSkill("Muster in Trestlebridge", "0x70059D10", "Trestlebridge (Muster)");
    self.warden:AddSkill("Muster in Akrâz-zahar", "0x7005AA8F", "Akrâz-zahar (Muster)");
    self.warden:AddSkill("Muster in Azanulbizar", "0x7005AA8C", "Azanulbizar (Muster)");
    self.warden:AddSkill("Muster at the Noble Gate", "0x7005D48A", "Noble Gate (Muster)");
    self.warden:AddSkill("Muster at Leitstáth", "0x7005D488", "Leitstáth (Muster)");
    self.warden:AddSkill("Muster at Tornhad", "0x70060EA5", "Tornhad (Muster)");
    self.warden:AddSkill("Muster at Nobottle", "0x7006133E", "Nobottle (Muster)");
    self.warden:AddSkill("Muster at Andrath", "0x70063242", "Andrath (Muster)");
    self.warden:AddSkill("Muster at Swanfleet", "0x700634B6", "Swanfleet (Muster)");
    self.warden:AddSkill("Muster at Cardolan", "0x700634AD", "Cardolan (Muster)");
    self.warden:AddSkill("Muster at Carn Dûm", "0x70064ACB", "Carn Dûm (Muster)");
    self.warden:AddSkill("Muster at Clegur", "0x70064F4D", "Clegur (Muster)");
    self.warden:AddSkill("Muster at Pelargir", "0x700658E8", "Pelargir (Muster)");
    self.warden:AddSkill("Muster at Jax Phanâl","0x7006870C", "Jax Phanâl (Muster)");
    self.warden:AddSkill("Muster at Umbar","0x7006870F","Umbar (Muster)");
    self.warden:AddSkill("Muster at Halrax","0x70068710", "Halrax (Muster)");
    self.warden:AddSkill("Muster at Dol Amroth","0x70068712", "King's Dol Amroth (Muster)", "King's Gondor");
    self.warden:AddSkill("Muster at Lond Cirion","0x70068715", "Lond Cirion (Muster)");
    self.warden:AddSkill("Muster at the Bloody Eagle Tavern","0x700697F3", "Bloody Eagle Tavern (Muster)");

    -- add the Mariner locations
    self.mariner:AddSkill("Sail to Celondim", "0x70066100", "Celondim (Sail)")
    self.mariner:AddSkill("Sail to the Brown Lands", "0x70066101", "Brown Lands (Sail)")
    self.mariner:AddSkill("Sail to Trader's Wharf", "0x70066105", "Trader's Wharf (Sail)")
    self.mariner:AddSkill("Sail to after-battle Osgiliath", "0x70066109", "After-battle Osgiliath (Sail)")
    self.mariner:AddSkill("Sail to Lake-town", "0x7006610C", "Lake-town (Sail)")
    self.mariner:AddSkill("Sail to the Mirk-eaves", "0x7006610E", "Mirk-eaves (Sail)")
    self.mariner:AddSkill("Sail to Tinnudir", "0x7006610F", "Tinnudir (Sail)")
    self.mariner:AddSkill("Sail to Dol Amroth", "0x70066117", "Dol Amroth (Sail)", "Dol Amroth with nearby")
    self.mariner:AddSkill("Sail to Buckland", "0x7006611A", "Buckland (Sail)")
    self.mariner:AddSkill("Sail to Pelargir", "0x7006611B", "Pelargir (Sail)")
    self.mariner:AddSkill("Sail to Sûri-kylä", "0x7006611C", "Sûri-kylä (Sail)")
    self.mariner:AddSkill("Sail to Lothlórien", "0x7006611E", "Lothlórien (Sail)")
    self.mariner:AddSkill("Sail to Tharbad", "0x70066120", "Tharbad (Sail)")
    self.mariner:AddSkill("Sail to Snowbourn", "0x70066121", "Snowbourn (Sail)")
    self.mariner:AddSkill("Sail to Umbar", "0x700687BB", "Umbar (Sail)")
    self.mariner:AddSkill("Sail to Lond Cirion", "0x700687BD", "Lond Cirion (Sail)")
    self.mariner:AddSkill("Sail to Jax Phanâl", "0x700687C0", "Jax Phanâl (Sail)")
    self.mariner:AddSkill("Sail to Dol Amroth", "0x700687C1", "King's Dol Amroth (Sail)", "King's Gondor")
    self.mariner:AddSkill("Sail to Halrax", "0x700687C3", "Halrax (Sail)")

    -- add the racial travel skills
    self.allRaces:AddSkill("Return to Bree", "0x700062F6", "Bree (Racial)", "This enables you to quickly return"); -- human
    self.allRaces:AddSkill("Return to the Shire", "0x700062C8", "Shire (Racial)"); -- hobbit
    self.allRaces:AddSkill("Return to Thorin's Gate", "0x70006346", "Thorin's Gate (Racial)", "This enables you to quickly return"); -- dwarf
    self.allRaces:AddSkill("Return to Rivendell", "0x7000631F", "Rivendell (Racial)", "This enables you to quickly return"); --elf
    self.allRaces:AddSkill("Return Home", "0x70041A22", "Beorning Home (Racial)"); -- beorning
    self.allRaces:AddSkill("Travel to Caras Galadhon in Lothlórien", "0x70048C8C", "Caras Galadhon (Racial)"); -- high-elf
    self.allRaces:AddSkill("Travel to Thorin's Hall", "0x70053C0F", "Thorin's Hall (Racial)"); -- stoutaxe
    self.allRaces:AddSkill("Return to Lyndelby", "0x70066D31", "Lyndelby (Racial)") -- river hobbit

    -- add the Return Home and housing skills
    self.gen:AddSkill("Return Home",    "0x700256BA", "Return Home");
    self.gen:AddSkill("Return Home 2",  "0x70025792", "Return Home 2");
    self.gen:AddSkill("Return Home 3",  "0x70025793", "Return Home 3");
    self.gen:AddSkill("Return Home 4",  "0x70025794", "Return Home 4");
    self.gen:AddSkill("Return Home 5",  "0x70025795", "Return Home 5");
    self.gen:AddSkill("Return Home 6",  "0x70025796", "Return Home 6");
    self.gen:AddSkill("Return Home 7",  "0x7002FF62", "Return Home 7");
    self.gen:AddSkill("Return Home 8",  "0x7002FF61", "Return Home 8");
    self.gen:AddSkill("Return Home 9",  "0x7002FF60", "Return Home 9");
    self.gen:AddSkill("Return Home 10", "0x7002FF5F", "Return Home 10");
    self.gen:AddSkill("Return Home 11", "0x7002FF63", "Return Home 11");
    self.gen:AddSkill("Travel to Personal House", "0x7000D046", "Personal House");
    self.gen:AddSkill("Travel to Premium House", "0x70046EE4", "Premium House");
    self.gen:AddSkill("Travel to Kinship House", "0x7000D047", "Kinship House");
    self.gen:AddSkill("Travel to Kinship Member's House", "0x70057C36", "Kinship Member's House");

    -- add the obtainable travel skills
    self.rep:AddSkill("Return to Thorin's Gate", "0x7001BF91", "Thorin's Gate (Rep)", "Thanks to your friendship");
    self.rep:AddSkill("Return to Bree", "0x7001BF90", "Bree (Rep)", "Thanks to your friendship");
    self.rep:AddSkill("Return to Lalia's Market", "0x700364B1", "Lalia's Market (Mithril)");
    self.rep:AddSkill("Return to Michel Delving", "0x70023262", "Shire (Store)");
    self.rep:AddSkill("Return to Rivendell", "0x70023263", "Rivendell (Store)", "Thanks to your friendship");
    self.rep:AddSkill("Return to Ost Guruth", "0x70020441", "Ost Guruth (Rep)");
    self.rep:AddSkill("Return to Mirkwood", "0x7001F374", "Mirkwood (Rep)");
    self.rep:AddSkill("Return to Enedwaith", "0x70021FA2", "Enedwaith (Rep)");
    self.rep:AddSkill("Return to Galtrev", "0x7002C647", "Galtrev (Rep)");
    self.rep:AddSkill("Return to Stangard", "0x7002C65D", "Stangard (Rep)");
    self.rep:AddSkill("Return to Snowbourn", "0x70031A46", "Snowbourn (Rep)");
    self.rep:AddSkill("Return to Forlaw", "0x70036B5E", "Forlaw (Rep)");
    self.rep:AddSkill("Return to Aldburg", "0x7003DC81", "Aldburg (Rep)");
    self.rep:AddSkill("Return to Derndingle", "0x7004128F", "Derndingle (Rep)");
    self.rep:AddSkill("Return to Helm's Deep", "0x7003DC82", "Helm's Deep (Rep)");
    self.rep:AddSkill("Return to Dol Amroth", "0x700411AC", "Dol Amroth (Rep)", "Dol Amroth in western Gondor");
    self.rep:AddSkill("Return to Arnach", "0x70043A6A", "Arnach (Rep)");
    self.rep:AddSkill("Return to Minas Tirith", "0x7004497E", "Minas Tirith (Rep)");
    self.rep:AddSkill("Return to the War-stead", "0x700459A9", "War-stead (Rep)");
    self.rep:AddSkill("Return to after-battle Minas Tirith", "0x70046CC0", "Minas Tirith after-battle (Rep)");
    self.rep:AddSkill("Return to Henneth Annûn", "0x70047080", "Henneth Annûn (Rep)");
    self.rep:AddSkill("Return to after-battle Osgiliath", "0x7004707D", "Osgiliath after-battle (Rep)");
    self.rep:AddSkill("Return to the Camp of the Host", "0x70047BF4", "Camp of the Host (Rep)");
    self.rep:AddSkill("Return to Haerondir", "0x70047C1B", "Haerondir (Rep)");
    self.rep:AddSkill("Return to the Udûn Foothold", "0x7004AE1D", "Udûn Foothold (Rep)");
    self.rep:AddSkill("Journey to the Court of Lothlórien", "0x7004B8C2", "Court of Lothlórien (Rep)");
    self.rep:AddSkill("Journey to the Hall of the King", "0x7004B8C3", "Hall of the King (Rep)");
    self.rep:AddSkill("Journey to the Hall Under the Mountain", "0x7004B8C4", "Hall Under the Mountain (Rep)");
    self.rep:AddSkill("Journey to Bâr Thorenion", "0x7004B8C5", "Bâr Thorenion (Rep)");
    self.rep:AddSkill("Return to Dale", "0x7004D738", "Dale (Rep)");
    self.rep:AddSkill("Return to Járnfast", "0x7004FAC3", "Járnfast (Rep)");
    self.rep:AddSkill("Return to Skarháld", "0x7004FAC5", "Skarháld (Rep)");
    self.rep:AddSkill("Return to Beorninghús", "0x70052F12", "Beorninghús (Rep)");
    self.rep:AddSkill("Return to Hultvís", "0x70052F04", "Hultvís (Rep)");
    self.rep:AddSkill("Return to Estolad Lân", "0x700551F8", "Estolad Lân (Rep)");
    self.rep:AddSkill("Return to Limlók", "0x70057629", "Limlók (Rep)");
    self.rep:AddSkill("Return to Annâk-khurfu", "0x7005856F", "Annâk-khurfu (Rep)");
    self.rep:AddSkill("Return to Trader's Wharf", "0x70059D0E", "Trader's Wharf (Rep)");
    self.rep:AddSkill("Return to Trestlebridge", "0x70059D12", "Trestlebridge (Rep)");
    self.rep:AddSkill("Return to Akrâz-zahar", "0x7005AA90", "Akrâz-zahar (Rep)");
    self.rep:AddSkill("Return to Azanulbizar", "0x7005AA92", "Azanulbizar (Rep)");
    self.rep:AddSkill("Journey to the Hall of Vérnozal", "0x7005A596", "Vérnozal (Quest)");
    self.rep:AddSkill("Return to the Noble Gate", "0x7005D47C", "Noble Gate (Rep)");
    self.rep:AddSkill("Return to Leitstáth", "0x7005D484", "Leitstáth (Rep)");
    self.rep:AddSkill("Return to Tornhad", "0x70060EA8", "Tornhad (Rep)");
    self.rep:AddSkill("Return to Nobottle", "0x70061340", "Nobottle (Rep)");
    self.rep:AddSkill("Return to Andrath", "0x7006323D", "Andrath (Rep)");
    self.rep:AddSkill("Return to Swanfleet", "0x700634A4", "Swanfleet (Rep)");
    self.rep:AddSkill("Return to Cardolan", "0x700634AE", "Cardolan (Rep)");
    self.rep:AddSkill("Return to the Tracery Archives in Rivendell", "0x700634A5", "Tracery Archive (Delving)");
    self.rep:AddSkill("Return to Carn Dûm", "0x70064ACA", "Carn Dûm (Rep)");
    self.rep:AddSkill("Return to Clegur", "0x70064F47", "Clegur (Rep)");
    self.rep:AddSkill("Return to Glân Vraig", "0x7005B38E", "Glân Vraig (Quest)");
    self.rep:AddSkill("Return to Pelargir", "0x700658EB", "Pelargir (Rep)");
    self.rep:AddSkill("Journey to the Order of the Eagle", "0x700686FE", "Order of the Eagle (Rep)");
    self.rep:AddSkill("Return to Umbar", "0x700686FF", "Umbar (Rep)");
    self.rep:AddSkill("Return to Dol Amroth", "0x70068700", "King's Dol Amroth (Rep U38)","King's Gondor");
    self.rep:AddSkill("Return to Jax Phanâl", "0x70068701", "Jax Phanâl (Rep)");
    self.rep:AddSkill("Return to Halrax", "0x70068702", "Halrax (Rep)");
    self.rep:AddSkill("Return to Lond Cirion", "0x70068703", "Lond Cirion (Rep)");
    self.rep:AddSkill("Journey to the Ledger-keepers", "0x70068704", "Ledger-Keepers (Rep)");
    self.rep:AddSkill("Return to the Bloody Eagle Tavern", "0x700697F2", "Bloody Eagle Tavern (Rep)");

    -- monster player maps
    self.creep:AddSkill("Crude Map to Gramsfoot", "0x70028BBC");
    self.creep:AddSkill("Map to Gramsfoot", "0x70028BC1");
    self.creep:AddSkill("Crude Map to Isendeep", "0x70028BB3");
    self.creep:AddSkill("Crude Map to Tol Ascarnen", "0x70028BB6");
    self.creep:AddSkill("Crude Map to Lugazag", "0x70028BB7");
    self.creep:AddSkill("Crude Map to Tirith Rhaw", "0x70028BBE");
    self.creep:AddSkill("Crude Map to Grimwood", "0x70028BBF");
    self.creep:AddSkill("Poor Map to Isendeep", "0x70028BAF");
    self.creep:AddSkill("Poor Map to Tol Ascarnen", "0x70028BB1");
    self.creep:AddSkill("Poor Map to Lugazag", "0x70028BB2");
    self.creep:AddSkill("Poor Map to Tirith Rhaw", "0x70028BB4");
    self.creep:AddSkill("Poor Map to Grimwood", "0x70028BB9");
    self.creep:AddSkill("Good Map to Isendeep", "0x70028BC0");
    self.creep:AddSkill("Good Map to Tol Ascarnen", "0x70028BC2");
    self.creep:AddSkill("Good Map to Lugazag", "0x70028BB5");
    self.creep:AddSkill("Good Map to Tirith Rhaw", "0x70028BB0");
    self.creep:AddSkill("Good Map to Grimwood", "0x70028BBD");
end
