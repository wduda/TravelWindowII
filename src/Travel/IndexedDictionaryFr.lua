-- Version FR 1.05 --
--[[ string constants ]] --
--[[ put all the strings that might require translation in ]] --
--[[ one location for easier access ]] --
helpString = "Travel\n\ntrav show: Afficher Travel Window\n" ..
        "trav hide: Masqer Travel Window\n" ..
        "trav toggle: Toggle the Travel Window\n";

-- window title strings
mainTitleString = "Travel";
optionsTitleString = "Options de Travel";
moorMapTitleString = "Map Locations";
eriadorMapTitleString = "Carte de l'Eriador";
rhovanionMapTitleString = "Carte de Rhovanion";
gondorMapTitleString = "Carte de Dol Amroth"

-- strings for maps
mapHomeString = "Map Home";
glanMapString = "Carte précise pour aller à Glân Vraig";
glanMapItemString = "Carte précise pour aller à Glân Vraig";

-- travel ration strings
rationItemString = "Ration de  voyage";
rationLabelString = "Ration de  voyage :";

-- adding map strings
mapInstructionString = "Drag your maps from your inventory onto the " ..
        "quickslot below.  Then press the button " ..
        "to set your map home skills.";
mapErrorString = "Carte non détectée, auncune mise à jour.";

-- error messages
resetOrderString = "Your order settings have been reset due to a change in " ..
        "the number of items saved.  This should only occur once.\n" ..
        "Sorry for the inconvenience.";

resetEnabledString = "Vos talents selectionnés ont étés remis a zéro a cause  " ..
        "d'une erreur dans les objets sauvegardés.\n";

skillNotTrainedString = "Compétence non utilisée: ";

-- options window strings
generalTabString = "General";
selectTabString = "Selection";
sortTabString = "Tri";
hideString = "Cacher la fenêtre Travel au démarrage ";
toggleString = "Show Toggle Button";
pulldownTravelString = "Travel when pulldown skill selected";
hideOnCombatString = "Cacher la fenêtre a l'entrée en combat";
genericLabelString = "Compétences générales";
racialLabelString = "Compétences Raciales";
classLabelString = "Compétences de Classe";
repLabelString = "Compétences de Réputation";
moveUpString = "Vers le Haut";
moveDownString = "Vers le bas";
moveTopString = "Haut";
moveBottomString = "Bas";
toggleSlidersString = "Modifier l'opacitée du bouton";
mainSlidersString = "Modifier l'opacitée de la fenêtre";
minString = "Min: ";
maxString = "Max: ";
resetSettingsString = "Remise a zéro";
checkSkillsString = "Vérification des compétences non utilisées";

