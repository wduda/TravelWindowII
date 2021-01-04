--[[ string constants ]] --
--[[ put all the strings that might require translation in ]] --
--[[ one location for easier access ]] --
helpString = "Travel\n\ntrav show: Zeigt das Travel-Fenster an\n" ..
"trav hide: Versteckt das Travel-Fenster\n" ..
"trav toggle: Schaltet das Travel-Fenster um\n";

-- window title strings
mainTitleString = "Travel";
optionsTitleString = "Travel Optionen";
moorMapTitleString = "Etten Reiseziele";
eriadorMapTitleString = "Eriador Reiseziele";
rhovanionMapTitleString = "Rhovanion Reiseziele";
gondorMapTitleString = "Gondor Reiseziele";

-- strings for maps
glanMapString = "Genaue Karte nach Glân Vraig";
glanMapItemString = "Genaue Karte nach Glân Vraig";


-- error messages
resetOrderString = "Deine Sortiereinstellungen wurden aufgrund einer Änderung der Anzahl" ..
"der zu speichernden Elemente zurückgesetzt. Dies sollte nur einmal passieren.\n" ..
"Entschuldige die Unannehmlichkeiten.";

resetEnabledString = "Deine ausgewählten Fertigkeiten wurden aufgrund einer Änderung der Anzahl " ..
"der zu speichernden Elemente zurückgesetzt. Dies sollte nur einmal passieren.\n" ..
"Entschuldige die Unannehmlichkeiten.";

skillNotTrainedString = "Nicht erlernter Skill: ";

-- options window strings
generalTabString = "Allgemein";
selectTabString = "Auswählen";
sortTabString = "Sortieren";
hideString = "Verstecke Fenster beim Start";
toggleString = "Zeige Umschalt-Button";
pulldownTravelString = "Reise wenn Pulldown-Fertigkeit selektiert";
hideOnCombatString = "Verstecke Fenster in Kampf";
genericLabelString = "Generische Fertigkeiten";
racialLabelString = "Rassenfertigkeiten";
classLabelString = "Klassenfertigkeiten";
repLabelString = "Ruffertigkeiten";
moveUpString = "hoch";
moveDownString = "runter";
moveTopString = "zum Anfang";
moveBottomString = "zum Ende";
toggleSlidersString = "Umschalt-Button Transparenz";
mainSlidersString = "Hauptfenster Transparenz";
minString = "Min: ";
maxString = "Max: ";
resetSettingsString = "Rücksetzen auf Standard";
checkSkillsString = "Nicht erlernte Fertigkeiten prüfen";

-- menu strings
menuFiltersString = "Filter";
menuGenString = "Zeige generische Fertigkeiten";
menuRaceString = "Zeige Rassenfertigkeiten";
menuRepString = "Zeige Ruffertigkeiten";
menuClassString = "Zeige Klassenfertigkeiten";
menuModeString = "Modus";
menuTextString = "Liste";
menuIconString = "Icons";
menuCaroString = "Karussell";
menuPullString = "Pulldown-Liste";
menuOptionsString = "Optionen";
moorMapString = "Öffne Etten-Karte";
eriadorMapString = "Öffne Eriador-Karte";
rhovanionMapString = "Öffne Rhovanion-Karte";
gondorMapString = "Öffne Gondor-Karte";
menuSkillsString = "Nicht erlernte Fertigkeiten auflisten";

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

