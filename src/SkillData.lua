--[[ travel skills ]] --
--[[ Add all the travel skills ]] --
-- add the data to custom dictionaries to maintain the order
function TravelDictionary:CreateDictionaries()
    -- add the hunter locations
    self.hunter:AddSkill({
        id="0x7000A2C1",
        nameEN="Return to Camp",
        nameDE="Zurück zum Lager",
        nameFR="Retour au campement",
        map={{MapType.NONE, -1, -1}},
        level=1
    })
    self.hunter:AddSkill({
        id="0x7000A2C3",
        nameEN="Guide to Michel Delving", labelEN="Michel Delving (Guide)",
        nameDE="Führer nach Michelbinge", labelDE="Michelbinge (Führer)",
        nameFR="Guide vers Grand'Cave", labelFR="Grand'Cave (Guide)",
        map={{MapType.ERIADOR, 360, 390}},
        overlap={"0x700062C8", "0x70023262"},
        level=1
    })
    self.hunter:AddSkill({
        id="0x70003F41",
        nameEN="Guide to Thorin's Hall", labelEN="Thorin's Hall (Guide)",
        nameDE="Führer zu Thorins Halle", labelDE="Thorins Halle (Führer)",
        nameFR="Guide vers le Palais de Thorin", labelFR="Palais de Thorin (Guide)",
        map={{MapType.ERIADOR, 305, 270}},
        overlap={"0x70006346", "0x70053C0F", "0x7001BF91"},
        level=1.1
    })
    self.hunter:AddSkill({
        id="0x70003F42",
        nameEN="Guide to Bree", labelEN="Bree (Guide)",
        nameDE="Führer nach Bree", labelDE="Bree (Führer)",
        nameFR="Guide vers Bree", labelFR="Bree (Guide)",
        map={{MapType.ERIADOR, 585, 335}},
        overlap={"0x700062F6", "0x7001BF90"},
        level=5
    })
    self.hunter:AddSkill({
        id="0x70064F4C",
        nameEN="Guide to Clegur", labelEN="Clegur (Guide)",
        nameDE="Führer nach Clegur", labelDE="Clegur (Führer)",
        nameFR="Guide vers Clegur", labelFR="Clegur (Guide)",
        map={{MapType.ERIADOR, 755, 555}},
        overlap={"0x70064F47"},
        level=7
    })
    self.hunter:AddSkill({
        id="0x700634AA",
        nameEN="Guide to Swanfleet", labelEN="Swanfleet (Guide)",
        nameDE="Führer nach Schwanenfleet", labelDE="Schwanenfleet (Führer)",
        nameFR="Guide vers les Noues des cygnes", labelFR="Noues des cygnes (Guide)",
        map={{MapType.ERIADOR, 825, 490}},
        overlap={"0x700634A4"},
        level=10
    })
    self.hunter:AddSkill({
        id="0x700634A7",
        nameEN="Guide to Cardolan", labelEN="Cardolan (Guide)",
        nameDE="Führer nach Cardolan", labelDE="Cardolan (Führer)",
        nameFR="Guide vers le Cardolan", labelFR="Cardolan (Guide)",
        map={{MapType.ERIADOR, 560, 495}},
        overlap={"0x700634AE"},
        level=15
    })
    self.hunter:AddSkill({
        id="0x7006323C",
        nameEN="Guide to Andrath", labelEN="Andrath (Guide)",
        nameDE="Führer nach Andrath", labelDE="Andrath (Führer)",
        nameFR="Guide vers Andrath", labelFR="Andrath (Guide)",
        map={{MapType.ERIADOR, 580, 465}},
        overlap={"0x7006323D"},
        level=17
    })
    self.hunter:AddSkill({
        id="0x7006133F",
        nameEN="Guide to Nobottle", labelEN="Nobottle (Guide)",
        nameDE="Führer nach Neuhausen", labelDE="Neuhausen (Führer)",
        nameFR="Guide vers Bourdeneuve", labelFR="Bourdeneuve (Guide)",
        map={{MapType.ERIADOR, 440, 350}},
        overlap={"0x70061340"},
        level=20
    })
    self.hunter:AddSkill({
        id="0x7000A2C2",
        nameEN="Guide to Ost Guruth", labelEN="Ost Guruth (Guide)",
        nameDE="Führer zur Feste Guruth", labelDE="Feste Guruth (Führer)",
        nameFR="Guide vers Ost Guruth", labelFR="Ost Guruth (Guide)",
        map={{MapType.ERIADOR, 755, 400}},
        overlap={"0x70020441"},
        level=25
    })
    self.hunter:AddSkill({
        id="0x70003F43",
        nameEN="Guide to Esteldín", labelEN="Esteldín (Guide)",
        nameDE="Führer nach Esteldín", labelDE="Esteldín (Führer)",
        nameFR="Guide vers Esteldin", labelFR="Esteldin (Guide)",
        map={{MapType.ERIADOR, 655, 290}},
        level=30
    })
    self.hunter:AddSkill({
        id="0x7000A2C4",
        nameEN="Guide to Evendim", labelEN="Evendim (Guide)",
        nameDE="Führer nach Evendim", labelDE="Evendim  (Führer)",
        nameFR="Guide vers Evendim", labelFR="Evendim (Guide)",
        map={{MapType.ERIADOR, 490, 235}},
        level=35
    })
    self.hunter:AddSkill({
        id="0x70060EA6",
        nameEN="Guide to Tornhad", labelEN="Tornhad (Guide)",
        nameDE="Führer nach Tornhad", labelDE="Tornhad (Führer)",
        nameFR="Guide vers Tornhad", labelFR="Tornhad (Guide)",
        map={{MapType.ERIADOR, 775, 435}},
        overlap={"0x70060EA8"},
        level=40
    })
    self.hunter:AddSkill({
        id="0x70003F44",
        nameEN="Guide to Rivendell", labelEN="Rivendell (Guide)",
        nameDE="Führer nach Bruchtal", labelDE="Bruchtal (Führer)",
        nameFR="Guide vers Fondcombe", labelFR="Fondcombe (Guide)",
        map={{MapType.ERIADOR, 865, 410}},
        overlap={"0x7000631F", "0x70023263"},
        level=40.1
    })
    self.hunter:AddSkill({
        id="0x7002E756",
        nameEN="Guide to the Misty Mountains", labelEN="Misty Mountains (Guide)",
        nameDE="Führer ins Nebelgebirge", labelDE="Nebelgebirge (Führer)",
        nameFR="Guide vers les Monts Brumeux", labelFR="Monts Brumeux (Guide)",
        map={{MapType.ERIADOR, 915, 265}},
        level=40.2
    })
    self.hunter:AddSkill({
        id="0x70059D16",
        nameEN="Guide to Trestlebridge", labelEN="Trestlebridge (Guide)",
        nameDE="Führer nach Schragen", labelDE="Schragen (Führer)",
        nameFR="Guide vers Pont-à-Tréteaux", labelFR="Pont-à-Tréteaux (Guide)",
        map={{MapType.ERIADOR, 590, 285}},
        overlap={"0x70059D12"},
        level=40.3
    })
    self.hunter:AddSkill({
        id="0x70059D0C",
        nameEN="Guide to Trader's Wharf", labelEN="Trader's Wharf (Guide)",
        nameDE="Führer zum Händlerkai", labelDE="Händlerkai (Führer)",
        nameFR="Guide vers le Quai des marchands", labelFR="Quai des marchands (Guide)",
        map={{MapType.ERIADOR, 515, 305}},
        overlap={"0x70059D0E"},
        level=40.4
    })
    self.hunter:AddSkill({
        id="0x70017C82",
        nameEN="Guide to Sûri-kylä", labelEN="Sûri-kylä (Guide)",
        nameDE="Führer nach Sûri-kylä", labelDE="Sûri-kylä (Führer)",
        nameFR="Guide vers Sûri-kylä", labelFR="Sûri-kylä (Guide)",
        map={{MapType.ERIADOR, 430, 50}},
        level=42
    })
    self.hunter:AddSkill({
        id="0x7000A2C5",
        nameEN="Guide to West Angmar", labelEN="West Angmar (Guide)",
        nameDE="Führer in das westliche Angmar", labelDE="West-Angmar (Führer)",
        nameFR="Guide vers l'ouest d'Angmar", labelFR="Angmar ouest (Guide)",
        map={{MapType.ERIADOR, 825, 185}},
        level=45
    })
    self.hunter:AddSkill({
        id="0x7000A2C6",
        nameEN="Guide to East Angmar", labelEN="East Angmar (Guide)",
        nameDE="Führer nach Ost-Angmar", labelDE="Ost-Angmar (Führer)",
        nameFR="Guide vers l'est d'Angmar", labelFR="Angmar est (Guide)",
        map={{MapType.ERIADOR, 705, 180}},
        level=49
    })
    self.hunter:AddSkill({
        id="0x70017C81",
        nameEN="Guide to Echad Dúnann", labelEN="Echad Dúnann (Guide)",
        nameDE="Führer nach Echad Dúnann", labelDE="Echad Dúnann (Führer)",
        nameFR="Guide vers Echad Dunann", labelFR="Echad Dunann (Guide)",
        map={{MapType.ERIADOR, 855, 535}},
        level=50
    })
    self.hunter:AddSkill({
        id="0x70017C7A",
        nameEN="Guide to the Twenty-first Hall", labelEN="Twenty-first Hall (Guide)",
        nameDE="Führer zur Einundzwanzigsten Halle", labelDE="Einundzwanzigste Halle (Führer)",
        nameFR="Guide vers la vingt et unième salle", labelFR="Vingt et unième salle (Guide)",
        map={{MapType.RHOVANION, 95, 585}, {MapType.ERIADOR, 950, 510}},
        level=55
    })    
    self.hunter:AddSkill({
        id="0x7002E754",
        nameEN="Guide to Caras Galadhon", labelEN="Caras Galadhon (Guide)",
        nameDE="Führer nach Caras Galadhon", labelDE="Caras Galadhon (Führer)",
        nameFR="Guide vers Caras Galadhon", labelFR="Caras Galadhon (Guide)",
        map={{MapType.RHOVANION, 120, 660}},
        overlap={"0x70048C8C"},
        level=60
    })
    self.hunter:AddSkill({
        id="0x7001F459",
        nameEN="Guide to Mirk-eaves", labelEN="Mirk-eaves (Guide)",
        nameDE="Führer zur Dunkelsenke", labelDE="Dunkelsenke (Führer)",
        nameFR="Guide vers l'Orée noire", labelFR="Orée noire (Guide)",
        map={{MapType.RHOVANION, 365, 630}},
        level=61
    })
    self.hunter:AddSkill({
        id="0x700235EF",
        nameEN="Guide to Harndirion", labelEN="Harndirion (Guide)",
        nameDE="Führer nach Harndirion", labelDE="Harndirion (Führer)",
        nameFR="Guide vers Harndirion", labelFR="Harndirion (Guide)",
        map={{MapType.ERIADOR, 815, 635}},
        level=62
    })
    self.hunter:AddSkill({
        id="0x7002A93F",
        nameEN="Guide to Galtrev", labelEN="Galtrev (Guide)",
        nameDE="Führer nach Galtrev", labelDE="Galtrev (Führer)",
        nameFR="Guide pour Galtrev", labelFR="Galtrev (Guide)",
        map={{MapType.ERIADOR, 810, 715}},
        overlap={"0x7002C647"},
        level=65
    })
    self.hunter:AddSkill({
        id="0x7002C62C",
        nameEN="Guide to Stangard", labelEN="Stangard (Guide)",
        nameDE="Führer nach Stangard", labelDE="Stangard (Führer)",
        nameFR="Guide vers Stangarde", labelFR="Stangarde (Guide)",
        map={{MapType.RHOVANION, 200, 720}, {MapType.ROHAN, 545, 90}},
        overlap={"0x7002C65D"},
        level=75
    })
    self.hunter:AddSkill({
        id="0x7003198E",
        nameEN="Guide to Snowbourn", labelEN="Snowbourn (Guide)",
        nameDE="Führer nach Schneegrenze", labelDE="Schneegrenze (Führer)",
        nameFR="Guide vers Neigebronne", labelFR="Neigebronne (Guide)",
        map={{MapType.ROHAN, 515, 500}},
        overlap={"0x70031A46"},
        level=80
    })
    self.hunter:AddSkill({
        id="0x70036B5D",
        nameEN="Guide to Forlaw", labelEN="Forlaw (Guide)",
        nameDE="Führer nach Forlach", labelDE="Forlach (Führer)",
        nameFR="Guide vers Forloi", labelFR="Forloi (Guide)",
        map={{MapType.ROHAN, 450, 175}},
        overlap={"0x70036B5E"},
        level=85
    })
    self.hunter:AddSkill({
        id="0x7003DC71",
        nameEN="Guide to Aldburg", labelEN="Aldburg (Guide)",
        nameDE="Führer nach Aldburg", labelDE="Aldburg (Führer)",
        nameFR="Guide vers Aldburg", labelFR="Aldburg (Guide)",
        map={{MapType.ROHAN, 570, 640}},
        overlap={"0x7003DC81"},
        level=88
    })
    self.hunter:AddSkill({
        id="0x7003DC72",
        nameEN="Guide to Helm's Deep", labelEN="Helm's Deep (Guide)",
        nameDE="Führer nach Helms Klamm", labelDE="Helms Klamm (Führer)",
        nameFR="Guide vers le Gouffre de Helm", labelFR="Gouffre de Helm (Guide)",
        map={{MapType.ROHAN, 275, 565}},
        overlap={"0x7003DC82"},
        level=90
    })
    self.hunter:AddSkill({
        id="0x70041197",
        nameEN="Guide to Dol Amroth", descEN="Dol Amroth in western Gondor", labelEN="Dol Amroth (Guide)",
        nameDE="Führer nach Dol Amroth", descDE="nach Dol Amroth.", labelDE="Dol Amroth (Führer)",
        nameFR="Guide vers Dol Amroth", descFR="l'Ouest du Gondor", labelFR="Dol Amroth (Guide)",
        map={{MapType.GONDOR, 225, 550}},
        overlap={"0x700411AC"},
        level=98
    })
    self.hunter:AddSkill({
        id="0x70043A63",
        nameEN="Guide to Arnach", labelEN="Arnach (Guide)",
        nameDE="Führer nach Arnach", labelDE="Arnach (Führer)",
        nameFR="Guide pour Arnach", labelFR="Arnach (Guide)",
        map={{MapType.GONDOR, 715, 425}},
        overlap={"0x70043A6A"},
        level=100
    })
    self.hunter:AddSkill({
        id="0x70044985",
        nameEN="Guide to Minas Tirith", labelEN="Minas Tirith (Guide)",
        nameDE="Führer nach Minas Tirith", labelDE="Minas Tirith  (Führer)",
        nameFR="Guide vers Minas Tirith", labelFR="Minas Tirith (Guide)",
        map={{MapType.GONDOR, 670, 345}},
        overlap={"0x7004497E"},
        level=100.1
    })
    self.hunter:AddSkill({
        id="0x700459AF",
        nameEN="Guide to the War-stead", labelEN="War-stead (Guide)",
        nameDE="Führer zum Kriegslager der Rohirrim", labelDE="Kriegslager der Rohirrim (Führer)",
        nameFR="Guide pour se rendre au camp militaire", labelFR="Camp militaire (Guide)",
        map={{MapType.GONDOR, 665, 140}},
        overlap={"0x700459A9"},
        level=102
    })
    self.hunter:AddSkill({
        id="0x70046CBB",
        nameEN="Guide to after-battle Minas Tirith", labelEN="Minas Tirith after battle (Guide)",
        nameDE="Führer zum schlachtgezeichneten Minas Tirith", labelDE="Minas Tirith nach der Schlacht (Führer)",
        nameFR="Guide de Minas Tirith après la bataille", labelFR="Minas Tirith après la bataille (Guide)",
        map={{MapType.GONDOR, 670, 375}},
        overlap={"0x70046CC0"},
        level=105
    })
    self.hunter:AddSkill({
        id="0x70047074",
        nameEN="Guide to after-battle Osgiliath", labelEN="Osgiliath after-battle (Guide)",
        nameDE="Führer zum schlachtgezeichneten Osgiliath", labelDE="Osgiliath nach der Schlacht (Führer)",
        nameFR="Guide vers Osgiliath après la bataille", labelFR="Osgiliath après la bataille (Guide)",
        map={{MapType.GONDOR, 855, 335}},
        overlap={"0x7004707D"},
        level=105.1
    })
    self.hunter:AddSkill({
        id="0x70047077",
        nameEN="Guide to Henneth Annûn", labelEN="Henneth Annûn (Guide)",
        nameDE="Führer zu Henneth Annûn", labelDE="Henneth Annûn (Führer)",
        nameFR="Guide vers Henneth Annûn", labelFR="Henneth Annûn (Guide)",
        map={{MapType.GONDOR, 875, 385}},
        overlap={"0x70047080"},
        level=105.2
    })
    self.hunter:AddSkill({
        id="0x70047BFA",
        nameEN="Guide to the Camp of the Host", labelEN="Camp of the Host (Guide)",
        nameDE="Führer zum Lager des Heeres", labelDE="Lager des Heeres (Führer)",
        nameFR="Guide vers le Camp de l'armée", labelFR="Camp de l'armée (Guide)",
        map={{MapType.GONDOR, 805, 170}},
        overlap={"0x70047BF4"},
        level=105.3
    })
    self.hunter:AddSkill({
        id="0x70047C1D",
        nameEN="Guide to Haerondir", labelEN="Haerondir (Guide)",
        nameDE="Führer nach Haerondir", labelDE="Haerondir (Führer)",
        nameFR="Guide vers Haerondir", labelFR="Haerondir (Guide)",
        map={{MapType.GONDOR, 855, 100}},
        overlap={"0x70047C1B"},
        level=105.4
    })
    self.hunter:AddSkill({
        id="0x7004AE1E",
        nameEN="Guide to the Udûn Foothold", labelEN="Udûn Foothold (Guide)",
        nameDE="Führer zum Udûn-Brückenkopf", labelDE="Udûn-Brückenkopf (Führer)",
        nameFR="Guide vers le fort d'Udûn", labelFR="Fort d'Udûn (Guide)",
        map={{MapType.GONDOR, 925, 230}},
        overlap={"0x7004AE1D"},
        level=106
    })
    self.hunter:AddSkill({
        id="0x7004D73B",
        nameEN="Guide to Dale", labelEN="Dale (Guide)",
        nameDE="Führer nach Thal", labelDE="Thal (Führer)",
        nameFR="Guide vers Dale", labelFR="Dale (Guide)",
        map={{MapType.RHOVANION, 720, 215}},
        overlap={"0x7004D738"},
        level=115
    })
    self.hunter:AddSkill({
        id="0x7004FACC",
        nameEN="Guide to Járnfast", labelEN="Járnfast (Guide)",
        nameDE="Führer nach Járnfast", labelDE="Járnfast (Führer)",
        nameFR="Guide vers Jarnfast", labelFR="Jarnfast (Guide)",
        map={{MapType.RHOVANION, 890, 110}},
        overlap={"0x7004FAC3"},
        level=116
    })
    self.hunter:AddSkill({
        id="0x7004FACB",
        nameEN="Guide to Skarháld", labelEN="Skarháld (Guide)",
        nameDE="Führer nach Skarháld", labelDE="Skarháld (Führer)",
        nameFR="Guide vers Skarhald", labelFR="Skarhald (Guide)",
        map={{MapType.RHOVANION, 430, 90}},
        overlap={"0x7004FAC5"},
        level=117
    })
    self.hunter:AddSkill({
        id="0x70052F07",
        nameEN="Guide to Beorninghús", labelEN="Beorninghús (Guide)",
        nameDE="Führer nach Beorningerhús", labelDE="Beorningerhús (Führer)",
        nameFR="Guide pour Beorninghus", labelFR="Beorninghus (Guide)",
        map={{MapType.RHOVANION, 390, 300}},
        overlap={"0x70041A22", "0x70052F12"},
        level=120
    })
    self.hunter:AddSkill({
        id="0x70052F08",
        nameEN="Guide to Hultvís", labelEN="Hultvís (Guide)",
        nameDE="Leitfaden für Hultvís", labelDE="Hultvís (Führer)",
        nameFR="Guide de Hultvis", labelFR="Hultvis (Guide)",
        map={{MapType.RHOVANION, 375, 400}},
        overlap={"0x70052F04"},
        level=120.1
    })
    self.hunter:AddSkill({
        id="0x700551F4",
        nameEN="Guide to Estolad Lân", labelEN="Estolad Lân (Guide)",
        nameDE="Führer nach Estolad Lân", labelDE="Estolad Lân (Führer)",
        nameFR="Guide vers Estolad Lân", labelFR="Estolad Lân (Guide)",
        map={{MapType.GONDOR, 960, 460}},
        overlap={"0x700551F8"},
        level=125
    })
    self.hunter:AddSkill({
        id="0x7005762D",
        nameEN="Guide to Limlók", labelEN="Limlók (Guide)",
        nameDE="Führer nach Limlók", labelDE="Limlók (Führer)",
        nameFR="Guide de Limlok", labelFR="Limlok (Guide)",
        map={{MapType.RHOVANION, 345, 230}},
        overlap={"0x70057629"},
        level=130
    })
    self.hunter:AddSkill({
        id="0x70058571",
        nameEN="Guide to Annâk-khurfu", labelEN="Annâk-khurfu (Guide)",
        nameDE="Führer nach Annâk-khurfu", labelDE="Annâk-khurfu (Führer)",
        nameFR="Guide vers Annâk-khurfu", labelFR="Annâk-khurfu (Guide)",
        map={{MapType.RHOVANION, 530, 90}},
        overlap={"0x7005856F"},
        level=130.1
    })
    self.hunter:AddSkill({
        id="0x7005AA91",
        nameEN="Guide to Akrâz-zahar", labelEN="Akrâz-zahar (Guide)",
        nameDE="Führer nach Akrâz-zahar", labelDE="Akrâz-zahar (Führer)",
        nameFR="Guide vers Akrâz-zahar", labelFR="Akrâz-zahar (Guide)",
        map={{MapType.RHOVANION, 750, 115}},
        overlap={"0x7005AA90"},
        level=130.2
    })
    self.hunter:AddSkill({
        id="0x7005AA95",
        nameEN="Guide to Azanulbizar", labelEN="Azanulbizar (Guide)",
        nameDE="Führer nach Azanulbizar", labelDE="Azanulbizar (Führer)",
        nameFR="Guide vers Azanulbizar", labelFR="Azanulbizar (Guide)",
        map={{MapType.RHOVANION, 210, 555}},
        overlap={"0x7005AA92"},
        level=130.3
    })
    self.hunter:AddSkill({
        id="0x7005D487",
        nameEN="Guide to the Noble Gate", labelEN="Noble Gate (Guide)",
        nameDE="Führer zum Prachttor", labelDE="Prachttor (Führer)",
        nameFR="Guide vers la Porte Noble", labelFR="Porte Noble (Guide)",
        map={{MapType.RHOVANION, 190, 130}},
        overlap={"0x7005D47C"},
        level=131
    })
    self.hunter:AddSkill({
        id="0x7005D47D",
        nameEN="Guide to Leitstáth", labelEN="Leitstáth (Guide)",
        nameDE="Führer nach Leitstáth", labelDE="Leitstáth (Führer)",
        nameFR="Guide vers Leitstath", labelFR="Leitstath (Guide)",
        map={{MapType.RHOVANION, 270, 65}},
        overlap={"0x7005D484"},
        level=135
    })
    self.hunter:AddSkill({
        id="0x70064AC8",
        nameEN="Guide to Carn Dûm", labelEN="Carn Dûm (Guide)",
        nameDE="Führer nach Carn Dûm", labelDE="Carn Dûm (Führer)",
        nameFR="Guide vers Carn Dûm", labelFR="Carn Dûm (Guide)",
        map={{MapType.ERIADOR, 735, 100}},
        overlap={"0x70064ACA"},
        level=140.1
    })
    self.hunter:AddSkill({
        id="0x700658EA",
        nameEN="Guide to Pelargir", labelEN="Pelargir (Guide)",
        nameDE="Führer nach Pelargir", labelDE="Pelargir (Führer)",
        nameFR="Guide vers Pelargir", labelFR="Pelargir (Guide)",
        map={{MapType.GONDOR, 670, 625}},
        overlap={"0x700658EB"},
        level=141
    })
    self.hunter:AddSkill({
        id="0x70068711",
        nameEN="Guide to Dol Amroth", descEN="King's Gondor", labelEN="King's Dol Amroth (Guide)",
        nameDE="Führer nach Dol Amroth", descDE="Königreich Gondor", labelDE="Dol Amroth - Königreich Gondor (Führer)",
        nameFR="Guide vers Dol Amroth", descFR="le Gondor royal", labelFR="Dol Amroth - Gondor royal (Guide)",
        map={{MapType.GONDOR, 210, 485}, {MapType.HARADWAITH, 210, 485}},
        overlap={"0x70068700"},
        level=142
    })
    self.hunter:AddSkill({
        id="0x70068717",
        nameEN="Guide to Lond Cirion", labelEN="Lond Cirion (Guide)",
        nameDE="Führer nach Lond Cirion", labelDE="Lond Cirion (Führer)",
        nameFR="Guide vers Lond Cirion", labelFR="Lond Cirion (Guide)",
        map={{MapType.GONDOR, 255, 420}, {MapType.HARADWAITH, 230, 20}},
        overlap={"0x70068703"},
        level=143
    })
    self.hunter:AddSkill({
        id="0x70068713",
        nameEN="Guide to Halrax", labelEN="Halrax (Guide)",
        nameDE="Führer nach Halrax", labelDE="Halrax (Führer)",
        nameFR="Guide vers Halrax", labelFR="Halrax (Guide)",
        map={{MapType.HARADWAITH, 275, 160}},
        overlap={"0x70068702"},
        level=145
    })
    self.hunter:AddSkill({
        id="0x70068719",
        nameEN="Guide to Jax Phanâl", labelEN="Jax Phanâl (Guide)",
        nameDE="Führer nach Jax Phanâl", labelDE="Jax Phanâl (Führer)",
        nameFR="Guide vers Jax Phanâl", labelFR="Jax Phanâl (Guide)",
        map={{MapType.HARADWAITH, 305, 315}},
        overlap={"0x70068701"},
        level=146
    })
    self.hunter:AddSkill({
        id="0x70068718",
        nameEN="Guide to Umbar", labelEN="Umbar (Guide)",
        nameDE="Führer nach Umbar", labelDE="Umbar (Führer)",
        nameFR="Guide vers Umbar", labelFR="Umbar (Guide)",
        map={{MapType.HARADWAITH, 505, 370}},
        overlap={"0x700686FF"},
        level=148
    })
    self.hunter:AddSkill({
        id="0x700697EF",
        nameEN="Guide to the Bloody Eagle Tavern", labelEN="Bloody Eagle Tavern (Guide)",
        nameDE="Führer zur Taverne \"Zum Blutigen Adler\"", labelDE="Zum Blutigen Adler (Führer)",
        nameFR="Guide vers la taverne de l'Aigle sanglant", labelFR="Taverne de l'Aigle sanglant (Guide)",
        map={{MapType.HARADWAITH, 475, 400}},
        overlap={"0x700697F2"},
        level=149
    })

    -- add the Warden locations
    self.warden:AddSkill({
        id="0x70064F4D",
        nameEN="Muster at Clegur", labelEN="Clegur (Muster)",
        nameDE="Appell in Clegur", labelDE="Clegur (Appell)",
        nameFR="Rassemblement à Clegur", labelFR="Clegur (Rassemblement)",
        map={{MapType.ERIADOR, 755, 555}},
        overlap={"0x70064F47"},
        level=7
    })
    self.warden:AddSkill({
        id="0x700634B6",
        nameEN="Muster at Swanfleet", labelEN="Swanfleet (Muster)",
        nameDE="Appell in Schwanenfleet", labelDE="Schwanenfleet (Appell)",
        nameFR="Rassemblement aux Noues des cygnes", labelFR="Noues des cygnes (Rassemblement)",
        map={{MapType.ERIADOR, 825, 490}},
        overlap={"0x700634A4"},
        level=10
    })
    self.warden:AddSkill({
        id="0x700634AD",
        nameEN="Muster at Cardolan", labelEN="Cardolan (Muster)",
        nameDE="Appell in Cardolan", labelDE="Cardolan (Appell)",
        nameFR="Rassemblement au Cardolan", labelFR="Cardolan (Rassemblement)",
        map={{MapType.ERIADOR, 560, 495}},
        overlap={"0x700634AE"},
        level=15
    })
    self.warden:AddSkill({
        id="0x70063242",
        nameEN="Muster at Andrath", labelEN="Andrath (Muster)",
        nameDE="Appell in Andrath", labelDE="Andrath (Appell)",
        nameFR="Rassemblement à Andrath", labelFR="Andrath (Rassemblement)",
        map={{MapType.ERIADOR, 580, 465}},
        overlap={"0x7006323D"},
        level=17
    })
    self.warden:AddSkill({
        id="0x7006133E",
        nameEN="Muster at Nobottle", labelEN="Nobottle (Muster)",
        nameDE="Appell in Neuhausen", labelDE="Neuhausen (Appell)",
        nameFR="Rassemblement à Bourdeneuve", labelFR="Bourdeneuve (Rassemblement)",
        map={{MapType.ERIADOR, 440, 350}},
        overlap={"0x70061340"},
        level=20
    })
    self.warden:AddSkill({
        id="0x70014786",
        nameEN="Muster in Ost Guruth", labelEN="Ost Guruth (Muster)",
        nameDE="Appell in der Feste Guruth", labelDE="Feste Guruth (Appell)",
        nameFR="Rassemblement : Ost Guruth", labelFR="Ost Guruth (Rassemblement)",
        map={{MapType.ERIADOR, 755, 400}},
        overlap={"0x70020441"},
        level=25
    })
    self.warden:AddSkill({
        id="0x70014798",
        nameEN="Muster in Esteldín", labelEN="Esteldín (Muster)",
        nameDE="Appell in Esteldín", labelDE="Esteldín (Appell)",
        nameFR="Rassemblement : Esteldin", labelFR="Esteldin (Rassemblement)",
        map={{MapType.ERIADOR, 655, 290}},
        level=30
    })
    self.warden:AddSkill({
        id="0x7001478E",
        nameEN="Muster in Evendim", labelEN="Evendim (Muster)",
        nameDE="Appell in Evendim", labelDE="Evendim (Appell)",
        nameFR="Rassemblement : La région d'Evendim", labelFR="Evendim (Rassemblement)",
        map={{MapType.ERIADOR, 490, 235}},
        level=35
    })
    self.warden:AddSkill({
        id="0x70060EA5",
        nameEN="Muster at Tornhad", labelEN="Tornhad (Muster)",
        nameDE="Appell in Tornhad", labelDE="Tornhad (Appell)",
        nameFR="Retour à Tornhad", labelFR="Tornhad (Rassemblement)",
        map={{MapType.ERIADOR, 775, 435}},
        overlap={"0x70060EA8"},
        level=40
    })
    self.warden:AddSkill({
        id="0x70014791",
        nameEN="Muster in Rivendell", labelEN="Rivendell (Muster)",
        nameDE="Appell in Bruchtal", labelDE="Bruchtal (Appell)",
        nameFR="Rassemblement : Fondcombe", labelFR="Fondcombe (Rassemblement)",
        map={{MapType.ERIADOR, 865, 410}},
        overlap={"0x7000631F", "0x70023263"},
        level=40.1
    })
    self.warden:AddSkill({
        id="0x700303DD",
        nameEN="Muster in the Misty Mountains", labelEN="Misty Mountains (Muster)",
        nameDE="Appell im Nebelgebirge", labelDE="Nebelgebirge (Appell)",
        nameFR="Rassemblement : Les Monts Brumeux", labelFR="Monts Brumeux (Rassemblement)",
        map={{MapType.ERIADOR, 915, 265}},
        level=40.2
    })
    self.warden:AddSkill({
        id="0x70059D10",
        nameEN="Muster in Trestlebridge", labelEN="Trestlebridge (Muster)",
        nameDE="Appell in Schragen", labelDE="Schragen (Appell)",
        nameFR="Rassemblement : Pont-à-Tréteaux", labelFR="Pont-à-Tréteaux (Rassemblement)",
        map={{MapType.ERIADOR, 590, 285}},
        overlap={"0x70059D12"},
        level=40.3
    })
    self.warden:AddSkill({
        id="0x70059D09",
        nameEN="Muster in Trader's Wharf", labelEN="Trader's Wharf (Muster)",
        nameDE="Appell am Händlerkai", labelDE="Händlerkai (Appell)",
        nameFR="Rassemblement : Quai des marchands", labelFR="Quai des marchands (Rassemblement)",
        map={{MapType.ERIADOR, 515, 305}},
        overlap={"0x70059D0E"},
        level=40.4
    })
    self.warden:AddSkill({
        id="0x700237D4",
        nameEN="Muster in Sûri-kylä", labelEN="Sûri-kylä (Muster)",
        nameDE="Appell in Sûri-kylä", labelDE="Sûri-kylä (Appell)",
        nameFR="Rassemblement : Sûri-kylä", labelFR="Sûri-kylä (Rassemblement)",
        map={{MapType.ERIADOR, 430, 50}},
        level=42
    })
    self.warden:AddSkill({
        id="0x7001819E",
        nameEN="Muster in the Twenty-first Hall", labelEN="Twenty-first Hall (Muster)",
        nameDE="Appell in der Einundzwanzigsten Halle", labelDE="21. Halle (Appell)",
        nameFR="Rassemblement : La vingt et unième salle", labelFR="Vingt et unième salle (Rassemblement)",
        map={{MapType.RHOVANION, 95, 585}, {MapType.ERIADOR, 950, 510}},
        level=55
    })
    self.warden:AddSkill({
        id="0x700303DF",
        nameEN="Muster in Caras Galadhon", labelEN="Caras Galadhon (Muster)",
        nameDE="Appell in Caras Galadhon", labelDE="Caras Galadhon (Appell)",
        nameFR="Rassemblement : Caras Galadhon", labelFR="Caras Galadhon (Rassemblement)",
        map={{MapType.RHOVANION, 120, 660}},
        overlap={"0x70048C8C"},
        level=60
    })
    self.warden:AddSkill({
        id="0x7001F45C",
        nameEN="Muster in Mirk-eaves", labelEN="Mirk-Eaves (Muster)",
        nameDE="Appell in der Dunkelsenke", labelDE="Dunkelsenke (Appell)",
        nameFR="Rassemblement : L'Orée noire", labelFR="Orée noire (Rassemblement)",
        map={{MapType.RHOVANION, 365, 630}},
        level=61
    })
    self.warden:AddSkill({
        id="0x700235EB",
        nameEN="Muster in Harndirion", labelEN="Harndirion (Muster)",
        nameDE="Appell in Harndirion", labelDE="Harndirion (Appell)",
        nameFR="Rassemblement : Harndirion", labelFR="Harndirion (Rassemblement)",
        map={{MapType.ERIADOR, 815, 635}},
        level=62
    })
    self.warden:AddSkill({
        id="0x7002A90A",
        nameEN="Muster in Galtrev", labelEN="Galtrev (Muster)",
        nameDE="Appell in Galtrev", labelDE="Galtrev (Appell)",
        nameFR="Rassemblement : Galtrev", labelFR="Galtrev (Rassemblement)",
        map={{MapType.ERIADOR, 810, 715}},
        overlap={"0x7002C647"},
        level=65
    })
    self.warden:AddSkill({
        id="0x7002C646",
        nameEN="Muster in Stangard", labelEN="Stangard (Muster)",
        nameDE="Appell in Stangard", labelDE="Stangard (Appell)",
        nameFR="Rassemblement : Stangarde", labelFR="Stangarde (Rassemblement)",
        map={{MapType.RHOVANION, 200, 720}, {MapType.ROHAN, 545, 90}},
        overlap={"0x7002C65D"},
        level=75
    })
    self.warden:AddSkill({
        id="0x7003198D",
        nameEN="Muster in Snowbourn", labelEN="Snowbourn (Muster)",
        nameDE="Appell in Schneegrenze", labelDE="Schneegrenze (Appell)",
        nameFR="Rassemblement : Neigebronne", labelFR="Neigebronne (Rassemblement)",
        map={{MapType.ROHAN, 515, 500}},
        overlap={"0x70031A46"},
        level=80
    })
    self.warden:AddSkill({
        id="0x70036B5B",
        nameEN="Muster in Forlaw", labelEN="Forlaw (Muster)",
        nameDE="Appell in Forlach", labelDE="Forlach (Appell)",
        nameFR="Rassemblement : Forloi", labelFR="Forloi (Rassemblement)",
        map={{MapType.ROHAN, 450, 175}},
        overlap={"0x70036B5E"},
        level=85
    })
    self.warden:AddSkill({
        id="0x7003DC7A",
        nameEN="Muster in Aldburg", labelEN="Aldburg (Muster)",
        nameDE="Appell in Aldburg", labelDE="Aldburg (Appell)",
        nameFR="Rassemblement : Aldburg", labelFR="Aldburg (Rassemblement)",
        map={{MapType.ROHAN, 570, 640}},
        overlap={"0x7003DC81"},
        level=88
    })
    self.warden:AddSkill({
        id="0x7003DC79",
        nameEN="Muster in Helm's Deep", labelEN="Helm's Deep (Muster)",
        nameDE="Appell in Helms Klamm", labelDE="Helms Klamm (Appell)",
        nameFR="Rassemblement : Gouffre de Helm", labelFR="Gouffre de Helm (Rassemblement)",
        map={{MapType.ROHAN, 275, 565}},
        overlap={"0x7003DC82"},
        level=90
    })
    self.warden:AddSkill({
        id="0x70041198",
        nameEN="Muster in Dol Amroth", descEN="Dol Amroth in western Gondor", labelEN="Dol Amroth (Muster)",
        nameDE="Appell in Dol Amroth", descDE="West-Gondor zu reisen", labelDE="Dol Amroth (Appell)",
        nameFR="Rassemblement : Dol Amroth", descFR="l'Ouest du Gondor", labelFR="Dol Amroth (Rassemblement)",
        map={{MapType.GONDOR, 225, 550}},
        overlap={"0x700411AC"},
        level=98
    })
    self.warden:AddSkill({
        id="0x70043A66",
        nameEN="Muster in Arnach", labelEN="Arnach (Muster)",
        nameDE="Appell in Arnach", labelDE="Arnach (Appell)",
        nameFR="Rassemblement : Arnach", labelFR="Arnach (Rassemblement)",
        map={{MapType.GONDOR, 715, 425}},
        overlap={"0x70043A6A"},
        level=100
    })
    self.warden:AddSkill({
        id="0x70044982",
        nameEN="Muster in Minas Tirith", labelEN="Minas Tirith (Muster)",
        nameDE="Appell in Minas Tirith", labelDE="Minas Tirith (Appell)",
        nameFR="Rassemblement : Minas Tirith", labelFR="Minas Tirith (Rassemblement)",
        map={{MapType.GONDOR, 670, 345}},
        overlap={"0x7004497E"},
        level=100.1
    })
    self.warden:AddSkill({
        id="0x700459AA",
        nameEN="Muster in the War-stead", labelEN="War-stead (Muster)",
        nameDE="Appell im Kriegslager", labelDE="Kriegslager der Rohirrim (Appell)",
        nameFR="Rassemblement : Camp militaire", labelFR="Camp militaire (Rassemblement)",
        map={{MapType.GONDOR, 665, 140}},
        overlap={"0x700459A9"},
        level=102
    })
    self.warden:AddSkill({
        id="0x70046CBF",
        nameEN="Muster in after-battle Minas Tirith", labelEN="Minas Tirith after battle (Muster)",
        nameDE="Appell im schlachtgezeichneten Minas Tirith", labelDE="Minas Tirith nach der Schlacht (Appell)",
        nameFR="Rassemblement : Minas Tirith après la bataille", labelFR="Minas Tirith après la bataille (Rassemblement)",
        map={{MapType.GONDOR, 670, 375}},
        overlap={"0x70046CC0"},
        level=105
    })
    self.warden:AddSkill({
        id="0x70047076",
        nameEN="Muster in after-battle Osgiliath", labelEN="Osgiliath after-battle (Muster)",
        nameDE="Appell im schlachtgezeichneten Osgiliath", labelDE="Osgiliath nach der Schlacht (Appell)",
        nameFR="Rassemblement : Osgiliath après la bataille", labelFR="Osgiliath après la bataille (Rassemblement)",
        map={{MapType.GONDOR, 855, 335}},
        overlap={"0x7004707D"},
        level=105.1
    })
    self.warden:AddSkill({
        id="0x70047075",
        nameEN="Muster in Henneth Annûn", labelEN="Henneth Annûn (Muster)",
        nameDE="Appell in Henneth Annûn", labelDE="Henneth Annûn (Appell)",
        nameFR="Rassemblement : Henneth Annûn", labelFR="Henneth Annûn (Rassemblement)",
        map={{MapType.GONDOR, 875, 385}},
        overlap={"0x70047080"},
        level=105.2
    })
    self.warden:AddSkill({
        id="0x70047BFC",
        nameEN="Muster in the Camp of the Host", labelEN="Camp of the Host (Muster)",
        nameDE="Appell im Lager des Heeres", labelDE="Lager des Heeres (Appell)",
        nameFR="Rassemblement : Camp de l'armée", labelFR="Camp de l'armée (Rassemblement)",
        map={{MapType.GONDOR, 805, 170}},
        overlap={"0x70047BF4"},
        level=105.3
    })
    self.warden:AddSkill({
        id="0x70047C23",
        nameEN="Muster in Haerondir", labelEN="Haerondir (Muster)",
        nameDE="Appell in Haerondir", labelDE="Haerondir (Appell)",
        nameFR="Rassemblement : Haerondir", labelFR="Haerondir (Rassemblement)",
        map={{MapType.GONDOR, 855, 100}},
        overlap={"0x70047C1B"},
        level=105.4
    })
    self.warden:AddSkill({
        id="0x7004AE1F",
        nameEN="Muster in the Udûn Foothold", labelEN="Udûn Foothold (Muster)",
        nameDE="Appell am Udûn-Brückenkopf", labelDE="Udûn-Brückenkopf (Appell)",
        nameFR="Rassemblement : Le fort d'Udûn", labelFR="Fort d'Udûn (Rassemblement)",
        map={{MapType.GONDOR, 925, 230}},
        overlap={"0x7004AE1D"},
        level=106
    })
    self.warden:AddSkill({
        id="0x7004D73A",
        nameEN="Muster in Dale", labelEN="Dale (Muster)",
        nameDE="Appell in Thal", labelDE="Thal (Appell)",
        nameFR="Rassemblement : Dale", labelFR="Dale (Rassemblement)",
        map={{MapType.RHOVANION, 720, 215}},
        overlap={"0x7004D738"},
        level=115
    })
    self.warden:AddSkill({
        id="0x7004FACA",
        nameEN="Muster in Járnfast", labelEN="Járnfast (Muster)",
        nameDE="Appell in Járnfast", labelDE="Jarnfast (Appell)",
        nameFR="Rassemblement : Jarnfast", labelFR="Jarnfast (Rassemblement)",
        map={{MapType.RHOVANION, 890, 110}},
        overlap={"0x7004FAC3"},
        level=116
    })
    self.warden:AddSkill({
        id="0x7004FACD",
        nameEN="Muster in Skarháld", labelEN="Skarháld (Muster)",
        nameDE="Appell in Skarháld", labelDE="Skarhald (Appell)",
        nameFR="Rassemblement : Skarhald", labelFR="Skarhald (Rassemblement)",
        map={{MapType.RHOVANION, 430, 90}},
        overlap={"0x7004FAC5"},
        level=117
    })
    self.warden:AddSkill({
        id="0x70052F0A",
        nameEN="Muster in Beorninghús", labelEN="Beorninghús (Muster)",
        nameDE="Appell im Beorningerhús", labelDE="Beorningerhús (Appell)",
        nameFR="Rassemblement : Beorninghus", labelFR="Beorninghus (Rassemblement)",
        map={{MapType.RHOVANION, 390, 300}},
        overlap={"0x70041A22", "0x70052F12"},
        level=120
    })
    self.warden:AddSkill({
        id="0x70052F06",
        nameEN="Muster in Hultvís", labelEN="Hultvís (Muster)",
        nameDE="Appell in Hultvís", labelDE="Hultvís (Appell)",
        nameFR="Rassemblement : Hultvis", labelFR="Hultvis (Rassemblement)",
        map={{MapType.RHOVANION, 375, 400}},
        overlap={"0x70052F04"},
        level=120.1
    })
    self.warden:AddSkill({
        id="0x700551F2",
        nameEN="Muster in Estolad Lân", labelEN="Estolad Lân (Muster)",
        nameDE="Appell in Estolad Lân", labelDE="Estolad Lân (Appell)",
        nameFR="Rassemblement : Estolad Lân", labelFR="Estolad Lân (Rassemblement)",
        map={{MapType.GONDOR, 960, 460}},
        overlap={"0x700551F8"},
        level=125
    })
    self.warden:AddSkill({
        id="0x70057635",
        nameEN="Muster in Limlók", labelEN="Limlók (Muster)",
        nameDE="Appell in Limlók", labelDE="Limlók (Appell)",
        nameFR="Rassemblement : Limlok", labelFR="Limlok (Rassemblement)",
        map={{MapType.RHOVANION, 345, 230}},
        overlap={"0x70057629"},
        level=130
    })
    self.warden:AddSkill({
        id="0x70058572",
        nameEN="Muster in Annâk-khurfu", labelEN="Annâk-khurfu (Muster)",
        nameDE="Appell in Annâk-khurfu", labelDE="Annâk-khurfu (Appell)",
        nameFR="Rassemblement : Annâk-khurfu", labelFR="Annâk-khurfu (Rassemblement)",
        map={{MapType.RHOVANION, 530, 90}},
        overlap={"0x7005856F"},
        level=130.1
    })
    self.warden:AddSkill({
        id="0x7005AA8F",
        nameEN="Muster in Akrâz-zahar", labelEN="Akrâz-zahar (Muster)",
        nameDE="Appell in Akrâz-zahar", labelDE="Akrâz-zahar (Appell)",
        nameFR="Rassemblement : Akrâz-zahar", labelFR="Akrâz-zahar (Rassemblement)",
        map={{MapType.RHOVANION, 750, 115}},
        overlap={"0x7005AA90"},
        level=130.2
    })
    self.warden:AddSkill({
        id="0x7005AA8C",
        nameEN="Muster in Azanulbizar", labelEN="Azanulbizar (Muster)",
        nameDE="Appell in Azanulbizar", labelDE="Azanulbizar (Appell)",
        nameFR="Rassemblement : Azanulbizar", labelFR="Azanulbizar (Rassemblement)",
        map={{MapType.RHOVANION, 210, 555}},
        overlap={"0x7005AA92"},
        level=130.3
    })
    self.warden:AddSkill({
        id="0x7005D48A",
        nameEN="Muster at the Noble Gate", labelEN="Noble Gate (Muster)",
        nameDE="Appell am Prachttor", labelDE="Prachttor (Appell)",
        nameFR="Rassemblement : La Porte Noble", labelFR="Porte Noble (Rassemblement)",
        map={{MapType.RHOVANION, 190, 130}},
        overlap={"0x7005D47C"},
        level=131
    })
    self.warden:AddSkill({
        id="0x7005D488",
        nameEN="Muster at Leitstáth", labelEN="Leitstáth (Muster)",
        nameDE="Appell in Leitstáth", labelDE="Leitstáth (Appell)",
        nameFR="Rassemblement : Leitstath", labelFR="Leitstath (Rassemblement)",
        map={{MapType.RHOVANION, 270, 65}},
        overlap={"0x7005D484"},
        level=135
    })
    self.warden:AddSkill({
        id="0x70064ACB",
        nameEN="Muster at Carn Dûm", labelEN="Carn Dûm (Muster)",
        nameDE="Appell in Carn Dûm", labelDE="Carn Dûm (Appell)",
        nameFR="Rassemblement : Carn Dûm", labelFR="Carn Dûm (Rassemblement)",
        map={{MapType.ERIADOR, 735, 100}},
        overlap={"0x70064ACA"},
        level=140.1
    })
    self.warden:AddSkill({
        id="0x700658E8",
        nameEN="Muster at Pelargir", labelEN="Pelargir (Muster)",
        nameDE="Heerschau in Pelargir", labelDE="Pelargir (Appell)",
        nameFR="Rassemblement à Pelargir", labelFR="Pelargir (Rassemblement)",
        map={{MapType.GONDOR, 670, 625}},
        overlap={"0x700658EB"},
        level=141
    })
    self.warden:AddSkill({
        id="0x70068712",
        nameEN="Muster at Dol Amroth", descEN="King's Gondor", labelEN="King's Dol Amroth (Muster)",
        nameDE="Appell in Dol Amroth", descDE="Königreich Gondor", labelDE="Dol Amroth - Königreich Gondor (Appell)",
        nameFR="Rassemblement à Dol Amroth", descFR="le Gondor royal", labelFR="Dol Amroth - Gondor royal (Rassemblement)",
        map={{MapType.GONDOR, 210, 485}, {MapType.HARADWAITH, 385, 70}},
        overlap={"0x70068700"},
        level=142
    })
    self.warden:AddSkill({
        id="0x70068715",
        nameEN="Muster at Lond Cirion", labelEN="Lond Cirion (Muster)",
        nameDE="Appell in Lond Cirion", labelDE="Lond Cirion (Appell)",
        nameFR="Rassemblement à Lond Cirion", labelFR="Lond Cirion (Rassemblement)",
        map={{MapType.GONDOR, 255, 420}, {MapType.HARADWAITH, 230, 20}},
        overlap={"0x70068703"},
        level=143
    })
    self.warden:AddSkill({
        id="0x70068710",
        nameEN="Muster at Halrax", labelEN="Halrax (Muster)",
        nameDE="Appell in Halrax", labelDE="Halrax (Appell)",
        nameFR="Rassemblement à Halrax", labelFR="Halrax (Rassemblement)",
        map={{MapType.HARADWAITH, 275, 260}},
        overlap={"0x70068702"},
        level=145
    })
    self.warden:AddSkill({
        id="0x7006870C",
        nameEN="Muster at Jax Phanâl", labelEN="Jax Phanâl (Muster)",
        nameDE="Appell in Jax Phanâl", labelDE="Jax Phanâl (Appell)",
        nameFR="Rassemblement à Jax Phanâl", labelFR="Jax Phanâl (Rassemblement)",
        map={{MapType.HARADWAITH, 305, 315}},
        overlap={"0x70068701"},
        level=146
    })
    self.warden:AddSkill({
        id="0x7006870F",
        nameEN="Muster at Umbar", labelEN="Umbar (Muster)",
        nameDE="Appell in Umbar", labelDE="Umbar (Appell)",
        nameFR="Rassemblement à Umbar", labelFR="Umbar (Rassemblement)",
        map={{MapType.HARADWAITH, 505, 370}},
        overlap={"0x700686FF"},
        level=148
    })
    self.warden:AddSkill({
        id="0x700697F3",
        nameEN="Muster at the Bloody Eagle Tavern", labelEN="Bloody Eagle Tavern (Muster)",
        nameDE="Appell in der Taverne \"Zum Blutigen Adler\"", labelDE="Zum Blutigen Adler (Appell)",
        nameFR="Rassemblement à la taverne de l'Aigle sanglant", labelFR="Taverne de l'Aigle sanglant (Rassemblement)",
        map={{MapType.HARADWAITH, 475, 400}},
        overlap={"0x700697F2"},
        level=149
    })

    -- add the Mariner locations
    self.mariner:AddSkill({
        id="0x70066100",
        nameEN="Sail to Celondim", labelEN="Celondim (Sail)",
        nameDE="Segelt nach Celondim", labelDE="Celondim (Segeln)",
        nameFR="Naviguer vers Celondim", labelFR="Celondim (Naviguer)",
        map={{MapType.ERIADOR, 310, 380}},
        level=1
    })
    self.mariner:AddSkill({
        id="0x7006611A",
        nameEN="Sail to Buckland", labelEN="Buckland (Sail)",
        nameDE="Segelt nach Bockland", labelDE="Bockland (Segeln)",
        nameFR="Naviguer vers le Pays de Bouc", labelFR="Pays de Bouc (Naviguer)",
        map={{MapType.ERIADOR, 515, 405}},
        level=4
    })
    self.mariner:AddSkill({
        id="0x70066120",
        nameEN="Sail to Tharbad", labelEN="Tharbad (Sail)",
        nameDE="Nach Tharbad segeln", labelDE="Tharbad (Segeln)",
        nameFR="Naviguer vers le Gué de Sarn", labelFR="le Gué de Sarn (Naviguer)",
        map={{MapType.ERIADOR, 650, 525}},
        level=5
    })
    self.mariner:AddSkill({
        id="0x7006610F",
        nameEN="Sail to Tinnudir", labelEN="Tinnudir (Sail)",
        nameDE="Segelt nach Tinnudir", labelDE="Tinnundir (Segeln)",
        nameFR="Naviguer vers Tinnudir", labelFR="Tinnudir (Naviguer)",
        map={{MapType.ERIADOR, 420, 250}},
        level=30
    })
    self.mariner:AddSkill({
        id="0x70066105",
        nameEN="Sail to Trader's Wharf", labelEN="Trader's Wharf (Sail)",
        nameDE="Segelt zum Händlerkai", labelDE="Händlerkai (Segel)",
        nameFR="Naviguer vers le Quai des marchands", labelFR="Quai des marchands (Naviguer)",
        map={{MapType.ERIADOR, 515, 305}},
        overlap={"0x70059D0E"},
        level=40.4
    })
    self.mariner:AddSkill({
        id="0x7006611C",
        nameEN="Sail to Sûri-kylä", labelEN="Sûri-kylä (Sail)",
        nameDE="Segelt nach Sûri-kylä", labelDE="Sûri-kylä (Segeln)",
        nameFR="Naviguer vers Sûri-kylä", labelFR="Sûri-kylä (Naviguer)",
        map={{MapType.ERIADOR, 430, 50}},
        level=42
    })
    self.mariner:AddSkill({
        id="0x7006611E",
        nameEN="Sail to Lothlórien", labelEN="Lothlórien (Sail)",
        nameDE="Segelt nach Lothlórien", labelDE="Lothlórien (Segeln)",
        nameFR="Naviguer vers la Lothlorien", labelFR="Lothlorien (Naviguer)",
        map={{MapType.RHOVANION, 245, 670}},
        overlap={"0x70048C8C"},
        level=60
    })
    self.mariner:AddSkill({
        id="0x7006610E",
        nameEN="Sail to the Mirk-eaves", labelEN="Mirk-eaves (Sail)",
        nameDE="Segelt zur Dunkelsenke", labelDE="Dunkelsenke (Segeln)",
        nameFR="Naviguer vers l'Orée Noire", labelFR="Orée Noire (Naviguer)",
        map={{MapType.RHOVANION, 365, 630}},
        level=61
    })
    self.mariner:AddSkill({
        id="0x70066101",
        nameEN="Sail to the Brown Lands", labelEN="Brown Lands (Sail)",
        nameDE="Segelt in die Braunen Lande", labelDE="Braune Lande (Segeln)",
        nameFR="Naviguer vers les Terres brunes", labelFR="Terres brunes (Naviguer)",
        map={{MapType.ROHAN, 700, 180}},
        level=75.1
    })
    self.mariner:AddSkill({
        id="0x70066121",
        nameEN="Sail to Snowbourn", labelEN="Snowbourn (Sail)",
        nameDE="Segelt nach Schneegrenze", labelDE="Schneegrenze (Segeln)",
        nameFR="Naviguer vers Neigebronne", labelFR="Neigebronne (Naviguer)",
        map={{MapType.ROHAN, 515, 500}},
        overlap={"0x70031A46"},
        level=80
    })
    self.mariner:AddSkill({
        id="0x70066117",
        nameEN="Sail to Dol Amroth", descEN="Dol Amroth with nearby", labelEN="Dol Amroth (Sail)",
        nameDE="Segelt nach Dol Amroth", descDE="nach Dol Amroth.", labelDE="Dol Amroth (Segeln)",
        nameFR="Naviguer vers Dol Amroth", descFR="Dol Amroth en bonne compagnie.", labelFR="Dol Amroth (Naviguer)",
        map={{MapType.GONDOR, 225, 550}},
        overlap={"0x700411AC"},
        level=98
    })
    self.mariner:AddSkill({
        id="0x70066109",
        nameEN="Sail to after-battle Osgiliath", labelEN="Osgiliath after-battle (Sail)",
        nameDE="Segelt ins schlachtgezeichnete Osgiliath", labelDE="Schlachtgezeichnetes Osgiliath (Segeln)",
        nameFR="Naviguer vers Osgiliath après la bataille", labelFR="Osgiliath après la bataille (Naviguer)",
        map={{MapType.GONDOR, 855, 335}},
        overlap={"0x7004707D"},
        level=105.1
    })
    self.mariner:AddSkill({
        id="0x7006610C",
        nameEN="Sail to Lake-town", labelEN="Lake-town (Sail)",
        nameDE="Segelt nach Seestadt.", labelDE="Seestadt (Segeln)",
        nameFR="Cap sur la Ville du Lac", labelFR="Ville du Lac (Naviguer)",
        map={{MapType.RHOVANION, 740, 275}},
        overlap={"0x7004D738"},
        level=115
    })
    self.mariner:AddSkill({
        id="0x7006611B",
        nameEN="Sail to Pelargir", labelEN="Pelargir (Sail)",
        nameDE="Segelt nach Pelargir", labelDE="Pelargir (Segeln)",
        nameFR="Naviguer vers Pelargir", labelFR="Pelargir (Naviguer)",
        map={{MapType.GONDOR, 670, 625}},
        overlap={"0x700658EB"},
        level=141
    })
    self.mariner:AddSkill({
        id="0x700687C1",
        nameEN="Sail to Dol Amroth", descEN="King's Gondor", labelEN="King's Dol Amroth (Sail)",
        nameDE="Segelt nach Dol Amroth", descDE="Königreich Gondor", labelDE="Dol Amroth - Königreich Gondor (Segeln)",
        nameFR="Naviguer vers Dol Amroth", descFR="le Gondor royal", labelFR="Dol Amroth - Gondor royal (Naviguer)",
        map={{MapType.GONDOR, 210, 485}, {MapType.HARADWAITH, 385, 70}},
        overlap={"0x70068700"},
        level=142
    })
    self.mariner:AddSkill({
        id="0x700687BD",
        nameEN="Sail to Lond Cirion", labelEN="Lond Cirion (Sail)",
        nameDE="Nach Lond Cirion segeln", labelDE="Lond Cirion (Segeln)",
        nameFR="Naviguer vers Lond Cirion", labelFR="Lond Cirion (Naviguer)",
        map={{MapType.GONDOR, 255, 420}, {MapType.HARADWAITH, 230, 20}},
        overlap={"0x70068703"},
        level=143
    })
    self.mariner:AddSkill({
        id="0x700687C3",
        nameEN="Sail to Halrax", labelEN="Halrax (Sail)",
        nameDE="Nach Halrax segeln", labelDE="Halrax (Segeln)",
        nameFR="Naviguer vers Halrax", labelFR="Halrax (Naviguer)",
        map={{MapType.HARADWAITH, 275, 160}},
        overlap={"0x70068702"},
        level=145
    })
    self.mariner:AddSkill({
        id="0x700687C0",
        nameEN="Sail to Jax Phanâl", labelEN="Jax Phanâl (Sail)",
        nameDE="Nach Jax Phanâl segeln", labelDE="Jax Phanâl (Segeln)",
        nameFR="Naviguer vers Jax Phanâl", labelFR="Jax Phanâl (Naviguer)",
        map={{MapType.HARADWAITH, 305, 315}},
        overlap={"0x70068701"},
        level=146
    })
    self.mariner:AddSkill({
        id="0x700687BB",
        nameEN="Sail to Umbar", labelEN="Umbar (Sail)",
        nameDE="Nach Umbar segeln", labelDE="Umbar (Segeln)",
        nameFR="Naviguer vers Umbar", labelFR="Umbar (Naviguer)",
        map={{MapType.HARADWAITH, 505, 370}},
        overlap={"0x700686FF"},
        level=148
    })

    -- add the racial travel skills
    self.racials:AddSkill({
        -- man
        id="0x700062F6",
        nameEN="Return to Bree", descEN="This enables you to quickly return", labelEN="Bree (Racial)",
        nameDE="Rückkehr nach Bree", descDE="Ihr könnt schnell nach Bree", labelDE="Bree (Rasse)",
        nameFR="Retour à Bree", descFR="Permet de retourner", labelFR="Bree (Race)",
        map={MapType.ERIADOR, 525, 335},
        level=5
    })
    self.racials:AddSkill({
        -- hobbit
        id="0x700062C8",
        nameEN="Return to the Shire", labelEN="Shire (Racial)",
        nameDE="Rückkehr ins Auenland", labelDE="Michelbinge (Rasse)",
        nameFR="Retournez dans la Comté", labelFR="Comté (Race)",
        map={MapType.ERIADOR, 405, 440},
        level=1
    })
    self.racials:AddSkill({
        -- dwarf
        id="0x70006346",
        nameEN="Return to Thorin's Gate", descEN="This enables you to quickly return", labelEN="Thorin's Gate (Racial)",
        nameDE="Rückkehr zu Thorins Tor", descDE="Hiermit gelangt Ihr schnell", labelDE="Thorins Tor (Rasse Zwerg)",
        nameFR="Retour : Porte de Thorin", descFR="Ceci vous permet de retourner", labelFR="Porte de Thorin (Race)",
        map={MapType.ERIADOR, 310, 270},
        level=1.2
    })
    self.racials:AddSkill({
        -- elf
        id="0x7000631F",
        nameEN="Return to Rivendell", descEN="This enables you to quickly return", labelEN="Rivendell (Racial)",
        nameDE="Rückkehr nach Bruchtal", descDE="Hiermit gelangt Ihr schnell", labelDE="Bruchtal (Rasse)",
        nameFR="Retour à Fondcombe", descFR="Ceci vous permet de retourner", labelFR="Fondcombe (Race)",
        map={MapType.ERIADOR, 900, 375},
        level=40.1
    })
    self.racials:AddSkill({
        -- beorning
        id="0x70041A22",
        nameEN="Return Home", labelEN="Beorning Home (Racial)",
        nameDE="Zum 1. Heim zurückkehren", labelDE="Grimbeorns Hütte (Rasse)",
        nameFR="Retour à la maison", labelFR="Maison Beorning (Race)",
        map={MapType.RHOVANION, 285, 340},
        level=120
    })
    self.racials:AddSkill({
        -- high elf
        id="0x70048C8C",
        nameEN="Travel to Caras Galadhon in Lothlórien", labelEN="Caras Galadhon (Racial)",
        nameDE="Reise nach Caras Galadhon in Lothlórien", labelDE="Caras Galadhon (Rasse)",
        nameFR="Voyage vers Caras Galadhon, en Lothlórien", labelFR="Caras Galadhon (Race)",
        map={MapType.RHOVANION, 120, 690},
        level=60
    })
    self.racials:AddSkill({
        -- stoutaxe
        id="0x70053C0F",
        nameEN="Travel to Thorin's Hall", labelEN="Thorin's Hall (Racial)",
        nameDE="Reise zu Thorins Halle", labelDE="Thorins Halle (Rasse Starkaxt)",
        nameFR="Aller au Palais de Thorin", labelFR="Palais de Thorin (Race)",
        map={MapType.ERIADOR, 345, 310},
        level=1.2
    })
    self.racials:AddSkill({
        -- river hobbit
        id="0x70066D31",
        nameEN="Return to Lyndelby", labelEN="Lyndelby (Racial)",
        nameDE="Kehrt zu Lyndelby zurück.", labelDE="Lyndelby (Rasse)", 
        nameFR="Retour à Lyndelby", labelFR="Lyndelby (Race)",
        map={MapType.RHOVANION, 155, 165},
        level=1.3
    })

    -- add the Return Home and housing skills
    self.gen:AddSkill({
        id="0x700256BA",
        nameEN="Return Home",
        nameDE="Zum 1. Heim zurückkehren", labelDE="1. Markstein",
        nameFR="Retour à la maison", labelFR="Point de repère 1",
        map={MapType.NONE, -1, -1},
        level=1
    })
    self.gen:AddSkill({
        id="0x70025792",
        nameEN="Return Home 2",
        nameDE="Zum 2. Heim zurückkehren", labelDE="2. Markstein",
        nameFR="Retour à la maison 2", labelFR="Point de repère 2",
        map={MapType.NONE, -1, -1},
        level=1
    })
    self.gen:AddSkill({
        id="0x70025793",
        nameEN="Return Home 3",
        nameDE="Zum 3. Heim zurückkehren", labelDE="3. Markstein",
        nameFR="Retour à la maison 3", labelFR="Point de repère 3",
        map={MapType.NONE, -1, -1},
        level=1
    })
    self.gen:AddSkill({
        id="0x70025794",
        nameEN="Return Home 4",
        nameDE="Zum 4. Heim zurückkehren", labelDE="4. Markstein",
        nameFR="Retour à la maison 4", labelFR="Point de repère 4",
        map={MapType.NONE, -1, -1},
        level=1
    })
    self.gen:AddSkill({
        id="0x70025795",
        nameEN="Return Home 5",
        nameDE="Zum 5. Heim zurückkehren", labelDE="5. Markstein",
        nameFR="Retour à la maison 5", labelFR="Point de repère 5",
        map={MapType.NONE, -1, -1},
        level=1
    })
    self.gen:AddSkill({
        id="0x70025796",
        nameEN="Return Home 6",
        nameDE="Zum 6. Heim zurückkehren", labelDE="6. Markstein",
        nameFR="Retour à la maison 6", labelFR="Point de repère 6",
        map={MapType.NONE, -1, -1},
        level=1
    })
    self.gen:AddSkill({
        id="0x7002FF62",
        nameEN="Return Home 7",
        nameDE="Zum 7. Heim zurückkehren", labelDE="7. Markstein",
        nameFR="Retour à la maison 7", labelFR="Point de repère 7",
        map={MapType.NONE, -1, -1},
        level=1
    })
    self.gen:AddSkill({
        id="0x7002FF61",
        nameEN="Return Home 8",
        nameDE="Zum 8. Heim zurückkehren", labelDE="8. Markstein",
        nameFR="Retour à la maison 8", labelFR="Point de repère 8",
        map={MapType.NONE, -1, -1},
        level=1
    })
    self.gen:AddSkill({
        id="0x7002FF60",
        nameEN="Return Home 9",
        nameDE="Zum 9. Heim zurückkehren", labelDE="9. Markstein",
        nameFR="Retour à la maison 9", labelFR="Point de repère 9",
        map={MapType.NONE, -1, -1},
        level=1
    })
    self.gen:AddSkill({
        id="0x7002FF5F",
        nameEN="Return Home 10",
        nameDE="Zum 10. Heim zurückkehren", labelDE="10. Markstein",
        nameFR="Retour à la maison 10", labelFR="Point de repère 10",
        map={MapType.NONE, -1, -1},
        level=1
    })
    self.gen:AddSkill({
        id="0x7002FF63",
        nameEN="Return Home 11",
        nameDE="Zum 11. Heim zurückkehren", labelDE="11. Markstein",
        nameFR="Retour à la maison 11", labelFR="Point de repère 11",
        map={MapType.NONE, -1, -1},
        level=1
    })
    self.gen:AddSkill({
        id="0x7000D046",
        nameEN="Travel to Personal House", labelEN="Personal House",
        nameDE="Reist zu Eurem eigenen Heim", labelDE="Eigenes Heim",
        nameFR="Retour à la maison personnelle", labelFR="Maison personnelle",
        map={MapType.NONE, -1, -1},
        level=1
    })
    self.gen:AddSkill({
        id="0x70046EE4",
        nameEN="Travel to Premium House", labelEN="Premium House",
        nameDE="Reist zu Eurem Premiumheim", labelDE="Premiumheim",
        nameFR="Aller à une maison premium", labelFR="Maison premium",
        map={MapType.NONE, -1, -1},
        level=1
    })
    self.gen:AddSkill({
        id="0x7000D047",
        nameEN="Travel to Kinship House", labelEN="Kinship House",
        nameDE="Reist zum Haus Eurer Sippe", labelDE="Heim Eurer Sippe",
        nameFR="Retour à la maison de confrérie", labelFR="Maison de confrérie",
        map={MapType.NONE, -1, -1},
        level=1
    })
    self.gen:AddSkill({
        id="0x70057C36",
        nameEN="Travel to Kinship Member's House", labelEN="Kinship Member's House",
        nameDE="Zum Haus des Sippenmitglieds reisen", labelDE="Heim des Sippenmitglieds",
        nameFR="Retour à la maison d'un membre de confrérie", labelFR="Maison d'un membre de confrérie",
        map={MapType.NONE, -1, -1},
        level=1
    })

    -- add the obtainable travel skills
    self.rep:AddSkill({
        id="0x70023262",
        nameEN="Return to Michel Delving", labelEN="Shire (Store)",
        nameDE="Rückkehr nach Michelbinge", labelDE="Michelbinge (Shop)",
        nameFR="Retour à Grand'Cave", labelFR="Retour à Grand'Cave (Shop)",
        map={{MapType.ERIADOR, 375, 440}},
        level=1
    })
    self.rep:AddSkill({
        id="0x7001BF91",
        nameEN="Return to Thorin's Gate", descEN="Thanks to your friendship", labelEN="Thorin's Gate (Rep)",
        nameDE="Rückkehr zu Thorins Tor", descDE="Dank Eurer Freundschaft", labelDE="Thorins Tor (Ruf)",
        nameFR="Retour : Porte de Thorin", descFR="Grâce à l'amitié qui vous", labelFR="Porte de Thorin (Rep/Shop)",
        map={{MapType.ERIADOR, 345, 310}},
        level=1.1
    })
    self.rep:AddSkill({
        id="0x7001BF90",
        nameEN="Return to Bree", descEN="Thanks to your friendship", labelEN="Bree (Rep)",
        nameDE="Rückkehr nach Bree", descDE="Dank Eurer Freundschaft", labelDE="Bree (Ruf)",
        nameFR="Retour à Bree", descFR="Grâce à votre amitié", labelFR="Retour à Bree (Rep/Shop)",
        map={{MapType.ERIADOR, 555, 335}},
        level=5
    })
    self.rep:AddSkill({
        id="0x700364B1",
        nameEN="Return to Lalia's Market", labelEN="Lalia's Market (Mithril)",
        nameDE="Kehrt zu Lalias Markt zurück", labelDE="Lalias Markt (Mithril)",
        nameFR="Retour au Marché de Lalia", labelFR="Retour au Marché de Lalia (Mithril)",
        map={{MapType.ERIADOR, 630, 360}},
        level=5.1
    })
    self.rep:AddSkill({
        id="0x70064F47",
        nameEN="Return to Clegur", labelEN="Clegur (Rep)",
        nameDE="Rückkehr nach Clegur", labelDE="Clegur (Ruf)",
        nameFR="Retournez voir Clegur", labelFR="Clegur (Rep)",
        map={{MapType.ERIADOR, 725, 555}},
        level=7
    })
    self.rep:AddSkill({
        id="0x700634A4",
        nameEN="Return to Swanfleet", labelEN="Swanfleet (Rep)",
        nameDE="Rückkehr nach Schwanenfleet", labelDE="Swanfleet (Ruf)",
        nameFR="Retour aux Noues des cygnes", labelFR="Noues des cygnes (Rep)",
        map={{MapType.ERIADOR, 795, 490}},
        level=10
    })
    self.rep:AddSkill({
        id="0x700634AE",
        nameEN="Return to Cardolan", labelEN="Cardolan (Rep)",
        nameDE="Rückkehr nach Cardolan", labelDE="Cardolan (Ruf)",
        nameFR="Retour au Cardolan", labelFR="Cardolan (Rep)",
        map={{MapType.ERIADOR, 590, 495}},
        level=15
    })
    self.rep:AddSkill({
        id="0x7006323D",
        nameEN="Return to Andrath", labelEN="Andrath (Rep)",
        nameDE="Rückkehr nach Andrath", labelDE="Andrath (Ruf)",
        nameFR="Retour à Andrath", labelFR="Andrath (Rep)",
        map={{MapType.ERIADOR, 550, 465}},
        level=17
    })
    self.rep:AddSkill({
        id="0x70061340",
        nameEN="Return to Nobottle", labelEN="Nobottle (Rep)",
        nameDE="Kehrt nach Neuhausen zurück.", labelDE="Neuhausen (Ruf)",
        nameFR="Retour à Bourdeneuve", labelFR="Bourdeneuve (Rep)",
        map={{MapType.ERIADOR, 410, 350}},
        level=20
    })
    self.rep:AddSkill({
        id="0x70020441",
        nameEN="Return to Ost Guruth", labelEN="Ost Guruth (Rep)",
        nameDE="Rückkehr zur Feste Guruth", labelDE="Feste Guruth (Ruf)",
        nameFR="Retournez à Ost Guruth", labelFR="Retournez à Ost Guruth (Rep)",
        map={{MapType.ERIADOR, 725, 400}},
        level=25
    })
    self.rep:AddSkill({
        id="0x70060EA8",
        nameEN="Return to Tornhad", labelEN="Tornhad (Rep)",
        nameDE="Kehrt nach Tornhad zurück.", labelDE="Tornhad (Ruf)",
        nameFR="Retournez voir Tornhad", labelFR="Tornhad (Rep)",
        map={{MapType.ERIADOR, 745, 435}},
        level=40
    })
    self.rep:AddSkill({
        id="0x70023263",
        nameEN="Return to Rivendell", descEN="Thanks to your friendship", labelEN="Rivendell (Store)",
        nameDE="Rückkehr nach Bruchtal", descDE="Dank Eurer Freundschaft", labelDE="Bruchtal (Shop)",
        nameFR="Retour à Fondcombe", descFR="Grâce à votre amitié avec", labelFR="Retour à Fondcombe (Shop)",
        map={{MapType.ERIADOR, 835, 410}},
        level=40.1
    })
    self.rep:AddSkill({
        id="0x700634A5",
        nameEN="Return to the Tracery Archives in Rivendell", labelEN="Tracery Archive (Delving)",
        nameDE="Rückkehr zu den Filigranmuster-Archiven in Bruchtal", labelDE="Filigranmuster-Archiv (Delving)",
        nameFR="Retour aux Archives de gravures de Fondcombe", labelFR="Archives de gravures (Delving)",
        map={{MapType.ERIADOR, 905, 345}},
        level=40.11
    })
    self.rep:AddSkill({
        id="0x7005B38E",
        nameEN="Return to Glân Vraig", labelEN="Glân Vraig (Quest)",
        nameDE="Nach Glân Vraig zurückkehren", labelDE="Glân Vraig (Aufgabe)",
        nameFR="Retour à Glân Vraig", labelFR="Glân Vraig (Quête)",
        map={{MapType.ERIADOR, 835, 245}},
        level=40.12
    })
    self.rep:AddSkill({
        id="0x70059D12",
        nameEN="Return to Trestlebridge", labelEN="Trestlebridge (Rep)",
        nameDE="Kehrt nach Schragen zurück.", labelDE="Schragen (Ruf)",
        nameFR="Retournez à Pont-à-Tréteaux", labelFR="Pont-à-Tréteaux (Rep)",
        map={{MapType.ERIADOR, 560, 285}},
        level=40.3
    })
    self.rep:AddSkill({
        id="0x70059D0E",
        nameEN="Return to Trader's Wharf", labelEN="Trader's Wharf (Rep)",
        nameDE="Kehrt zum Händlerkai zurück.", labelDE="Händlerkai (Ruf)",
        nameFR="Retournez au Quai des marchands", labelFR="Quai des marchands (Rep)",
        map={{MapType.ERIADOR, 515, 275}},
        level=40.4
    })
    self.rep:AddSkill({
        id="0x7001F374",
        nameEN="Return to Mirkwood", labelEN="Mirkwood (Rep)",
        nameDE="Rückkehr zum Düsterwald", labelDE="Düsterwald (Ruf)",
        nameFR="Retour dans la Forêt Noire", labelFR="Retour dans la Forêt Noire (Rep)",
        map={{MapType.RHOVANION, 335, 630}},
        level=61
    })
    self.rep:AddSkill({
        id="0x70021FA2",
        nameEN="Return to Enedwaith", labelEN="Enedwaith (Rep)",
        nameDE="Rückkehr nach Enedwaith", labelDE="Enedwaith (Ruf)",
        nameFR="Retour en Enedwaith", labelFR="Retour en Enedwaith (Rep)",
        map={{MapType.ERIADOR, 765, 620}},
        level=62
    })
    self.rep:AddSkill({
        id="0x7002C647",
        nameEN="Return to Galtrev", labelEN="Galtrev (Rep)",
        nameDE="Kehrt nach Galtrev zurück", labelDE="Galtrev (Ruf)",
        nameFR="Retour à Galtrev", labelFR="Retour à Galtrev (Rep)",
        map={{MapType.ERIADOR, 780, 715}},
        level=65
    })
    self.rep:AddSkill({
        id="0x7002C65D",
        nameEN="Return to Stangard", labelEN="Stangard (Rep)",
        nameDE="Kehrt nach Stangard zurück", labelDE="Stangard (Ruf)",
        nameFR="Retour à Stangarde", labelFR="Retour à Stangarde (Rep)",
        map={{MapType.RHOVANION, 170, 720}, {MapType.ROHAN, 515, 90}},
        level=75
    })
    self.rep:AddSkill({
        id="0x70031A46",
        nameEN="Return to Snowbourn", labelEN="Snowbourn (Rep)",
        nameDE="Kehrt nach Schneegrenze zurück", labelDE="Schneegrenze (Ruf)",
        nameFR="Retourner à Neigebronne", labelFR="Retourner à Neigebronne (Rep)",
        map={{MapType.ROHAN, 485, 500}},
        level=85
    })
    self.rep:AddSkill({
        id="0x70036B5E",
        nameEN="Return to Forlaw", labelEN="Forlaw (Rep)",
        nameDE="Rückkehr nach Forlach", labelDE="Forlach (Ruf)",
        nameFR="Retour à Forloi", labelFR="Retour à Forloi (Rep)",
        map={{MapType.ROHAN, 480, 175}},
        level=85
    })
    self.rep:AddSkill({
        id="0x7003DC81",
        nameEN="Return to Aldburg", labelEN="Aldburg (Rep)",
        nameDE="Kehrt nach Aldburg zurück", labelDE="Aldburg (Ruf)",
        nameFR="Retour à Aldburg", labelFR="Aldburg (Rep)",
        map={{MapType.ROHAN, 540, 640}},
        level=88
    })
    self.rep:AddSkill({
        id="0x7003DC82",
        nameEN="Return to Helm's Deep", labelEN="Helm's Deep (Rep)",
        nameDE="Kehrt nach Helms Klamm zurück", labelDE="Helms Klamm (Ruf)",
        nameFR="Retour au Gouffre de Helm", labelFR="Gouffre de Helm(Rep)",
        map={{MapType.ROHAN, 245, 565}},
        level=90
    })
    self.rep:AddSkill({
        id="0x7004128F",
        nameEN="Return to Derndingle", labelEN="Derndingle (Rep)",
        nameDE="Rückkehr ins Geheimnistal", labelDE="Geheimnistal (Ruf)",
        nameFR="Retour à Derunant", labelFR="Derunant (Rep)",
        map={{MapType.RHOVANION, 45, 720}, {MapType.ROHAN, 295, 275}},
        level=90.1
    })
    self.rep:AddSkill({
        id="0x700411AC",
        nameEN="Return to Dol Amroth", descEN="Dol Amroth in western Gondor", labelEN="Dol Amroth (Rep)",
        nameDE="Rückkehr nach Dol Amroth", descDE="West-Gondor zurückkehren", labelDE="Dol Amroth (Ruf)",
        nameFR="Retour à Dol Amroth", descFR="l'Ouest du Gondor", labelFR="Dol Amroth (Rep)",
        map={{MapType.GONDOR, 195, 550}},
        level=98
    })
    self.rep:AddSkill({
        id="0x70043A6A",
        nameEN="Return to Arnach", labelEN="Arnach (Rep)",
        nameDE="Rückkehr nach Arnach", labelDE="Arnach (Ruf)",
        nameFR="Retournez à Arnach", labelFR="Arnach (Rep)",
        map={{MapType.GONDOR, 685, 425}},
        level=100
    })
    self.rep:AddSkill({
        id="0x7004497E",
        nameEN="Return to Minas Tirith", labelEN="Minas Tirith (Rep)",
        nameDE="Kehrt nach Minas Tirith zurück.", labelDE="Minas Tirith (Ruf)",
        nameFR="Retour à Minas Tirith", labelFR="Retour à Minas Tirith (Rep)",
        map={{MapType.GONDOR, 700, 345}},
        level=100.1
    })
    self.rep:AddSkill({
        id="0x700459A9",
        nameEN="Return to the War-stead", labelEN="War-stead (Rep)",
        nameDE="Zurück zum Kriegslager der Rohirrim", labelDE="Kriegslager der Rohirrim (Ruf)",
        nameFR="Retour au camp militaire", labelFR="Camp militaire (Rep)",
        map={{MapType.GONDOR, 635, 140}},
        level=102
    })
    self.rep:AddSkill({
        id="0x70046CC0",
        nameEN="Return to after-battle Minas Tirith", labelEN="Minas Tirith after-battle (Rep)",
        nameDE="Rückkehr ins schlachtgezeichnete Minas Tirith", labelDE="Minas Tirith nach der Schlacht (Ruf)",
        nameFR="Retour à Minas Tirith après la bataille", labelFR="Minas Tirith après la bataille (Rep)",
        map={{MapType.GONDOR, 700, 375}},
        level=105
    })
    self.rep:AddSkill({
        id="0x7004707D",
        nameEN="Return to after-battle Osgiliath", labelEN="Osgiliath after-battle (Rep)",
        nameDE="Rückkehr ins schlachtgezeichnete Osgiliath", labelDE="Osgiliath nach der Schlacht (Ruf)",
        nameFR="Retour à Osgiliath après la bataille", labelFR="Osgiliath après la bataille (Rep)",
        map={{MapType.GONDOR, 825, 335}},
        level=105.1
    })
    self.rep:AddSkill({
        id="0x70047080",
        nameEN="Return to Henneth Annûn", labelEN="Henneth Annûn (Rep)",
        nameDE="Rückkehr nach Henneth Annûn", labelDE="Henneth Annûn (Ruf)",
        nameFR="Retour à Henneth Annûn", labelFR="Henneth Annûn (Rep)",
        map={{MapType.GONDOR, 845, 385}},
        level=105.2
    })
    self.rep:AddSkill({
        id="0x70047BF4",
        nameEN="Return to the Camp of the Host", labelEN="Camp of the Host (Rep)",
        nameDE="Rückkehr ins Lager des Heeres", labelDE="Lager des Heeres (Ruf)",
        nameFR="Retour au Camp de l'armée", labelFR="Camp de l'armée (Rep)",
        map={{MapType.GONDOR, 775, 170}},
        level=105.3
    })
    self.rep:AddSkill({
        id="0x70047C1B",
        nameEN="Return to Haerondir", labelEN="Haerondir (Rep)",
        nameDE="Rückkehr nach Haerondir", labelDE="Haerondir (Ruf)",
        nameFR="Retour à Haerondir", labelFR="Haerondir (Rep)",
        map={{MapType.GONDOR, 825, 100}},
        level=105.4
    })
    self.rep:AddSkill({
        id="0x7004AE1D",
        nameEN="Return to the Udûn Foothold", labelEN="Udûn Foothold (Rep)",
        nameDE="Zurück zum Udûn-Brückenkopf", labelDE="Udûn-Brückenkopf (Ruf)",
        nameFR="Retour au fort d'Udûn", labelFR="Fort d'Udûn (Rep)",
        map={{MapType.GONDOR, 895, 230}},
        level=106
    })
    self.rep:AddSkill({
        id="0x7004B8C2",
        nameEN="Journey to the Court of Lothlórien", labelEN="Court of Lothlórien (Rep)",
        nameDE="Reise zum Hof von Lothlórien", labelDE="Hof von Lothlórien (Ruf)",
        nameFR="Voyager jusqu'à la Cour de Lothlórien", labelFR="Cour de Lothlórien (Rep)",
        map={{MapType.RHOVANION, 140, 585}},
        level=110
    })
    self.rep:AddSkill({
        id="0x7004B8C3",
        nameEN="Journey to the Hall of the King", labelEN="Hall of the King (Rep)",
        nameDE="Reise zur Halle des Königs", labelDE="Halle des Königs (Ruf)",
        nameFR="Voyager jusqu'au Palais du roi", labelFR="Palais du roi (Rep)",
        map={{MapType.GONDOR, 740, 310}},
        level=110.1
    })
    self.rep:AddSkill({
        id="0x7004B8C4",
        nameEN="Journey to the Hall Under the Mountain", labelEN="Hall Under the Mountain (Rep)",
        nameDE="Reise zur Halle unter dem Berg", labelDE="Halle unter dem Berg (Ruf)",
        nameFR="Voyager jusqu'au Palais sous la Montagne", labelFR="Palais sous la Montagne (Rep)",
        map={{MapType.RHOVANION, 630, 115}},
        level=110.2
    })
    self.rep:AddSkill({
        id="0x7004B8C5",
        nameEN="Journey to Bâr Thorenion", labelEN="Bâr Thorenion (Rep)",
        nameDE="Reise nach Bâr Thorenion", labelDE="Bâr Thorenion (Ruf)",
        nameFR="Voyager jusqu'à Bâr Thorenion", labelFR="Bâr Thorenion (Rep)",
        map={{MapType.GONDOR, 965, 370}},
        level=110.3
    })
    self.rep:AddSkill({
        id="0x7004D738",
        nameEN="Return to Dale", labelEN="Dale (Rep)",
        nameDE="Rückkehr nach Thal", labelDE="Thal (Ruf)",
        nameFR="Revenir à Dale", labelFR="Dale (Rep)",
        map={{MapType.RHOVANION, 690, 215}},
        level=115
    })
    self.rep:AddSkill({
        id="0x7004FAC3",
        nameEN="Return to Járnfast", labelEN="Járnfast (Rep)",
        nameDE="Rückkehr nach Járnfast", labelDE="Járnfast (Ruf)",
        nameFR="Revenir à Jarnfast", labelFR="Jarnfast (Rep)",
        map={{MapType.RHOVANION, 860, 110}},
        level=116
    })
    self.rep:AddSkill({
        id="0x7004FAC5",
        nameEN="Return to Skarháld", labelEN="Skarháld (Rep)",
        nameDE="Kehrt nach Skarháld zurück.", labelDE="Skarháld (Ruf)",
        nameFR="Revenir à Skarhald", labelFR="Skarhald (Rep)",
        map={{MapType.RHOVANION, 400, 90}},
        level=117
    })
    self.rep:AddSkill({
        id="0x70052F12",
        nameEN="Return to Beorninghús", labelEN="Beorninghús (Rep)",
        nameDE="Kehrt zum Beorningerhús zurück.", labelDE="Beorningerhús (Ruf)",
        nameFR="Retournez auprès de Beorninghus", labelFR="Beorninghus (Rep)",
        map={{MapType.RHOVANION, 360, 300}},
        level=120
    })
    self.rep:AddSkill({
        id="0x70052F04",
        nameEN="Return to Hultvís", labelEN="Hultvís (Rep)",
        nameDE="Kehrt zum Hultvís zurück.", labelDE="Hultvís (Ruf)",
        nameFR="Retournez auprès de Hultvis", labelFR="Hultvis (Rep)",
        map={{MapType.RHOVANION, 345, 400}},
        level=120.1
    })
    self.rep:AddSkill({
        id="0x700551F8",
        nameEN="Return to Estolad Lân", labelEN="Estolad Lân (Rep)",
        nameDE="Zurück nach Estolad Lân", labelDE="Estolad Lân (Ruf)",
        nameFR="Retour à Estolad Lân", labelFR="Estolad Lân (Rep)",
        map={{MapType.GONDOR, 930, 460}},
        level=125
    })
    self.rep:AddSkill({
        id="0x70057629",
        nameEN="Return to Limlók", labelEN="Limlók (Rep)",
        nameDE="Rückkehr nach Limlók", labelDE="Limlók (Ruf)",
        nameFR="Retour à Limlok", labelFR="Limlok (Rep)",
        map={{MapType.RHOVANION, 315, 230}},
        level=130
    })
    self.rep:AddSkill({
        id="0x7005856F",
        nameEN="Return to Annâk-khurfu", labelEN="Annâk-khurfu (Rep)",
        nameDE="Rückkehr nach Annâk-khurfu", labelDE="Annâk-khurfu (Ruf)",
        nameFR="Retournez à Annâk-khurfu", labelFR="Annâk-khurfu (Rep)",
        map={{MapType.RHOVANION, 500, 90}},
        level=130.1
    })
    self.rep:AddSkill({
        id="0x7005AA90",
        nameEN="Return to Akrâz-zahar", labelEN="Akrâz-zahar (Rep)",
        nameDE="Rückkehr nach Akrâz-zahar", labelDE="Akrâz-zahar (Ruf)",
        nameFR="Retour à Akrâz-zahar", labelFR="Akrâz-zahar (Rep)",
        map={{MapType.RHOVANION, 720, 115}},
        level=130.2
    })
    self.rep:AddSkill({
        id="0x7005AA92",
        nameEN="Return to Azanulbizar", labelEN="Azanulbizar (Rep)",
        nameDE="Rückkehre nach Azanulbizar", labelDE="Azanulbizar (Ruf)",
        nameFR="Retour à Azanulbizar", labelFR="Azanulbizar (Rep)",
        map={{MapType.RHOVANION, 180, 555}},
        level=130.3
    })
    self.rep:AddSkill({
        id="0x7005D47C",
        nameEN="Return to the Noble Gate", labelEN="Noble Gate (Rep)",
        nameDE="Rückkehr zum Prachttor", labelDE="Prachttor (Ruf)",
        nameFR="Retourner à la Porte Noble", labelFR="Porte Noble (Rep)",
        map={{MapType.RHOVANION, 160, 130}},
        level=131
    })
    self.rep:AddSkill({
        id="0x7005D484",
        nameEN="Return to Leitstáth", labelEN="Leitstáth (Rep)",
        nameDE="Rückkehr nach Leitstáth", labelDE="Leitstáth (Ruf)",
        nameFR="Retourner à Leitstath", labelFR="Leitstath (Rep)",
        map={{MapType.RHOVANION, 240, 65}},
        level=135
    })
    self.rep:AddSkill({
        id="0x7005A596",
        nameEN="Journey to the Hall of Vérnozal", labelEN="Vérnozal (Quest)",
        nameDE="Reise zur Halle Vérnozal", labelDE="Vérnozal (Aufgabe)",
        nameFR="Voyage jusqu'à la Grande salle de Vérnozal", labelFR="Vérnozal (Quête)",
        map={{MapType.RHOVANION, 155, 45}},
        level=140
    })
    self.rep:AddSkill({
        id="0x70064ACA",
        nameEN="Return to Carn Dûm", labelEN="Carn Dûm (Rep)",
        nameDE="Rückkehr nach Carn Dûm", labelDE="Carn Dûm (Ruf)",
        nameFR="Retour à Carn Dûm", labelFR=" Carn Dûm (Rep)",
        map={{MapType.ERIADOR, 705, 100}},
        level=140.1
    })
    self.rep:AddSkill({
        id="0x700658EB",
        nameEN="Return to Pelargir", labelEN="Pelargir (Rep)",
        nameDE="Rückkehr nach Pelargir", labelDE="Pelargir (Ruf)",
        nameFR="Retournez à Pelargir", labelFR="Pelargir (Rep)",
        map={{MapType.GONDOR, 640, 625}},
        level=141
    })
    self.rep:AddSkill({
        id="0x70068700",
        nameEN="Return to Dol Amroth", descEN="King's Gondor", labelEN="King's Dol Amroth (Rep)",
        nameDE="Rückkehr nach Dol Amroth", descDE="Königreich Gondor", labelDE="Dol Amroth - Königreich Gondor (Ruf)",
        nameFR="Retour à Dol Amroth", descFR="le Gondor royal", labelFR="Dol Amroth - Gondor royal (Rep)",
        map={{MapType.GONDOR, 180, 485}, {MapType.HARADWAITH, 355, 70}},
        level=142
    })
    self.rep:AddSkill({
        id="0x70068703",
        nameEN="Return to Lond Cirion", labelEN="Lond Cirion (Rep)",
        nameDE="Nach Lond Cirion zurückkehren", labelDE="Lond Cirion (Ruf)",
        nameFR="Retour à Lond Cirion", labelFR="Lond Cirion (Rep)",
        map={{MapType.GONDOR, 225, 420}, {MapType.HARADWAITH, 200, 20}},
        level=143
    })
    self.rep:AddSkill({
        id="0x70068702",
        nameEN="Return to Halrax", labelEN="Halrax (Rep)",
        nameDE="Kehrt zu Halrax zurück.", labelDE="Halrax (Ruf)",
        nameFR="Retournez voir Halrax", labelFR="Halrax (Rep)",
        map={{MapType.HARADWAITH, 245, 260}},
        level=145
    })
    self.rep:AddSkill({
        id="0x70068701",
        nameEN="Return to Jax Phanâl", labelEN="Jax Phanâl (Rep)",
        nameDE="Nach Jax Phanâl zurückkehren", labelDE="Jax Phanâl (Ruf)",
        nameFR="Retour à Jax Phanâl", labelFR="Jax Phanâl (Rep)",
        map={{MapType.HARADWAITH, 335, 315}},
        level=146
    })
    self.rep:AddSkill({
        id="0x700686FF",
        nameEN="Return to Umbar", labelEN="Umbar (Rep)",
        nameDE="Nach Umbar zurückkehren", labelDE="Umbar (Ruf)",
        nameFR="Retour à Umbar", labelFR="Umbar (Rep)",
        map={{MapType.HARADWAITH, 475, 370}},
        level=148
    })
    self.rep:AddSkill({
        id="0x700697F2",
        nameEN="Return to the Bloody Eagle Tavern", labelEN="Bloody Eagle Tavern (Rep)",
        nameDE="Rückkehr zur Taverne \"Zum Blutigen Adler\"", labelDE="Zum Blutigen Adler (Ruf)",
        nameFR="Retour à la taverne de l'Aigle Sanglant", labelFR="Taverne de l'Aigle Sanglant (Rep)",
        map={{MapType.HARADWAITH, 445, 400}},
        level=149
    })
    self.rep:AddSkill({
        id="0x70068704",
        nameEN="Journey to the Ledger-keepers", labelEN="Ledger-Keepers (Rep)",
        nameDE="Zu den Buchhütern reisen", labelDE="Ledger-Keepers (Ruf)",
        nameFR="Voyager vers les Gardiens des écrits", labelFR="Gardiens des écrits (Rep)",
        map={{MapType.HARADWAITH, 415, 340}},
        level=150
    })
    self.rep:AddSkill({
        id="0x700686FE",
        nameEN="Journey to the Order of the Eagle", labelEN="Order of the Eagle (Rep)",
        nameDE="Zum Orden des Adlers reisen", labelDE="Orden des Adlers (Ruf)",
        nameFR="Voyager vers l'Ordre de l'Aigle", labelFR="L'Ordre de l'Aigle (Rep)",
        map={{MapType.HARADWAITH, 415, 370}},
        level=150
    })