-- menu strings
menuFiltersString = "Filtres";
menuGenString = "Voir les voyages Génériques";
menuRaceString = "Voir les voyages Raciaux";
menuRepString = "Voir les voyages de Réputation";
menuClassString = "Voir les voyages de Classe";
menuModeString = "Mode";
menuTextString = "Liste de texte";
menuIconString = "Grille d'icône";
menuCaroString = "Caroussel";
menuPullString = "Menu déroulant";
menuMapString = "Ajouter une carte";
menuOptionsString = "Options";
moorMapString = "Ouvrir la carte de Moor";
eriadorMapString = "Ouvrir la carte de l'Eriador";
rhovanionMapString = "Ouvrir la carte du Rhovanion";
gondorMapString = "Ouvrir la carte de Gondor"
menuSkillsString = "Lister les compétences non apprises";

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

    hunterLocations:AddData("Retour au campement", "0x7000A2C1", "Retour au campement");
    hunterLocations:AddData("Guide vers Bree", "0x70003F42", "Guide vers Bree");
    hunterLocations:AddData("Guide vers le Palais de Thorin", "0x70003F41", "Guide vers le Palais de Thorin");
    hunterLocations:AddData("Guide vers Grand'Cave", "0x7000A2C3", "Guide vers Grand'Cave");
    hunterLocations:AddData("Guide vers Esteldin", "0x70003F43", "Guide vers Esteldin");
    hunterLocations:AddData("Guide vers Evendim", "0x7000A2C4", "Guide vers Evendim");
    hunterLocations:AddData("Guide vers Ost Guruth", "0x7000A2C2", "Guide vers Ost Guruth");
    hunterLocations:AddData("Guide vers Fondcombe", "0x70003F44", "Guide vers Fondcombe");
    hunterLocations:AddData("Guide vers Sûri-Kylä", "0x70017C82", "Guide vers Sûri-kylä");
    hunterLocations:AddData("Guide vers l'ouest d'Angmar", "0x7000A2C5", "Guide vers l'ouest d'Angmar");
    hunterLocations:AddData("Guide vers l'est d'Angmar", "0x7000A2C6", "Guide vers l'est d'Angmar");
    hunterLocations:AddData("Guide vers Echad Dunann", "0x70017C81", "Guide vers Echad Dunann");
    hunterLocations:AddData("Guide vers la vingt et unième salle", "0x70017C7A", "Guide vers la vingt et unième salle");
    hunterLocations:AddData("Guide vers l'Orée noire", "0x7001F459", "Guide vers l'Orée noire");
    hunterLocations:AddData("Guide vers Harndirion", "0x700235EF", "Guide vers Harndirion");
    hunterLocations:AddData("Guide vers Galtrev", "0x7002A93F", "Guide vers Galtrev");
    hunterLocations:AddData("Guide vers Stangarde", "0x7002C62C", "Guide vers Stangarde");
    hunterLocations:AddData("Guide vers Caras Galadhon", "0x7002E754", "Guide vers Caras Galadhon");
    hunterLocations:AddData("Guide vers les Monts Brumeux", "0x7002E756", "Guide vers les Monts Brumeux");
    hunterLocations:AddData("Guide vers Neigebronne", "0x7003198E", "Guide vers Neigebronne");
    hunterLocations:AddData("Guide vers Forloi", "0x70036B5D", "Guide vers Forloi");
    hunterLocations:AddData("Guide vers Aldburg", "0x7003DC71", "Guide vers Aldburg");
    hunterLocations:AddData("Guide vers le Gouffre de Helm", "0x7003DC72", "Guide vers le Gouffre de Helm");
    hunterLocations:AddData("Guide vers Dol Amroth", "0x70041197", "Guide vers Dol Amroth");
    hunterLocations:AddData("Guide vers Arnach", "0x70043A63", "Guide vers Arnach");

    wardenLocations:AddData("Rassemblement à Ost Guruth", "0x70014786", "Rassemblement à Ost Guruth");
    wardenLocations:AddData("Rassemblement à Esteldin", "0x70014798", "Rassemblement à Esteldin");
    wardenLocations:AddData("Rassemblement à Evendim", "0x7001478E", "Rassemblement dans la région d'Evendim");
    wardenLocations:AddData("Rassemblement à Fondcombe", "0x70014791", "Rassemblement à Fondcombe");
    wardenLocations:AddData("Rassemblement à Sûri-Kylä", "0x700237D4", "Rassemblement à Sûri-kylä");
    wardenLocations:AddData("Rassemblement à la vingt et unième salle", "0x7001819E", "Rassemblement à la vingt et unième salle");
    wardenLocations:AddData("Rassemblement à l'Orée noire", "0x7001F45C", "Rassemblement à l'Orée noire");
    wardenLocations:AddData("Rassemblement à Harndirion", "0x700235EB", "Rassemblement à Harndirion");
    wardenLocations:AddData("Rassemblement à Galtrev", "0x7002A90A", "Rassemblement à Galtrev");
    wardenLocations:AddData("Rassemblement à Stangarde", "0x7002C646", "Rassemblement à Stangarde");
    wardenLocations:AddData("Rassemblement à Caras Galadhon", "0x700303DF", "Rassemblement à Caras Galadhon");
    wardenLocations:AddData("Rassemblement dans les monts brumeux", "0x700303DD", "Rassemblement dans les monts brumeux");
    wardenLocations:AddData("Rassemblement à Neigebronne", "0x7003198D", "Rassemblement à Neigebronne");
    wardenLocations:AddData("Rassemblement à Forloi", "0x70036B5B", "Rassemblement à Forloi");
    wardenLocations:AddData("Rassemblement à Aldburg", "0x7003DC7A", "Rassemblement à Aldburg");
    wardenLocations:AddData("Rassemblement au Gouffre de Helm", "0x7003DC79", "Rassemblement au Gouffre de Helm");
    wardenLocations:AddData("Rassemblement au Dol Amroth", "0x70041198", "Rassemblement au Dol Amroth");
    wardenLocations:AddData("Rassemblement au Arnach", "0x70043A66", "Rassemblement au Arnach");

    racialLocations:AddData("Retour à Bree", "0x700062F6", "Retour à Bree");
    racialLocations:AddData("Retournez dans la Comté", "0x700062C8", "Retournez dans la Comté");
    racialLocations:AddData("Retour à la porte de Thorin", "0x70006346", "Retour à Thorin's Gate");
    racialLocations:AddData("Retour à Fondcombe", "0x7000631F", "Retour à Fondcombe");
    racialLocations:AddData("Retour à la maison", "0x70041a22", "Retour à la maison");

    -- check if a function that only exists in the newest update exists,
    -- if so, add the Return Home skills
    if (Turbine.UI.Control.IsDisplayed ~= nil) then
        genLocations:AddData("Return Home 1", "0x700256BA", "skip");
        genLocations:AddData("Return Home 2", "0x70025792", "skip");
        genLocations:AddData("Return Home 3", "0x70025793", "skip");
        genLocations:AddData("Return Home 4", "0x70025794", "skip");
        genLocations:AddData("Return Home 5", "0x70025795", "skip");
        genLocations:AddData("Return Home 6", "0x70025796", "skip");
        genLocations:AddData("Return Home 7", "0x7002FF5E", "skip");
        genLocations:AddData("Return Home 8", "0x7002FF5F", "skip");
        genLocations:AddData("Return Home 9", "0x7002FF60", "skip");
        genLocations:AddData("Return Home 10", "0x7002FF61", "skip");
        genLocations:AddData("Return Home 11", "0x7002FF62", "skip");
        genLocations:AddData("Return Home 12", "0x7002FF63", "skip");
    end
    genLocations:AddData("Maison personnelle", "0x7000D046", "Retour à la maison personnelle");
    genLocations:AddData("Maison de confrérie", "0x7000D047", "Retour à la maison de confrérie");

    repLocations:AddData("Revenir à la Porte de Thorin (Rep)", "0x7001BF91", "Revenir à la Porte de Thorin");
    repLocations:AddData("Retour à Bree (Rep)", "0x7001BF90", "Retour à Bree");
    repLocations:AddData("Retour au Marché de Lalia", "0x700364B1", "Retour au Marché de Lalia");
    repLocations:AddData("Retour à Grand'Cave (Rep)", "0x70023262", "Retour à Grand'Cave");
    repLocations:AddData("Retour à Fondcombe (Rep)", "0x70023263", "Retour à Fondcombe");
    repLocations:AddData("Retournez à Ost Guruth (Rep)", "0x70020441", "Retournez à Ost Guruth.");
    repLocations:AddData("Retour dans La Forêt Noire (Rep)", "0x7001F374", "Retour dans la Forêt Noire");
    repLocations:AddData("Retour en Enedwaith (Rep)", "0x70021FA2", "Retour en Enedwaith");
    repLocations:AddData("Retour à Galtrev (Rep)", "0x7002C647", "Retour à Galtrev");
    repLocations:AddData("Retour à Stangarde (Rep)", "0x7002C65D", "Retour à Stangarde");
    repLocations:AddData("Retourner à Neigebronne (Rep)", "0x70031A46", "Retourner à Neigebronne");
    repLocations:AddData("Retour à Forloi (Rep)", "0x70036B5E", "Retour à Forloi");
    repLocations:AddData("Retour à Aldburg (Rep)", "0x7003DC81", "Retour à Aldburg");
    repLocations:AddData("Retour à Derunant (Rep)", "0x7004128F", "Retour à Derunant");
    repLocations:AddData("Retour au Gouffre de Helm (Rep)", "0x7003DC82", "Retour au Gouffre de Helm");
    repLocations:AddData("Retour à Dol Amroth (Rep)", "0x700411AC", "Retour à Dol Amroth");
    repLocations:AddData("Retour à Arnach (Rep)", "0x70043A6A", "Retour à Arnach");

    creepLocations:AddData("Carte grossière pour aller au Gouffre d'Isen", "0x70028BB3");
    creepLocations:AddData("Carte grossière pour aller à Tol Ascarnen", "0x70028BB6");
    creepLocations:AddData("Carte grossière pour aller à Lugazag", "0x70028BB7");
    creepLocations:AddData("Carte grossière pour aller au Pied de Gram", "0x70028BBC");
    creepLocations:AddData("Carte grossière pour aller à Tirith Rhaw", "0x70028BBE");
    creepLocations:AddData("Carte grossière pour aller au Bois Funeste", "0x70028BBF");

    creepLocations:AddData("Piètre carte pour aller au Gouffre d'Isen", "0x70028BAF");
    creepLocations:AddData("Piètre carte pour aller à Tol Ascarnen", "0x70028BB1");
    creepLocations:AddData("Piètre carte pour aller à Lugazag", "0x70028BB2");
    creepLocations:AddData("Piètre carte pour aller à Tirith Rhaw", "0x70028BB4");
    creepLocations:AddData("Piètre carte pour aller au Bois Funeste", "0x70028BB9");

    creepLocations:AddData("Bonne carte pour aller au Gouffre d'Isen", "0x70028BC0");
    creepLocations:AddData("Bonne carte pour aller à Tol Ascarnen", "0x70028BC2");
    creepLocations:AddData("Bonne carte pour aller à Lugazag", "0x70028BB5");
    creepLocations:AddData("Bonne carte pour aller à Tirith Rhaw", "0x70028BB0");
    creepLocations:AddData("Bonne carte pour aller au Bois Funeste", "0x70028BBD");

    creepLocations:AddData("Carte pour aller au Pied de Gram", "0x70028BC1");
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


