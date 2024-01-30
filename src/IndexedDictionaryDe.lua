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

skillNotTrainedString = "Nicht erlernte Fertigkeit: ";

-- options window strings
generalTabString = "Allgemein";
selectTabString = "Auswahl";
sortTabString = "Sortierung";
hideString = "Verstecke Fenster beim Start";
toggleString = "Zeige An/Aus-Knopf";
pulldownTravelString = "Reise wenn Pulldown-Fertigkeit selektiert";
hideOnTravelString = "Verstecke Fenster bei Reise";
hideOnCombatString = "Verstecke Fenster bei Kampfbeginn";
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
enableRepSkillsString = "Überlappung Aktivieren";
disableRepSkillsString = "Überlappung Deaktivieren";
enableAllString = "Alle Aktivieren";
disableAllString = "Alle Deaktivieren";
ignoreEscString = "Escape ignorieren, um das Hauptfenster zu schließen";
minWindowString = "Mini-Fenster verwenden";
fadeWindowString = "Geschwindigkeit des Fade-Fensters";

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
mapWindowString = "Karten";
menuOptionsString = "Optionen";
moorMapString = "Öffne Etten-Karte";
eriadorMapString = "Öffne Eriador-Karte";
rhovanionMapString = "Öffne Rhovanion-Karte";
rohanMapString = "Öffne Rohan-Karte";
gondorMapString = "Öffne Gondor-Karte";
haradwaithMapString = "Öffne Haradwaith-Karte";
menuSkillsString = "Nicht erlernte Fertigkeiten prüfen";

