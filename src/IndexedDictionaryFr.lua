--[[ string constants ]] --
--[[ put all the strings that might require translation in ]] --
--[[ one location for easier access ]] --
helpString = "Travel\n\ntrav show: Afficher Travel Window\n" ..
"trav hide: Masquer Travel Window\n" ..
"trav toggle: Toggle the Travel Window\n";

-- window title strings
mainTitleString = "Travel";
optionsTitleString = "Options de Travel";
moorMapTitleString = "Carte des Landes d'Etten";
eriadorMapTitleString = "Carte de l'Eriador";
rhovanionMapTitleString = "Carte du Rhovanion";
gondorMapTitleString = "Carte du Gondor"

-- strings for maps
glanMapString = "Carte précise pour aller à Glân Vraig";
glanMapItemString = "Carte précise pour aller à Glân Vraig";

-- error messages
resetOrderString = "Votre ordre personnalisé a été ré-initialisé du fait d'un changement dans " ..
"le nombre d'éléments sauvegardés.  Ceci ne devrait se produire qu'une fois.\n" ..
"Sorry for the inconvenience.";

resetEnabledString = "Vos talents selectionnés ont étés remis a zéro à cause  " ..
"d'une erreur dans les objets sauvegardés.\n";

skillNotTrainedString = "Compétence non utilisée: ";

-- options window strings
generalTabString = "Général";
selectTabString = "Sélection";
sortTabString = "Tri";
hideString = "Cacher la fenêtre Travel au démarrage ";
toggleString = "Montrer le bouton Travel";
pulldownTravelString = "Voyager lorsque la compétence déroulante est sélectionnée";
hideOnCombatString = "Cacher la fenêtre à l'entrée en combat";
genericLabelString = "Compétences générales";
racialLabelString = "Compétences raciales";
classLabelString = "Compétences de classe";
repLabelString = "Compétences de réputation";
moveUpString = "Vers le haut";
moveDownString = "Vers le bas";
moveTopString = "Tout en haut";
moveBottomString = "Tout en bas";
toggleSlidersString = "Modifier l'opacité du bouton";
mainSlidersString = "Modifier l'opacité de la fenêtre";
minString = "Min: ";
maxString = "Max: ";
resetSettingsString = "Remise a zéro";
checkSkillsString = "Vérification des compétences non utilisées";

