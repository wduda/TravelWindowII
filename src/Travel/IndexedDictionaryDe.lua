--[[ string constants ]] --
--[[ put all the strings that might require translation in ]] --
--[[ one location for easier access ]] --
helpString = "Travel\n\ntrav show: Zeigt das Travel-Fenster an\n" ..
"trav hide: Versteckt das Travel-Fenster\n" ..
"trav toggle: Schaltet das Travel-Fenster um\n";

-- window title strings
mainTitleString = "Travel";
optionsTitleString = "Travel Optionen";
moorMapTitleString = "Kartenorte";
eriadorMapTitleString = "Eriador-Orte";
rhovanionMapTitleString = "Rhovanion-Orte";
gondorMapTitleString = "Gondor-Orte";

-- strings for maps
mapHomeString = "Karte zum Ausgangspunkt";
glanMapString = "Genaue Karte nach Glân Vraig";
glanMapItemString = "Genaue Karte nach Glân Vraig";

-- adding map strings
mapInstructionString = "Ziehe deine Karten aus deinem Inventar in den  " ..
"Quickslot unten. Dann drücke den Button " ..
"um deine Karte zu setzen.";
mapErrorString = "Keine Karten gefunden, keine Aktualisierungen durchgeführt.";

-- error messages
resetOrderString = "Deine Sortiereinstellungen wurden aufgrund einer Änderung der Anzahl" ..
"der zu speichernden Elemente zurückgesetzt. Dies sollte nur einmal passieren.\n" ..
"Entschuldigung für die Unannehmlichkeiten.";

resetEnabledString = "Deine ausgewählten Fertigkeiten wurden aufgrund eines Fehlers " ..
"auf die Zahl der zuletzt gespeicherten zurückgesetzt.\n";

skillNotTrainedString = "Nicht gelernter Skill: ";

-- options window strings
generalTabString = "Allgemein";
selectTabString = "Auswählen";
sortTabString = "Sortieren";
hideString = "Verstecke Travel-Fenster am Start";
toggleString = "Zeige Umschalt-Button";
pulldownTravelString = "Reise wenn Pulldown-Fertigkeit selektiert";
hideOnCombatString = "Verstecke Fenster wenn in Kampf";
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
checkSkillsString = "Nicht gelernte Skills prüfen";

