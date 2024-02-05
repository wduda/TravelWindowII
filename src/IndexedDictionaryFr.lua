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

skillNotTrainedString = "Compétence non utilisée: ";

-- options window strings
generalTabString = "Général";
selectTabString = "Sélection";
sortTabString = "Tri";
hideString = "Cacher la fenêtre au démarrage";
toggleString = "Montrer le bouton Travel";
pulldownTravelString = "Voyager lorsque la compétence déroulante est sélectionnée";
hideOnTravelString = "Cacher la fenêtre quand une compétence de voyage est utilisée";
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
saveGlobalDefaultsString = "Enregistrer par défaut globales";
loadGlobalDefaultsString = "Charger par défaut globales"";
checkSkillsString = "Vérification des compétences non utilisées";
enableRepSkillsString = "Activer le chevauchement";
disableRepSkillsString = "Désactiver le chevauchement";
enableAllString = "Activer tout";
disableAllString = "Désactiver tout";
ignoreEscString = "Ignorer Escape pour fermer la fenêtre principale";
minWindowString = "Utiliser la mini-fenêtre";
fadeWindowString = "Fondu de la vitesse de la fenêtre";

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
mapWindowString = "Destinations";
menuOptionsString = "Options";
moorMapString = "Destinations aux Landes d'Etten";
eriadorMapString = "Destinations en Eriador";
rhovanionMapString = "Destination dans le Rhovanion";
rohanMapString = "Destinations dans le Rohan"
gondorMapString = "Destinations dans le Gondor"
haradwaithMapString = "Destinations dans le Haradwaith"
menuSkillsString = "Vérification des compétences non utilisées";