-- menu strings
menuFiltersString = "Filtres";
menuGenString = "Voir les voyages génériques";
menuRaceString = "Voir les voyages raciaux";
menuRepString = "Voir les voyages de réputation";
menuClassString = "Voir les voyages de classe";
menuModeString = "Mode";
menuTextString = "Liste de texte";
menuIconString = "Grille d'icône";
menuCaroString = "Caroussel";
menuPullString = "Menu déroulant";
menuOptionsString = "Options";
moorMapString = "Destinations aux Landes d'Etten";
eriadorMapString = "Destinations en Eriador";
rhovanionMapString = "Destination dans le Rhovanion";
gondorMapString = "Destinations dans le Gondor"
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
    hunterLocations:AddSkill("Retour au campement", "0x7000A2C1", "Retour au campement"); --@TODO
    hunterLocations:AddSkill("Guide vers Bree", "0x70003F42", "Bree (Guide)"); --@TODO
    hunterLocations:AddSkill("Guide vers le Palais de Thorin", "0x70003F41", "Guide vers le Palais de Thorin (Guide)"); --@TODO
    hunterLocations:AddSkill("Guide vers Grand'Cave", "0x7000A2C3", "Guide vers Grand'Cave  (Guide)"); --@TODO
    hunterLocations:AddSkill("Guide vers Esteldin", "0x70003F43", "Guide vers Esteldin (Guide)"); --@TODO
    hunterLocations:AddSkill("Guide vers Evendim", "0x7000A2C4", "Guide vers Evendim (Guide)"); --@TODO
    hunterLocations:AddSkill("Guide vers Ost Guruth", "0x7000A2C2", "Guide vers Ost Guruth (Guide)"); --@TODO
    hunterLocations:AddSkill("Guide vers Fondcombe", "0x70003F44", "Guide vers Fondcombe (Guide)"); --@TODO
    hunterLocations:AddSkill("Guide vers Sûri-Kylä", "0x70017C82", "Guide vers Sûri-kylä (Guide)"); --@TODO
    hunterLocations:AddSkill("Guide vers l'ouest d'Angmar", "0x7000A2C5", "Guide vers l'ouest d'Angmar (Guide)"); --@TODO
    hunterLocations:AddSkill("Guide vers l'est d'Angmar", "0x7000A2C6", "Guide vers l'est d'Angmar (Guide)"); --@TODO
    hunterLocations:AddSkill("Guide vers Echad Dunann", "0x70017C81", "Guide vers Echad Dunann (Guide)"); --@TODO
    hunterLocations:AddSkill("Guide vers la vingt et unième salle", "0x70017C7A", "Guide vers la vingt et unième salle (Guide)"); --@TODO
    hunterLocations:AddSkill("Guide vers l'Orée noire", "0x7001F459", "Guide vers l'Orée noire (Guide)"); --@TODO
    hunterLocations:AddSkill("Guide vers Harndirion", "0x700235EF", "Guide vers Harndirion (Guide)"); --@TODO
    hunterLocations:AddSkill("Guide pour Galtrev", "0x7002A93F", "Guide pour Galtrev (Guide)"); --@TODO
    hunterLocations:AddSkill("Guide vers Stangarde", "0x7002C62C", "Guide vers Stangarde (Guide)"); --@TODO
    hunterLocations:AddSkill("Guide vers Caras Galadhon", "0x7002E754", "Guide vers Caras Galadhon (Guide)"); --@TODO
    hunterLocations:AddSkill("Guide vers les Monts Brumeux", "0x7002E756", "Guide vers les Monts Brumeux (Guide)"); --@TODO
    hunterLocations:AddSkill("Guide vers Neigebronne", "0x7003198E", "Guide vers Neigebronne (Guide)"); --@TODO
    hunterLocations:AddSkill("Guide vers Forloi", "0x70036B5D", "Guide vers Forloi (Guide)"); --@TODO
    hunterLocations:AddSkill("Guide vers Aldburg", "0x7003DC71", "Aldburg (Guide)");
    hunterLocations:AddSkill("Guide vers le Gouffre de Helm", "0x7003DC72", "Guide vers le Gouffre de Helm (Guide)"); --@TODO
    hunterLocations:AddSkill("Guide vers Dol Amroth", "0x70041197", "Guide vers Dol Amroth (Guide)"); --@TODO
    hunterLocations:AddSkill("Guide vers Arnach", "0x70043A63", "Guide pour Arnach (Guide)"); --@TODO
    hunterLocations:AddSkill("Guide vers Minas Tirith", "0x70044985", "Guide vers Minas Tirith (Guide)"); --@TODO
    hunterLocations:AddSkill("Guide pour se rendre au Camp Militaire", "0x700459AF", "Guide pour se rendre au Camp Militaire (Guide)"); --@TODO
    hunterLocations:AddSkill("Guide de Minas Tirith après la bataille", "0x70046CBB", "Guide de Minas Tirith après la bataille (Guide)"); --@TODO
    hunterLocations:AddSkill("Guide vers Henneth Annûn", "0x70047077", "Guide vers Henneth Annûn (Guide)"); --@TODO
    hunterLocations:AddSkill("Guide vers Osgiliath après la bataille", "0x70047074", "Guide vers Osgiliath après la bataille (Guide)"); --@TODO
    hunterLocations:AddSkill("Guide vers le Camp de l'armée", "0x70047BFA", "Guide to the Camp of the Host (Guide)"); --@TODO
    hunterLocations:AddSkill("Guide vers Haerondir", "0x70047C1D", "Guide vers Haerondir (Guide)"); --@TODO
    hunterLocations:AddSkill("Guide vers le fort d'Udûn", "0x7004AE1E", "Guide vers le fort d'Udûn (Guide)"); --@TODO
    hunterLocations:AddSkill("Guide vers Jarnfast", "0x7004facc", "Guide vers Jarnfast (Guide)"); --@TODO
    hunterLocations:AddSkill("Guide vers Skarhald", "0x7004facb", "Guide vers Skarhald (Guide)"); --@TODO
    hunterLocations:AddSkill("Guide vers Dale", "0x7004d73b", "Guide vers Dale (Guide)"); --@TODO
    hunterLocations:AddSkill("Guide vers Beorninghus", "0x70052F07", "Guide pour Beorninghus (Guide)"); --@TODO
    hunterLocations:AddSkill("Guide vers Hultvis", "0x70052F08", "Guide vers Hultvis (Guide)"); --@TODO
    hunterLocations:AddSkill("Guide vers Estolad Lân", "0x700551F4", "Guide vers Estolad Lân (Guide)"); --@TODO
    hunterLocations:AddSkill("Guide vers Limlok", "0x7005762d", "Guide de Limlok (Guide)"); --@TODO
    hunterLocations:AddSkill("Guide vers Annâk-khurfu", "0x7005856F", "Guide de Annâk-khurfu (Guide)"); --@TODO

	wardenLocations:AddSkill("Rassemblement à Ost Guruth", "0x70014786", "Rassemblement à Ost Guruth (Rassemblement)"); --@TODO
    wardenLocations:AddSkill("Rassemblement à Esteldin", "0x70014798", "Rassemblement à Esteldin (Rassemblement)"); --@TODO
    wardenLocations:AddSkill("Rassemblement à Evendim", "0x7001478E", "Rassemblement dans la région d'Evendim (Rassemblement)"); --@TODO
    wardenLocations:AddSkill("Rassemblement à Fondcombe", "0x70014791", "Rassemblement à Fondcombe (Rassemblement)"); --@TODO
    wardenLocations:AddSkill("Rassemblement à Sûri-Kylä", "0x700237D4", "Rassemblement à Sûri-kylä (Rassemblement)"); --@TODO
    wardenLocations:AddSkill("Rassemblement à la vingt et unième salle", "0x7001819E", "Rassemblement à la vingt et unième salle (Rassemblement)"); --@TODO
    wardenLocations:AddSkill("Rassemblement à l'Orée noire", "0x7001F45C", "Rassemblement à l'Orée noire (Rassemblement)"); --@TODO
    wardenLocations:AddSkill("Rassemblement à Harndirion", "0x700235EB", "Rassemblement à Harndirion (Rassemblement)"); --@TODO
    wardenLocations:AddSkill("Rassemblement à Galtrev", "0x7002A90A", "Rassemblement à Galtrev (Rassemblement)"); --@TODO
    wardenLocations:AddSkill("Rassemblement à Stangarde", "0x7002C646", "Rassemblement à Stangarde (Rassemblement)"); --@TODO
    wardenLocations:AddSkill("Rassemblement à Caras Galadhon", "0x700303DF", "Rassemblement à Caras Galadhon (Rassemblement)"); --@TODO
    wardenLocations:AddSkill("Rassemblement dans les monts brumeux", "0x700303DD", "Rassemblement dans les monts brumeux (Rassemblement)"); --@TODO
    wardenLocations:AddSkill("Rassemblement à Neigebronne", "0x7003198D", "Rassemblement à Neigebronne (Rassemblement)"); --@TODO
    wardenLocations:AddSkill("Rassemblement à Forloi", "0x70036B5B", "Rassemblement à Forloi (Rassemblement)"); --@TODO
    wardenLocations:AddSkill("Rassemblement à Aldburg", "0x7003DC7A", "Aldburg (Rassemblement)");
    wardenLocations:AddSkill("Rassemblement au Gouffre de Helm", "0x7003DC79", "Rassemblement au Gouffre de Helm (Rassemblement)"); --@TODO
    wardenLocations:AddSkill("Rassemblement au Dol Amroth", "0x70041198", "Rassemblement au Dol Amroth (Rassemblement)"); --@TODO
    wardenLocations:AddSkill("Rassemblement au Arnach", "0x70043A66", "Rassemblement au Arnach (Rassemblement)"); --@TODO
    wardenLocations:AddSkill("Rassemblement au Minas Tirith", "0x70044982", "Rassemblement au Minas Tirith (Rassemblement)"); --@TODO
    wardenLocations:AddSkill("Rassemblement au Camp Militaire", "0x700459AA", "Rassemblement au Camp Militaire (Rassemblement)"); --@TODO
    wardenLocations:AddSkill("Rassemblement à Minas Tirith après la bataille", "0x70046CBF", "Rassemblement à Minas Tirith après la bataille (Rassemblement)"); --@TODO
    wardenLocations:AddSkill("Rassemblement à Henneth Annûn", "0x70047075", "Rassemblement à Henneth Annûn (Rassemblement)"); --@TODO
    wardenLocations:AddSkill("Rassemblement à Osgiliath après la bataille", "0x70047076", "Rassemblement à Osgiliath après la bataille (Rassemblement)"); --@TODO
    wardenLocations:AddSkill("Rassemblement au Camp de l'armée", "0x70047BFC", "Rassemblement au Camp de l'armée (Rassemblement)"); --@TODO
    wardenLocations:AddSkill("Rassemblement à Haerondir", "0x70047C23", "Rassemblement à Haerondir (Rassemblement)"); --@TODO
    wardenLocations:AddSkill("Rassemblement dans le fort d'Udûn", "0x7004AE1F", "Rassemblement dans le fort d'Udûn (Rassemblement)"); --@TODO
    wardenLocations:AddSkill("Retour à Jarnfast", "0x7004FACA", "Retour à Jarnfast (Rassemblement)"); --@TODO
    wardenLocations:AddSkill("Retour à Skarhald", "0x7004FACD", "Retour à Skarhald (Rassemblement)"); --@TODO
    wardenLocations:AddSkill("Retour à Dale", "0x7004d73a", "Retour à Dale (Rassemblement)"); --@TODO
    wardenLocations:AddSkill("Rassemblement à Beorninghus", "0x70052F07", "Beorninghus (Rassemblement)"); --@TODO
    wardenLocations:AddSkill("Rassemblement à Hultvis", "0x70052F08", "Hultvis (Rassemblement)"); --@TODO
    wardenLocations:AddSkill("Rassemblement à Estolad Lân", "0x700551F2", "Estolad Lân (Rassemblement)"); --@TODO
    wardenLocations:AddSkill("Rassemblement à Limlok", "0x70057635", "Limlok (Rassemblement)"); --@TODO
    wardenLocations:AddSkill("Rassemblement à Annâk-khurfu", "0x7005856F", "Annâk-khurfu (Rassemblement)"); --@TODO

	racialLocations:AddSkill("Retour à Bree", "0x700062F6", "Bree (Race)");
    racialLocations:AddSkill("Retournez dans la Comté", "0x700062C8", "Comté (Race)"); --@TODO
    racialLocations:AddSkill("Retour : Porte de Thorin", "0x70006346", "Porte de Thorin (Race)"); --@TODO
    racialLocations:AddSkill("Retour à Fondcombe", "0x7000631F", "Fondcombe (Race)");
    racialLocations:AddSkill("Retour à la maison", "0x70041A22", "Retour à la maison (Race)"); --@TODO
    racialLocations:AddSkill("Retour à Caras Galadhon dans Lothlórien", "0x70048C8C", "Voyage vers Caras Galadhon, en Lothlórien (Race)"); --@TODO
    racialLocations:AddSkill("Revenir au Palais de Thorin", "0x70053C0F", "Aller au Palais de Thorin (Race)"); --@TODO

    genLocations:AddSkill("Return Home 1", "0x700256BA", "Return Home 1"); --@TODO
    genLocations:AddSkill("Compétence Point de repère 2", "0x70025792", "Point De Repère 2"); --@TODO
    genLocations:AddSkill("Return Home 3", "0x70025793", "Return Home 3"); --@TODO
    genLocations:AddSkill("Return Home 4", "0x70025794", "Return Home 4"); --@TODO
    genLocations:AddSkill("Return Home 5", "0x70025795", "Return Home 5"); --@TODO
    genLocations:AddSkill("Return Home 6", "0x70025796", "Return Home 6"); --@TODO
    genLocations:AddSkill("Return Home 7", "0x7002FF5E", "Return Home 7"); --@TODO
    genLocations:AddSkill("Return Home 8", "0x7002FF5F", "Return Home 8"); --@TODO
    genLocations:AddSkill("Return Home 9", "0x7002FF60", "Return Home 9"); --@TODO
    genLocations:AddSkill("Return Home 10", "0x7002FF61", "Return Home 10"); --@TODO
    genLocations:AddSkill("Return Home 11", "0x7002FF62", "Return Home 11"); --@TODO
    genLocations:AddSkill("Retour à la maison personnelle", "0x7000D046", "Maison personnelle");
    genLocations:AddSkill("Aller à une maison premium", "0x70046EE4", "Maison premium");
    genLocations:AddSkill("Retour à la maison de confrérie", "0x7000D047", "Maison de confrérie");
    genLocations:AddSkill("Retour à la maison d'un membre de confrérie", "0x70057C36", "Maison d'un membre de confrérie");

    repLocations:AddSkill("Retour : Porte de Thorin", "0x7001BF91", "Porte de Thorin (Rep/Shop)");
    repLocations:AddSkill("Retour à Bree", "0x7001BF90", "Retour à Bree (Rep/Shop)");
    repLocations:AddSkill("Retour au Marché de Lalia", "0x700364B1", "Retour au Marché de Lalia (Mithril)");
    repLocations:AddSkill("Retour à Grand'Cave", "0x70023262", "Retour à Grand'Cave (Shop)");
    repLocations:AddSkill("Retour à Fondcombe", "0x70023263", "Retour à Fondcombe (Shop)");
    repLocations:AddSkill("Retournez à Ost Guruth", "0x70020441", "Retournez à Ost Guruth");
    repLocations:AddSkill("Retour en Enedwaith", "0x70021FA2", "Retour en Enedwaith");
    repLocations:AddSkill("Retour à Galtrev", "0x7002C647", "Retour à Galtrev");
    repLocations:AddSkill("Retour dans la Forêt Noire", "0x7001F374", "Retour dans la Forêt Noire");
    repLocations:AddSkill("Retour à Stangarde", "0x7002C65D", "Retour à Stangarde");
    repLocations:AddSkill("Retour à Forloi", "0x70036B5E", "Retour à Forloi");
    repLocations:AddSkill("Retourner à Neigebronne", "0x70031A46", "Retourner à Neigebronne");
    repLocations:AddSkill("Retour à Aldburg", "0x7003DC81", "Aldburg (Rep)");
    repLocations:AddSkill("Retour à Derunant", "0x7004128F", "Derunant (Rep)");
    repLocations:AddSkill("Retour au Gouffre de Helm", "0x7003DC82", "Gouffre de Helm(Rep)");
    repLocations:AddSkill("Retour à Dol Amroth", "0x700411AC", "Dol Amroth (Rep)");
    repLocations:AddSkill("Retournez à Arnach", "0x70043A6A", "Arnach (Rep)");
    repLocations:AddSkill("Retour à Minas Tirith", "0x7004497E", "Retour à Minas Tirith (Rep)");
    repLocations:AddSkill("Retour au Camp Militaire", "0x700459A9", "Camp Militaire (Rep)"); --@TODO
    repLocations:AddSkill("Retour à Minas Tirith après la bataille", "0x70046CC0", "Minas Tirith après la bataille (Rep)");
    repLocations:AddSkill("Osgiliath après la bataille", "0x7004707D", "Retour à Osgiliath après la bataille"); --@TODO
    repLocations:AddSkill("Henneth Annûn", "0x70047080", "Retour à Henneth Annûn"); --@TODO
    repLocations:AddSkill("Camp de l'armée", "0x70047BF4", "Retour au Camp de l'armée"); --@TODO
    repLocations:AddSkill("Haerondir", "0x70047C1B", "Retour à Haerondir"); --@TODO
    repLocations:AddSkill("Fort d'Udûn", "0x7004AE1D", "Retour au fort d'Udûn"); --@TODO
    repLocations:AddSkill("Cour de Lothlórien", "0x7004B8C2", "Voyager jusqu'à la Cour de Lothlórien"); --@TODO
    repLocations:AddSkill("Palais du roi", "0x7004B8C3", "Voyager jusqu'au Palais du roi"); --@TODO
    repLocations:AddSkill("Bâr Thorenion", "0x7004B8C5", "Voyager jusqu'à Bâr Thorenion"); --@TODO
    repLocations:AddSkill("Palais sous la Montagne", "0x7004B8C4", "Voyager jusqu'au Palais sous la Montagne"); --@TODO
    repLocations:AddSkill("Dale", "0x7004d738", "Revenir à Dale"); --@TODO
    repLocations:AddSkill("Jarnfast", "0x7004fac3", "Revenir à Jarnfast"); --@TODO
    repLocations:AddSkill("Skarhald", "0x7004fac5", "Revenir à Skarhald"); --@TODO
    repLocations:AddSkill("Beorninghus", "0x70052F12", "Retournez auprès de Beorninghus"); --@TODO
    repLocations:AddSkill("Hultvis", "0x70052F04", "Retournez auprès de Hultvis"); --@TODO
    repLocations:AddSkill("Estolad Lân", "0x700551F8", "Retour à Estolad Lân"); --@TODO
    repLocations:AddSkill("Limlok", "0x70057629", "Retour à Limlok"); --@TODO
    repLocations:AddSkill("Annâk-khurfu", "0x7005856F", "Retournez à Annâk-khurfu"); --@TODO

    creepLocations:AddSkill("Carte grossière pour aller au Gouffre d'Isen", "0x70028BB3"); --@TODO
    creepLocations:AddSkill("Carte grossière pour aller à Tol Ascarnen", "0x70028BB6"); --@TODO
    creepLocations:AddSkill("Carte grossière pour aller à Lugazag", "0x70028BB7"); --@TODO
    creepLocations:AddSkill("Carte grossière pour aller au Pied de Gram", "0x70028BBC"); --@TODO
    creepLocations:AddSkill("Carte grossière pour aller à Tirith Rhaw", "0x70028BBE"); --@TODO
    creepLocations:AddSkill("Carte grossière pour aller au Bois Funeste", "0x70028BBF"); --@TODO

    creepLocations:AddSkill("Piètre carte pour aller au Gouffre d'Isen", "0x70028BAF"); --@TODO
    creepLocations:AddSkill("Piètre carte pour aller à Tol Ascarnen", "0x70028BB1"); --@TODO
    creepLocations:AddSkill("Piètre carte pour aller à Lugazag", "0x70028BB2"); --@TODO
    creepLocations:AddSkill("Piètre carte pour aller à Tirith Rhaw", "0x70028BB4"); --@TODO
    creepLocations:AddSkill("Piètre carte pour aller au Bois Funeste", "0x70028BB9"); --@TODO

    creepLocations:AddSkill("Bonne carte pour aller au Gouffre d'Isen", "0x70028BC0"); --@TODO
    creepLocations:AddSkill("Bonne carte pour aller à Tol Ascarnen", "0x70028BC2"); --@TODO
    creepLocations:AddSkill("Bonne carte pour aller à Lugazag", "0x70028BB5"); --@TODO
    creepLocations:AddSkill("Bonne carte pour aller à Tirith Rhaw", "0x70028BB0"); --@TODO
    creepLocations:AddSkill("Bonne carte pour aller au Bois Funeste", "0x70028BBD"); --@TODO

    creepLocations:AddSkill("Carte pour aller au Pied de Gram", "0x70028BC1"); --@TODO
end