function TravelDictionaries:CreateDictionaries()
    -- add the data to custom dictionaries to maintain the order
    hunterLocations:AddData("Zurück zum Lager", "0x7000A2C1", "Zurück zum Lager");
    hunterLocations:AddData("Führer nach Bree", "0x70003F42", "Bree (Führer)");
    hunterLocations:AddData("Führer zu Thorins Halle", "0x70003F41", "Thorins Halle (Führer)");
    hunterLocations:AddData("Führer nach Michelbinge", "0x7000A2C3", "Michelbinge (Führer)");
    hunterLocations:AddData("Führer nach Esteldín", "0x70003F43", "Esteldín (Führer)");
    hunterLocations:AddData("Führer nach Evendim", "0x7000A2C4", "Evendim  (Führer)");
    hunterLocations:AddData("Führer zur Feste Guruth", "0x7000A2C2", "Feste Guruth (Führer)");
    hunterLocations:AddData("Führer nach Bruchtal", "0x70003F44", "Bruchtal (Führer)"); --@TODO
    hunterLocations:AddData("Führer nach Sûri-kylä", "0x70017C82", "Sûri-kylä (Führer)");--@TODO
    hunterLocations:AddData("Führer nach West-Angmar", "0x7000A2C5", "West-Angmar (Führer)");--@TODO
    hunterLocations:AddData("Führer nach Ost-Angmar", "0x7000A2C6", "Ost-Angmar (Führer)");--@TODO
    hunterLocations:AddData("Führer nach Echad Dúnann", "0x70017C81", "Echad Dúnann (Führer)");--@TODO
    hunterLocations:AddData("Führer zur 21. Halle", "0x70017C7A", "Einundzwanzigste Halle (Führer)");--@TODO
    hunterLocations:AddData("Führer zur Dunkelsenke", "0x7001F459", "Dunkelsenke (Führer)");--@TODO
    hunterLocations:AddData("Führer nach Harndirion", "0x700235EF", "Harndirion (Führer)");--@TODO
    hunterLocations:AddData("Führer nach Galtrev", "0x7002A93F", "Galtrev (Führer)");--@TODO
    hunterLocations:AddData("Führer nach Stangard", "0x7002C62C", "Stangard (Führer)");--@TODO
    hunterLocations:AddData("Führer nach Caras Galadhon", "0x7002E754", "Caras Galadhon (Führe--@TODOr)");
    hunterLocations:AddData("Führer ins Nebelgebirge", "0x7002E756", "Nebelgebirge (Führer)");--@TODO
    hunterLocations:AddData("Führer nach Schneegrenze", "0x7003198E", "Schneegrenze (Führer)");--@TODO
    hunterLocations:AddData("Führer nach Forlach", "0x70036B5D", "Forlach (Führer)");--@TODO
    hunterLocations:AddData("Führer nach Aldburg", "0x7003DC71", "Aldburg (Führer)");--@TODO
    hunterLocations:AddData("Führer nach Helms Klamm", "0x7003DC72", "Helms Klamm (Führer)")--@TODO;
    hunterLocations:AddData("Führer nach Dol Amroth", "0x70041197", "Dol Amroth (Führer)");--@TODO
    hunterLocations:AddData("Führer nach Arnach", "0x70043A63", "Arnach (Führer)");--@TODO
    hunterLocations:AddData("Führer nach Minas Tirith", "0x70044985", "Minas Tirith (Führer)");
    hunterLocations:AddData("Führer zum Kriegslager", "0x700459AF", "Kriegslager der Rohirrim (Führer)");
    hunterLocations:AddData("Führer zum schlachtgezeichneten Minas Tirith", "0x70046CBB", "Minas Tirith nach der Schlacht (Führer)");
    hunterLocations:AddData("Führer nach Henneth Annûn", "0x70047077", "Henneth Annûn (Führer)");
    hunterLocations:AddData("Führer zum schlachtgezeichneten Osgiliath", "0x70047074", "Osgiliath nach der Schlacht (Führer)");
    hunterLocations:AddData("Führer zum Lager des Heeres", "0x70047BFA", "Lager des Heeres (Führer)");
    hunterLocations:AddData("Führer nach Haerondir", "0x70047C1D", "Haerondir (Führer)");
    hunterLocations:AddData("Führer zum Udûn-Brückenkopf", "0x7004AE1E", "Udûn-Brückenkopf (Führer)");--@TODO
	hunterLocations:AddData("Führer nach Thal", "0x7004d73b", "Thal (Führer)");--@TODO
	hunterLocations:AddData("Führer nach Járnfast", "0x7004facc", "Járnfast (Führer)")--@TODO;
    hunterLocations:AddData("Führer nach Skarháld", "0x7004facb", "Skarháld (Führer)");--@TODO
	hunterLocations:AddData("Führer nach Beorninghús", "0x70052F07", "Beorningerhús (Führer)");--@TODO
    hunterLocations:AddData("Führer nach Hultvís", "0x70052F08", "Hultvís (Führer)");--@TODO
    hunterLocations:AddData("Führer nach Estolad Lân", "0x700551F4", "Estolad Lân (Führer)"); -- Need to get the right Skill-ID--@TODO
    hunterLocations:AddData("Führer nach Limlók", "0x7005762d", "Limlók (Führer)");--@TODO
    hunterLocations:AddData("Führer nach Annâk-khurfu", "0x70058571", "Annâk-khurfu (Führer)");--@TODO

    wardenLocations:AddData("Appell in der Feste Guruth", "0x70014786", "Feste Guruth (Appell)");
    wardenLocations:AddData("Appell in Esteldín", "0x70014798", "Esteldín (Appell)");
    wardenLocations:AddData("Appell in Evendim", "0x7001478E", "Evendim (Appell)");
    wardenLocations:AddData("Appell in Bruchtal", "0x70014791", "Bruchtal (Appell)");
    wardenLocations:AddData("Appell in Sûri-kylä", "0x700237D4", "Sûri-kylä (Appell)");--@TODO
    wardenLocations:AddData("Appell in der 21. Halle", "0x7001819E", "21. Halle (Appell)");--@TODO
    wardenLocations:AddData("Appell in der Dunkelsenke", "0x7001F45C", "Dunkelsenke (Appell)");--@TODO
    wardenLocations:AddData("Appell in Harndirion", "0x700235EB", "Harndirion (Appell)");--@TODO
    wardenLocations:AddData("Appell in Galtrev", "0x7002A90A", "Galtrev (Appell)");--@TODO
    wardenLocations:AddData("Appell in Stangard", "0x7002C646", "Stangard (Appell)");--@TODO
    wardenLocations:AddData("Appell in Caras Galadhon", "0x700303DF", "Caras Galadhon (Appell)");--@TODO
    wardenLocations:AddData("Appell im Nebelgebirge", "0x700303DD", "Nebelgebirge (Appell)");--@TODO
    wardenLocations:AddData("Appell in Schneegrenze", "0x7003198D", "Schneegrenze (Appell)");--@TODO
    wardenLocations:AddData("Appell in Forlach", "0x70036B5B", "Forlach (Appell)");--@TODO
    wardenLocations:AddData("Appell in Aldburg", "0x7003DC7A", "Aldburg (Appell)");--@TODO
    wardenLocations:AddData("Appell in Helms Klamm", "0x7003DC79", "Helms Klamm (Appell)");--@TODO
    wardenLocations:AddData("Appell in Dol Amroth", "0x70041198", "Dol Amroth (Appell)");--@TODO
    wardenLocations:AddData("Appell in Arnach", "0x70043A66", "Arnach (Appell)");--@TODO
    wardenLocations:AddData("Appell in Minas Tirith", "0x70044982", "Minas Tirith (Appell)");
    wardenLocations:AddData("Appell im Kriegslager", "0x700459AA", "Kriegslager der Rohirrim (Appell)");
    wardenLocations:AddData("Appell im schlachtgezeichneten Minas Tirith", "0x70046CBF", "Minas Tirith nach der Schlacht (Appell)");
    wardenLocations:AddData("Appell in Henneth Annûn", "0x70047075", "Henneth Annûn (Appell)");
    wardenLocations:AddData("Appell im schlachtgezeichneten Osgiliath", "0x70047076", "Osgiliath nach der Schlacht (Appell)");
    wardenLocations:AddData("Appell im Lager des Heeres", "0x70047BFC", "Lager des Heeres (Appell)");
    wardenLocations:AddData("Appell in Haerondir", "0x70047C23", "Haerondir (Appell)");
    wardenLocations:AddData("Appell im Udûn-Brückenkopf", "0x7004AE1F", "Udûn-Brückenkopf (Appell)");--@TODO
    wardenLocations:AddData("Appell in Thal", "0x7004d73a", "Thal (Appell)");--@TODO
	wardenLocations:AddData("Appell in Járnfast", "0x7004FACA", "Jarnfast (Appell)");--@TODO
    wardenLocations:AddData("Appell in Skarháld", "0x7004FACD",  "Skarhald (Appell)");--@TODO
	wardenLocations:AddData("Appell in Beorninghús", "0x70052F0A", "Beorninghús (Appell)");--@TODO
    wardenLocations:AddData("Appell in Hultvís", "0x70052F06", "Hultvís (Appell)");--@TODO
    wardenLocations:AddData("Appell in Estolad Lân", "0x700551F2", "Estolad Lân (Appell)");--@TODO
	wardenLocations:AddData("Appell in Limlók", "0x70057635", "Limlók (Appell)");--@TODO
    wardenLocations:AddData("Appell in Annâk-khurfu", "0x70058572", "Annâk-khurfu (Appell)");--@TODO

    racialLocations:AddData("Rückkehr nach Bree", "0x700062F6", "Bree (Rasse)");
    racialLocations:AddData("Rückkehr ins Auenland", "0x700062C8", "Michelbinge (Rasse)");
    racialLocations:AddData("Rückkehr zu Thorins Tor", "0x70006346", "Thorins Tor (Rasse Zwerg)");
    racialLocations:AddData("Rückkehr nach Bruchtal", "0x7000631F", "Bruchtal (Rasse)");
    racialLocations:AddData("Zum 1. Heim zurückkehren", "0x70041A22", "Grimbeorns Hütte (Rasse)");
    racialLocations:AddData("Reise nach Caras Galadhon in Lothlórien", "0x70048C8C", "Caras Galadhon (Rasse)");
    racialLocations:AddData("Reise zu Thorins Halle", "0x70053C0F", "Thorins Halle (Rasse Starkaxt)");

    genLocations:AddData("Zum 1. Heim zurückkehren", "0x700256BA", "1. Markstein");
    genLocations:AddData("Zum 2. Heim zurückkehren", "0x70025792", "2. Markstein");
    genLocations:AddData("Zum 3. Heim zurückkehren", "0x70025793", "3. Markstein");
    genLocations:AddData("Zum 4. Heim zurückkehren", "0x70025794", "4. Markstein");
    genLocations:AddData("Zum 5. Heim zurückkehren", "0x70025795", "5. Markstein");
    genLocations:AddData("Zum 6. Heim zurückkehren", "0x70025796", "6. Markstein");
    genLocations:AddData("Zum 7. Heim zurückkehren", "0x7002FF5F", "7. Markstein");
    genLocations:AddData("Zum 8. Heim zurückkehren", "0x7002FF60", "8. Markstein");
    genLocations:AddData("Zum 9. Heim zurückkehren", "0x7002FF61", "9. Markstein");
    genLocations:AddData("Zum 10. Heim zurückkehren", "0x7002FF62", "10. Markstein");
    genLocations:AddData("Zum 11. Heim zurückkehren", "0x7002FF63", "11. Markstein");
    genLocations:AddData("Reist zu Eurem eigenen Heim", "0x7000D046", "Eigenes Heim");
    genLocations:AddData("Reist zu Eurem Premiumheim", "0x70046EE4", "Premiumheim");
    genLocations:AddData("Reist zum Haus Eurer Sippe", "0x7000D047", "Heim Eurer Sippe");
    genLocations:AddData("Zum Haus des Sippenmitglieds reisen", "0x70057C36", "Heim des Sippenmitglieds");

    repLocations:AddData("Rückkehr zu Thorins Tor", "0x7001BF91", "Thorins Tor (Ruf)");
    repLocations:AddData("Rückkehr nach Bree", "0x7001BF90", "Bree (Ruf)");
    repLocations:AddData("Kehrt zu Lalias Markt zurück", "0x700364B1", "Lalias Markt (Mithril)");
    repLocations:AddData("Rückkehr nach Michelbinge", "0x70023262", "Michelbinge (Shop)");
    repLocations:AddData("Rückkehr nach Bruchtal", "0x70023263", "Bruchtal (Ruf)");
    repLocations:AddData("Rückkehr zur Feste Guruth", "0x70020441", "Feste Guruth (Ruf)");
    repLocations:AddData("Rückkehr zum Düsterwald", "0x7001F374", "Düsterwald (Ruf)");
    repLocations:AddData("Rückkehr nach Enedwaith", "0x70021FA2", "Enedwaith (Ruf)");
    repLocations:AddData("Kehrt nach Galtrev zurück", "0x7002C647", "Galtrev (Ruf)");
    repLocations:AddData("Kehrt nach Stangard zurück", "0x7002C65D", "Stangard (Ruf)");
    repLocations:AddData("Kehrt nach Schneegrenze zurück", "0x70031A46", "Schneegrenze (Ruf)");
    repLocations:AddData("Rückkehr nach Forlach", "0x70036B5E", "Forlach (Ruf)");
    repLocations:AddData("Kehrt nach Aldburg zurück", "0x7003DC81", "Aldburg (Ruf)");
    repLocations:AddData("Rückkehr ins Geheimnistal", "0x7004128F", "Geheimnistal (Ruf)");
    repLocations:AddData("Kehrt nach Helms Klamm zurück", "0x7003DC82", "Helms Klamm (Ruf)");
    repLocations:AddData("Rückkehr nach Dol Amroth", "0x700411AC", "Dol Amroth (Ruf)");
    repLocations:AddData("Rückkehr nach Arnach", "0x70043A6A", "Arnach (Ruf)");
    repLocations:AddData("Kehrt nach Minas Tirith zurück", "0x7004497E", "Minas Tirith (Ruf)");
    repLocations:AddData("Rückkehr zum Kriegslager", "0x700459A9", "Kriegslager der Rohirrim (Ruf)");
    repLocations:AddData("Rückkehr ins schlachtgezeichnete Minas Tirith", "0x70046CC0", "Minas Tirith nach der Schlacht (Ruf)");
    repLocations:AddData("Rückkehr nach Henneth Annûn", "0x70047080", "Henneth Annûn (Ruf)");
    repLocations:AddData("Rückkehr ins schlachtgezeichnete Osgiliath", "0x7004707D", "Osgiliath nach der Schlacht (Ruf)");
    repLocations:AddData("Rückkehr ins Lager des Heeres", "0x70047BF4", "Lager des Heeres (Ruf)");
    repLocations:AddData("Rückkehr nach Haerondir", "0x70047C1B", "Haerondir (Ruf)");
    repLocations:AddData("Zum Udûn-Brückenkopf", "0x7004AE1D", "Udûn-Brückenkopf (Ruf)"); --@TODO
    repLocations:AddData("Zum Hof von Lothlórien", "0x7004B8C2", "Hof von Lothlórien (Ruf)"); --@TODO
    repLocations:AddData("Zur Halle des Königs", "0x7004B8C3", "Halle des Königs (Ruf)"); --@TODO
    repLocations:AddData("Zur Halle unter dem Berg", "0x7004B8C4", "Halle unter dem Berg (Ruf)"); --@TODO
    repLocations:AddData("Nach Bâr Thorenion", "0x7004B8C5", "Bâr Thorenion (Ruf)"); --@TODO
	repLocations:AddData("Nach Thal", "0x7004d738", "Thal (Ruf)"); --@TODO
	repLocations:AddData("Nach Járnfast", "0x7004fac3", "Járnfast (Ruf)"); --@TODO
    repLocations:AddData("Nach Skarháld", "0x7004fac5", "Skarháld (Ruf)"); --@TODO
	repLocations:AddData("Nach Beorninghús", "0x70052F12", "Beorningerhús (Ruf)"); --@TODO
    repLocations:AddData("Nach Hultvís", "0x70052F04", "Hultvís (Ruf)"); --@TODO
    repLocations:AddData("Nach Estolad Lân", "0x700551F8", "Estolad Lân (Ruf)"); --@TODO
    repLocations:AddData("Nach Limlók", "0x70057629", "Limlók (Ruf)"); --@TODO
    repLocations:AddData("Rückkehr nach Annâk-khurfu", "0x7005856F", "Annâk-khurfu (Ruf)");
    
    -- Crude Map to Gramsfoot for newb creeps
    creepLocations:AddData("Grobe Karte nach Gramfuß", "0x70028BBC");
    creepLocations:AddData("Karte nach Gramfuß", "0x70028BC1");

    creepLocations:AddData("Grobe Isenbinge-Karte", "0x70028BB3");
    creepLocations:AddData("Grobe Tol Ascarnen-Karte", "0x70028BB6");
    creepLocations:AddData("Grobe Karte zum Lugazag", "0x70028BB7");
    creepLocations:AddData("Grobe Tirith Rhaw-Karte", "0x70028BBE");
    creepLocations:AddData("Grobe Karte nach Grimmwald", "0x70028BBF");

    creepLocations:AddData("Minderwertige Isenbinge-Karte", "0x70028BAF");
    creepLocations:AddData("Minderwertige Karte zum Tol Ascarnen", "0x70028BB1");
    creepLocations:AddData("Minderwertige Karte zum Lugazag", "0x70028BB2");
    creepLocations:AddData("Minderwertige Tirith-Rhaw-Karte", "0x70028BB4");
    creepLocations:AddData("Minderwertige Karte nach Grimmwald", "0x70028BB9");

    creepLocations:AddData("Gute Isenbinge-Karte", "0x70028BC0");
    creepLocations:AddData("Gute Tol Ascarnen-Karte", "0x70028BC2");
    creepLocations:AddData("Gute Lugazag-Karte", "0x70028BB5");
    creepLocations:AddData("Gute Karte zum Tirith Rhaw", "0x70028BB0");
    creepLocations:AddData("Gute Grimmwald-Karte", "0x70028BBD");
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

-- function to return the name at a specified index
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