--[[ travel skills ]] --
--[[ Add all the travel skills ]] --
-- add the data to custom dictionaries to maintain the order
function TravelDictionary:CreateDictionaries()
    -- add the hunter locations
    self.hunter:AddSkill("Retour au campement", "0x7000A2C1", "Retour au campement");
    self.hunter:AddSkill("Guide vers Bree", "0x70003F42", "Bree (Guide)");
    self.hunter:AddSkill("Guide vers le Palais de Thorin", "0x70003F41", "Palais de Thorin (Guide)");
    self.hunter:AddSkill("Guide vers Grand'Cave", "0x7000A2C3", "Grand'Cave (Guide)");
    self.hunter:AddSkill("Guide vers Esteldin", "0x70003F43", "Esteldin (Guide)");
    self.hunter:AddSkill("Guide vers Evendim", "0x7000A2C4", "Evendim (Guide)");
    self.hunter:AddSkill("Guide vers Ost Guruth", "0x7000A2C2", "Ost Guruth (Guide)");
    self.hunter:AddSkill("Guide vers Fondcombe", "0x70003F44", "Fondcombe (Guide)");
    self.hunter:AddSkill("Guide vers Sûri-kylä", "0x70017C82", "Sûri-kylä (Guide)");
    self.hunter:AddSkill("Guide vers l'ouest d'Angmar", "0x7000A2C5", "Angmar ouest (Guide)");
    self.hunter:AddSkill("Guide vers l'est d'Angmar", "0x7000A2C6", "Angmar est (Guide)");
    self.hunter:AddSkill("Guide vers Echad Dunann", "0x70017C81", "Echad Dunann (Guide)");
    self.hunter:AddSkill("Guide vers la vingt et unième salle", "0x70017C7A", "Vingt et unième salle (Guide)");
    self.hunter:AddSkill("Guide vers l'Orée noire", "0x7001F459", "Orée noire (Guide)");
    self.hunter:AddSkill("Guide vers Harndirion", "0x700235EF", "Harndirion (Guide)");
    self.hunter:AddSkill("Guide pour Galtrev", "0x7002A93F", "Galtrev (Guide)");
    self.hunter:AddSkill("Guide vers Stangarde", "0x7002C62C", "Stangarde (Guide)");
    self.hunter:AddSkill("Guide vers Caras Galadhon", "0x7002E754", "Caras Galadhon (Guide)");
    self.hunter:AddSkill("Guide vers les Monts Brumeux", "0x7002E756", "Monts Brumeux (Guide)");
    self.hunter:AddSkill("Guide vers Neigebronne", "0x7003198E", "Neigebronne (Guide)");
    self.hunter:AddSkill("Guide vers Forloi", "0x70036B5D", "Forloi (Guide)");
    self.hunter:AddSkill("Guide vers Aldburg", "0x7003DC71", "Aldburg (Guide)");
    self.hunter:AddSkill("Guide vers le Gouffre de Helm", "0x7003DC72", "Gouffre de Helm (Guide)");
    self.hunter:AddSkill("Guide vers Dol Amroth", "0x70041197", "Dol Amroth (Guide)", "l'Ouest du Gondor");
    self.hunter:AddSkill("Guide pour Arnach", "0x70043A63", "Arnach (Guide)");
    self.hunter:AddSkill("Guide vers Minas Tirith", "0x70044985", "Minas Tirith (Guide)");
    self.hunter:AddSkill("Guide pour se rendre au camp militaire", "0x700459AF", "Camp militaire (Guide)");
    self.hunter:AddSkill("Guide de Minas Tirith après la bataille", "0x70046CBB", "Minas Tirith après la bataille (Guide)");
    self.hunter:AddSkill("Guide vers Henneth Annûn", "0x70047077", "Henneth Annûn (Guide)");
    self.hunter:AddSkill("Guide vers Osgiliath après la bataille", "0x70047074", "Osgiliath après la bataille (Guide)");
    self.hunter:AddSkill("Guide vers le Camp de l'armée", "0x70047BFA", "Camp de l'armée (Guide)");
    self.hunter:AddSkill("Guide vers Haerondir", "0x70047C1D", "Haerondir (Guide)");
    self.hunter:AddSkill("Guide vers le fort d'Udûn", "0x7004AE1E", "Fort d'Udûn (Guide)");
    self.hunter:AddSkill("Guide vers Dale", "0x7004D73B", "Dale (Guide)");
    self.hunter:AddSkill("Guide vers Jarnfast", "0x7004FACC", "Jarnfast (Guide)");
    self.hunter:AddSkill("Guide vers Skarhald", "0x7004FACB", "Skarhald (Guide)");
    self.hunter:AddSkill("Guide pour Beorninghus", "0x70052F07", "Beorninghus (Guide)");
    self.hunter:AddSkill("Guide de Hultvis", "0x70052F08", "Hultvis (Guide)");
    self.hunter:AddSkill("Guide vers Estolad Lân", "0x700551F4", "Estolad Lân (Guide)");
    self.hunter:AddSkill("Guide de Limlok", "0x7005762D", "Limlok (Guide)");
    self.hunter:AddSkill("Guide vers Annâk-khurfu", "0x70058571", "Annâk-khurfu (Guide)");
    self.hunter:AddSkill("Guide vers le Quai des marchands", "0x70059D0C", "Quai des marchands (Guide)");
    self.hunter:AddSkill("Guide vers Pont-à-Tréteaux", "0x70059D16", "Pont-à-Tréteaux (Guide)");
    self.hunter:AddSkill("Guide vers Akrâz-zahar", "0x7005AA91", "Akrâz-zahar (Guide)");
    self.hunter:AddSkill("Guide vers Azanulbizar", "0x7005AA95", "Azanulbizar (Guide)");
    self.hunter:AddSkill("Guide vers la Porte Noble", "0x7005D487", "Porte Noble (Guide)");
    self.hunter:AddSkill("Guide vers Leitstath", "0x7005D47D", "Leitstath (Guide)");
    self.hunter:AddSkill("Guide vers Tornhad", "0x70060EA6", "Tornhad (Guide)");
    self.hunter:AddSkill("Guide vers Bourdeneuve", "0x7006133F", "Bourdeneuve (Guide)");
    self.hunter:AddSkill("Guide vers Andrath", "0x7006323C", "Andrath (Guide)");
    self.hunter:AddSkill("Guide vers les Noues des cygnes", "0x700634AA", "Noues des cygnes (Guide)");
    self.hunter:AddSkill("Guide vers le Cardolan", "0x700634A7", "Cardolan (Guide)");
    self.hunter:AddSkill("Guide vers Carn Dûm", "0x70064AC8", "Carn Dûm (Guide)");
    self.hunter:AddSkill("Guide vers Clegur", "0x70064F4C", "Clegur (Guide)");
    self.hunter:AddSkill("Guide vers Pelargir", "0x700658EA", "Pelargir (Guide)");
    self.hunter:AddSkill("Guide vers Dol Amroth", "0x70068711", "Dol Amroth royal (Guide U38)", "le Gondor royal");
    self.hunter:AddSkill("Guide vers Halrax", "0x70068713", "Halrax (Guide)");
    self.hunter:AddSkill("Guide vers Lond Cirion", "0x70068717", "Lond Cirion (Guide)");
    self.hunter:AddSkill("Guide vers Umbar", "0x70068718", "Umbar (Guide)");
    self.hunter:AddSkill("Guide vers Jax Phanâl", "0x70068719", "Jax Phanâl (Guide)");
    self.hunter:AddSkill("Guide vers la taverne de l'Aigle sanglant", "0x700697EF", "Taverne de l'Aigle sanglant (Guide)");

    -- add the Warden locations
    self.warden:AddSkill("Rassemblement : Ost Guruth", "0x70014786", "Ost Guruth (Rassemblement)");
    self.warden:AddSkill("Rassemblement : Esteldin", "0x70014798", "Esteldin (Rassemblement)");
    self.warden:AddSkill("Rassemblement : La région d'Evendim", "0x7001478E", "Evendim (Rassemblement)");
    self.warden:AddSkill("Rassemblement : Fondcombe", "0x70014791", "Fondcombe (Rassemblement)");
    self.warden:AddSkill("Rassemblement : Sûri-kylä", "0x700237D4", "Sûri-kylä (Rassemblement)");
    self.warden:AddSkill("Rassemblement : La vingt et unième salle", "0x7001819E", "Vingt et unième salle (Rassemblement)");
    self.warden:AddSkill("Rassemblement : L'Orée noire", "0x7001F45C", "Orée noire (Rassemblement)");
    self.warden:AddSkill("Rassemblement : Harndirion", "0x700235EB", "Harndirion (Rassemblement)");
    self.warden:AddSkill("Rassemblement : Galtrev", "0x7002A90A", "Galtrev (Rassemblement)");
    self.warden:AddSkill("Rassemblement : Stangarde", "0x7002C646", "Stangarde (Rassemblement)");
    self.warden:AddSkill("Rassemblement : Caras Galadhon", "0x700303DF", "Caras Galadhon (Rassemblement)");
    self.warden:AddSkill("Rassemblement : Les Monts Brumeux", "0x700303DD", "Monts Brumeux (Rassemblement)");
    self.warden:AddSkill("Rassemblement : Neigebronne", "0x7003198D", "Neigebronne (Rassemblement)");
    self.warden:AddSkill("Rassemblement : Forloi", "0x70036B5B", "Forloi (Rassemblement)");
    self.warden:AddSkill("Rassemblement : Aldburg", "0x7003DC7A", "Aldburg (Rassemblement)");
    self.warden:AddSkill("Rassemblement : Gouffre de Helm", "0x7003DC79", "Gouffre de Helm (Rassemblement)");
    self.warden:AddSkill("Rassemblement : Dol Amroth", "0x70041198", "Dol Amroth (Rassemblement)", "l'Ouest du Gondor");
    self.warden:AddSkill("Rassemblement : Arnach", "0x70043A66", "Arnach (Rassemblement)");
    self.warden:AddSkill("Rassemblement : Minas Tirith", "0x70044982", "Minas Tirith (Rassemblement)");
    self.warden:AddSkill("Rassemblement : Camp militaire", "0x700459AA", "Camp militaire (Rassemblement)");
    self.warden:AddSkill("Rassemblement : Minas Tirith après la bataille", "0x70046CBF", "Minas Tirith après la bataille (Rassemblement)");
    self.warden:AddSkill("Rassemblement : Henneth Annûn", "0x70047075", "Henneth Annûn (Rassemblement)");
    self.warden:AddSkill("Rassemblement : Osgiliath après la bataille", "0x70047076", "Osgiliath après la bataille (Rassemblement)");
    self.warden:AddSkill("Rassemblement : Camp de l'armée", "0x70047BFC", "Camp de l'armée (Rassemblement)");
    self.warden:AddSkill("Rassemblement : Haerondir", "0x70047C23", "Haerondir (Rassemblement)");
    self.warden:AddSkill("Rassemblement : Le fort d'Udûn", "0x7004AE1F", "Fort d'Udûn (Rassemblement)");
    self.warden:AddSkill("Rassemblement : Dale", "0x7004D73A", "Dale (Rassemblement)");
    self.warden:AddSkill("Rassemblement : Jarnfast", "0x7004FACA", "Jarnfast (Rassemblement)");
    self.warden:AddSkill("Rassemblement : Skarhald", "0x7004FACD", "Skarhald (Rassemblement)");
    self.warden:AddSkill("Rassemblement : Beorninghus", "0x70052F0A", "Beorninghus (Rassemblement)");
    self.warden:AddSkill("Rassemblement : Hultvis", "0x70052F06", "Hultvis (Rassemblement)");
    self.warden:AddSkill("Rassemblement : Estolad Lân", "0x700551F2", "Estolad Lân (Rassemblement)");
    self.warden:AddSkill("Rassemblement : Limlok", "0x70057635", "Limlok (Rassemblement)");
    self.warden:AddSkill("Rassemblement : Annâk-khurfu", "0x70058572", "Annâk-khurfu (Rassemblement)");
    self.warden:AddSkill("Rassemblement : Quai des marchands", "0x70059D09", "Quai des marchands (Rassemblement)");
    self.warden:AddSkill("Rassemblement : Pont-à-Tréteaux", "0x70059D10", "Pont-à-Tréteaux (Rassemblement)");
    self.warden:AddSkill("Rassemblement : Akrâz-zahar", "0x7005AA8F", "Akrâz-zahar (Rassemblement)");
    self.warden:AddSkill("Rassemblement : Azanulbizar", "0x7005AA8C", "Azanulbizar (Rassemblement)");
    self.warden:AddSkill("Rassemblement : La Porte Noble", "0x7005D48A", "Porte Noble (Rassemblement)");
    self.warden:AddSkill("Rassemblement : Leitstath", "0x7005D488", "Leitstath (Rassemblement)");
    self.warden:AddSkill("Retour à Tornhad", "0x70060EA5", "Tornhad (Rassemblement)");
    self.warden:AddSkill("Rassemblement à Bourdeneuve", "0x7006133E", "Bourdeneuve (Rassemblement)");
    self.warden:AddSkill("Rassemblement à Andrath", "0x70063242", "Andrath (Rassemblement)");
    self.warden:AddSkill("Rassemblement aux Noues des cygnes", "0x700634B6", "Noues des cygnes (Rassemblement)");
    self.warden:AddSkill("Rassemblement au Cardolan", "0x700634AD", "Cardolan (Rassemblement)");
    self.warden:AddSkill("Rassemblement : Carn Dûm", "0x70064ACB", "Carn Dûm (Rassemblement)");
    self.warden:AddSkill("Rassemblement à Clegur", "0x70064F4D", "Clegur (Rassemblement)");
    self.warden:AddSkill("Rassemblement à Pelargir", "0x700658E8", "Pelargir (Rassemblement)");
    self.warden:AddSkill("Rassemblement à Jax Phanâl","0x7006870C", "Jax Phanâl (Rassemblement)");
    self.warden:AddSkill("Rassemblement à Umbar","0x7006870F","Umbar (Rassemblement)");
    self.warden:AddSkill("Rassemblement à Halrax","0x70068710", "Halrax (Rassemblement)");
    self.warden:AddSkill("Rassemblement à Dol Amroth","0x70068712", "Dol Amroth royal (Rassemblement)", "le Gondor royal");
    self.warden:AddSkill("Rassemblement à Lond Cirion","0x70068715", "Lond Cirion (Rassemblement)");
    self.warden:AddSkill("Rassemblement à la taverne de l'Aigle sanglant","0x700697F3", "Taverne de l'Aigle sanglant (Rassemblement)");

    -- add the Mariner locations
    self.mariner:AddSkill("Naviguer vers Celondim", "0x70066100", "Celondim (Naviguer)")
    self.mariner:AddSkill("Naviguer vers les Terres brunes", "0x70066101", "Terres brunes (Naviguer)")
    self.mariner:AddSkill("Naviguer vers le Quai des marchands", "0x70066105", "Quai des marchands (Naviguer)")
    self.mariner:AddSkill("Naviguer vers Osgiliath après la bataille", "0x70066109", "Osgiliath après la bataille (Naviguer)")
    self.mariner:AddSkill("Cap sur la Ville du Lac", "0x7006610C", "Ville du Lac (Naviguer)")
    self.mariner:AddSkill("Naviguer vers l'Orée Noire", "0x7006610E", "Orée Noire (Naviguer)")
    self.mariner:AddSkill("Naviguer vers Tinnudir", "0x7006610F", "Tinnudir (Naviguer)")
    self.mariner:AddSkill("Naviguer vers Dol Amroth", "0x70066117", "Dol Amroth (Naviguer)", "Dol Amroth en bonne compagnie.")
    self.mariner:AddSkill("Naviguer vers le Pays de Bouc", "0x7006611A", "Pays de Bouc (Naviguer)")
    self.mariner:AddSkill("Naviguer vers Pelargir", "0x7006611B", "Pelargir (Naviguer)")
    self.mariner:AddSkill("Naviguer vers Sûri-kylä", "0x7006611C", "Sûri-kylä (Naviguer)")
    self.mariner:AddSkill("Naviguer vers la Lothlorien", "0x7006611E", "Lothlorien (Naviguer)")
    self.mariner:AddSkill("Naviguer vers le Gué de Sarn", "0x70066120", "le Gué de Sarn (Naviguer)")
    self.mariner:AddSkill("Naviguer vers Neigebronne", "0x70066121", "Neigebronne (Naviguer)")
    self.mariner:AddSkill("Naviguer vers Umbar", "0x700687BB", "Umbar (Naviguer)");
    self.mariner:AddSkill("Naviguer vers Lond Cirion", "0x700687BD", "Lond Cirion (Naviguer)");
    self.mariner:AddSkill("Naviguer vers Jax Phanâl", "0x700687C0", "Jax Phanâl (Naviguer)");
    self.mariner:AddSkill("Naviguer vers Dol Amroth", "0x700687C1", "Dol Amroth royal (Naviguer)", "le Gondor royal");
    self.mariner:AddSkill("Naviguer vers Halrax", "0x700687C3", "Halrax (Naviguer)");

    -- add the racial travel skills
    self.allRaces:AddSkill("Retour à Bree", "0x700062F6", "Bree (Race)", "Permet de retourner");
    self.allRaces:AddSkill("Retournez dans la Comté", "0x700062C8", "Comté (Race)");
    self.allRaces:AddSkill("Retour : Porte de Thorin", "0x70006346", "Porte de Thorin (Race)", "Ceci vous permet de retourner");
    self.allRaces:AddSkill("Retour à Fondcombe", "0x7000631F", "Fondcombe (Race)", "Ceci vous permet de retourner");
    self.allRaces:AddSkill("Retour à la maison", "0x70041A22", "Maison Beorning (Race)");
    self.allRaces:AddSkill("Voyage vers Caras Galadhon, en Lothlórien", "0x70048C8C", "Caras Galadhon (Race)");
    self.allRaces:AddSkill("Aller au Palais de Thorin", "0x70053C0F", "Palais de Thorin (Race)");
    self.allRaces:AddSkill("Retour à Lyndelby", "0x70066d31", "Lyndelby (Race)") -- river hobbit

    -- add the Return Home and housing skills
    self.gen:AddSkill("Retour à la maison",    "0x700256BA", "Point de repère 1");
    self.gen:AddSkill("Retour à la maison 2",  "0x70025792", "Point de repère 2");
    self.gen:AddSkill("Retour à la maison 3",  "0x70025793", "Point de repère 3");
    self.gen:AddSkill("Retour à la maison 4",  "0x70025794", "Point de repère 4");
    self.gen:AddSkill("Retour à la maison 5",  "0x70025795", "Point de repère 5");
    self.gen:AddSkill("Retour à la maison 6",  "0x70025796", "Point de repère 6");
    self.gen:AddSkill("Retour à la maison 7",  "0x7002FF62", "Point de repère 7");
    self.gen:AddSkill("Retour à la maison 8",  "0x7002FF61", "Point de repère 8");
    self.gen:AddSkill("Retour à la maison 9",  "0x7002FF60", "Point de repère 9");
    self.gen:AddSkill("Retour à la maison 10", "0x7002FF5F", "Point de repère 10");
    self.gen:AddSkill("Retour à la maison 11", "0x7002FF63", "Point de repère 11");
    self.gen:AddSkill("Retour à la maison personnelle", "0x7000D046", "Maison personnelle");
    self.gen:AddSkill("Aller à une maison premium", "0x70046EE4", "Maison premium");
    self.gen:AddSkill("Retour à la maison de confrérie", "0x7000D047", "Maison de confrérie");
    self.gen:AddSkill("Retour à la maison d'un membre de confrérie", "0x70057C36", "Maison d'un membre de confrérie");

    -- add the obtainable travel skills
    self.rep:AddSkill("Retour : Porte de Thorin", "0x7001BF91", "Porte de Thorin (Rep/Shop)", "Grâce à l'amitié qui vous");
    self.rep:AddSkill("Retour à Bree", "0x7001BF90", "Retour à Bree (Rep/Shop)", "Grâce à votre amitié");
    self.rep:AddSkill("Retour au Marché de Lalia", "0x700364B1", "Retour au Marché de Lalia (Mithril)");
    self.rep:AddSkill("Retour à Grand'Cave", "0x70023262", "Retour à Grand'Cave (Shop)");
    self.rep:AddSkill("Retour à Fondcombe", "0x70023263", "Retour à Fondcombe (Shop)", "Grâce à votre amitié avec");
    self.rep:AddSkill("Retournez à Ost Guruth", "0x70020441", "Retournez à Ost Guruth (Rep)");
    self.rep:AddSkill("Retour dans la Forêt Noire", "0x7001F374", "Retour dans la Forêt Noire (Rep)");
    self.rep:AddSkill("Retour en Enedwaith", "0x70021FA2", "Retour en Enedwaith (Rep)");
    self.rep:AddSkill("Retour à Galtrev", "0x7002C647", "Retour à Galtrev (Rep)");
    self.rep:AddSkill("Retour à Stangarde", "0x7002C65D", "Retour à Stangarde (Rep)");
    self.rep:AddSkill("Retourner à Neigebronne", "0x70031A46", "Retourner à Neigebronne (Rep)");
    self.rep:AddSkill("Retour à Forloi", "0x70036B5E", "Retour à Forloi (Rep)");
    self.rep:AddSkill("Retour à Aldburg", "0x7003DC81", "Aldburg (Rep)");
    self.rep:AddSkill("Retour à Derunant", "0x7004128F", "Derunant (Rep)");
    self.rep:AddSkill("Retour au Gouffre de Helm", "0x7003DC82", "Gouffre de Helm(Rep)");
    self.rep:AddSkill("Retour à Dol Amroth", "0x700411AC", "Dol Amroth (Rep)", "l'Ouest du Gondor");
    self.rep:AddSkill("Retournez à Arnach", "0x70043A6A", "Arnach (Rep)");
    self.rep:AddSkill("Retour à Minas Tirith", "0x7004497E", "Retour à Minas Tirith (Rep)");
    self.rep:AddSkill("Retour au camp militaire", "0x700459A9", "Camp militaire (Rep)");
    self.rep:AddSkill("Retour à Minas Tirith après la bataille", "0x70046CC0", "Minas Tirith après la bataille (Rep)");
    self.rep:AddSkill("Retour à Henneth Annûn", "0x70047080", "Henneth Annûn (Rep)");
    self.rep:AddSkill("Retour à Osgiliath après la bataille", "0x7004707D", "Osgiliath après la bataille (Rep)");
    self.rep:AddSkill("Retour au Camp de l'armée", "0x70047BF4", "Camp de l'armée (Rep)");
    self.rep:AddSkill("Retour à Haerondir", "0x70047C1B", "Haerondir (Rep)");
    self.rep:AddSkill("Retour au fort d'Udûn", "0x7004AE1D", "Fort d'Udûn (Rep)");
    self.rep:AddSkill("Voyager jusqu'à la Cour de Lothlórien", "0x7004B8C2", "Cour de Lothlórien (Rep)");
    self.rep:AddSkill("Voyager jusqu'au Palais du roi", "0x7004B8C3", "Palais du roi (Rep)");
    self.rep:AddSkill("Voyager jusqu'au Palais sous la Montagne", "0x7004B8C4", "Palais sous la Montagne (Rep)");
    self.rep:AddSkill("Voyager jusqu'à Bâr Thorenion", "0x7004B8C5", "Bâr Thorenion (Rep)");
    self.rep:AddSkill("Revenir à Dale", "0x7004D738", "Dale (Rep)");
    self.rep:AddSkill("Revenir à Jarnfast", "0x7004FAC3", "Jarnfast (Rep)");
    self.rep:AddSkill("Revenir à Skarhald", "0x7004FAC5", "Skarhald (Rep)");
    self.rep:AddSkill("Retournez auprès de Beorninghus", "0x70052F12", "Beorninghus (Rep)");
    self.rep:AddSkill("Retournez auprès de Hultvis", "0x70052F04", "Hultvis (Rep)");
    self.rep:AddSkill("Retour à Estolad Lân", "0x700551F8", "Estolad Lân (Rep)");
    self.rep:AddSkill("Retour à Limlok", "0x70057629", "Limlok (Rep)");
    self.rep:AddSkill("Retournez à Annâk-khurfu", "0x7005856F", "Annâk-khurfu (Rep)");
    self.rep:AddSkill("Retournez au Quai des marchands", "0x70059D0E", "Quai des marchands (Rep)");
    self.rep:AddSkill("Retournez à Pont-à-Tréteaux", "0x70059D12", "Pont-à-Tréteaux (Rep)");
    self.rep:AddSkill("Retour à Akrâz-zahar", "0x7005AA90", "Akrâz-zahar (Rep)");
    self.rep:AddSkill("Retour à Azanulbizar", "0x7005AA92", "Azanulbizar (Rep)");
    self.rep:AddSkill("Voyage jusqu'à la Grande salle de Vérnozal", "0x7005A596", "Vérnozal (Quête)");
    self.rep:AddSkill("Retourner à la Porte Noble", "0x7005D47C", "Porte Noble (Rep)");
    self.rep:AddSkill("Retourner à Leitstath", "0x7005D484", "Leitstath (Rep)");
    self.rep:AddSkill("Retournez voir Tornhad", "0x70060EA8", "Tornhad (Rep)");
    self.rep:AddSkill("Retour à Bourdeneuve", "0x70061340", "Bourdeneuve (Rep)");
    self.rep:AddSkill("Retour à Andrath", "0x7006323D", "Andrath (Rep)");
    self.rep:AddSkill("Retour aux Noues des cygnes", "0x700634A4", "Noues des cygnes (Rep)");
    self.rep:AddSkill("Retour au Cardolan", "0x700634AE", "Cardolan (Rep)");
    self.rep:AddSkill("Retour aux Archives de gravures de Fondcombe", "0x700634A5", "Archives de gravures (Delving)");
    self.rep:AddSkill("Retour à Carn Dûm", "0x70064ACA", " Carn Dûm (Rep)");
    self.rep:AddSkill("Retournez voir Clegur", "0x70064F47", "Clegur (Rep)");
    self.rep:AddSkill("Retour à Glân Vraig", "0x7005B38E", "Glân Vraig (Quête)");
    self.rep:AddSkill("Retournez à Pelargir", "0x700658EB", "Pelargir (Rep)");
    self.rep:AddSkill("Voyager vers l'Ordre de l'Aigle", "0x700686FE", "L'Ordre de l'Aigle (Rep)");
    self.rep:AddSkill("Retour à Umbar", "0x700686FF", "Umbar (Rep)");
    self.rep:AddSkill("Retour à Dol Amroth", "0x70068700", "Dol Amroth royal (Rep U38)", "le Gondor royal");
    self.rep:AddSkill("Retour à Jax Phanâl", "0x70068701", "Jax Phanâl (Rep)");
    self.rep:AddSkill("Retournez voir Halrax", "0x70068702", "Halrax (Rep)");
    self.rep:AddSkill("Retour à Lond Cirion", "0x70068703", "Lond Cirion (Rep)");
    self.rep:AddSkill("Voyager vers les Gardiens des écrits", "0x70068704", "Gardiens des écrits (Rep)");
    self.rep:AddSkill("Retour à la taverne de l'Aigle Sanglant", "0x700697F2", "Taverne de l'Aigle Sanglant (Rep)");

    -- monster player maps
    self.creep:AddSkill("Carte grossière pour aller au Pied de Gram", "0x70028BBC");
    self.creep:AddSkill("Carte pour aller au Pied de Gram", "0x70028BC1");
    self.creep:AddSkill("Carte grossière pour aller au Gouffre d'Isen", "0x70028BB3");
    self.creep:AddSkill("Carte grossière pour aller à Tol Ascarnen", "0x70028BB6");
    self.creep:AddSkill("Carte grossière pour aller à Lugazag", "0x70028BB7");
    self.creep:AddSkill("Carte grossière pour aller à Tirith Rhaw", "0x70028BBE");
    self.creep:AddSkill("Carte grossière pour aller au Bois Funeste", "0x70028BBF");
    self.creep:AddSkill("Piètre carte pour aller au Gouffre d'Isen", "0x70028BAF");
    self.creep:AddSkill("Piètre carte pour aller à Tol Ascarnen", "0x70028BB1");
    self.creep:AddSkill("Piètre carte pour aller à Lugazag", "0x70028BB2");
    self.creep:AddSkill("Piètre carte pour aller à Tirith Rhaw", "0x70028BB4");
    self.creep:AddSkill("Piètre carte pour aller au Bois Funeste", "0x70028BB9");
    self.creep:AddSkill("Bonne carte pour aller au Gouffre d'Isen", "0x70028BC0");
    self.creep:AddSkill("Bonne carte pour aller à Tol Ascarnen", "0x70028BC2");
    self.creep:AddSkill("Bonne carte pour aller à Lugazag", "0x70028BB5");
    self.creep:AddSkill("Bonne carte pour aller à Tirith Rhaw", "0x70028BB0");
    self.creep:AddSkill("Bonne carte pour aller au Bois Funeste", "0x70028BBD");
end