-- menu strings
menuFiltersString = "Filter";
menuGenString = "Zeige generische Reisen";
menuRaceString = "Zeige Rassenreisen";
menuRepString = "Zeige Rufreisen";
menuClassString = "Zeige Klassenreisen";
menuModeString = "Modus";
menuTextString = "Liste";
menuIconString = "Icon-Gitternetz";
menuCaroString = "Karussell";
menuPullString = "Pulldown-Liste";
menuMapString = "Karte hinzufuegen";
menuOptionsString = "Optionen";
moorMapString = "Öffne Etten-Karte";
eriadorMapString = "Öffne Eriador-Karte";
rhovanionMapString = "Öffne Rhovanion-Karte";
gondorMapString = "Öffne Gondor-Karte";
menuSkillsString = "Nicht gelernte Skills listen";

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
    hunterLocations:AddData("Führer nach Bree", "0x70003F42", "Führer nach Bree");
    hunterLocations:AddData("Führer zu Thorins Halle", "0x70003F41", "Führer zu Thorins Halle");
    hunterLocations:AddData("Führer nach Michelbinge", "0x7000A2C3", "Führer nach Michelbinge");
    hunterLocations:AddData("Führer nach Esteldín", "0x70003F43", "Führer nach Esteldín");
    hunterLocations:AddData("Führer nach Evendim", "0x7000A2C4", "Führer nach Evendim");
    hunterLocations:AddData("Führer zur Feste Guruth", "0x7000A2C2", "Führer zur Feste Guruth");
    hunterLocations:AddData("Führer nach Bruchtal", "0x70003F44", "Führer nach Bruchtal");
    hunterLocations:AddData("Führer nach Sûri-kylä", "0x70017C82", "Führer nach Sûri-kylä");
    hunterLocations:AddData("Führer nach West-Angmar", "0x7000A2C5", "Führer in das westliche Angmar");
    hunterLocations:AddData("Führer nach Ost-Angmar", "0x7000A2C6", "Führer nach Ost-Angmar");
    hunterLocations:AddData("Führer nach Echad Dúnann", "0x70017C81", "Führer nach Echad Dúnann");
    hunterLocations:AddData("Führer zur 21. Halle", "0x70017C7A", "Führer zur Einundzwanzigsten Halle");
    hunterLocations:AddData("Führer zur Dunkelsenke", "0x7001F459", "Führer zur Dunkelsenke");
    hunterLocations:AddData("Führer nach Harndirion", "0x700235EF", "Führer nach Harndirion");
    hunterLocations:AddData("Führer nach Galtrev", "0x7002A93F", "Führer nach Galtrev");
    hunterLocations:AddData("Führer nach Stangard", "0x7002C62C", "Führer nach Stangard");
    hunterLocations:AddData("Führer nach Caras Galadhon", "0x7002E754", "Führer nach Caras Galadhon");
    hunterLocations:AddData("Führer ins Nebelgebirge", "0x7002E756", "Führer ins Nebelgebirge");
    hunterLocations:AddData("Führer nach Schneegrenze", "0x7003198E", "Führer nach Schneegrenze");
    hunterLocations:AddData("Führer nach Forlach", "0x70036B5D", "Führer nach Forlach");
    hunterLocations:AddData("Führer nach Aldburg", "0x7003DC71", "Führer nach Aldburg");
    hunterLocations:AddData("Führer nach Helms Klamm", "0x7003DC72", "Führer nach Helms Klamm");
    hunterLocations:AddData("Führer nach Dol Amroth", "0x70041197", "Führer nach Dol Amroth");
    hunterLocations:AddData("Führer nach Arnach", "0x70043A63", "Führer nach Arnach");
    hunterLocations:AddData("Führer nach Minas Tirith", "0x70044985", "Führer nach Minas Tirith");
    hunterLocations:AddData("Führer zum Kriegslager der Rohirrim", "0x700459AF", "Führer zum Kriegslager der Rohirrim");
    hunterLocations:AddData("Führer zum schlachtgezeichneten Minas Tirith", "0x70046CBB", "Führer zum schlachtgezeichneten Minas Tirith");
    hunterLocations:AddData("Führer zu Henneth Annûn", "0x70047077", "Führer zu Henneth Annûn");
    hunterLocations:AddData("Führer zum schlachtgezeichneten Osgiliath", "0x70047074", "Führer zum schlachtgezeichneten Osgiliath");
    hunterLocations:AddData("Führer zum Lager des Heeres", "0x70047BFA", "Führer zum Lager des Heeres");
    hunterLocations:AddData("Führer nach Haerondir", "0x70047C1D", "Führer nach Haerondir");
    hunterLocations:AddData("Guide to the Udûn Foothold", "0x7004AE1E", "Guide to the Udûn Foothold");

    wardenLocations:AddData("Appell in der Feste Guruth", "0x70014786", "Appell in der Feste Guruth");
    wardenLocations:AddData("Appell in Esteldín", "0x70014798", "Appell in Esteldín");
    wardenLocations:AddData("Appell in Evendim", "0x7001478E", "Appell in Evendim");
    wardenLocations:AddData("Appell in Bruchtal", "0x70014791", "Appell in Bruchtal");
    wardenLocations:AddData("Appell in Sûri-kylä", "0x700237D4", "Appell in Sûri-kylä");
    wardenLocations:AddData("Appell in der 21. Halle", "0x7001819E", "Appell in der Einundzwanzigsten Halle");
    wardenLocations:AddData("Appell in der Dunkelsenke", "0x7001F45C", "Appell in der Dunkelsenke");
    wardenLocations:AddData("Appell in Harndirion", "0x700235EB", "Appell in Harndirion");
    wardenLocations:AddData("Appell in Galtrev", "0x7002A90A", "Appell in Galtrev");
    wardenLocations:AddData("Appell in Stangard", "0x7002C646", "Appell in Stangard");
    wardenLocations:AddData("Appell in Caras Galadhon", "0x700303DF", "Appell in Caras Galadhon");
    wardenLocations:AddData("Appell im Nebelgebirge", "0x700303DD", "Appell im Nebelgebirge");
    wardenLocations:AddData("Appell in Schneegrenze", "0x7003198D", "Appell in Schneegrenze");
    wardenLocations:AddData("Appell in Forlach", "0x70036B5B", "Appell in Forlach");
    wardenLocations:AddData("Appell in Aldburg", "0x7003DC7A", "Appell in Aldburg");
    wardenLocations:AddData("Appell in Helms Klamm", "0x7003DC79", "Appell in Helms Klamm");
    wardenLocations:AddData("Appell in Dol Amroth", "0x70041198", "Appell in Dol Amroth");
    wardenLocations:AddData("Appell in Arnach", "0x70043A66", "Appell in Arnach");
    wardenLocations:AddData("Appell in Minas Tirith", "0x70044982", "Appell in Minas Tirith");
    wardenLocations:AddData("Appell im Kriegslager", "0x700459AA", "Appell im Kriegslager");
    wardenLocations:AddData("Appell im schlachtgezeichneten Minas Tirith", "0x70046CBF", "Appell im schlachtgezeichneten Minas Tirith");
    wardenLocations:AddData("Appell in Henneth Annûn", "0x70047075", "Appell in Henneth Annûn");
    wardenLocations:AddData("Appell im schlachtgezeichneten Osgiliath", "0x70047076", "Appell im schlachtgezeichneten Osgiliath");
    wardenLocations:AddData("Appell im Lager des Heeres", "0x70047BFC", "Appell im Lager des Heeres");
    wardenLocations:AddData("Appell in Haerondir", "0x70047C23", "Appell in Haerondir");
    wardenLocations:AddData("Muster in the Udûn Foothold", "0x7004AE1F", "Muster in the Udûn Foothold");

    racialLocations:AddData("Rückkehr nach Bree (Rasse)", "0x700062F6", "Rückkehr nach Bree");
    racialLocations:AddData("Rückkehr ins Auenland (Rasse)", "0x700062C8", "Rückkehr ins Auenland");
    racialLocations:AddData("Rückkehr zu Thorins Tor (Rasse)", "0x70006346", "Rückkehr zu Thorins Tor");
    racialLocations:AddData("Rückkehr nach Bruchtal (Rasse)", "0x7000631F", "Rückkehr nach Bruchtal");
    racialLocations:AddData("Zurück zu Grimbeorns Hütte (Rasse)", "0x70041A22", "Zum 1. Heim zurückkehren");
    racialLocations:AddData("Return to Caras Galadhon in Lothlórien", "0x70048C8C", "Return to Caras Galadhon in Lothlórien");

    -- check if a function that only exists in the newest update exists,
    -- if so, add the Return Home skills
    if (Turbine.UI.Control.IsDisplayed ~= nil) then
        genLocations:AddData("zum 1. Heim zurückkehren", "0x700256BA", "skip");
        genLocations:AddData("zum 2. Heim zurückkehren", "0x70025792", "skip");
        genLocations:AddData("zum 3. Heim zurückkehren", "0x70025793", "skip");
        genLocations:AddData("zum 4. Heim zurückkehren", "0x70025794", "skip");
        genLocations:AddData("zum 5. Heim zurückkehren", "0x70025795", "skip");
        genLocations:AddData("zum 6. Heim zurückkehren", "0x70025796", "skip");
        genLocations:AddData("zum 7. Heim zurückkehren", "0x7002FF5F", "skip");
        genLocations:AddData("zum 8. Heim zurückkehren", "0x7002FF60", "skip");
        genLocations:AddData("zum 9. Heim zurückkehren", "0x7002FF61", "skip");
        genLocations:AddData("zum 10. Heim zurückkehren", "0x7002FF62", "skip");
        genLocations:AddData("zum 11. Heim zurückkehren", "0x7002FF63", "skip");
        genLocations:AddData("zum 12. Heim zurückkehren", "0x7002FF64", "skip");
    end
    genLocations:AddData("Zum eigenen Haus reisen", "0x7000D046", "Reist zu Eurem eigenen Heim");
    genLocations:AddData("Reist zu Eurem Premiumheim", "0x70046EE4", "Reist zu Eurem Premiumheim");
    genLocations:AddData("Zum Sippenhaus reisen", "0x7000D047", "Reist zum Haus Eurer Sippe");

    repLocations:AddData("Rückkehr nach Thorins Tor", "0x7001BF91", "Rückkehr zu Thorins Tor");
    repLocations:AddData("Rückkehr nach Bree", "0x7001BF90", "Rückkehr nach Bree");
    repLocations:AddData("Rückkehr zu Lalias Markt", "0x700364B1", "Kehrt zu Lalias Markt zurück");
    repLocations:AddData("Rückkehr nach Michelbinge", "0x70023262", "Rückkehr nach Michelbinge");
    repLocations:AddData("Rückkehr nach Bruchtal", "0x70023263", "Rückkehr nach Bruchtal");
    repLocations:AddData("Rückkehr zur Feste Guruth", "0x70020441", "Rückkehr zur Feste Guruth");
    repLocations:AddData("Rückkehr nach Düsterwald", "0x7001F374", "Rückkehr zum Düsterwald");
    repLocations:AddData("Rückkehr nach Enedwaith", "0x70021FA2", "Rückkehr nach Enedwaith");
    repLocations:AddData("Rückkehr nach Galtrev", "0x7002C647", "Kehrt nach Galtrev zurück");
    repLocations:AddData("Rückkehr nach Stangard", "0x7002C65D", "Kehrt nach Stangard zurück");
    repLocations:AddData("Rückkehr nach Schneegrenze", "0x70031A46", "Kehrt nach Schneegrenze zurück");
    repLocations:AddData("Rückkehr nach Forlach", "0x70036B5E", "Rückkehr nach Forlach");
    repLocations:AddData("Rückkehr nach Aldburg", "0x7003DC81", "Kehrt nach Aldburg zurück");
    repLocations:AddData("Rückkehr ins Geheimnistal", "0x7004128F", "Rückkehr ins Geheimnistal");
    repLocations:AddData("Rückkehr nach Helms Klamm", "0x7003DC82", "Kehrt nach Helms Klamm zurück");
    repLocations:AddData("Rückkehr nach Dol Amroth", "0x700411AC", "Rückkehr nach Dol Amroth");
    repLocations:AddData("Rückkehr nach Arnach", "0x70043A6A", "Rückkehr nach Arnach");
    repLocations:AddData("Rückkehr nach Minas Tirith", "0x7004497E", "Kehrt nach Minas Tirith zurück.");
    repLocations:AddData("Zurück zum Kriegslager der Rohirrim", "0x700459A9", "Zurück zum Kriegslager der Rohirrim");
    repLocations:AddData("Rückkehr ins schlachtgezeichnete Minas Tirith", "0x70046CC0", "Rückkehr ins schlachtgezeichnete Minas Tirith");
    repLocations:AddData("Rückkehr ins schlachtgezeichnete Henneth Annûn", "0x70047080", "Rückkehr ins schlachtgezeichnete Henneth Annûn");
    repLocations:AddData("Rückkehr ins schlachtgezeichnete Osgiliath", "0x7004707D", "Rückkehr ins schlachtgezeichnete Osgiliath");
    repLocations:AddData("Rückkehr ins Lager des Heeres", "0x70047BF4", "Rückkehr ins Lager des Heeres");
    repLocations:AddData("Rückkehr nach Haerondir (Rep)", "0x70047C1B", "Rückkehr nach Haerondir");
    repLocations:AddData("Return to the Udûn Foothold", "0x7004AE1D", "Return to the Udûn Foothold");

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