end

function TravelDictionary:CreateCreepDictionary()
    -- monster player maps
    self.creep:AddSkill({
        id="0x70028BBC",
        nameEN="Return to Gramsfoot",
        nameDE="Rückkehr nach Gramfuß",
        nameFR="Retournez au Pied de Gram",
        map={MapType.CREEPS, 180, 120},
        level=1
    })
    self.creep:AddSkill({
        id="0x70028BC1",
        nameEN="Map to Gramsfoot",
        nameDE="Karte zum Gramfuss",
        nameFR="Carte pour aller au Pied de Gram",
        map={MapType.CREEPS, 215, 120},
        hasSameText={"0x7002A7B9"},
        level=1
    })
    self.creep:AddSkill({
        id="0x7002A7B9",
        nameEN="Map to Gramsfoot",
        nameDE="Karte zum Gramfuss",
        nameFR="Carte pour aller au Pied de Gram",
        map={MapType.CREEPS, 245, 120},
        hasSameText={"0x70028BC1"},
        level=1
    })
    self.creep:AddSkill({
        id="0x70028BB3",
        nameEN="Crude Map to Isendeep",
        nameDE="Kartenskizze zur Isenbinge",
        nameFR="Carte grossière pour aller au Gouffre d'Isen",
        map={MapType.CREEPS, 700, 200},
        level=1
    })
    self.creep:AddSkill({
        id="0x70028BB6",
        nameEN="Crude Map to Tol Ascarnen",
        nameDE="Grobe Karte zur Feste Tol Ascarnen",
        nameFR="Carte grossière pour aller à Tol Ascarnen",
        map={MapType.CREEPS, 350, 440},
        level=1
    })
    self.creep:AddSkill({
        id="0x70028BB7",
        nameEN="Crude Map to Lugazag",
        nameDE="Kartenskizze zur Feste Lugazag",
        nameFR="Carte grossière pour aller à Lugazag",
        map={MapType.CREEPS, 180, 380},
        level=1
    })
    self.creep:AddSkill({
        id="0x70028BBE",
        nameEN="Crude Map to Tirith Rhaw",
        nameDE="Grobe Karte zur Feste Tirith Rhaw",
        nameFR="Carte grossière pour aller à Tirith Rhaw",
        map={MapType.CREEPS, 500, 295},
        level=1
    })
    self.creep:AddSkill({
        id="0x70028BBF",
        nameEN="Crude Map to Grimwood",
        nameDE="Kartenskizze zum Grimmwald",
        nameFR="Carte grossière pour aller au Bois Funeste",
        map={MapType.CREEPS, 340, 510},
        level=1
    })
    self.creep:AddSkill({
        id="0x70028BAF",
        nameEN="Poor Map to Isendeep",
        nameDE="Minderwertige Karte zur Isenbinge",
        nameFR="Piètre carte pour aller au Gouffre d'Isen",
        map={MapType.CREEPS, 610, 300},
        level=1
    })
    self.creep:AddSkill({
        id="0x70028BB1",
        nameEN="Poor Map to Tol Ascarnen",
        nameDE="Minderwertige Karte zur Feste Tol Ascarnen",
        nameFR="Piètre carte pour aller à Tol Ascarnen",
        map={MapType.CREEPS, 435, 365},
        level=1
    })
    self.creep:AddSkill({
        id="0x70028BB2",
        nameEN="Poor Map to Lugazag",
        nameDE="Minderwertige Karte zur Feste Lugazag",
        nameFR="Piètre carte pour aller à Lugazag",
        map={MapType.CREEPS, 180, 270},
        level=1
    })
    self.creep:AddSkill({
        id="0x70028BB4",
        nameEN="Poor Map to Tirith Rhaw",
        nameDE="Minderwertige Karte zur Feste Tirith Rhaw",
        nameFR="Piètre carte pour aller à Tirith Rhaw",
        map={MapType.CREEPS, 625, 365},
        level=1
    })
    self.creep:AddSkill({
        id="0x70028BB9",
        nameEN="Poor Map to Grimwood",
        nameDE="Minderwertige Karte zum Grimmwald",
        nameFR="Piètre carte pour aller au Bois Funeste",
        map={MapType.CREEPS, 380, 540},
        level=1
    })
    self.creep:AddSkill({
        id="0x70028BC0",
        nameEN="Good Map to Isendeep",
        nameDE="Gute Karte zur Isenbinge",
        nameFR="Bonne carte pour aller au Gouffre d'Isen",
        map={MapType.CREEPS, 310, 95},
        hasSameText={"0x7002A7B7"},
        level=1
    })
    self.creep:AddSkill({
        id="0x7002A7B7",
        nameEN="Good Map to Isendeep",
        nameDE="Gute Karte zur Isenbinge",
        nameFR="Bonne carte pour aller au Gouffre d'Isen",
        map={MapType.CREEPS, 340, 95},
        hasSameText={"0x70028BC0"},
        level=1
    })
    self.creep:AddSkill({
        id="0x70028BC2",
        nameEN="Good Map to Tol Ascarnen",
        nameDE="Gute Karte zur Feste Tol Ascarnen",
        nameFR="Bonne carte pour aller à Tol Ascarnen",
        map={MapType.CREEPS, 375, 480},
        hasSameText={"0x7002A7B4"},
        level=1
    })
    self.creep:AddSkill({
        id="0x7002A7B4",
        nameEN="Good Map to Tol Ascarnen",
        nameDE="Gute Karte zur Feste Tol Ascarnen",
        nameFR="Bonne carte pour aller à Tol Ascarnen",
        map={MapType.CREEPS, 405, 480},
        hasSameText={"0x70028BC2"},
        level=1
    })
    self.creep:AddSkill({
        id="0x70028BB5",
        nameEN="Good Map to Lugazag",
        nameDE="Gute Karte zur Feste Lugazag",
        nameFR="Bonne carte pour aller à Lugazag",
        map={MapType.CREEPS, 305, 275},
        hasSameText={"0x7002A7B6"},
        level=1
    })
    self.creep:AddSkill({
        id="0x7002A7B6",
        nameEN="Good Map to Lugazag",
        nameDE="Gute Karte zur Feste Lugazag",
        nameFR="Bonne carte pour aller à Lugazag",
        map={MapType.CREEPS, 335, 275},
        hasSameText={"0x70028BB5"},
        level=1
    })
    self.creep:AddSkill({
        id="0x70028BB0",
        nameEN="Good Map to Tirith Rhaw",
        nameDE="Gute Karte zur Feste Tirith Rhaw",
        nameFR="Bonne carte pour aller à Tirith Rhaw",
        map={MapType.CREEPS, 555, 470},
        hasSameText={"0x7002A7B5"},
        level=1
    })
    self.creep:AddSkill({
        id="0x7002A7B5",
        nameEN="Good Map to Tirith Rhaw",
        nameDE="Gute Karte zur Feste Tirith Rhaw",
        nameFR="Bonne carte pour aller à Tirith Rhaw",
        map={MapType.CREEPS, 585, 470},
        hasSameText={"0x70028BB0"},
        level=1
    })
    self.creep:AddSkill({
        id="0x70028BBD",
        nameEN="Good Map to Grimwood",
        nameDE="Gute Karte zum Grimmwald",
        nameFR="Bonne carte pour aller au Bois Funeste",
        map={MapType.CREEPS, 445, 650},
        hasSameText={"0x7002A7B3"},
        level=1
    })
    self.creep:AddSkill({
        id="0x7002A7B3",
        nameEN="Good Map to Grimwood",
        nameDE="Gute Karte zum Grimmwald",
        nameFR="Bonne carte pour aller au Bois Funeste",
        map={MapType.CREEPS, 475, 650},
        hasSameText={"0x70028BBD"},
        level=1
    })
end
