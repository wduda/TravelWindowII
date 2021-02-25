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

-- add the data to custom dictionaries to maintain the order
function TravelDictionaries:CreateDictionaries()
    hunterLocations:AddSkill("Retour au campement", "0x7000A2C1", "Retour au campement");
    hunterLocations:AddSkill("Guide vers Bree", "0x70003F42", "Bree (Guide)");
    hunterLocations:AddSkill("Guide vers le Palais de Thorin", "0x70003F41", "Palais de Thorin (Guide)");
    hunterLocations:AddSkill("Guide vers Grand'Cave", "0x7000A2C3", "Grand'Cave (Guide)");
    hunterLocations:AddSkill("Guide vers Esteldin", "0x70003F43", "Esteldin (Guide)");
    hunterLocations:AddSkill("Guide vers Evendim", "0x7000A2C4", "Evendim (Guide)");
    hunterLocations:AddSkill("Guide vers Ost Guruth", "0x7000A2C2", "Ost Guruth (Guide)");
    hunterLocations:AddSkill("Guide vers Fondcombe", "0x70003F44", "Fondcombe (Guide)");
    hunterLocations:AddSkill("Guide vers Sûri-kylä", "0x70017C82", "Sûri-kylä (Guide)");
    hunterLocations:AddSkill("Guide vers l'ouest d'Angmar", "0x7000A2C5", "Angmar ouest (Guide)");
    hunterLocations:AddSkill("Guide vers l'est d'Angmar", "0x7000A2C6", "Angmar est (Guide)");
    hunterLocations:AddSkill("Guide vers Echad Dunann", "0x70017C81", "Echad Dunann (Guide)");
    hunterLocations:AddSkill("Guide vers la vingt et unième salle", "0x70017C7A", "Vingt et unième salle (Guide)");
    hunterLocations:AddSkill("Guide vers l'Orée noire", "0x7001F459", "Orée noire (Guide)");
    hunterLocations:AddSkill("Guide vers Harndirion", "0x700235EF", "Harndirion (Guide)");
    hunterLocations:AddSkill("Guide pour Galtrev", "0x7002A93F", "Galtrev (Guide)");
    hunterLocations:AddSkill("Guide vers Stangarde", "0x7002C62C", "Stangarde (Guide)");
    hunterLocations:AddSkill("Guide vers Caras Galadhon", "0x7002E754", "Caras Galadhon (Guide)");
    hunterLocations:AddSkill("Guide vers les Monts Brumeux", "0x7002E756", "Monts Brumeux (Guide)");
    hunterLocations:AddSkill("Guide vers Neigebronne", "0x7003198E", "Neigebronne (Guide)");
    hunterLocations:AddSkill("Guide vers Forloi", "0x70036B5D", "Forloi (Guide)");
    hunterLocations:AddSkill("Guide vers Aldburg", "0x7003DC71", "Aldburg (Guide)");
    hunterLocations:AddSkill("Guide vers le Gouffre de Helm", "0x7003DC72", "Gouffre de Helm (Guide)");
    hunterLocations:AddSkill("Guide vers Dol Amroth", "0x70041197", "Dol Amroth (Guide)");
    hunterLocations:AddSkill("Guide pour Arnach", "0x70043A63", "Arnach (Guide)");
    hunterLocations:AddSkill("Guide vers Minas Tirith", "0x70044985", "Minas Tirith (Guide)");
    hunterLocations:AddSkill("Guide pour se rendre au camp militaire", "0x700459AF", "Camp militaire (Guide)");
    hunterLocations:AddSkill("Guide de Minas Tirith après la bataille", "0x70046CBB", "Minas Tirith après la bataille (Guide)");
    hunterLocations:AddSkill("Guide vers Henneth Annûn", "0x70047077", "Henneth Annûn (Guide)");
    hunterLocations:AddSkill("Guide vers Osgiliath après la bataille", "0x70047074", "Osgiliath après la bataille (Guide)");
    hunterLocations:AddSkill("Guide vers le Camp de l'armée", "0x70047BFA", "Camp de l'armée (Guide)");
    hunterLocations:AddSkill("Guide vers Haerondir", "0x70047C1D", "Haerondir (Guide)");
    hunterLocations:AddSkill("Guide vers le fort d'Udûn", "0x7004AE1E", "Fort d'Udûn (Guide)");
    hunterLocations:AddSkill("Guide vers Dale", "0x7004D73B", "Dale (Guide)");
    hunterLocations:AddSkill("Guide vers Jarnfast", "0x7004FACC", "Jarnfast (Guide)");
    hunterLocations:AddSkill("Guide vers Skarhald", "0x7004FACB", "Skarhald (Guide)");
    hunterLocations:AddSkill("Guide pour Beorninghus", "0x70052F07", "Beorninghus (Guide)");
    hunterLocations:AddSkill("Guide de Hultvis", "0x70052F08", "Guide vers Hultvis (Guide)");
    hunterLocations:AddSkill("Guide vers Estolad Lân", "0x700551F4", "Estolad Lân (Guide)");
    hunterLocations:AddSkill("Guide de Limlok", "0x7005762D", "Limlok (Guide)");
    hunterLocations:AddSkill("Guide vers Annâk-khurfu", "0x70058571", "Annâk-khurfu (Guide)");
    hunterLocations:AddSkill("Guide vers Quai des marchands", "0x70059D0C", "Quai des marchands (Guide)");
    hunterLocations:AddSkill("Guide vers Pont-à-Tréteaux", "0x70059D16", "Pont-à-Tréteaux (Guide)");

    wardenLocations:AddSkill("Rassemblement à Ost Guruth", "0x70014786", "Ost Guruth (Rassemblement)");
    wardenLocations:AddSkill("Rassemblement à Esteldin", "0x70014798", "Esteldin (Rassemblement)");
    wardenLocations:AddSkill("Rassemblement dans la région d'Evendim", "0x7001478E", "Evendim (Rassemblement)");
    wardenLocations:AddSkill("Rassemblement à Fondcombe", "0x70014791", "Fondcombe (Rassemblement)");
    wardenLocations:AddSkill("Rassemblement à Sûri-kylä", "0x700237D4", "Sûri-kylä (Rassemblement)");
    wardenLocations:AddSkill("Rassemblement à la vingt et unième salle", "0x7001819E", "Vingt et unième salle (Rassemblement)");
    wardenLocations:AddSkill("Rassemblement à l'Orée noire", "0x7001F45C", "Orée noire (Rassemblement)");
    wardenLocations:AddSkill("Rassemblement à Harndirion", "0x700235EB", "Harndirion (Rassemblement)");
    wardenLocations:AddSkill("Rassemblement à Galtrev", "0x7002A90A", "Galtrev (Rassemblement)");
    wardenLocations:AddSkill("Rassemblement à Stangarde", "0x7002C646", "Stangarde (Rassemblement)");
    wardenLocations:AddSkill("Rassemblement à Caras Galadhon", "0x700303DF", "Caras Galadhon (Rassemblement)");
    wardenLocations:AddSkill("Rassemblement dans les Monts Brumeux", "0x700303DD", "Monts Brumeux (Rassemblement)");
    wardenLocations:AddSkill("Rassemblement à Neigebronne", "0x7003198D", "Neigebronne (Rassemblement)");
    wardenLocations:AddSkill("Rassemblement à Forloi", "0x70036B5B", "Forloi (Rassemblement)");
    wardenLocations:AddSkill("Rassemblement à Aldburg", "0x7003DC7A", "Aldburg (Rassemblement)");
    wardenLocations:AddSkill("Rassemblement au Gouffre de Helm", "0x7003DC79", "Gouffre de Helm (Rassemblement)");
    wardenLocations:AddSkill("Rassemblement à Dol Amroth", "0x70041198", "Dol Amroth (Rassemblement)");
    wardenLocations:AddSkill("Rassemblement à Arnach", "0x70043A66", "Arnach (Rassemblement)");
    wardenLocations:AddSkill("Rassemblement à Minas Tirith", "0x70044982", "Minas Tirith (Rassemblement)");
    wardenLocations:AddSkill("Rassemblement au camp militaire", "0x700459AA", "Camp militaire (Rassemblement)");
    wardenLocations:AddSkill("Rassemblement à Minas Tirith après la bataille", "0x70046CBF", "Minas Tirith après la bataille (Rassemblement)");
    wardenLocations:AddSkill("Rassemblement à Henneth Annûn", "0x70047075", "Henneth Annûn (Rassemblement)");
    wardenLocations:AddSkill("Rassemblement à Osgiliath après la bataille", "0x70047076", "Osgiliath après la bataille (Rassemblement)");
    wardenLocations:AddSkill("Rassemblement au Camp de l'armée", "0x70047BFC", "Camp de l'armée (Rassemblement)");
    wardenLocations:AddSkill("Rassemblement à Haerondir", "0x70047C23", "Haerondir (Rassemblement)");
    wardenLocations:AddSkill("Rassemblement dans le fort d'Udûn", "0x7004AE1F", "Fort d'Udûn (Rassemblement)");
    wardenLocations:AddSkill("Retour à Dale", "0x7004D73A", "Dale (Rassemblement)");
    wardenLocations:AddSkill("Retour à Jarnfast", "0x7004FACA", "Jarnfast (Rassemblement)");
    wardenLocations:AddSkill("Retour à Skarhald", "0x7004FACD", "Skarhald (Rassemblement)");
    wardenLocations:AddSkill("Rassemblement à Beorninghus", "0x70052F0A", "Beorninghus (Rassemblement)");
    wardenLocations:AddSkill("Rassemblement à Hultvis", "0x70052F06", "Hultvis (Rassemblement)");
    wardenLocations:AddSkill("Rassemblement à Estolad Lân", "0x700551F2", "Estolad Lân (Rassemblement)");
    wardenLocations:AddSkill("Rassemblement à Limlok", "0x70057635", "Limlok (Rassemblement)");
    wardenLocations:AddSkill("Rassemblement à Annâk-khurfu", "0x70058572", "Annâk-khurfu (Rassemblement)");
    wardenLocations:AddSkill("Rassemblement à Quai des marchands", "0x70059D09", "Quai des marchands (Rassemblement)");
    wardenLocations:AddSkill("Rassemblement à Pont-à-Tréteaux", "0x700559D10", "Pont-à-Tréteaux (Rassemblement)");

    racialLocations:AddSkill("Retour à Bree", "0x700062F6", "Bree (Race)");
    racialLocations:AddSkill("Retournez dans la Comté", "0x700062C8", "Comté (Race)");
    racialLocations:AddSkill("Retour : Porte de Thorin", "0x70006346", "Porte de Thorin (Race)");
    racialLocations:AddSkill("Retour à Fondcombe", "0x7000631F", "Fondcombe (Race)");
    racialLocations:AddSkill("Retour à la maison", "0x70041A22", "Maison Beorning (Race)");
    racialLocations:AddSkill("Voyage vers Caras Galadhon, en Lothlórien", "0x70048C8C", "Caras Galadhon (Race)");
    racialLocations:AddSkill("Aller au Palais de Thorin", "0x70053C0F", "Palais de Thorin (Race)");

    genLocations:AddSkill("Retour à la maison",    "0x700256BA", "Point de repère 1");
    genLocations:AddSkill("Retour à la maison 2",  "0x70025792", "Point de repère 2");
    genLocations:AddSkill("Retour à la maison 3",  "0x70025793", "Point de repère 3");
    genLocations:AddSkill("Retour à la maison 4",  "0x70025794", "Point de repère 4");
    genLocations:AddSkill("Retour à la maison 5",  "0x70025795", "Point de repère 5");
    genLocations:AddSkill("Retour à la maison 6",  "0x70025796", "Point de repère 6");
    genLocations:AddSkill("Retour à la maison 7",  "0x7002FF62", "Point de repère 7");
    genLocations:AddSkill("Retour à la maison 8",  "0x7002FF61", "Point de repère 8");
    genLocations:AddSkill("Retour à la maison 9",  "0x7002FF60", "Point de repère 9");
    genLocations:AddSkill("Retour à la maison 10", "0x7002FF5F", "Point de repère 10");
    genLocations:AddSkill("Retour à la maison 11", "0x7002FF63", "Point de repère 11");
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
    repLocations:AddSkill("Retour dans la Forêt Noire", "0x7001F374", "Retour dans la Forêt Noire");
    repLocations:AddSkill("Retour en Enedwaith", "0x70021FA2", "Retour en Enedwaith");
    repLocations:AddSkill("Retour à Galtrev", "0x7002C647", "Retour à Galtrev");
    repLocations:AddSkill("Retour à Stangarde", "0x7002C65D", "Retour à Stangarde");
    repLocations:AddSkill("Retourner à Neigebronne", "0x70031A46", "Retourner à Neigebronne");
    repLocations:AddSkill("Retour à Forloi", "0x70036B5E", "Retour à Forloi");
    repLocations:AddSkill("Retour à Aldburg", "0x7003DC81", "Aldburg (Rep)");
    repLocations:AddSkill("Retour à Derunant", "0x7004128F", "Derunant (Rep)");
    repLocations:AddSkill("Retour au Gouffre de Helm", "0x7003DC82", "Gouffre de Helm(Rep)");
    repLocations:AddSkill("Retour à Dol Amroth", "0x700411AC", "Dol Amroth (Rep)");
    repLocations:AddSkill("Retournez à Arnach", "0x70043A6A", "Arnach (Rep)");
    repLocations:AddSkill("Retour à Minas Tirith", "0x7004497E", "Retour à Minas Tirith (Rep)");
    repLocations:AddSkill("Retour au camp militaire", "0x700459A9", "Camp militaire (Rep)");
    repLocations:AddSkill("Retour à Minas Tirith après la bataille", "0x70046CC0", "Minas Tirith après la bataille (Rep)");
    repLocations:AddSkill("Retour à Henneth Annûn", "0x70047080", "Henneth Annûn (Rep)");
    repLocations:AddSkill("Retour à Osgiliath après la bataille", "0x7004707D", "Osgiliath après la bataille (Rep)");
    repLocations:AddSkill("Retour au Camp de l'armée", "0x70047BF4", "Camp de l'armée (Rep)");
    repLocations:AddSkill("Retour à Haerondir", "0x70047C1B", "Haerondir");
    repLocations:AddSkill("Retour au fort d'Udûn", "0x7004AE1D", "Fort d'Udûn");
    repLocations:AddSkill("Voyager jusqu'à la Cour de Lothlórien", "0x7004B8C2", "Cour de Lothlórien (Rep)");
    repLocations:AddSkill("Voyager jusqu'au Palais du roi", "0x7004B8C3", "Palais du roi (Rep)");
    repLocations:AddSkill("Voyager jusqu'au Palais sous la Montagne", "0x7004B8C4", "Palais sous la Montagne (Rep)");
    repLocations:AddSkill("Voyager jusqu'à Bâr Thorenion", "0x7004B8C5", "Bâr Thorenion (Rep)");
    repLocations:AddSkill("Revenir à Dale", "0x7004D738", "Dale (Rep)");
    repLocations:AddSkill("Revenir à Jarnfast", "0x7004FAC3", "Jarnfast (Rep)");
    repLocations:AddSkill("Revenir à Skarhald", "0x7004FAC5", "Skarhald (Rep)");
    repLocations:AddSkill("Retournez auprès de Beorninghus", "0x70052F12", "Beorninghus (Rep)");
    repLocations:AddSkill("Retournez auprès de Hultvis", "0x70052F04", "Hultvis (Rep)");
    repLocations:AddSkill("Retour à Estolad Lân", "0x700551F8", "Estolad Lân (Rep)");
    repLocations:AddSkill("Retour à Limlok", "0x70057629", "Limlok (Rep)");
    repLocations:AddSkill("Retournez à Annâk-khurfu", "0x7005856F", "Annâk-khurfu (Rep)");
    repLocations:AddSkill("Retour à Quai des marchands", "0x70059D0E", "Quai des marchands (Rep)");
    repLocations:AddSkill("Retour à Pont-à-Tréteaux", "0x70059D12", "Pont-à-Tréteaux (Rep)");

    -- monster player maps
    creepLocations:AddSkill("Carte grossière pour aller au Pied de Gram", "0x70028BBC");
    creepLocations:AddSkill("Carte pour aller au Pied de Gram", "0x70028BC1");

    creepLocations:AddSkill("Carte grossière pour aller au Gouffre d'Isen", "0x70028BB3");
    creepLocations:AddSkill("Carte grossière pour aller à Tol Ascarnen", "0x70028BB6");
    creepLocations:AddSkill("Carte grossière pour aller à Lugazag", "0x70028BB7");
    creepLocations:AddSkill("Carte grossière pour aller à Tirith Rhaw", "0x70028BBE");
    creepLocations:AddSkill("Carte grossière pour aller au Bois Funeste", "0x70028BBF");

    creepLocations:AddSkill("Piètre carte pour aller au Gouffre d'Isen", "0x70028BAF");
    creepLocations:AddSkill("Piètre carte pour aller à Tol Ascarnen", "0x70028BB1");
    creepLocations:AddSkill("Piètre carte pour aller à Lugazag", "0x70028BB2");
    creepLocations:AddSkill("Piètre carte pour aller à Tirith Rhaw", "0x70028BB4");
    creepLocations:AddSkill("Piètre carte pour aller au Bois Funeste", "0x70028BB9");

    creepLocations:AddSkill("Bonne carte pour aller au Gouffre d'Isen", "0x70028BC0");
    creepLocations:AddSkill("Bonne carte pour aller à Tol Ascarnen", "0x70028BC2");
    creepLocations:AddSkill("Bonne carte pour aller à Lugazag", "0x70028BB5");
    creepLocations:AddSkill("Bonne carte pour aller à Tirith Rhaw", "0x70028BB0");
    creepLocations:AddSkill("Bonne carte pour aller au Bois Funeste", "0x70028BBD");

end
