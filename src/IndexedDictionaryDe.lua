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
resetOrderString = "Deine Sortiereinstellungen wurden aufgrund einer Änderung der Anzahl " ..
"der zu speichernden Elemente zurückgesetzt. Dies sollte nur einmal passieren.\n" ..
"Entschuldige die Unannehmlichkeiten.";

resetEnabledString = "Deine ausgewählten Fertigkeiten wurden aufgrund einer Änderung der Anzahl " ..
"der zu speichernden Elemente zurückgesetzt. Dies sollte nur einmal passieren.\n" ..
"Entschuldige die Unannehmlichkeiten.";

skillNotTrainedString = "Nicht erlernter Fertigkeit: ";

-- options window strings
generalTabString = "Allgemein";
selectTabString = "Auswahl";
sortTabString = "Sortierung";
hideString = "Verstecke Fenster beim Start";
toggleString = "Zeige An/Aus-Knopf";
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
toggleSlidersString = "An/Aus-Knopf Transparenz";
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
menuSkillsString = "Nicht erlernte Fertigkeiten prüfen";

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
    hunterLocations:AddSkill("Zurück zum Lager", "0x7000A2C1", "Zurück zum Lager");
    hunterLocations:AddSkill("Führer nach Bree", "0x70003F42", "Bree (Führer)");
    hunterLocations:AddSkill("Führer zu Thorins Halle", "0x70003F41", "Thorins Halle (Führer)");
    hunterLocations:AddSkill("Führer nach Michelbinge", "0x7000A2C3", "Michelbinge (Führer)");
    hunterLocations:AddSkill("Führer nach Esteldín", "0x70003F43", "Esteldín (Führer)");
    hunterLocations:AddSkill("Führer nach Evendim", "0x7000A2C4", "Evendim  (Führer)");
    hunterLocations:AddSkill("Führer zur Feste Guruth", "0x7000A2C2", "Feste Guruth (Führer)");
    hunterLocations:AddSkill("Führer nach Bruchtal", "0x70003F44", "Bruchtal (Führer)");
    hunterLocations:AddSkill("Führer nach Sûri-kylä", "0x70017C82", "Sûri-kylä (Führer)");
    hunterLocations:AddSkill("Führer in das westliche Angmar", "0x7000A2C5", "West-Angmar (Führer)");
    hunterLocations:AddSkill("Führer nach Ost-Angmar", "0x7000A2C6", "Ost-Angmar (Führer)");
    hunterLocations:AddSkill("Führer nach Echad Dúnann", "0x70017C81", "Echad Dúnann (Führer)");
    hunterLocations:AddSkill("Führer zur Einundzwanzigsten Halle", "0x70017C7A", "Einundzwanzigste Halle (Führer)");
    hunterLocations:AddSkill("Führer zur Dunkelsenke", "0x7001F459", "Dunkelsenke (Führer)");
    hunterLocations:AddSkill("Führer nach Harndirion", "0x700235EF", "Harndirion (Führer)");
    hunterLocations:AddSkill("Führer nach Galtrev", "0x7002A93F", "Galtrev (Führer)");
    hunterLocations:AddSkill("Führer nach Stangard", "0x7002C62C", "Stangard (Führer)");
    hunterLocations:AddSkill("Führer nach Caras Galadhon", "0x7002E754", "Caras Galadhon (Führer)");
    hunterLocations:AddSkill("Führer ins Nebelgebirge", "0x7002E756", "Nebelgebirge (Führer)");
    hunterLocations:AddSkill("Führer nach Schneegrenze", "0x7003198E", "Schneegrenze (Führer)");
    hunterLocations:AddSkill("Führer nach Forlach", "0x70036B5D", "Forlach (Führer)");
    hunterLocations:AddSkill("Führer nach Aldburg", "0x7003DC71", "Aldburg (Führer)");
    hunterLocations:AddSkill("Führer nach Helms Klamm", "0x7003DC72", "Helms Klamm (Führer)");
    hunterLocations:AddSkill("Führer nach Dol Amroth", "0x70041197", "Dol Amroth (Führer)");
    hunterLocations:AddSkill("Führer nach Arnach", "0x70043A63", "Arnach (Führer)");
    hunterLocations:AddSkill("Führer nach Minas Tirith", "0x70044985", "Minas Tirith (Führer)");
    hunterLocations:AddSkill("Führer zum Kriegslager der Rohirrim", "0x700459AF", "Kriegslager der Rohirrim (Führer)");
    hunterLocations:AddSkill("Führer zum schlachtgezeichneten Minas Tirith", "0x70046CBB", "Minas Tirith nach der Schlacht (Führer)");
    hunterLocations:AddSkill("Führer zu Henneth Annûn", "0x70047077", "Henneth Annûn (Führer)");
    hunterLocations:AddSkill("Führer zum schlachtgezeichneten Osgiliath", "0x70047074", "Osgiliath nach der Schlacht (Führer)");
    hunterLocations:AddSkill("Führer zum Lager des Heeres", "0x70047BFA", "Lager des Heeres (Führer)");
    hunterLocations:AddSkill("Führer nach Haerondir", "0x70047C1D", "Haerondir (Führer)");
    hunterLocations:AddSkill("Führer zum Udûn-Brückenkopf", "0x7004AE1E", "Udûn-Brückenkopf (Führer)");
	hunterLocations:AddSkill("Führer nach Thal", "0x7004D73B", "Thal (Führer)");
	hunterLocations:AddSkill("Führer nach Járnfast", "0x7004FACC", "Járnfast (Führer)");
    hunterLocations:AddSkill("Führer nach Skarháld", "0x7004facb", "Skarháld (Führer)");
	hunterLocations:AddSkill("Führer nach Beorningerhús", "0x70052F07", "Beorningerhús (Führer)");
    hunterLocations:AddSkill("Leitfaden für Hultvís", "0x70052F08", "Hultvís (Führer)");
    hunterLocations:AddSkill("Führer nach Estolad Lân", "0x700551F4", "Estolad Lân (Führer)");
    hunterLocations:AddSkill("Führer nach Limlók", "0x7005762d", "Limlók (Führer)");
    hunterLocations:AddSkill("Führer nach Annâk-khurfu", "0x70058571", "Annâk-khurfu (Führer)");

    wardenLocations:AddSkill("Appell in der Feste Guruth", "0x70014786", "Feste Guruth (Appell)");
    wardenLocations:AddSkill("Appell in Esteldín", "0x70014798", "Esteldín (Appell)");
    wardenLocations:AddSkill("Appell in Evendim", "0x7001478E", "Evendim (Appell)");
    wardenLocations:AddSkill("Appell in Bruchtal", "0x70014791", "Bruchtal (Appell)");
    wardenLocations:AddSkill("Appell in Sûri-kylä", "0x700237D4", "Sûri-kylä (Appell)");
    wardenLocations:AddSkill("Appell in der Einundzwanzigsten Halle", "0x7001819E", "21. Halle (Appell)");
    wardenLocations:AddSkill("Appell in der Dunkelsenke", "0x7001F45C", "Dunkelsenke (Appell)");
    wardenLocations:AddSkill("Appell in Harndirion", "0x700235EB", "Harndirion (Appell)");
    wardenLocations:AddSkill("Appell in Galtrev", "0x7002A90A", "Galtrev (Appell)");
    wardenLocations:AddSkill("Appell in Stangard", "0x7002C646", "Stangard (Appell)");
    wardenLocations:AddSkill("Appell in Caras Galadhon", "0x700303DF", "Caras Galadhon (Appell)");
    wardenLocations:AddSkill("Appell im Nebelgebirge", "0x700303DD", "Nebelgebirge (Appell)");
    wardenLocations:AddSkill("Appell in Schneegrenze", "0x7003198D", "Schneegrenze (Appell)");
    wardenLocations:AddSkill("Appell in Forlach", "0x70036B5B", "Forlach (Appell)");
    wardenLocations:AddSkill("Appell in Aldburg", "0x7003DC7A", "Aldburg (Appell)");
    wardenLocations:AddSkill("Appell in Helms Klamm", "0x7003DC79", "Helms Klamm (Appell)");
    wardenLocations:AddSkill("Appell in Dol Amroth", "0x70041198", "Dol Amroth (Appell)");
    wardenLocations:AddSkill("Appell in Arnach", "0x70043A66", "Arnach (Appell)");
    wardenLocations:AddSkill("Appell in Minas Tirith", "0x70044982", "Minas Tirith (Appell)");
    wardenLocations:AddSkill("Appell im Kriegslager", "0x700459AA", "Kriegslager der Rohirrim (Appell)");
    wardenLocations:AddSkill("Appell im schlachtgezeichneten Minas Tirith", "0x70046CBF", "Minas Tirith nach der Schlacht (Appell)");
    wardenLocations:AddSkill("Appell in Henneth Annûn", "0x70047075", "Henneth Annûn (Appell)");
    wardenLocations:AddSkill("Appell im schlachtgezeichneten Osgiliath", "0x70047076", "Osgiliath nach der Schlacht (Appell)");
    wardenLocations:AddSkill("Appell im Lager des Heeres", "0x70047BFC", "Lager des Heeres (Appell)");
    wardenLocations:AddSkill("Appell in Haerondir", "0x70047C23", "Haerondir (Appell)");
    wardenLocations:AddSkill("Appell im Udûn-Brückenkopf", "0x7004AE1F", "Udûn-Brückenkopf (Appell)");
    wardenLocations:AddSkill("Appell in Thal", "0x7004d73a", "Thal (Appell)");
	wardenLocations:AddSkill("Musterung in Járnfast", "0x7004FACA", "Jarnfast (Appell)");
    wardenLocations:AddSkill("Musterung in Skarháld", "0x7004FACD",  "Skarhald (Appell)");
	wardenLocations:AddSkill("Appell im Beorningerhús", "0x70052F0A", "Beorningerhús (Appell)");
    wardenLocations:AddSkill("Appell in Hultvís", "0x70052F06", "Hultvís (Appell)");
    wardenLocations:AddSkill("Appell in Estolad Lân", "0x700551F2", "Estolad Lân (Appell)");
	wardenLocations:AddSkill("Appell in Limlók", "0x70057635", "Limlók (Appell)");
    wardenLocations:AddSkill("Appell in Annâk-khurfu", "0x70058572", "Annâk-khurfu (Appell)");

    racialLocations:AddSkill("Rückkehr nach Bree", "0x700062F6", "Bree (Rasse)");
    racialLocations:AddSkill("Rückkehr ins Auenland", "0x700062C8", "Michelbinge (Rasse)");
    racialLocations:AddSkill("Rückkehr zu Thorins Tor", "0x70006346", "Thorins Tor (Rasse Zwerg)");
    racialLocations:AddSkill("Rückkehr nach Bruchtal", "0x7000631F", "Bruchtal (Rasse)");
    racialLocations:AddSkill("Zum 1. Heim zurückkehren", "0x70041A22", "Grimbeorns Hütte (Rasse)");
    racialLocations:AddSkill("Reise nach Caras Galadhon in Lothlórien", "0x70048C8C", "Caras Galadhon (Rasse)");
    racialLocations:AddSkill("Reise zu Thorins Halle", "0x70053C0F", "Thorins Halle (Rasse Starkaxt)");

    genLocations:AddSkill("Zum 1. Heim zurückkehren", "0x700256BA", "1. Markstein");
    genLocations:AddSkill("Zum 2. Heim zurückkehren", "0x70025792", "2. Markstein");
    genLocations:AddSkill("Zum 3. Heim zurückkehren", "0x70025793", "3. Markstein");
    genLocations:AddSkill("Zum 4. Heim zurückkehren", "0x70025794", "4. Markstein");
    genLocations:AddSkill("Zum 5. Heim zurückkehren", "0x70025795", "5. Markstein");
    genLocations:AddSkill("Zum 6. Heim zurückkehren", "0x70025796", "6. Markstein");
    genLocations:AddSkill("Zum 7. Heim zurückkehren", "0x7002FF5F", "7. Markstein");
    genLocations:AddSkill("Zum 8. Heim zurückkehren", "0x7002FF60", "8. Markstein");
    genLocations:AddSkill("Zum 9. Heim zurückkehren", "0x7002FF61", "9. Markstein");
    genLocations:AddSkill("Zum 10. Heim zurückkehren", "0x7002FF62", "10. Markstein");
    genLocations:AddSkill("Zum 11. Heim zurückkehren", "0x7002FF63", "11. Markstein");
    genLocations:AddSkill("Reist zu Eurem eigenen Heim", "0x7000D046", "Eigenes Heim");
    genLocations:AddSkill("Reist zu Eurem Premiumheim", "0x70046EE4", "Premiumheim");
    genLocations:AddSkill("Reist zum Haus Eurer Sippe", "0x7000D047", "Heim Eurer Sippe");
    genLocations:AddSkill("Zum Haus des Sippenmitglieds reisen", "0x70057C36", "Heim des Sippenmitglieds");

    repLocations:AddSkill("Rückkehr zu Thorins Tor", "0x7001BF91", "Thorins Tor (Ruf)");
    repLocations:AddSkill("Rückkehr nach Bree", "0x7001BF90", "Bree (Ruf)");
    repLocations:AddSkill("Kehrt zu Lalias Markt zurück", "0x700364B1", "Lalias Markt (Mithril)");
    repLocations:AddSkill("Rückkehr nach Michelbinge", "0x70023262", "Michelbinge (Shop)");
    repLocations:AddSkill("Rückkehr nach Bruchtal", "0x70023263", "Bruchtal (Shop)");
    repLocations:AddSkill("Rückkehr zur Feste Guruth", "0x70020441", "Feste Guruth (Ruf)");
    repLocations:AddSkill("Rückkehr zum Düsterwald", "0x7001F374", "Düsterwald (Ruf)");
    repLocations:AddSkill("Rückkehr nach Enedwaith", "0x70021FA2", "Enedwaith (Ruf)");
    repLocations:AddSkill("Kehrt nach Galtrev zurück", "0x7002C647", "Galtrev (Ruf)");
    repLocations:AddSkill("Kehrt nach Stangard zurück", "0x7002C65D", "Stangard (Ruf)");
    repLocations:AddSkill("Kehrt nach Schneegrenze zurück", "0x70031A46", "Schneegrenze (Ruf)");
    repLocations:AddSkill("Rückkehr nach Forlach", "0x70036B5E", "Forlach (Ruf)");
    repLocations:AddSkill("Kehrt nach Aldburg zurück", "0x7003DC81", "Aldburg (Ruf)");
    repLocations:AddSkill("Rückkehr ins Geheimnistal", "0x7004128F", "Geheimnistal (Ruf)");
    repLocations:AddSkill("Kehrt nach Helms Klamm zurück", "0x7003DC82", "Helms Klamm (Ruf)");
    repLocations:AddSkill("Rückkehr nach Dol Amroth", "0x700411AC", "Dol Amroth (Ruf)");
    repLocations:AddSkill("Rückkehr nach Arnach", "0x70043A6A", "Arnach (Ruf)");
    repLocations:AddSkill("Kehrt nach Minas Tirith zurück.", "0x7004497E", "Minas Tirith (Ruf)");
    repLocations:AddSkill("Zurück zum Kriegslager der Rohirrim", "0x700459A9", "Kriegslager der Rohirrim (Ruf)");
    repLocations:AddSkill("Rückkehr ins schlachtgezeichnete Minas Tirith", "0x70046CC0", "Minas Tirith nach der Schlacht (Ruf)");
    repLocations:AddSkill("Rückkehr nach Henneth Annûn", "0x70047080", "Henneth Annûn (Ruf)");
    repLocations:AddSkill("Rückkehr ins schlachtgezeichnete Osgiliath", "0x7004707D", "Osgiliath nach der Schlacht (Ruf)");
    repLocations:AddSkill("Rückkehr ins Lager des Heeres", "0x70047BF4", "Lager des Heeres (Ruf)");
    repLocations:AddSkill("Rückkehr nach Haerondir", "0x70047C1B", "Haerondir (Ruf)");
    repLocations:AddSkill("Zurück zum Udûn-Brückenkopf", "0x7004AE1D", "Udûn-Brückenkopf (Ruf)");
    repLocations:AddSkill("Reise zum Hof von Lothlórien", "0x7004B8C2", "Hof von Lothlórien (Ruf)");
    repLocations:AddSkill("Reise zur Halle des Königs", "0x7004B8C3", "Halle des Königs (Ruf)");
    repLocations:AddSkill("Reise zur Halle unter dem Berg", "0x7004B8C4", "Halle unter dem Berg (Ruf)");
    repLocations:AddSkill("Reise nach Bâr Thorenion", "0x7004B8C5", "Bâr Thorenion (Ruf)");
	repLocations:AddSkill("Rückkehr nach Thal.", "0x7004D738", "Thal (Ruf)");
	repLocations:AddSkill("Rückkehr nach Járnfast", "0x7004FAC3", "Járnfast (Ruf)");
    repLocations:AddSkill("Kehrt nach Skarháld zurück.", "0x7004FAC5", "Skarháld (Ruf)");
	repLocations:AddSkill("Kehrt zum Beorningerhús zurück.", "0x70052F12", "Beorningerhús (Ruf)");
    repLocations:AddSkill("Kehrt zum Hultvís zurück.", "0x70052F04", "Hultvís (Ruf)");
    repLocations:AddSkill("Zurück nach Estolad Lân", "0x700551F8", "Estolad Lân (Ruf)");
    repLocations:AddSkill("Rückkehr nach Limlók", "0x70057629", "Limlók (Ruf)");
    repLocations:AddSkill("Rückkehr nach Annâk-khurfu", "0x7005856F", "Annâk-khurfu (Ruf)");
    
    -- Crude Map to Gramsfoot for newb creeps
    creepLocations:AddSkill("Kartenskizze zum Gramfuss", "0x70028BBC");
    creepLocations:AddSkill("Karte zum Gramfuss", "0x70028BC1");

    creepLocations:AddSkill("Kartenskizze zur Isenbinge", "0x70028BB3");
    creepLocations:AddSkill("Grobe Karte zur Feste Tol Ascarnen", "0x70028BB6");
    creepLocations:AddSkill("Kartenskizze zur Feste Lugazag", "0x70028BB7");
    creepLocations:AddSkill("Grobe Karte zur Feste Tirith Rhaw", "0x70028BBE");
    creepLocations:AddSkill("Kartenskizze zum Grimmwald", "0x70028BBF");

    creepLocations:AddSkill("Minderwertige Karte zur Isenbinge", "0x70028BAF");
    creepLocations:AddSkill("Minderwertige Karte zur Feste Tol Ascarnen", "0x70028BB1");
    creepLocations:AddSkill("Minderwertige Karte zur Feste Lugazag", "0x70028BB2");
    creepLocations:AddSkill("Minderwertige Karte zur Feste Tirith Rhaw", "0x70028BB4");
    creepLocations:AddSkill("Minderwertige Karte zum Grimmwald", "0x70028BB9");

    creepLocations:AddSkill("Gute Karte zur Isenbinge", "0x70028BC0");
    creepLocations:AddSkill("Gute Karte zur Feste Tol Ascarnen", "0x70028BC2");
    creepLocations:AddSkill("Gute Karte zur Feste Lugazag", "0x70028BB5");
    creepLocations:AddSkill("Gute Karte zur Feste Tirith Rhaw", "0x70028BB0");
    creepLocations:AddSkill("Gute Karte zum Grimmwald", "0x70028BBD");
end