--[[ travel skills ]] --
--[[ Add all the travel skills ]] --
-- add the data to custom dictionaries to maintain the order
function TravelDictionary:CreateDictionaries()
    -- add the hunter locations
    self.hunter:AddSkill("Zurück zum Lager", "0x7000A2C1", "Zurück zum Lager");
    self.hunter:AddSkill("Führer nach Bree", "0x70003F42", "Bree (Führer)");
    self.hunter:AddSkill("Führer zu Thorins Halle", "0x70003F41", "Thorins Halle (Führer)");
    self.hunter:AddSkill("Führer nach Michelbinge", "0x7000A2C3", "Michelbinge (Führer)");
    self.hunter:AddSkill("Führer nach Esteldín", "0x70003F43", "Esteldín (Führer)");
    self.hunter:AddSkill("Führer nach Evendim", "0x7000A2C4", "Evendim  (Führer)");
    self.hunter:AddSkill("Führer zur Feste Guruth", "0x7000A2C2", "Feste Guruth (Führer)");
    self.hunter:AddSkill("Führer nach Bruchtal", "0x70003F44", "Bruchtal (Führer)");
    self.hunter:AddSkill("Führer nach Sûri-kylä", "0x70017C82", "Sûri-kylä (Führer)");
    self.hunter:AddSkill("Führer in das westliche Angmar", "0x7000A2C5", "West-Angmar (Führer)");
    self.hunter:AddSkill("Führer nach Ost-Angmar", "0x7000A2C6", "Ost-Angmar (Führer)");
    self.hunter:AddSkill("Führer nach Echad Dúnann", "0x70017C81", "Echad Dúnann (Führer)");
    self.hunter:AddSkill("Führer zur Einundzwanzigsten Halle", "0x70017C7A", "Einundzwanzigste Halle (Führer)");
    self.hunter:AddSkill("Führer zur Dunkelsenke", "0x7001F459", "Dunkelsenke (Führer)");
    self.hunter:AddSkill("Führer nach Harndirion", "0x700235EF", "Harndirion (Führer)");
    self.hunter:AddSkill("Führer nach Galtrev", "0x7002A93F", "Galtrev (Führer)");
    self.hunter:AddSkill("Führer nach Stangard", "0x7002C62C", "Stangard (Führer)");
    self.hunter:AddSkill("Führer nach Caras Galadhon", "0x7002E754", "Caras Galadhon (Führer)");
    self.hunter:AddSkill("Führer ins Nebelgebirge", "0x7002E756", "Nebelgebirge (Führer)");
    self.hunter:AddSkill("Führer nach Schneegrenze", "0x7003198E", "Schneegrenze (Führer)");
    self.hunter:AddSkill("Führer nach Forlach", "0x70036B5D", "Forlach (Führer)");
    self.hunter:AddSkill("Führer nach Aldburg", "0x7003DC71", "Aldburg (Führer)");
    self.hunter:AddSkill("Führer nach Helms Klamm", "0x7003DC72", "Helms Klamm (Führer)");
    self.hunter:AddSkill("Führer nach Dol Amroth", "0x70041197", "Dol Amroth (Führer)", "nach Dol Amroth.");
    self.hunter:AddSkill("Führer nach Arnach", "0x70043A63", "Arnach (Führer)");
    self.hunter:AddSkill("Führer nach Minas Tirith", "0x70044985", "Minas Tirith (Führer)");
    self.hunter:AddSkill("Führer zum Kriegslager der Rohirrim", "0x700459AF", "Kriegslager der Rohirrim (Führer)");
    self.hunter:AddSkill("Führer zum schlachtgezeichneten Minas Tirith", "0x70046CBB", "Minas Tirith nach der Schlacht (Führer)");
    self.hunter:AddSkill("Führer zu Henneth Annûn", "0x70047077", "Henneth Annûn (Führer)");
    self.hunter:AddSkill("Führer zum schlachtgezeichneten Osgiliath", "0x70047074", "Osgiliath nach der Schlacht (Führer)");
    self.hunter:AddSkill("Führer zum Lager des Heeres", "0x70047BFA", "Lager des Heeres (Führer)");
    self.hunter:AddSkill("Führer nach Haerondir", "0x70047C1D", "Haerondir (Führer)");
    self.hunter:AddSkill("Führer zum Udûn-Brückenkopf", "0x7004AE1E", "Udûn-Brückenkopf (Führer)");
    self.hunter:AddSkill("Führer nach Thal", "0x7004D73B", "Thal (Führer)");
    self.hunter:AddSkill("Führer nach Járnfast", "0x7004FACC", "Járnfast (Führer)");
    self.hunter:AddSkill("Führer nach Skarháld", "0x7004FACB", "Skarháld (Führer)");
    self.hunter:AddSkill("Führer nach Beorningerhús", "0x70052F07", "Beorningerhús (Führer)");
    self.hunter:AddSkill("Leitfaden für Hultvís", "0x70052F08", "Hultvís (Führer)");
    self.hunter:AddSkill("Führer nach Estolad Lân", "0x700551F4", "Estolad Lân (Führer)");
    self.hunter:AddSkill("Führer nach Limlók", "0x7005762D", "Limlók (Führer)");
    self.hunter:AddSkill("Führer nach Annâk-khurfu", "0x70058571", "Annâk-khurfu (Führer)");
    self.hunter:AddSkill("Führer zum Händlerkai", "0x70059D0C", "Händlerkai (Führer)");
    self.hunter:AddSkill("Führer nach Schragen", "0x70059D16", "Schragen (Führer)");
    self.hunter:AddSkill("Führer nach Akrâz-zahar", "0x7005AA91", "Akrâz-zahar (Führer)");
    self.hunter:AddSkill("Führer nach Azanulbizar", "0x7005AA95", "Azanulbizar (Führer)");
    self.hunter:AddSkill("Führer zum Prachttor", "0x7005D487", "Prachttor (Führer)");
    self.hunter:AddSkill("Führer nach Leitstáth", "0x7005D47D", "Leitstáth (Führer)");
    self.hunter:AddSkill("Führer nach Tornhad", "0x70060EA6", "Tornhad (Führer)");
    self.hunter:AddSkill("Führer nach Neuhausen", "0x7006133F", "Neuhausen (Führer)");
    self.hunter:AddSkill("Führer nach Andrath", "0x7006323C", "Andrath (Führer)");
    self.hunter:AddSkill("Führer nach Schwanenfleet", "0x700634AA", "Schwanenfleet (Führer)");
    self.hunter:AddSkill("Führer nach Cardolan", "0x700634A7", "Cardolan (Führer)");
    self.hunter:AddSkill("Führer nach Carn Dûm", "0x70064AC8", "Carn Dûm (Führer)");
    self.hunter:AddSkill("Führer nach Clegur", "0x70064F4C", "Clegur (Führer)");
    self.hunter:AddSkill("Führer nach Pelargir", "0x700658EA", "Pelargir (Führer)");
    self.hunter:AddSkill("Führer nach Dol Amroth", "0x70068711", "Königreich Dol Amroth (Führer U38)", "Königreich Gondor");
    self.hunter:AddSkill("Führer nach Halrax", "0x70068713", "Halrax (Führer)");
    self.hunter:AddSkill("Führer nach Lond Cirion", "0x70068717", "Lond Cirion (Führer)");
    self.hunter:AddSkill("Führer nach Umbar", "0x70068718", "Umbar (Führer)");
    self.hunter:AddSkill("Führer nach Jax Phanâl", "0x70068719", "Jax Phanâl (Führer)");
    self.hunter:AddSkill("Führer zur Taverne \"Zum Blutigen Adler\"", "0x700697EF", "Zum Blutigen Adler (Führer)");

    -- add the Warden locations
    self.warden:AddSkill("Appell in der Feste Guruth", "0x70014786", "Feste Guruth (Appell)");
    self.warden:AddSkill("Appell in Esteldín", "0x70014798", "Esteldín (Appell)");
    self.warden:AddSkill("Appell in Evendim", "0x7001478E", "Evendim (Appell)");
    self.warden:AddSkill("Appell in Bruchtal", "0x70014791", "Bruchtal (Appell)");
    self.warden:AddSkill("Appell in Sûri-kylä", "0x700237D4", "Sûri-kylä (Appell)");
    self.warden:AddSkill("Appell in der Einundzwanzigsten Halle", "0x7001819E", "21. Halle (Appell)");
    self.warden:AddSkill("Appell in der Dunkelsenke", "0x7001F45C", "Dunkelsenke (Appell)");
    self.warden:AddSkill("Appell in Harndirion", "0x700235EB", "Harndirion (Appell)");
    self.warden:AddSkill("Appell in Galtrev", "0x7002A90A", "Galtrev (Appell)");
    self.warden:AddSkill("Appell in Stangard", "0x7002C646", "Stangard (Appell)");
    self.warden:AddSkill("Appell in Caras Galadhon", "0x700303DF", "Caras Galadhon (Appell)");
    self.warden:AddSkill("Appell im Nebelgebirge", "0x700303DD", "Nebelgebirge (Appell)");
    self.warden:AddSkill("Appell in Schneegrenze", "0x7003198D", "Schneegrenze (Appell)");
    self.warden:AddSkill("Appell in Forlach", "0x70036B5B", "Forlach (Appell)");
    self.warden:AddSkill("Appell in Aldburg", "0x7003DC7A", "Aldburg (Appell)");
    self.warden:AddSkill("Appell in Helms Klamm", "0x7003DC79", "Helms Klamm (Appell)");
    self.warden:AddSkill("Appell in Dol Amroth", "0x70041198", "Dol Amroth (Appell)", "West-Gondor zu reisen");
    self.warden:AddSkill("Appell in Arnach", "0x70043A66", "Arnach (Appell)");
    self.warden:AddSkill("Appell in Minas Tirith", "0x70044982", "Minas Tirith (Appell)");
    self.warden:AddSkill("Appell im Kriegslager", "0x700459AA", "Kriegslager der Rohirrim (Appell)");
    self.warden:AddSkill("Appell im schlachtgezeichneten Minas Tirith", "0x70046CBF", "Minas Tirith nach der Schlacht (Appell)");
    self.warden:AddSkill("Appell in Henneth Annûn", "0x70047075", "Henneth Annûn (Appell)");
    self.warden:AddSkill("Appell im schlachtgezeichneten Osgiliath", "0x70047076", "Osgiliath nach der Schlacht (Appell)");
    self.warden:AddSkill("Appell im Lager des Heeres", "0x70047BFC", "Lager des Heeres (Appell)");
    self.warden:AddSkill("Appell in Haerondir", "0x70047C23", "Haerondir (Appell)");
    self.warden:AddSkill("Appell am Udûn-Brückenkopf", "0x7004AE1F", "Udûn-Brückenkopf (Appell)");
    self.warden:AddSkill("Appell in Thal", "0x7004D73A", "Thal (Appell)");
    self.warden:AddSkill("Appell in Járnfast", "0x7004FACA", "Jarnfast (Appell)");
    self.warden:AddSkill("Appell in Skarháld", "0x7004FACD",  "Skarhald (Appell)");
    self.warden:AddSkill("Appell im Beorningerhús", "0x70052F0A", "Beorningerhús (Appell)");
    self.warden:AddSkill("Appell in Hultvís", "0x70052F06", "Hultvís (Appell)");
    self.warden:AddSkill("Appell in Estolad Lân", "0x700551F2", "Estolad Lân (Appell)");
    self.warden:AddSkill("Appell in Limlók", "0x70057635", "Limlók (Appell)");
    self.warden:AddSkill("Appell in Annâk-khurfu", "0x70058572", "Annâk-khurfu (Appell)");
    self.warden:AddSkill("Appell am Händlerkai", "0x70059D09", "Händlerkai (Appell)");
    self.warden:AddSkill("Appell in Schragen", "0x70059D10", "Schragen (Appell)");
    self.warden:AddSkill("Appell in Akrâz-zahar", "0x7005AA8F", "Akrâz-zahar (Appell)");
    self.warden:AddSkill("Appell in Azanulbizar", "0x7005AA8C", "Azanulbizar (Appell)");
    self.warden:AddSkill("Appell am Prachttor", "0x7005D48A", "Prachttor (Appell)");
    self.warden:AddSkill("Appell in Leitstáth", "0x7005D488", "Leitstáth (Appell)");
    self.warden:AddSkill("Appell in Tornhad", "0x70060EA5", "Tornhad (Appell)");
    self.warden:AddSkill("Appell in Neuhausen", "0x7006133E", "Neuhausen (Appell)");
    self.warden:AddSkill("Appell in Andrath", "0x70063242", "Andrath (Appell)");
    self.warden:AddSkill("Appell in Schwanenfleet", "0x700634B6", "Schwanenfleet (Appell)");
    self.warden:AddSkill("Appell in Cardolan", "0x700634AD", "Cardolan (Appell)");
    self.warden:AddSkill("Appell in Carn Dûm", "0x70064ACB", "Carn Dûm (Appell)");
    self.warden:AddSkill("Appell in Clegur", "0x70064F4D", "Clegur (Appell)");
    self.warden:AddSkill("Heerschau in Pelargir", "0x700658E8", "Pelargir (Appell)");
    self.warden:AddSkill("Appell in Jax Phanâl","0x7006870C", "Jax Phanâl (Appell)");
    self.warden:AddSkill("Appell in Umbar","0x7006870F","Umbar (Appell)");
    self.warden:AddSkill("Appell in Halrax","0x70068710", "Halrax (Appell)");
    self.warden:AddSkill("Appell in Dol Amroth","0x70068712", "Königreich Dol Amroth (Appell)", "Königreich Gondor");
    self.warden:AddSkill("Appell in Lond Cirion","0x70068715", "Lond Cirion (Appell)");
    self.warden:AddSkill("Appell in der Taverne \"Zum Blutigen Adler\"","0x700697F3", "Zum Blutigen Adler (Appell)");

    -- add the Mariner locations
    self.mariner:AddSkill("Segelt nach Celondim", "0x70066100", "Celondim (Segeln)")
    self.mariner:AddSkill("Segelt in die Braunen Lande", "0x70066101", "Braune Lande (Segeln)")
    self.mariner:AddSkill("Segelt zum Händlerkai", "0x70066105", "Händlerkai (Segel)")
    self.mariner:AddSkill("Segelt ins schlachtgezeichnete Osgiliath", "0x70066109", "Schlachtgezeichnetes Osgiliath (Segeln)")
    self.mariner:AddSkill("Segelt nach Seestadt.", "0x7006610C", "Seestadt (Segeln)")
    self.mariner:AddSkill("Segelt zur Dunkelsenke", "0x7006610E", "Dunkelsenke (Segeln)")
    self.mariner:AddSkill("Segelt nach Tinnudir", "0x7006610F", "Tinnundir (Segeln)")
    self.mariner:AddSkill("Segelt nach Dol Amroth", "0x70066117", "Dol Amroth (Segeln)", "nach Dol Amroth.")
    self.mariner:AddSkill("Segelt nach Bockland", "0x7006611A", "Bockland (Segeln)")
    self.mariner:AddSkill("Segelt nach Pelargir", "0x7006611B", "Pelargir (Segeln)")
    self.mariner:AddSkill("Segelt nach Sûri-kylä", "0x7006611C", "Sûri-kylä (Segeln)")
    self.mariner:AddSkill("Segelt nach Lothlórien", "0x7006611E", "Lothlórien (Segeln)")
    self.mariner:AddSkill("Nach Tharbad segeln", "0x70066120", "Tharbad (Segeln)")
    self.mariner:AddSkill("Segelt nach Schneegrenze", "0x70066121", "Schneegrenze (Segeln)")
    self.mariner:AddSkill("Nach Umbar segeln", "0x700687BB", "Umbar (Segeln)")
    self.mariner:AddSkill("Nach Lond Cirion segeln", "0x700687BD", "Lond Cirion (Segeln)")
    self.mariner:AddSkill("Nach Jax Phanâl segeln", "0x700687C0", "Jax Phanâl (Segeln)")
    self.mariner:AddSkill("Segelt nach Dol Amroth", "0x700687C1", "Königreich Dol Amroth (Segeln)", "Königreich Gondor")
    self.mariner:AddSkill("Nach Halrax segeln", "0x700687C3", "Halrax (Segeln)")

    -- add the racial travel skills
    self.allRaces:AddSkill("Rückkehr nach Bree", "0x700062F6", "Bree (Rasse)", "Ihr könnt schnell nach Bree");
    self.allRaces:AddSkill("Rückkehr ins Auenland", "0x700062C8", "Michelbinge (Rasse)");
    self.allRaces:AddSkill("Rückkehr zu Thorins Tor", "0x70006346", "Thorins Tor (Rasse Zwerg)", "Hiermit gelangt Ihr schnell");
    self.allRaces:AddSkill("Rückkehr nach Bruchtal", "0x7000631F", "Bruchtal (Rasse)", "Hiermit gelangt Ihr schnell");
    self.allRaces:AddSkill("Zum 1. Heim zurückkehren", "0x70041A22", "Grimbeorns Hütte (Rasse)");
    self.allRaces:AddSkill("Reise nach Caras Galadhon in Lothlórien", "0x70048C8C", "Caras Galadhon (Rasse)");
    self.allRaces:AddSkill("Reise zu Thorins Halle", "0x70053C0F", "Thorins Halle (Rasse Starkaxt)");
    self.allRaces:AddSkill("Kehrt zu Lyndelby zurück.", "0x70066D31", "Lyndelby (Rasse)") 

    -- add the Return Home and housing skills
    self.gen:AddSkill("Zum 1. Heim zurückkehren",  "0x700256BA", "1. Markstein");
    self.gen:AddSkill("Zum 2. Heim zurückkehren",  "0x70025792", "2. Markstein");
    self.gen:AddSkill("Zum 3. Heim zurückkehren",  "0x70025793", "3. Markstein");
    self.gen:AddSkill("Zum 4. Heim zurückkehren",  "0x70025794", "4. Markstein");
    self.gen:AddSkill("Zum 5. Heim zurückkehren",  "0x70025795", "5. Markstein");
    self.gen:AddSkill("Zum 6. Heim zurückkehren",  "0x70025796", "6. Markstein");
    self.gen:AddSkill("Zum 7. Heim zurückkehren",  "0x7002FF62", "7. Markstein");
    self.gen:AddSkill("Zum 8. Heim zurückkehren",  "0x7002FF61", "8. Markstein");
    self.gen:AddSkill("Zum 9. Heim zurückkehren",  "0x7002FF60", "9. Markstein");
    self.gen:AddSkill("Zum 10. Heim zurückkehren", "0x7002FF5F", "10. Markstein");
    self.gen:AddSkill("Zum 11. Heim zurückkehren", "0x7002FF63", "11. Markstein");
    self.gen:AddSkill("Reist zu Eurem eigenen Heim", "0x7000D046", "Eigenes Heim");
    self.gen:AddSkill("Reist zu Eurem Premiumheim", "0x70046EE4", "Premiumheim");
    self.gen:AddSkill("Reist zum Haus Eurer Sippe", "0x7000D047", "Heim Eurer Sippe");
    self.gen:AddSkill("Zum Haus des Sippenmitglieds reisen", "0x70057C36", "Heim des Sippenmitglieds");

    -- add the obtainable travel skills
    self.rep:AddSkill("Rückkehr zu Thorins Tor", "0x7001BF91", "Thorins Tor (Ruf)", "Dank Eurer Freundschaft");
    self.rep:AddSkill("Rückkehr nach Bree", "0x7001BF90", "Bree (Ruf)", "Dank Eurer Freundschaft");
    self.rep:AddSkill("Kehrt zu Lalias Markt zurück", "0x700364B1", "Lalias Markt (Mithril)");
    self.rep:AddSkill("Rückkehr nach Michelbinge", "0x70023262", "Michelbinge (Shop)");
    self.rep:AddSkill("Rückkehr nach Bruchtal", "0x70023263", "Bruchtal (Shop)", "Dank Eurer Freundschaft");
    self.rep:AddSkill("Rückkehr zur Feste Guruth", "0x70020441", "Feste Guruth (Ruf)");
    self.rep:AddSkill("Rückkehr zum Düsterwald", "0x7001F374", "Düsterwald (Ruf)");
    self.rep:AddSkill("Rückkehr nach Enedwaith", "0x70021FA2", "Enedwaith (Ruf)");
    self.rep:AddSkill("Kehrt nach Galtrev zurück", "0x7002C647", "Galtrev (Ruf)");
    self.rep:AddSkill("Kehrt nach Stangard zurück", "0x7002C65D", "Stangard (Ruf)");
    self.rep:AddSkill("Kehrt nach Schneegrenze zurück", "0x70031A46", "Schneegrenze (Ruf)");
    self.rep:AddSkill("Rückkehr nach Forlach", "0x70036B5E", "Forlach (Ruf)");
    self.rep:AddSkill("Kehrt nach Aldburg zurück", "0x7003DC81", "Aldburg (Ruf)");
    self.rep:AddSkill("Rückkehr ins Geheimnistal", "0x7004128F", "Geheimnistal (Ruf)");
    self.rep:AddSkill("Kehrt nach Helms Klamm zurück", "0x7003DC82", "Helms Klamm (Ruf)");
    self.rep:AddSkill("Rückkehr nach Dol Amroth", "0x700411AC", "Dol Amroth (Ruf)", "West-Gondor zurückkehren");
    self.rep:AddSkill("Rückkehr nach Arnach", "0x70043A6A", "Arnach (Ruf)");
    self.rep:AddSkill("Kehrt nach Minas Tirith zurück.", "0x7004497E", "Minas Tirith (Ruf)");
    self.rep:AddSkill("Zurück zum Kriegslager der Rohirrim", "0x700459A9", "Kriegslager der Rohirrim (Ruf)");
    self.rep:AddSkill("Rückkehr ins schlachtgezeichnete Minas Tirith", "0x70046CC0", "Minas Tirith nach der Schlacht (Ruf)");
    self.rep:AddSkill("Rückkehr nach Henneth Annûn", "0x70047080", "Henneth Annûn (Ruf)");
    self.rep:AddSkill("Rückkehr ins schlachtgezeichnete Osgiliath", "0x7004707D", "Osgiliath nach der Schlacht (Ruf)");
    self.rep:AddSkill("Rückkehr ins Lager des Heeres", "0x70047BF4", "Lager des Heeres (Ruf)");
    self.rep:AddSkill("Rückkehr nach Haerondir", "0x70047C1B", "Haerondir (Ruf)");
    self.rep:AddSkill("Zurück zum Udûn-Brückenkopf", "0x7004AE1D", "Udûn-Brückenkopf (Ruf)");
    self.rep:AddSkill("Reise zum Hof von Lothlórien", "0x7004B8C2", "Hof von Lothlórien (Ruf)");
    self.rep:AddSkill("Reise zur Halle des Königs", "0x7004B8C3", "Halle des Königs (Ruf)");
    self.rep:AddSkill("Reise zur Halle unter dem Berg", "0x7004B8C4", "Halle unter dem Berg (Ruf)");
    self.rep:AddSkill("Reise nach Bâr Thorenion", "0x7004B8C5", "Bâr Thorenion (Ruf)");
    self.rep:AddSkill("Rückkehr nach Thal", "0x7004D738", "Thal (Ruf)");
    self.rep:AddSkill("Rückkehr nach Járnfast", "0x7004FAC3", "Járnfast (Ruf)");
    self.rep:AddSkill("Kehrt nach Skarháld zurück.", "0x7004FAC5", "Skarháld (Ruf)");
    self.rep:AddSkill("Kehrt zum Beorningerhús zurück.", "0x70052F12", "Beorningerhús (Ruf)");
    self.rep:AddSkill("Kehrt zum Hultvís zurück.", "0x70052F04", "Hultvís (Ruf)");
    self.rep:AddSkill("Zurück nach Estolad Lân", "0x700551F8", "Estolad Lân (Ruf)");
    self.rep:AddSkill("Rückkehr nach Limlók", "0x70057629", "Limlók (Ruf)");
    self.rep:AddSkill("Rückkehr nach Annâk-khurfu", "0x7005856F", "Annâk-khurfu (Ruf)");
    self.rep:AddSkill("Kehrt zum Händlerkai zurück.", "0x70059D0E", "Händlerkai (Ruf)");
    self.rep:AddSkill("Kehrt nach Schragen zurück.", "0x70059D12", "Schragen (Ruf)");
    self.rep:AddSkill("Rückkehr nach Akrâz-zahar", "0x7005AA90", "Akrâz-zahar (Ruf)");
    self.rep:AddSkill("Rückkehre nach Azanulbizar", "0x7005AA92", "Azanulbizar (Ruf)");
    self.rep:AddSkill("Reise zur Halle Vérnozal", "0x7005A596", "Vérnozal (Aufgabe)");
    self.rep:AddSkill("Rückkehr zum Prachttor", "0x7005D47C", "Prachttor (Ruf)");
    self.rep:AddSkill("Rückkehr nach Leitstáth", "0x7005D484", "Leitstáth (Ruf)");
    self.rep:AddSkill("Kehrt nach Tornhad zurück.", "0x70060EA8", "Tornhad (Ruf)");
    self.rep:AddSkill("Kehrt nach Neuhausen zurück.", "0x70061340", "Neuhausen (Ruf)");
    self.rep:AddSkill("Rückkehr nach Andrath", "0x7006323D", "Andrath (Ruf)");
    self.rep:AddSkill("Rückkehr nach Schwanenfleet", "0x700634A4", "Swanfleet (Ruf)");
    self.rep:AddSkill("Rückkehr nach Cardolan", "0x700634AE", "Cardolan (Ruf)");
    self.rep:AddSkill("Rückkehr zu den Filigranmuster-Archiven in Bruchtal", "0x700634A5", "Filigranmuster-Archiv (Delving)");
    self.rep:AddSkill("Rückkehr nach Carn Dûm", "0x70064ACA", "Carn Dûm (Ruf)");
    self.rep:AddSkill("Rückkehr nach Clegur", "0x70064F47", "Clegur (Ruf)");
    self.rep:AddSkill("Nach Glân Vraig zurückkehren", "0x7005B38E", "Glân Vraig (Aufgabe)");
    self.rep:AddSkill("Rückkehr nach Pelargir", "0x700658EB", "Pelargir (Ruf)");
    self.rep:AddSkill("Zum Orden des Adlers reisen", "0x700686FE", "Orden des Adlers (Ruf)");
    self.rep:AddSkill("Nach Umbar zurückkehren", "0x700686FF", "Umbar (Ruf)");
    self.rep:AddSkill("Rückkehr nach Dol Amroth", "0x70068700", "Königreich Dol Amroth (Ruf U38)", "Königreich Gondor");
    self.rep:AddSkill("Nach Jax Phanâl zurückkehren", "0x70068701", "Jax Phanâl (Ruf)");
    self.rep:AddSkill("Kehrt zu Halrax zurück.", "0x70068702", "Halrax (Ruf)");
    self.rep:AddSkill("Nach Lond Cirion zurückkehren", "0x70068703", "Lond Cirion (Ruf)");
    self.rep:AddSkill("Zu den Buchhütern reisen", "0x70068704", "Ledger-Keepers (Ruf)");
    self.rep:AddSkill("Rückkehr zur Taverne \"Zum Blutigen Adler\"", "0x700697F2", "Zum Blutigen Adler (Ruf)");

    -- monster player maps
    self.creep:AddSkill("Kartenskizze zum Gramfuss", "0x70028BBC");
    self.creep:AddSkill("Karte zum Gramfuss", "0x70028BC1");
    self.creep:AddSkill("Kartenskizze zur Isenbinge", "0x70028BB3");
    self.creep:AddSkill("Grobe Karte zur Feste Tol Ascarnen", "0x70028BB6");
    self.creep:AddSkill("Kartenskizze zur Feste Lugazag", "0x70028BB7");
    self.creep:AddSkill("Grobe Karte zur Feste Tirith Rhaw", "0x70028BBE");
    self.creep:AddSkill("Kartenskizze zum Grimmwald", "0x70028BBF");
    self.creep:AddSkill("Minderwertige Karte zur Isenbinge", "0x70028BAF");
    self.creep:AddSkill("Minderwertige Karte zur Feste Tol Ascarnen", "0x70028BB1");
    self.creep:AddSkill("Minderwertige Karte zur Feste Lugazag", "0x70028BB2");
    self.creep:AddSkill("Minderwertige Karte zur Feste Tirith Rhaw", "0x70028BB4");
    self.creep:AddSkill("Minderwertige Karte zum Grimmwald", "0x70028BB9");
    self.creep:AddSkill("Gute Karte zur Isenbinge", "0x70028BC0");
    self.creep:AddSkill("Gute Karte zur Feste Tol Ascarnen", "0x70028BC2");
    self.creep:AddSkill("Gute Karte zur Feste Lugazag", "0x70028BB5");
    self.creep:AddSkill("Gute Karte zur Feste Tirith Rhaw", "0x70028BB0");
    self.creep:AddSkill("Gute Karte zum Grimmwald", "0x70028BBD");
end
