--[[ travel skills ]] --
--[[ Add all the travel skills ]] --
-- add the data to custom dictionaries to maintain the order
function TravelDictionary:CreateDictionaries()
    -- add the hunter locations
    self.hunter:AddLabelTag({EN=" (Guide)", DE=" (Führer)", FR=" (Guide)" })
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
        nameEN="Guide to Michel Delving", labelEN="Michel Delving", zoneEN="Shire",
        nameDE="Führer nach Michelbinge", labelDE="Michelbinge",    zoneDE="Auenland",
        nameFR="Guide vers Grand'Cave",   labelFR="Grand'Cave",     zoneFR="Comté",
        map={{MapType.ERIADOR, 360, 390}},
        overlap={"0x700062C8", "0x70023262"},
        level=1
    })
    self.hunter:AddSkill({
        id="0x70003F41",
        nameEN="Guide to Thorin's Hall",         labelEN="Thorin's Hall",    zoneEN="Ered Luin",
        nameDE="Führer zu Thorins Halle",        labelDE="Thorins Halle",    zoneDE="Ered Luin",
        nameFR="Guide vers le Palais de Thorin", labelFR="Palais de Thorin", zoneFR="Ered Luin",
        map={{MapType.ERIADOR, 305, 270}},
        overlap={"0x70006346", "0x70053C0F", "0x7001BF91"},
        level=1.1
    })
    self.hunter:AddSkill({
        id="0x70003F42",
        nameEN="Guide to Bree",    labelEN="West Gate",   zoneEN="Bree",
        nameDE="Führer nach Bree", labelDE="Westtor",     zoneDE="Bree",
        nameFR="Guide vers Bree",  labelFR="Porte Ouest", zoneFR="Bree",
        map={{MapType.ERIADOR, 585, 335}},
        overlap={"0x700062F6", "0x7001BF90"},
        level=5
    })
    self.hunter:AddSkill({
        id="0x70064F4C",
        nameEN="Guide to Clegur",    labelEN="Clegur", zoneEN="Swanfleet",
        nameDE="Führer nach Clegur", labelDE="Clegur", zoneDE="Schwanenfleet",
        nameFR="Guide vers Clegur",  labelFR="Clegur", zoneFR="Noues des cygnes",
        map={{MapType.ERIADOR, 755, 555}},
        overlap={"0x70064F47"},
        level=7
    })
    self.hunter:AddSkill({
        id="0x700634AA",
        nameEN="Guide to Swanfleet",              labelEN="Lhan Garan", zoneEN="Swanfleet",
        nameDE="Führer nach Schwanenfleet",       labelDE="Lhan Garan", zoneDE="Schwanenfleet",
        nameFR="Guide vers les Noues des cygnes", labelFR="Lhan Garan", zoneFR="Noues des cygnes",
        map={{MapType.ERIADOR, 825, 490}},
        overlap={"0x700634A4"},
        level=10
    })
    self.hunter:AddSkill({
        id="0x700634A7",
        nameEN="Guide to Cardolan",      labelEN="Herne", zoneEN="Cardolan",
        nameDE="Führer nach Cardolan",   labelDE="Herne", zoneDE="Cardolan",
        nameFR="Guide vers le Cardolan", labelFR="Herne", zoneFR="Cardolan",
        map={{MapType.ERIADOR, 560, 495}},
        overlap={"0x700634AE"},
        level=15
    })
    self.hunter:AddSkill({
        id="0x7006323C",
        nameEN="Guide to Andrath",    labelEN="Andrath", zoneEN="Cardolan",
        nameDE="Führer nach Andrath", labelDE="Andrath", zoneDE="Cardolan",
        nameFR="Guide vers Andrath",  labelFR="Andrath", zoneFR="Cardolan",
        map={{MapType.ERIADOR, 580, 465}},
        overlap={"0x7006323D"},
        level=17
    })
    self.hunter:AddSkill({
        id="0x7006133F",
        nameEN="Guide to Nobottle",      labelEN="Nobottle",    zoneEN="Yondershire",
        nameDE="Führer nach Neuhausen",  labelDE="Neuhausen",   zoneDE="Ferne Auen",
        nameFR="Guide vers Bourdeneuve", labelFR="Bourdeneuve", zoneFR="Comté lointain",
        map={{MapType.ERIADOR, 440, 350}},
        overlap={"0x70061340"},
        level=20
    })
    self.hunter:AddSkill({
        id="0x7000A2C2",
        nameEN="Guide to Ost Guruth",     labelEN="Ost Guruth",   zoneEN="Lone-lands",
        nameDE="Führer zur Feste Guruth", labelDE="Feste Guruth", zoneDE="Einsame Lande",
        nameFR="Guide vers Ost Guruth",   labelFR="Ost Guruth",   zoneFR="Terres Solitaires",
        map={{MapType.ERIADOR, 755, 400}},
        overlap={"0x70020441"},
        level=25
    })
    self.hunter:AddSkill({
        id="0x70003F43",
        nameEN="Guide to Esteldín",    labelEN="Esteldín", zoneEN="North Downs",
        nameDE="Führer nach Esteldín", labelDE="Esteldín", zoneDE="Nordhöhen",
        nameFR="Guide vers Esteldin",  labelFR="Esteldin", zoneFR="Hauts du Nord",
        map={{MapType.ERIADOR, 655, 290}},
        level=30
    })
    self.hunter:AddSkill({
        id="0x7000A2C4",
        nameEN="Guide to Evendim",    labelEN="Tinnudir", zoneEN="Evendim",
        nameDE="Führer nach Evendim", labelDE="Tinnudir", zoneDE="Evendim",
        nameFR="Guide vers Evendim",  labelFR="Tinnudir", zoneFR="Evendim",
        map={{MapType.ERIADOR, 490, 235}},
        level=35
    })
    self.hunter:AddSkill({
        id="0x70060EA6",
        nameEN="Guide to Tornhad",    labelEN="Tornhad", zoneEN="Angle of Mitheithel",
        nameDE="Führer nach Tornhad", labelDE="Tornhad", zoneDE="Der Bogen von Mitheithel",
        nameFR="Guide vers Tornhad",  labelFR="Tornhad", zoneFR="L'Angle de Mitheithel",
        map={{MapType.ERIADOR, 775, 435}},
        overlap={"0x70060EA8"},
        level=40
    })
    self.hunter:AddSkill({
        id="0x70003F44",
        nameEN="Guide to Rivendell",   labelEN="Rivendell", zoneEN="Trollshaws",
        nameDE="Führer nach Bruchtal", labelDE="Bruchtal",  zoneDE="Die Trollhöhen",
        nameFR="Guide vers Fondcombe", labelFR="Fondcombe", zoneFR="Trouée des Trolls",
        map={{MapType.ERIADOR, 865, 410}},
        overlap={"0x7000631F", "0x70023263"},
        level=40.1
    })
    self.hunter:AddSkill({
        id="0x7002E756",
        nameEN="Guide to the Misty Mountains", labelEN="Hrimbarg", zoneEN="Misty Mountains",
        nameDE="Führer ins Nebelgebirge",      labelDE="Hrimbarg", zoneDE="Nebelgebirge",
        nameFR="Guide vers les Monts Brumeux", labelFR="Hrimbarg", zoneFR="Monts Brumeux",
        map={{MapType.ERIADOR, 915, 265}},
        level=40.2
    })
    self.hunter:AddSkill({
        id="0x70059D16",
        nameEN="Guide to Trestlebridge",     labelEN="Trestlebridge",   zoneEN="North Downs",
        nameDE="Führer nach Schragen",       labelDE="Schragen",        zoneDE="Nordhöhen",
        nameFR="Guide vers Pont-à-Tréteaux", labelFR="Pont-à-Tréteaux", zoneFR="Hauts du Nord",
        map={{MapType.ERIADOR, 590, 285}},
        overlap={"0x70059D12"},
        level=40.3
    })
    self.hunter:AddSkill({
        id="0x70059D0C",
        nameEN="Guide to Trader's Wharf",          labelEN="Trader's Wharf",     zoneEN="Evendim",
        nameDE="Führer zum Händlerkai",            labelDE="Händlerkai",         zoneDE="Evendim",
        nameFR="Guide vers le Quai des marchands", labelFR="Quai des marchands", zoneFR="Evendim",
        map={{MapType.ERIADOR, 515, 305}},
        overlap={"0x70059D0E"},
        level=40.4
    })
    self.hunter:AddSkill({
        id="0x70017C82",
        nameEN="Guide to Sûri-kylä",    labelEN="Sûri-kylä", zoneEN="Forochel",
        nameDE="Führer nach Sûri-kylä", labelDE="Sûri-kylä", zoneDE="Forochel",
        nameFR="Guide vers Sûri-kylä",  labelFR="Sûri-kylä", zoneFR="Forochel",
        map={{MapType.ERIADOR, 430, 50}},
        level=42
    })
    self.hunter:AddSkill({
        id="0x7000A2C5",
        nameEN="Guide to West Angmar",           labelEN="Aughaire", zoneEN="Angmar",
        nameDE="Führer in das westliche Angmar", labelDE="Aughaire", zoneDE="Angmar",
        nameFR="Guide vers l'ouest d'Angmar",    labelFR="Aughaire", zoneFR="Angmar",
        map={{MapType.ERIADOR, 825, 185}},
        level=45
    })
    self.hunter:AddSkill({
        id="0x7000A2C6",
        nameEN="Guide to East Angmar",      labelEN="Gath Forthnír", zoneEN="Angmar",
        nameDE="Führer nach Ost-Angmar",    labelDE="Gath Forthnír", zoneDE="Angmar",
        nameFR="Guide vers l'est d'Angmar", labelFR="Gath Forthnír", zoneFR="Angmar",
        map={{MapType.ERIADOR, 705, 180}},
        level=49
    })
    self.hunter:AddSkill({
        id="0x70017C81",
        nameEN="Guide to Echad Dúnann",    labelEN="Echad Dúnann", zoneEN="Eregion",
        nameDE="Führer nach Echad Dúnann", labelDE="Echad Dúnann", zoneDE="Eregion",
        nameFR="Guide vers Echad Dunann",  labelFR="Echad Dunann", zoneFR="Eregion",
        map={{MapType.ERIADOR, 855, 535}},
        level=50
    })
    self.hunter:AddSkill({
        id="0x70017C7A",
        nameEN="Guide to the Twenty-first Hall",      labelEN="Twenty-first Hall",      zoneEN="Moria",
        nameDE="Führer zur Einundzwanzigsten Halle",  labelDE="Einundzwanzigste Halle", zoneDE="Moria",
        nameFR="Guide vers la vingt et unième salle", labelFR="Vingt et unième salle",  zoneFR="Moria",
        map={{MapType.RHOVANION, 95, 585}, {MapType.ERIADOR, 950, 510}},
        level=55
    })
    self.hunter:AddSkill({
        id="0x7002E754",
        nameEN="Guide to Caras Galadhon",    labelEN="Caras Galadhon", zoneEN="Lothlórien",
        nameDE="Führer nach Caras Galadhon", labelDE="Caras Galadhon", zoneDE="Lothlórien",
        nameFR="Guide vers Caras Galadhon",  labelFR="Caras Galadhon", zoneFR="Lothlórien",
        map={{MapType.RHOVANION, 120, 660}},
        overlap={"0x70048C8C"},
        level=60
    })
    self.hunter:AddSkill({
        id="0x7001F459",
        nameEN="Guide to Mirk-eaves",     labelEN="Mirk-eaves",  zoneEN="Mirkwood",
        nameDE="Führer zur Dunkelsenke",  labelDE="Dunkelsenke", zoneDE="Düsterwald",
        nameFR="Guide vers l'Orée noire", labelFR="Orée noire",  zoneFR="Forêt Noire",
        map={{MapType.RHOVANION, 365, 630}},
        level=61
    })
    self.hunter:AddSkill({
        id="0x700235EF",
        nameEN="Guide to Harndirion",    labelEN="Harndirion", zoneEN="Enedwaith",
        nameDE="Führer nach Harndirion", labelDE="Harndirion", zoneDE="Enedwaith",
        nameFR="Guide vers Harndirion",  labelFR="Harndirion", zoneFR="Enedwaith",
        map={{MapType.ERIADOR, 815, 635}},
        level=62
    })
    self.hunter:AddSkill({
        id="0x7002A93F",
        nameEN="Guide to Galtrev",    labelEN="Galtrev", zoneEN="Dunland",
        nameDE="Führer nach Galtrev", labelDE="Galtrev", zoneDE="Dunland",
        nameFR="Guide pour Galtrev",  labelFR="Galtrev", zoneFR="Pays de Dun",
        map={{MapType.ERIADOR, 810, 715}},
        overlap={"0x7002C647"},
        level=65
    })
    self.hunter:AddSkill({
        id="0x7002C62C",
        nameEN="Guide to Stangard",    labelEN="Stangard",  zoneEN="Great River",
        nameDE="Führer nach Stangard", labelDE="Stangard",  zoneDE="Großer Fluss",
        nameFR="Guide vers Stangarde", labelFR="Stangarde", zoneFR="Grand Fleuve",
        map={{MapType.RHOVANION, 200, 720}, {MapType.ROHAN, 545, 90}},
        overlap={"0x7002C65D"},
        level=75
    })
    self.hunter:AddSkill({
        id="0x7003198E",
        nameEN="Guide to Snowbourn",       labelEN="Snowbourn",    zoneEN="East Rohan",
        nameDE="Führer nach Schneegrenze", labelDE="Schneegrenze", zoneDE="Ost-Rohan",
        nameFR="Guide vers Neigebronne",   labelFR="Neigebronne",  zoneFR="Rohan est",
        map={{MapType.ROHAN, 515, 500}},
        overlap={"0x70031A46"},
        level=80
    })
    self.hunter:AddSkill({
        id="0x70036B5D",
        nameEN="Guide to Forlaw",     labelEN="Forlaw",  zoneEN="Wildermore",
        nameDE="Führer nach Forlach", labelDE="Forlach", zoneDE="Wildermark",
        nameFR="Guide vers Forloi",   labelFR="Forloi",  zoneFR="Landes farouches",
        map={{MapType.ROHAN, 450, 175}},
        overlap={"0x70036B5E"},
        level=85
    })
    self.hunter:AddSkill({
        id="0x7003DC71",
        nameEN="Guide to Aldburg",    labelEN="Aldburg", zoneEN="West Rohan",
        nameDE="Führer nach Aldburg", labelDE="Aldburg", zoneDE="West-Rohan",
        nameFR="Guide vers Aldburg",  labelFR="Aldburg", zoneFR="Rohan de l'Ouest",
        map={{MapType.ROHAN, 570, 640}},
        overlap={"0x7003DC81"},
        level=88
    })
    self.hunter:AddSkill({
        id="0x7003DC72",
        nameEN="Guide to Helm's Deep",          labelEN="Helm's Deep",     zoneEN="West Rohan",
        nameDE="Führer nach Helms Klamm",       labelDE="Helms Klamm",     zoneDE="West-Rohan",
        nameFR="Guide vers le Gouffre de Helm", labelFR="Gouffre de Helm", zoneFR="Rohan de l'Ouest",
        map={{MapType.ROHAN, 275, 565}},
        overlap={"0x7003DC82"},
        level=90
    })
    self.hunter:AddSkill({
        id="0x70041197",
        nameEN="Guide to Dol Amroth",    descEN="in western Gondor", labelEN="Dol Amroth", zoneEN="Western Gondor",
        nameDE="Führer nach Dol Amroth", descDE="nach Dol Amroth.",  labelDE="Dol Amroth", zoneDE="West-Gondor",
        nameFR="Guide vers Dol Amroth",  descFR="l'Ouest du Gondor", labelFR="Dol Amroth", zoneFR="Gondor de l'Ouest",
        map={{MapType.GONDOR, 225, 550}},
        overlap={"0x700411AC"},
        level=98
    })
    self.hunter:AddSkill({
        id="0x70043A63",
        nameEN="Guide to Arnach",    labelEN="Arnach", zoneEN="Eastern Gondor",
        nameDE="Führer nach Arnach", labelDE="Arnach", zoneDE="Ost-Gondor",
        nameFR="Guide pour Arnach",  labelFR="Arnach", zoneFR="Gondor de l'Ouest",
        map={{MapType.GONDOR, 715, 425}},
        overlap={"0x70043A6A"},
        level=100
    })
    self.hunter:AddSkill({
        id="0x70044985",
        nameEN="Guide to Minas Tirith",    labelEN="Minas Tirith", zoneEN="Old Anórien",
        nameDE="Führer nach Minas Tirith", labelDE="Minas Tirith", zoneDE="Alt-Anórien",
        nameFR="Guide vers Minas Tirith",  labelFR="Minas Tirith", zoneFR="Ancien Anórien",
        map={{MapType.GONDOR, 670, 345}},
        overlap={"0x7004497E"},
        level=100.1
    })
    self.hunter:AddSkill({
        id="0x700459AF",
        nameEN="Guide to the War-stead",                 labelEN="War-stead",                zoneEN="Far Anórien",
        nameDE="Führer zum Kriegslager der Rohirrim",    labelDE="Kriegslager der Rohirrim", zoneDE="Fernes Anórien",
        nameFR="Guide pour se rendre au camp militaire", labelFR="Camp militaire",           zoneFR="Lointain Anórien",
        map={{MapType.GONDOR, 665, 140}},
        overlap={"0x700459A9"},
        level=102
    })
    self.hunter:AddSkill({
        id="0x70046CBB",
        nameEN="Guide to after-battle Minas Tirith",           labelEN="Minas Tirith after battle",      zoneEN="Anórien",
        nameDE="Führer zum schlachtgezeichneten Minas Tirith", labelDE="Minas Tirith nach der Schlacht", zoneDE="Anórien",
        nameFR="Guide de Minas Tirith après la bataille",      labelFR="Minas Tirith après la bataille", zoneFR="Anórien",
        map={{MapType.GONDOR, 670, 375}},
        overlap={"0x70046CC0"},
        level=105
    })
    self.hunter:AddSkill({
        id="0x70047074",
        nameEN="Guide to after-battle Osgiliath",           labelEN="Osgiliath after-battle",      zoneEN="Anórien",
        nameDE="Führer zum schlachtgezeichneten Osgiliath", labelDE="Osgiliath nach der Schlacht", zoneDE="Anórien",
        nameFR="Guide vers Osgiliath après la bataille",    labelFR="Osgiliath après la bataille", zoneFR="Anórien",
        map={{MapType.GONDOR, 855, 335}},
        overlap={"0x7004707D"},
        level=105.1
    })
    self.hunter:AddSkill({
        id="0x70047077",
        nameEN="Guide to Henneth Annûn",   labelEN="Henneth Annûn", zoneEN="Ithilien",
        nameDE="Führer zu Henneth Annûn",  labelDE="Henneth Annûn", zoneDE="Ithilien",
        nameFR="Guide vers Henneth Annûn", labelFR="Henneth Annûn", zoneFR="Ithilien",
        map={{MapType.GONDOR, 875, 385}},
        overlap={"0x70047080"},
        level=105.2
    })
    self.hunter:AddSkill({
        id="0x70047BFA",
        nameEN="Guide to the Camp of the Host", labelEN="Camp of the Host", zoneEN="The Wastes",
        nameDE="Führer zum Lager des Heeres",   labelDE="Lager des Heeres", zoneDE="Das Ödland",
        nameFR="Guide vers le Camp de l'armée", labelFR="Camp de l'armée",  zoneFR="Les Landes désertiques",
        map={{MapType.GONDOR, 805, 170}},
        overlap={"0x70047BF4"},
        level=105.3
    })
    self.hunter:AddSkill({
        id="0x70047C1D",
        nameEN="Guide to Haerondir",    labelEN="Haerondir", zoneEN="The Wastes",
        nameDE="Führer nach Haerondir", labelDE="Haerondir", zoneDE="Das Ödland",
        nameFR="Guide vers Haerondir",  labelFR="Haerondir", zoneFR="Les Landes désertiques",
        map={{MapType.GONDOR, 855, 100}},
        overlap={"0x70047C1B"},
        level=105.4
    })
    self.hunter:AddSkill({
        id="0x7004AE1E",
        nameEN="Guide to the Udûn Foothold",  labelEN="Udûn Foothold",    zoneEN="Mordor",
        nameDE="Führer zum Udûn-Brückenkopf", labelDE="Udûn-Brückenkopf", zoneDE="Mordor",
        nameFR="Guide vers le fort d'Udûn",   labelFR="Fort d'Udûn",      zoneFR="Mordor",
        map={{MapType.GONDOR, 925, 230}},
        overlap={"0x7004AE1D"},
        level=106
    })
    self.hunter:AddSkill({
        id="0x7004D73B",
        nameEN="Guide to Dale",    labelEN="Dale", zoneEN="Eryn Lasgalen",
        nameDE="Führer nach Thal", labelDE="Thal", zoneDE="Eryn Lasgalen",
        nameFR="Guide vers Dale",  labelFR="Dale", zoneFR="Eryn Lasgalen",
        map={{MapType.RHOVANION, 720, 215}},
        overlap={"0x7004D738"},
        level=115
    })
    self.hunter:AddSkill({
        id="0x7004FACC",
        nameEN="Guide to Járnfast",    labelEN="Járnfast", zoneEN="The Ironfold",
        nameDE="Führer nach Járnfast", labelDE="Járnfast", zoneDE="Der Eisenbruch",
        nameFR="Guide vers Jarnfast",  labelFR="Jarnfast", zoneFR="La Crevasse de Fer",
        map={{MapType.RHOVANION, 890, 110}},
        overlap={"0x7004FAC3"},
        level=116
    })
    self.hunter:AddSkill({
        id="0x7004FACB",
        nameEN="Guide to Skarháld",    labelEN="Skarháld", zoneEN="Ered Mithrin",
        nameDE="Führer nach Skarháld", labelDE="Skarháld", zoneDE="Ered Mithrin",
        nameFR="Guide vers Skarhald",  labelFR="Skarhald", zoneFR="Ered Mithrin",
        map={{MapType.RHOVANION, 430, 90}},
        overlap={"0x7004FAC5"},
        level=117
    })
    self.hunter:AddSkill({
        id="0x70052F07",
        nameEN="Guide to Beorninghús",      labelEN="Beorninghús",   zoneEN="Vales of Anduin",
        nameDE="Führer nach Beorningerhús", labelDE="Beorningerhús", zoneDE="Die Täler des Anduin",
        nameFR="Guide pour Beorninghus",    labelFR="Beorninghus",   zoneFR="Val d'Anduin",
        map={{MapType.RHOVANION, 390, 300}},
        overlap={"0x70041A22", "0x70052F12"},
        level=120
    })
    self.hunter:AddSkill({
        id="0x70052F08",
        nameEN="Guide to Hultvís",      labelEN="Hultvís", zoneEN="Vales of Anduin",
        nameDE="Leitfaden für Hultvís", labelDE="Hultvís", zoneDE="Die Täler des Anduin",
        nameFR="Guide de Hultvis",      labelFR="Hultvis", zoneFR="Val d'Anduin",
        map={{MapType.RHOVANION, 375, 400}},
        overlap={"0x70052F04"},
        level=120.1
    })
    self.hunter:AddSkill({
        id="0x700551F4",
        nameEN="Guide to Estolad Lân",    labelEN="Estolad Lân", zoneEN="Imlad Morgul",
        nameDE="Führer nach Estolad Lân", labelDE="Estolad Lân", zoneDE="Imlad Morgul",
        nameFR="Guide vers Estolad Lân",  labelFR="Estolad Lân", zoneFR="Imlad Morgul",
        map={{MapType.GONDOR, 960, 460}},
        overlap={"0x700551F8"},
        level=125
    })
    self.hunter:AddSkill({
        id="0x7005762D",
        nameEN="Guide to Limlók",    labelEN="Limlók", zoneEN="Wells of Langflood",
        nameDE="Führer nach Limlók", labelDE="Limlók", zoneDE="Quellen des Langflut",
        nameFR="Guide de Limlok",    labelFR="Limlok", zoneFR="Puits du Long Fleuve",
        map={{MapType.RHOVANION, 345, 230}},
        overlap={"0x70057629"},
        level=130
    })
    self.hunter:AddSkill({
        id="0x70058571",
        nameEN="Guide to Annâk-khurfu",    labelEN="Annâk-khurfu", zoneEN="Elderslade",
        nameDE="Führer nach Annâk-khurfu", labelDE="Annâk-khurfu", zoneDE="Elderslade",
        nameFR="Guide vers Annâk-khurfu",  labelFR="Annâk-khurfu", zoneFR="Elderslade",
        map={{MapType.RHOVANION, 530, 90}},
        overlap={"0x7005856F"},
        level=130.1
    })
    self.hunter:AddSkill({
        id="0x7005AA91",
        nameEN="Guide to Akrâz-zahar",    labelEN="Akrâz-zahar", zoneEN="Eryn Lasgalen",
        nameDE="Führer nach Akrâz-zahar", labelDE="Akrâz-zahar", zoneDE="Eryn Lasgalen",
        nameFR="Guide vers Akrâz-zahar",  labelFR="Akrâz-zahar", zoneFR="Eryn Lasgalen",
        map={{MapType.RHOVANION, 750, 115}},
        overlap={"0x7005AA90"},
        level=130.2
    })
    self.hunter:AddSkill({
        id="0x7005AA95",
        nameEN="Guide to Azanulbizar",    labelEN="Amdân", zoneEN="Azanulbizar",
        nameDE="Führer nach Azanulbizar", labelDE="Amdân", zoneDE="Azanulbizar",
        nameFR="Guide vers Azanulbizar",  labelFR="Amdân", zoneFR="Azanulbizar",
        map={{MapType.RHOVANION, 210, 555}},
        overlap={"0x7005AA92"},
        level=130.3
    })
    self.hunter:AddSkill({
        id="0x7005D487",
        nameEN="Guide to the Noble Gate",   labelEN="Noble Gate",  zoneEN="Gundabad",
        nameDE="Führer zum Prachttor",      labelDE="Prachttor",   zoneDE="Gundabad",
        nameFR="Guide vers la Porte Noble", labelFR="Porte Noble", zoneFR="Gundabad",
        map={{MapType.RHOVANION, 190, 130}},
        overlap={"0x7005D47C"},
        level=131
    })
    self.hunter:AddSkill({
        id="0x7005D47D",
        nameEN="Guide to Leitstáth",    labelEN="Leitstáth", zoneEN="Gundabad",
        nameDE="Führer nach Leitstáth", labelDE="Leitstáth", zoneDE="Gundabad",
        nameFR="Guide vers Leitstath",  labelFR="Leitstath", zoneFR="Gundabad",
        map={{MapType.RHOVANION, 270, 65}},
        overlap={"0x7005D484"},
        level=135
    })
    self.hunter:AddSkill({
        id="0x70064AC8",
        nameEN="Guide to Carn Dûm",    labelEN="Carn Dûm", zoneEN="Angmar",
        nameDE="Führer nach Carn Dûm", labelDE="Carn Dûm", zoneDE="Angmar",
        nameFR="Guide vers Carn Dûm",  labelFR="Carn Dûm", zoneFR="Angmar",
        map={{MapType.ERIADOR, 735, 100}},
        overlap={"0x70064ACA"},
        level=140.1
    })
    self.hunter:AddSkill({
        id="0x700658EA",
        nameEN="Guide to Pelargir",    labelEN="Pelargir", zoneEN="King's Gondor",
        nameDE="Führer nach Pelargir", labelDE="Pelargir", zoneDE="Königreich Gondor",
        nameFR="Guide vers Pelargir",  labelFR="Pelargir", zoneFR="Gondor royal",
        map={{MapType.GONDOR, 670, 625}},
        overlap={"0x700658EB"},
        level=141
    })
    self.hunter:AddSkill({
        id="0x70068711",
        nameEN="Guide to Dol Amroth",    descEN="King's Gondor",     labelEN="Dol Amroth", zoneEN="King's Gondor",
        nameDE="Führer nach Dol Amroth", descDE="Königreich Gondor", labelDE="Dol Amroth", zoneDE="Königreich Gondor",
        nameFR="Guide vers Dol Amroth",  descFR="le Gondor royal",   labelFR="Dol Amroth", zoneFR="Gondor royal",
        map={{MapType.GONDOR, 210, 485}, {MapType.HARADWAITH, 210, 485}},
        overlap={"0x70068700"},
        level=142
    })
    self.hunter:AddSkill({
        id="0x70068717",
        nameEN="Guide to Lond Cirion",    labelEN="Lond Cirion", zoneEN="Anfalas",
        nameDE="Führer nach Lond Cirion", labelDE="Lond Cirion", zoneDE="Anfalas",
        nameFR="Guide vers Lond Cirion",  labelFR="Lond Cirion", zoneFR="Anfalas",
        map={{MapType.GONDOR, 255, 420}, {MapType.HARADWAITH, 230, 20}},
        overlap={"0x70068703"},
        level=143
    })
    self.hunter:AddSkill({
        id="0x70068713",
        nameEN="Guide to Halrax",    labelEN="Halrax", zoneEN="Shield Isles",
        nameDE="Führer nach Halrax", labelDE="Halrax", zoneDE="Die Schildinseln",
        nameFR="Guide vers Halrax",  labelFR="Halrax", zoneFR="Les îles du Bouclier",
        map={{MapType.HARADWAITH, 275, 160}},
        overlap={"0x70068702"},
        level=145
    })
    self.hunter:AddSkill({
        id="0x70068719",
        nameEN="Guide to Jax Phanâl",    labelEN="Jax Phanâl", zoneEN="Umbar",
        nameDE="Führer nach Jax Phanâl", labelDE="Jax Phanâl", zoneDE="Umbar",
        nameFR="Guide vers Jax Phanâl",  labelFR="Jax Phanâl", zoneFR="Umbar",
        map={{MapType.HARADWAITH, 305, 315}},
        overlap={"0x70068701"},
        level=146
    })
    self.hunter:AddSkill({
        id="0x70068718",
        nameEN="Guide to Umbar",    labelEN="Umbar Baharbêl", zoneEN="Umbar",
        nameDE="Führer nach Umbar", labelDE="Umbar Baharbêl", zoneDE="Umbar",
        nameFR="Guide vers Umbar",  labelFR="Umbar Baharbêl", zoneFR="Umbar",
        map={{MapType.HARADWAITH, 505, 370}},
        overlap={"0x700686FF"},
        level=148
    })
    self.hunter:AddSkill({
        id="0x700697EF",
        nameEN="Guide to the Bloody Eagle Tavern",          labelEN="Bloody Eagle Tavern",         zoneEN="Umbar",
        nameDE="Führer zur Taverne \"Zum Blutigen Adler\"", labelDE="Zum Blutigen Adler",          zoneDE="Umbar",
        nameFR="Guide vers la taverne de l'Aigle sanglant", labelFR="Taverne de l'Aigle sanglant", zoneFR="Umbar",
        map={{MapType.HARADWAITH, 475, 400}},
        overlap={"0x700697F2"},
        level=149
    })

    -- add the Warden locations
    self.warden:AddLabelTag({EN=" (Muster)", DE=" (Appell)", FR=" (Rassemblement)" })
    self.warden:AddSkill({
        id="0x70064F4D",
        nameEN="Muster at Clegur",       labelEN="Clegur", zoneEN="Swanfleet",
        nameDE="Appell in Clegur",       labelDE="Clegur", zoneDE="Schwanenfleet",
        nameFR="Rassemblement à Clegur", labelFR="Clegur", zoneFR="Noues des cygnes",
        map={{MapType.ERIADOR, 755, 555}},
        overlap={"0x70064F47"},
        level=7
    })
    self.warden:AddSkill({
        id="0x700634B6",
        nameEN="Muster at Swanfleet",                labelEN="Lhan Garan", zoneEN="Swanfleet",
        nameDE="Appell in Schwanenfleet",            labelDE="Lhan Garan", zoneDE="Schwanenfleet",
        nameFR="Rassemblement aux Noues des cygnes", labelFR="Lhan Garan", zoneFR="Noues des cygnes",
        map={{MapType.ERIADOR, 825, 490}},
        overlap={"0x700634A4"},
        level=10
    })
    self.warden:AddSkill({
        id="0x700634AD",
        nameEN="Muster at Cardolan",        labelEN="Herne", zoneEN="Cardolan",
        nameDE="Appell in Cardolan",        labelDE="Herne", zoneDE="Cardolan",
        nameFR="Rassemblement au Cardolan", labelFR="Herne", zoneFR="Cardolan",
        map={{MapType.ERIADOR, 560, 495}},
        overlap={"0x700634AE"},
        level=15
    })
    self.warden:AddSkill({
        id="0x70063242",
        nameEN="Muster at Andrath",       labelEN="Andrath", zoneEN="Cardolan",
        nameDE="Appell in Andrath",       labelDE="Andrath", zoneDE="Cardolan",
        nameFR="Rassemblement à Andrath", labelFR="Andrath", zoneFR="Cardolan",
        map={{MapType.ERIADOR, 580, 465}},
        overlap={"0x7006323D"},
        level=17
    })
    self.warden:AddSkill({
        id="0x7006133E",
        nameEN="Muster at Nobottle",          labelEN="Nobottle",    zoneEN="Yondershire",
        nameDE="Appell in Neuhausen",         labelDE="Neuhausen",   zoneDE="Ferne Auen",
        nameFR="Rassemblement à Bourdeneuve", labelFR="Bourdeneuve", zoneFR="Comté lointain",
        map={{MapType.ERIADOR, 440, 350}},
        overlap={"0x70061340"},
        level=20
    })
    self.warden:AddSkill({
        id="0x70014786",
        nameEN="Muster in Ost Guruth",       labelEN="Ost Guruth",   zoneEN="Lone-lands",
        nameDE="Appell in der Feste Guruth", labelDE="Feste Guruth", zoneDE="Einsame Lande",
        nameFR="Rassemblement : Ost Guruth", labelFR="Ost Guruth",   zoneFR="Terres Solitaires",
        map={{MapType.ERIADOR, 755, 400}},
        overlap={"0x70020441"},
        level=25
    })
    self.warden:AddSkill({
        id="0x70014798",
        nameEN="Muster in Esteldín",       labelEN="Esteldín", zoneEN="North Downs",
        nameDE="Appell in Esteldín",       labelDE="Esteldín", zoneDE="Nordhöhen",
        nameFR="Rassemblement : Esteldin", labelFR="Esteldin", zoneFR="Hauts du Nord",
        map={{MapType.ERIADOR, 655, 290}},
        level=30
    })
    self.warden:AddSkill({
        id="0x7001478E",
        nameEN="Muster in Evendim",                   labelEN="Tinnudir", zoneEN="Evendim",
        nameDE="Appell in Evendim",                   labelDE="Tinnudir", zoneDE="Evendim",
        nameFR="Rassemblement : La région d'Evendim", labelFR="Tinnudir", zoneFR="Evendim",
        map={{MapType.ERIADOR, 490, 235}},
        level=35
    })
    self.warden:AddSkill({
        id="0x70060EA5",
        nameEN="Muster at Tornhad", labelEN="Tornhad", zoneEN="Angle of Mitheithel",
        nameDE="Appell in Tornhad", labelDE="Tornhad", zoneDE="Der Bogen von Mitheithel",
        nameFR="Retour à Tornhad",  labelFR="Tornhad", zoneFR="L'Angle de Mitheithel",
        map={{MapType.ERIADOR, 775, 435}},
        overlap={"0x70060EA8"},
        level=40
    })
    self.warden:AddSkill({
        id="0x70014791",
        nameEN="Muster in Rivendell",       labelEN="Rivendell", zoneEN="Trollshaws",
        nameDE="Appell in Bruchtal",        labelDE="Bruchtal",  zoneDE="Die Trollhöhen",
        nameFR="Rassemblement : Fondcombe", labelFR="Fondcombe", zoneFR="Trouée des Trolls",
        map={{MapType.ERIADOR, 865, 410}},
        overlap={"0x7000631F", "0x70023263"},
        level=40.1
    })
    self.warden:AddSkill({
        id="0x700303DD",
        nameEN="Muster in the Misty Mountains",     labelEN="Hrimbarg", zoneEN="Misty Mountains",
        nameDE="Appell im Nebelgebirge",            labelDE="Hrimbarg", zoneDE="Nebelgebirge",
        nameFR="Rassemblement : Les Monts Brumeux", labelFR="Hrimbarg", zoneFR="Monts Brumeux",
        map={{MapType.ERIADOR, 915, 265}},
        level=40.2
    })
    self.warden:AddSkill({
        id="0x70059D10",
        nameEN="Muster in Trestlebridge",         labelEN="Trestlebridge",   zoneEN="North Downs",
        nameDE="Appell in Schragen",              labelDE="Schragen",        zoneDE="Nordhöhen",
        nameFR="Rassemblement : Pont-à-Tréteaux", labelFR="Pont-à-Tréteaux", zoneFR="Hauts du Nord",
        map={{MapType.ERIADOR, 590, 285}},
        overlap={"0x70059D12"},
        level=40.3
    })
    self.warden:AddSkill({
        id="0x70059D09",
        nameEN="Muster in Trader's Wharf",           labelEN="Trader's Wharf",     zoneEN="Evendim",
        nameDE="Appell am Händlerkai",               labelDE="Händlerkai",         zoneDE="Evendim",
        nameFR="Rassemblement : Quai des marchands", labelFR="Quai des marchands", zoneFR="Evendim",
        map={{MapType.ERIADOR, 515, 305}},
        overlap={"0x70059D0E"},
        level=40.4
    })
    self.warden:AddSkill({
        id="0x700237D4",
        nameEN="Muster in Sûri-kylä",       labelEN="Sûri-kylä", zoneEN="Forochel",
        nameDE="Appell in Sûri-kylä",       labelDE="Sûri-kylä", zoneDE="Forochel",
        nameFR="Rassemblement : Sûri-kylä", labelFR="Sûri-kylä", zoneFR="Forochel",
        map={{MapType.ERIADOR, 430, 50}},
        level=42
    })
    self.warden:AddSkill({
        id="0x7001819E",
        nameEN="Muster in the Twenty-first Hall",          labelEN="Twenty-first Hall",     zoneEN="Moria",
        nameDE="Appell in der Einundzwanzigsten Halle",    labelDE="21. Halle",             zoneDE="Moria",
        nameFR="Rassemblement : La vingt et unième salle", labelFR="Vingt et unième salle", zoneFR="Moria",
        map={{MapType.RHOVANION, 95, 585}, {MapType.ERIADOR, 950, 510}},
        level=55
    })
    self.warden:AddSkill({
        id="0x700303DF",
        nameEN="Muster in Caras Galadhon",       labelEN="Caras Galadhon", zoneEN="Lothlórien",
        nameDE="Appell in Caras Galadhon",       labelDE="Caras Galadhon", zoneDE="Lothlórien",
        nameFR="Rassemblement : Caras Galadhon", labelFR="Caras Galadhon", zoneFR="Lothlórien",
        map={{MapType.RHOVANION, 120, 660}},
        overlap={"0x70048C8C"},
        level=60
    })
    self.warden:AddSkill({
        id="0x7001F45C",
        nameEN="Muster in Mirk-eaves",         labelEN="Mirk-Eaves",  zoneEN="Mirkwood",
        nameDE="Appell in der Dunkelsenke",    labelDE="Dunkelsenke", zoneDE="Düsterwald",
        nameFR="Rassemblement : L'Orée noire", labelFR="Orée noire",  zoneFR="Forêt Noire",
        map={{MapType.RHOVANION, 365, 630}},
        level=61
    })
    self.warden:AddSkill({
        id="0x700235EB",
        nameEN="Muster in Harndirion",       labelEN="Harndirion", zoneEN="Enedwaith",
        nameDE="Appell in Harndirion",       labelDE="Harndirion", zoneDE="Enedwaith",
        nameFR="Rassemblement : Harndirion", labelFR="Harndirion", zoneFR="Enedwaith",
        map={{MapType.ERIADOR, 815, 635}},
        level=62
    })
    self.warden:AddSkill({
        id="0x7002A90A",
        nameEN="Muster in Galtrev",       labelEN="Galtrev", zoneEN="Dunland",
        nameDE="Appell in Galtrev",       labelDE="Galtrev", zoneDE="Dunland",
        nameFR="Rassemblement : Galtrev", labelFR="Galtrev", zoneFR="Pays de Dun",
        map={{MapType.ERIADOR, 810, 715}},
        overlap={"0x7002C647"},
        level=65
    })
    self.warden:AddSkill({
        id="0x7002C646",
        nameEN="Muster in Stangard",        labelEN="Stangard",  zoneEN="Great River",
        nameDE="Appell in Stangard",        labelDE="Stangard",  zoneDE="Großer Fluss",
        nameFR="Rassemblement : Stangarde", labelFR="Stangarde", zoneFR="Grand Fleuve",
        map={{MapType.RHOVANION, 200, 720}, {MapType.ROHAN, 545, 90}},
        overlap={"0x7002C65D"},
        level=75
    })
    self.warden:AddSkill({
        id="0x7003198D",
        nameEN="Muster in Snowbourn",         labelEN="Snowbourn",    zoneEN="East Rohan",
        nameDE="Appell in Schneegrenze",      labelDE="Schneegrenze", zoneDE="Ost-Rohan",
        nameFR="Rassemblement : Neigebronne", labelFR="Neigebronne",  zoneFR="Rohan est",
        map={{MapType.ROHAN, 515, 500}},
        overlap={"0x70031A46"},
        level=80
    })
    self.warden:AddSkill({
        id="0x70036B5B",
        nameEN="Muster in Forlaw",       labelEN="Forlaw",  zoneEN="Wildermore",
        nameDE="Appell in Forlach",      labelDE="Forlach", zoneDE="Wildermark",
        nameFR="Rassemblement : Forloi", labelFR="Forloi",  zoneFR="Landes farouches",
        map={{MapType.ROHAN, 450, 175}},
        overlap={"0x70036B5E"},
        level=85
    })
    self.warden:AddSkill({
        id="0x7003DC7A",
        nameEN="Muster in Aldburg",       labelEN="Aldburg", zoneEN="West Rohan",
        nameDE="Appell in Aldburg",       labelDE="Aldburg", zoneDE="West-Rohan",
        nameFR="Rassemblement : Aldburg", labelFR="Aldburg", zoneFR="Rohan de l'Ouest",
        map={{MapType.ROHAN, 570, 640}},
        overlap={"0x7003DC81"},
        level=88
    })
    self.warden:AddSkill({
        id="0x7003DC79",
        nameEN="Muster in Helm's Deep",           labelEN="Helm's Deep",     zoneEN="West Rohan",
        nameDE="Appell in Helms Klamm",           labelDE="Helms Klamm",     zoneDE="West-Rohan",
        nameFR="Rassemblement : Gouffre de Helm", labelFR="Gouffre de Helm", zoneFR="Rohan de l'Ouest",
        map={{MapType.ROHAN, 275, 565}},
        overlap={"0x7003DC82"},
        level=90
    })
    self.warden:AddSkill({
        id="0x70041198",
        nameEN="Muster in Dol Amroth",       descEN="in western Gondor",     labelEN="Dol Amroth", zoneEN="Western Gondor",
        nameDE="Appell in Dol Amroth",       descDE="West-Gondor zu reisen", labelDE="Dol Amroth", zoneDE="West-Gondor",
        nameFR="Rassemblement : Dol Amroth", descFR="l'Ouest du Gondor",     labelFR="Dol Amroth", zoneFR="Gondor de l'Ouest",
        map={{MapType.GONDOR, 225, 550}},
        overlap={"0x700411AC"},
        level=98
    })
    self.warden:AddSkill({
        id="0x70043A66",
        nameEN="Muster in Arnach",       labelEN="Arnach", zoneEN="Eastern Gondor",
        nameDE="Appell in Arnach",       labelDE="Arnach", zoneDE="Ost-Gondor",
        nameFR="Rassemblement : Arnach", labelFR="Arnach", zoneFR="Gondor de l'Ouest",
        map={{MapType.GONDOR, 715, 425}},
        overlap={"0x70043A6A"},
        level=100
    })
    self.warden:AddSkill({
        id="0x70044982",
        nameEN="Muster in Minas Tirith",       labelEN="Minas Tirith", zoneEN="Old Anórien",
        nameDE="Appell in Minas Tirith",       labelDE="Minas Tirith", zoneDE="Alt-Anórien",
        nameFR="Rassemblement : Minas Tirith", labelFR="Minas Tirith", zoneFR="Ancien Anórien",
        map={{MapType.GONDOR, 670, 345}},
        overlap={"0x7004497E"},
        level=100.1
    })
    self.warden:AddSkill({
        id="0x700459AA",
        nameEN="Muster in the War-stead",        labelEN="War-stead",                zoneEN="Far Anórien",
        nameDE="Appell im Kriegslager",          labelDE="Kriegslager der Rohirrim", zoneDE="Fernes Anórien",
        nameFR="Rassemblement : Camp militaire", labelFR="Camp militaire",           zoneFR="Lointain Anórien",
        map={{MapType.GONDOR, 665, 140}},
        overlap={"0x700459A9"},
        level=102
    })
    self.warden:AddSkill({
        id="0x70046CBF",
        nameEN="Muster in after-battle Minas Tirith",            labelEN="Minas Tirith after battle",      zoneEN="Anórien",
        nameDE="Appell im schlachtgezeichneten Minas Tirith",    labelDE="Minas Tirith nach der Schlacht", zoneDE="Anórien",
        nameFR="Rassemblement : Minas Tirith après la bataille", labelFR="Minas Tirith après la bataille", zoneFR="Anórien",
        map={{MapType.GONDOR, 670, 375}},
        overlap={"0x70046CC0"},
        level=105
    })
    self.warden:AddSkill({
        id="0x70047076",
        nameEN="Muster in after-battle Osgiliath",            labelEN="Osgiliath after-battle",      zoneEN="Anórien",
        nameDE="Appell im schlachtgezeichneten Osgiliath",    labelDE="Osgiliath nach der Schlacht", zoneDE="Anórien",
        nameFR="Rassemblement : Osgiliath après la bataille", labelFR="Osgiliath après la bataille", zoneFR="Anórien",
        map={{MapType.GONDOR, 855, 335}},
        overlap={"0x7004707D"},
        level=105.1
    })
    self.warden:AddSkill({
        id="0x70047075",
        nameEN="Muster in Henneth Annûn",       labelEN="Henneth Annûn", zoneEN="Ithilien",
        nameDE="Appell in Henneth Annûn",       labelDE="Henneth Annûn", zoneDE="Ithilien",
        nameFR="Rassemblement : Henneth Annûn", labelFR="Henneth Annûn", zoneFR="Ithilien",
        map={{MapType.GONDOR, 875, 385}},
        overlap={"0x70047080"},
        level=105.2
    })
    self.warden:AddSkill({
        id="0x70047BFC",
        nameEN="Muster in the Camp of the Host",  labelEN="Camp of the Host", zoneEN="The Wastes",
        nameDE="Appell im Lager des Heeres",      labelDE="Lager des Heeres", zoneDE="Das Ödland",
        nameFR="Rassemblement : Camp de l'armée", labelFR="Camp de l'armée",  zoneFR="Les Landes désertiques",
        map={{MapType.GONDOR, 805, 170}},
        overlap={"0x70047BF4"},
        level=105.3
    })
    self.warden:AddSkill({
        id="0x70047C23",
        nameEN="Muster in Haerondir",       labelEN="Haerondir", zoneEN="The Wastes",
        nameDE="Appell in Haerondir",       labelDE="Haerondir", zoneDE="Das Ödland",
        nameFR="Rassemblement : Haerondir", labelFR="Haerondir", zoneFR="Les Landes désertiques",
        map={{MapType.GONDOR, 855, 100}},
        overlap={"0x70047C1B"},
        level=105.4
    })
    self.warden:AddSkill({
        id="0x7004AE1F",
        nameEN="Muster in the Udûn Foothold",    labelEN="Udûn Foothold",    zoneEN="Mordor",
        nameDE="Appell am Udûn-Brückenkopf",     labelDE="Udûn-Brückenkopf", zoneDE="Mordor",
        nameFR="Rassemblement : Le fort d'Udûn", labelFR="Fort d'Udûn",      zoneFR="Mordor",
        map={{MapType.GONDOR, 925, 230}},
        overlap={"0x7004AE1D"},
        level=106
    })
    self.warden:AddSkill({
        id="0x7004D73A",
        nameEN="Muster in Dale",       labelEN="Dale", zoneEN="Eryn Lasgalen",
        nameDE="Appell in Thal",       labelDE="Thal", zoneDE="Eryn Lasgalen",
        nameFR="Rassemblement : Dale", labelFR="Dale", zoneFR="Eryn Lasgalen",
        map={{MapType.RHOVANION, 720, 215}},
        overlap={"0x7004D738"},
        level=115
    })
    self.warden:AddSkill({
        id="0x7004FACA",
        nameEN="Muster in Járnfast",       labelEN="Járnfast", zoneEN="The Ironfold",
        nameDE="Appell in Járnfast",       labelDE="Jarnfast", zoneDE="Der Eisenbruch",
        nameFR="Rassemblement : Jarnfast", labelFR="Jarnfast", zoneFR="La Crevasse de Fer",
        map={{MapType.RHOVANION, 890, 110}},
        overlap={"0x7004FAC3"},
        level=116
    })
    self.warden:AddSkill({
        id="0x7004FACD",
        nameEN="Muster in Skarháld",       labelEN="Skarháld", zoneEN="Ered Mithrin",
        nameDE="Appell in Skarháld",       labelDE="Skarhald", zoneDE="Ered Mithrin",
        nameFR="Rassemblement : Skarhald", labelFR="Skarhald", zoneFR="Ered Mithrin",
        map={{MapType.RHOVANION, 430, 90}},
        overlap={"0x7004FAC5"},
        level=117
    })
    self.warden:AddSkill({
        id="0x70052F0A",
        nameEN="Muster in Beorninghús",       labelEN="Beorninghús",   zoneEN="Vales of Anduin",
        nameDE="Appell im Beorningerhús",     labelDE="Beorningerhús", zoneDE="Die Täler des Anduin",
        nameFR="Rassemblement : Beorninghus", labelFR="Beorninghus",   zoneFR="Val d'Anduin",
        map={{MapType.RHOVANION, 390, 300}},
        overlap={"0x70041A22", "0x70052F12"},
        level=120
    })
    self.warden:AddSkill({
        id="0x70052F06",
        nameEN="Muster in Hultvís",       labelEN="Hultvís", zoneEN="Vales of Anduin",
        nameDE="Appell in Hultvís",       labelDE="Hultvís", zoneDE="Die Täler des Anduin",
        nameFR="Rassemblement : Hultvis", labelFR="Hultvis", zoneFR="Val d'Anduin",
        map={{MapType.RHOVANION, 375, 400}},
        overlap={"0x70052F04"},
        level=120.1
    })
    self.warden:AddSkill({
        id="0x700551F2",
        nameEN="Muster in Estolad Lân",       labelEN="Estolad Lân", zoneEN="Imlad Morgul",
        nameDE="Appell in Estolad Lân",       labelDE="Estolad Lân", zoneDE="Imlad Morgul",
        nameFR="Rassemblement : Estolad Lân", labelFR="Estolad Lân", zoneFR="Imlad Morgul",
        map={{MapType.GONDOR, 960, 460}},
        overlap={"0x700551F8"},
        level=125
    })
    self.warden:AddSkill({
        id="0x70057635",
        nameEN="Muster in Limlók",       labelEN="Limlók", zoneEN="Wells of Langflood",
        nameDE="Appell in Limlók",       labelDE="Limlók", zoneDE="Quellen des Langflut",
        nameFR="Rassemblement : Limlok", labelFR="Limlok", zoneFR="Puits du Long Fleuve",
        map={{MapType.RHOVANION, 345, 230}},
        overlap={"0x70057629"},
        level=130
    })
    self.warden:AddSkill({
        id="0x70058572",
        nameEN="Muster in Annâk-khurfu",       labelEN="Annâk-khurfu", zoneEN="Elderslade",
        nameDE="Appell in Annâk-khurfu",       labelDE="Annâk-khurfu", zoneDE="Elderslade",
        nameFR="Rassemblement : Annâk-khurfu", labelFR="Annâk-khurfu", zoneFR="Elderslade",
        map={{MapType.RHOVANION, 530, 90}},
        overlap={"0x7005856F"},
        level=130.1
    })
    self.warden:AddSkill({
        id="0x7005AA8F",
        nameEN="Muster in Akrâz-zahar",       labelEN="Akrâz-zahar", zoneEN="Eryn Lasgalen",
        nameDE="Appell in Akrâz-zahar",       labelDE="Akrâz-zahar", zoneDE="Eryn Lasgalen",
        nameFR="Rassemblement : Akrâz-zahar", labelFR="Akrâz-zahar", zoneFR="Eryn Lasgalen",
        map={{MapType.RHOVANION, 750, 115}},
        overlap={"0x7005AA90"},
        level=130.2
    })
    self.warden:AddSkill({
        id="0x7005AA8C",
        nameEN="Muster in Azanulbizar",       labelEN="Amdân", zoneEN="Azanulbizar",
        nameDE="Appell in Azanulbizar",       labelDE="Amdân", zoneDE="Azanulbizar",
        nameFR="Rassemblement : Azanulbizar", labelFR="Amdân", zoneFR="Azanulbizar",
        map={{MapType.RHOVANION, 210, 555}},
        overlap={"0x7005AA92"},
        level=130.3
    })
    self.warden:AddSkill({
        id="0x7005D48A",
        nameEN="Muster at the Noble Gate",       labelEN="Noble Gate",  zoneEN="Gundabad",
        nameDE="Appell am Prachttor",            labelDE="Prachttor",   zoneDE="Gundabad",
        nameFR="Rassemblement : La Porte Noble", labelFR="Porte Noble", zoneFR="Gundabad",
        map={{MapType.RHOVANION, 190, 130}},
        overlap={"0x7005D47C"},
        level=131
    })
    self.warden:AddSkill({
        id="0x7005D488",
        nameEN="Muster at Leitstáth",       labelEN="Leitstáth", zoneEN="Gundabad",
        nameDE="Appell in Leitstáth",       labelDE="Leitstáth", zoneDE="Gundabad",
        nameFR="Rassemblement : Leitstath", labelFR="Leitstath", zoneFR="Gundabad",
        map={{MapType.RHOVANION, 270, 65}},
        overlap={"0x7005D484"},
        level=135
    })
    self.warden:AddSkill({
        id="0x70064ACB",
        nameEN="Muster at Carn Dûm",        labelEN="Carn Dûm",   zoneEN="Angmar",
        nameDE="Appell in Carn Dûm",        labelDE="Carn Dûm",   zoneDE="Angmar",
        nameFR="Rassemblement : Carn Dûm", labelFR="Carn Dûm", zoneFR="Angmar",
        map={{MapType.ERIADOR, 735, 100}},
        overlap={"0x70064ACA"},
        level=140.1
    })
    self.warden:AddSkill({
        id="0x700658E8",
        nameEN="Muster at Pelargir",       labelEN="Pelargir", zoneEN="King's Gondor",
        nameDE="Heerschau in Pelargir",    labelDE="Pelargir", zoneDE="Königreich Gondor",
        nameFR="Rassemblement à Pelargir", labelFR="Pelargir", zoneFR="Gondor royal",
        map={{MapType.GONDOR, 670, 625}},
        overlap={"0x700658EB"},
        level=141
    })
    self.warden:AddSkill({
        id="0x70068712",
        nameEN="Muster at Dol Amroth",       descEN="King's Gondor",     labelEN="Dol Amroth", zoneEN="King's Gondor",
        nameDE="Appell in Dol Amroth",       descDE="Königreich Gondor", labelDE="Dol Amroth", zoneDE="Königreich Gondor",
        nameFR="Rassemblement à Dol Amroth", descFR="le Gondor royal",   labelFR="Dol Amroth", zoneFR="Gondor royal",
        map={{MapType.GONDOR, 210, 485}, {MapType.HARADWAITH, 385, 70}},
        overlap={"0x70068700"},
        level=142
    })
    self.warden:AddSkill({
        id="0x70068715",
        nameEN="Muster at Lond Cirion",       labelEN="Lond Cirion", zoneEN="Anfalas",
        nameDE="Appell in Lond Cirion",       labelDE="Lond Cirion", zoneDE="Anfalas",
        nameFR="Rassemblement à Lond Cirion", labelFR="Lond Cirion", zoneFR="Anfalas",
        map={{MapType.GONDOR, 255, 420}, {MapType.HARADWAITH, 230, 20}},
        overlap={"0x70068703"},
        level=143
    })
    self.warden:AddSkill({
        id="0x70068710",
        nameEN="Muster at Halrax",       labelEN="Halrax", zoneEN="Shield Isles",
        nameDE="Appell in Halrax",       labelDE="Halrax", zoneDE="Die Schildinseln",
        nameFR="Rassemblement à Halrax", labelFR="Halrax", zoneFR="Les îles du Bouclier",
        map={{MapType.HARADWAITH, 275, 260}},
        overlap={"0x70068702"},
        level=145
    })
    self.warden:AddSkill({
        id="0x7006870C",
        nameEN="Muster at Jax Phanâl",       labelEN="Jax Phanâl", zoneEN="Umbar",
        nameDE="Appell in Jax Phanâl",       labelDE="Jax Phanâl", zoneDE="Umbar",
        nameFR="Rassemblement à Jax Phanâl", labelFR="Jax Phanâl", zoneFR="Umbar",
        map={{MapType.HARADWAITH, 305, 315}},
        overlap={"0x70068701"},
        level=146
    })
    self.warden:AddSkill({
        id="0x7006870F",
        nameEN="Muster at Umbar",       labelEN="Umbar Baharbêl", zoneEN="Umbar",
        nameDE="Appell in Umbar",       labelDE="Umbar Baharbêl", zoneDE="Umbar",
        nameFR="Rassemblement à Umbar", labelFR="Umbar Baharbêl", zoneFR="Umbar",
        map={{MapType.HARADWAITH, 505, 370}},
        overlap={"0x700686FF"},
        level=148
    })
    self.warden:AddSkill({
        id="0x700697F3",
        nameEN="Muster at the Bloody Eagle Tavern",              labelEN="Bloody Eagle Tavern",         zoneEN="Umbar",
        nameDE="Appell in der Taverne \"Zum Blutigen Adler\"",   labelDE="Zum Blutigen Adler",          zoneDE="Umbar",
        nameFR="Rassemblement à la taverne de l'Aigle sanglant", labelFR="Taverne de l'Aigle sanglant", zoneFR="Umbar",
        map={{MapType.HARADWAITH, 475, 400}},
        overlap={"0x700697F2"},
        level=149
    })

    -- add the Mariner locations
    self.mariner:AddLabelTag({EN=" (Sail)", DE=" (Segeln)", FR=" (Naviguer)" })
    self.mariner:AddSkill({
        id="0x70066100",
        nameEN="Sail to Celondim",       labelEN="Celondim", zoneEN="Ered Luin",
        nameDE="Segelt nach Celondim",   labelDE="Celondim", zoneDE="Ered Luin",
        nameFR="Naviguer vers Celondim", labelFR="Celondim", zoneFR="Ered Luin",
        map={{MapType.ERIADOR, 310, 380}},
        level=1
    })
    self.mariner:AddSkill({
        id="0x7006611A",
        nameEN="Sail to Buckland",              labelEN="Buckland",     zoneEN="Bree",
        nameDE="Segelt nach Bockland",          labelDE="Bockland",     zoneDE="Bree",
        nameFR="Naviguer vers le Pays de Bouc", labelFR="Pays de Bouc", zoneFR="Bree",
        map={{MapType.ERIADOR, 515, 405}},
        level=4
    })
    self.mariner:AddSkill({
        id="0x70066120",
        nameEN="Sail to Tharbad",              labelEN="Tharbad",        zoneEN="Swanfleet",
        nameDE="Nach Tharbad segeln",          labelDE="Tharbad",        zoneDE="Schwanenfleet",
        nameFR="Naviguer vers le Gué de Sarn", labelFR="le Gué de Sarn", zoneFR="Noues des cygnes",
        map={{MapType.ERIADOR, 650, 525}},
        level=5
    })
    self.mariner:AddSkill({
        id="0x7006610F",
        nameEN="Sail to Tinnudir",       labelEN="Tinnudir", zoneEN="Evendim",
        nameDE="Segelt nach Tinnudir",   labelDE="Tinnudir", zoneDE="Evendim",
        nameFR="Naviguer vers Tinnudir", labelFR="Tinnudir", zoneFR="Evendim",
        map={{MapType.ERIADOR, 420, 250}},
        level=30
    })
    self.mariner:AddSkill({
        id="0x70066105",
        nameEN="Sail to Trader's Wharf",              labelEN="Trader's Wharf",     zoneEN="Evendim",
        nameDE="Segelt zum Händlerkai",               labelDE="Händlerkai",         zoneDE="Evendim",
        nameFR="Naviguer vers le Quai des marchands", labelFR="Quai des marchands", zoneFR="Evendim",
        map={{MapType.ERIADOR, 515, 305}},
        overlap={"0x70059D0E"},
        level=40.4
    })
    self.mariner:AddSkill({
        id="0x7006611C",
        nameEN="Sail to Sûri-kylä",       labelEN="Sûri-kylä", zoneEN="Forochel",
        nameDE="Segelt nach Sûri-kylä",   labelDE="Sûri-kylä", zoneDE="Forochel",
        nameFR="Naviguer vers Sûri-kylä", labelFR="Sûri-kylä", zoneFR="Forochel",
        map={{MapType.ERIADOR, 430, 50}},
        level=42
    })
    self.mariner:AddSkill({
        id="0x7006611E",
        nameEN="Sail to Lothlórien",          labelEN="Egladil", zoneEN="Lothlórien",
        nameDE="Segelt nach Lothlórien",      labelDE="Egladil", zoneDE="Lothlórien",
        nameFR="Naviguer vers la Lothlorien", labelFR="Egladil", zoneFR="Lothlórien",
        map={{MapType.RHOVANION, 245, 670}},
        overlap={"0x70048C8C"},
        level=60
    })
    self.mariner:AddSkill({
        id="0x7006610E",
        nameEN="Sail to the Mirk-eaves",     labelEN="Mirk-eaves",  zoneEN="Mirkwood",
        nameDE="Segelt zur Dunkelsenke",     labelDE="Dunkelsenke", zoneDE="Düsterwald",
        nameFR="Naviguer vers l'Orée Noire", labelFR="Orée Noire",  zoneFR="Forêt Noire",
        map={{MapType.RHOVANION, 365, 630}},
        level=61
    })
    self.mariner:AddSkill({
        id="0x70066101",
        nameEN="Sail to the Brown Lands",         labelEN="Brown Lands",   zoneEN="Great River",
        nameDE="Segelt in die Braunen Lande",     labelDE="Braune Lande",  zoneDE="Großer Fluss",
        nameFR="Naviguer vers les Terres brunes", labelFR="Terres brunes", zoneFR="Grand Fleuve",
        map={{MapType.ROHAN, 700, 180}},
        level=75.1
    })
    self.mariner:AddSkill({
        id="0x70066121",
        nameEN="Sail to Snowbourn",         labelEN="Snowbourn",    zoneEN="East Rohan",
        nameDE="Segelt nach Schneegrenze",  labelDE="Schneegrenze", zoneDE="Ost-Rohan",
        nameFR="Naviguer vers Neigebronne", labelFR="Neigebronne",  zoneFR="Rohan est",
        map={{MapType.ROHAN, 515, 500}},
        overlap={"0x70031A46"},
        level=80
    })
    self.mariner:AddSkill({
        id="0x70066117",
        nameEN="Sail to Dol Amroth",       descEN="Dol Amroth with nearby",     labelEN="Dol Amroth", zoneEN="Western Gondor",
        nameDE="Segelt nach Dol Amroth",   descDE="nach Dol Amroth.",           labelDE="Dol Amroth", zoneDE="West-Gondor",
        nameFR="Naviguer vers Dol Amroth", descFR="Amroth en bonne compagnie.", labelFR="Dol Amroth", zoneFR="Gondor de l'Ouest",
        map={{MapType.GONDOR, 225, 550}},
        overlap={"0x700411AC"},
        level=98
    })
    self.mariner:AddSkill({
        id="0x70066109",
        nameEN="Sail to after-battle Osgiliath",            labelEN="Osgiliath after-battle",         zoneEN="Anórien",
        nameDE="Segelt ins schlachtgezeichnete Osgiliath",  labelDE="Schlachtgezeichnetes Osgiliath", zoneDE="Anórien",
        nameFR="Naviguer vers Osgiliath après la bataille", labelFR="Osgiliath après la bataille",    zoneFR="Anórien",
        map={{MapType.GONDOR, 855, 335}},
        overlap={"0x7004707D"},
        level=105.1
    })
    self.mariner:AddSkill({
        id="0x7006610C",
        nameEN="Sail to Lake-town",       labelEN="Lake-town",    zoneEN="Eryn Lasgalen",
        nameDE="Segelt nach Seestadt.",   labelDE="Seestadt",     zoneDE="Eryn Lasgalen",
        nameFR="Cap sur la Ville du Lac", labelFR="Ville du Lac", zoneFR="Eryn Lasgalen",
        map={{MapType.RHOVANION, 740, 275}},
        overlap={"0x7004D738"},
        level=115
    })
    self.mariner:AddSkill({
        id="0x7006611B",
        nameEN="Sail to Pelargir",       labelEN="Pelargir", zoneEN="King's Gondor",
        nameDE="Segelt nach Pelargir",   labelDE="Pelargir", zoneDE="Königreich Gondor",
        nameFR="Naviguer vers Pelargir", labelFR="Pelargir", zoneFR="Gondor royal",
        map={{MapType.GONDOR, 670, 625}},
        overlap={"0x700658EB"},
        level=141
    })
    self.mariner:AddSkill({
        id="0x700687C1",
        nameEN="Sail to Dol Amroth",       descEN="King's Gondor",     labelEN="Dol Amroth", zoneEN="King's Gondor",
        nameDE="Segelt nach Dol Amroth",   descDE="Königreich Gondor", labelDE="Dol Amroth", zoneDE="Königreich Gondor",
        nameFR="Naviguer vers Dol Amroth", descFR="le Gondor royal",   labelFR="Dol Amroth", zoneFR="Gondor royal",
        map={{MapType.GONDOR, 210, 485}, {MapType.HARADWAITH, 385, 70}},
        overlap={"0x70068700"},
        level=142
    })
    self.mariner:AddSkill({
        id="0x700687BD",
        nameEN="Sail to Lond Cirion",       labelEN="Lond Cirion", zoneEN="Anfalas",
        nameDE="Nach Lond Cirion segeln",   labelDE="Lond Cirion", zoneDE="Anfalas",
        nameFR="Naviguer vers Lond Cirion", labelFR="Lond Cirion", zoneFR="Anfalas",
        map={{MapType.GONDOR, 255, 420}, {MapType.HARADWAITH, 230, 20}},
        overlap={"0x70068703"},
        level=143
    })
    self.mariner:AddSkill({
        id="0x700687C3",
        nameEN="Sail to Halrax",       labelEN="Halrax", zoneEN="Shield Isles",
        nameDE="Nach Halrax segeln",   labelDE="Halrax", zoneDE="Die Schildinseln",
        nameFR="Naviguer vers Halrax", labelFR="Halrax", zoneFR="Les îles du Bouclier",
        map={{MapType.HARADWAITH, 275, 160}},
        overlap={"0x70068702"},
        level=145
    })
    self.mariner:AddSkill({
        id="0x700687C0",
        nameEN="Sail to Jax Phanâl",       labelEN="Jax Phanâl", zoneEN="Umbar",
        nameDE="Nach Jax Phanâl segeln",   labelDE="Jax Phanâl", zoneDE="Umbar",
        nameFR="Naviguer vers Jax Phanâl", labelFR="Jax Phanâl", zoneFR="Umbar",
        map={{MapType.HARADWAITH, 305, 315}},
        overlap={"0x70068701"},
        level=146
    })
    self.mariner:AddSkill({
        id="0x700687BB",
        nameEN="Sail to Umbar",       labelEN="Umbar Baharbêl", zoneEN="Umbar",
        nameDE="Nach Umbar segeln",   labelDE="Umbar Baharbêl", zoneDE="Umbar",
        nameFR="Naviguer vers Umbar", labelFR="Umbar Baharbêl", zoneFR="Umbar",
        map={{MapType.HARADWAITH, 505, 370}},
        overlap={"0x700686FF"},
        level=148
    })

    -- add the racial travel skills
    self.racials:AddLabelTag({EN=" (Racial)", DE=" (Rasse)", FR=" (Race)" })
    self.racials:AddSkill({
        -- man
        id="0x700062F6",
        nameEN="Return to Bree",     descEN="enables you to quickly return", labelEN="West Gate",   zoneEN="Bree",
        nameDE="Rückkehr nach Bree", descDE="Ihr könnt schnell nach Bree",   labelDE="Westtor",     zoneDE="Bree",
        nameFR="Retour à Bree",      descFR="Permet de retourner",           labelFR="Porte Ouest", zoneFR="Bree",
        map={MapType.ERIADOR, 525, 335},
        level=5
    })
    self.racials:AddSkill({
        -- hobbit
        id="0x700062C8",
        nameEN="Return to the Shire",     labelEN="Michel Delving", zoneEN="Shire",
        nameDE="Rückkehr ins Auenland",   labelDE="Michelbinge",    zoneDE="Auenland",
        nameFR="Retournez dans la Comté", labelFR="Grand'Cave",     zoneFR="Comté",
        map={MapType.ERIADOR, 405, 440},
        level=1
    })
    self.racials:AddSkill({
        -- dwarf
        id="0x70006346",
        nameEN="Return to Thorin's Gate",   descEN="This enables you to quickly return", labelEN="Thorin's Gate",   zoneEN="Ered Luin",
        nameDE="Rückkehr zu Thorins Tor",   descDE="Hiermit gelangt Ihr schnell",        labelDE="Thorins Tor",     zoneEN="Ered Luin",
        nameFR="Retour : Porte de Thorin", descFR="Ceci vous permet de retourner",    labelFR="Porte de Thorin", zoneEN="Ered Luin",
        map={MapType.ERIADOR, 310, 270},
        level=1.2
    })
    self.racials:AddSkill({
        -- elf
        id="0x7000631F",
        nameEN="Return to Rivendell",    descEN="This enables you to quickly return", labelEN="Rivendell", zoneEN="Trollshaws",
        nameDE="Rückkehr nach Bruchtal", descDE="Hiermit gelangt Ihr schnell",        labelDE="Bruchtal",  zoneDE="Die Trollhöhen",
        nameFR="Retour à Fondcombe",     descFR="Ceci vous permet de retourner",      labelFR="Fondcombe", zoneFR="Trouée des Trolls",
        map={MapType.ERIADOR, 900, 375},
        level=40.1
    })
    self.racials:AddSkill({
        -- beorning
        id="0x70041A22",
        nameEN="Return Home",              labelEN="Beorning Home",    zoneEN="Vales of Anduin",
        nameDE="Zum 1. Heim zurückkehren", labelDE="Grimbeorns Hütte", zoneDE="Die Täler des Anduin",
        nameFR="Retour à la maison",       labelFR="Maison Beorning",  zoneFR="Val d'Anduin",
        map={MapType.RHOVANION, 285, 340},
        level=120
    })
    self.racials:AddSkill({
        -- high elf
        id="0x70048C8C",
        nameEN="Travel to Caras Galadhon in Lothlórien",    labelEN="Caras Galadhon", zoneEN="Lothlórien",
        nameDE="Reise nach Caras Galadhon in Lothlórien",   labelDE="Caras Galadhon", zoneDE="Lothlórien",
        nameFR="Voyage vers Caras Galadhon, en Lothlórien", labelFR="Caras Galadhon", zoneFR="Lothlórien",
        map={MapType.RHOVANION, 120, 690},
        level=60
    })
    self.racials:AddSkill({
        -- stoutaxe
        id="0x70053C0F",
        nameEN="Travel to Thorin's Hall",   labelEN="Thorin's Hall",    zoneEN="Ered Luin",
        nameDE="Reise zu Thorins Halle",    labelDE="Thorins Halle",    zoneEN="Ered Luin",
        nameFR="Aller au Palais de Thorin", labelFR="Palais de Thorin", zoneEN="Ered Luin",
        map={MapType.ERIADOR, 345, 310},
        level=1.2
    })
    self.racials:AddSkill({
        -- river hobbit
        id="0x70066D31",
        nameEN="Return to Lyndelby",        labelEN="Lyndelby", zoneEN="Wells of Langflood",
        nameDE="Kehrt zu Lyndelby zurück.", labelDE="Lyndelby", zoneDE="Quellen des Langflut",
        nameFR="Retour à Lyndelby",         labelFR="Lyndelby", zoneFR="Puits du Long Fleuve",
        map={MapType.RHOVANION, 155, 165},
        level=1.3
    })

    -- add the Return Home and housing skills
    self.gen:AddSkill({
        id="0x700256BA",
        nameEN="Return Home",
        nameDE="Zum 1. Heim zurückkehren", labelDE="1. Markstein",
        nameFR="Retour à la maison",       labelFR="Point de repère 1",
        map={MapType.NONE, -1, -1},
        level=1
    })
    self.gen:AddSkill({
        id="0x70025792",
        nameEN="Return Home 2",
        nameDE="Zum 2. Heim zurückkehren", labelDE="2. Markstein",
        nameFR="Retour à la maison 2",     labelFR="Point de repère 2",
        map={MapType.NONE, -1, -1},
        level=1
    })
    self.gen:AddSkill({
        id="0x70025793",
        nameEN="Return Home 3",
        nameDE="Zum 3. Heim zurückkehren", labelDE="3. Markstein",
        nameFR="Retour à la maison 3",     labelFR="Point de repère 3",
        map={MapType.NONE, -1, -1},
        level=1
    })
    self.gen:AddSkill({
        id="0x70025794",
        nameEN="Return Home 4",
        nameDE="Zum 4. Heim zurückkehren", labelDE="4. Markstein",
        nameFR="Retour à la maison 4",     labelFR="Point de repère 4",
        map={MapType.NONE, -1, -1},
        level=1
    })
    self.gen:AddSkill({
        id="0x70025795",
        nameEN="Return Home 5",
        nameDE="Zum 5. Heim zurückkehren", labelDE="5. Markstein",
        nameFR="Retour à la maison 5",     labelFR="Point de repère 5",
        map={MapType.NONE, -1, -1},
        level=1
    })
    self.gen:AddSkill({
        id="0x70025796",
        nameEN="Return Home 6",
        nameDE="Zum 6. Heim zurückkehren", labelDE="6. Markstein",
        nameFR="Retour à la maison 6",     labelFR="Point de repère 6",
        map={MapType.NONE, -1, -1},
        level=1
    })
    self.gen:AddSkill({
        id="0x7002FF62",
        nameEN="Return Home 7",
        nameDE="Zum 7. Heim zurückkehren", labelDE="7. Markstein",
        nameFR="Retour à la maison 7",     labelFR="Point de repère 7",
        map={MapType.NONE, -1, -1},
        level=1
    })
    self.gen:AddSkill({
        id="0x7002FF61",
        nameEN="Return Home 8",
        nameDE="Zum 8. Heim zurückkehren", labelDE="8. Markstein",
        nameFR="Retour à la maison 8",     labelFR="Point de repère 8",
        map={MapType.NONE, -1, -1},
        level=1
    })
    self.gen:AddSkill({
        id="0x7002FF60",
        nameEN="Return Home 9",
        nameDE="Zum 9. Heim zurückkehren", labelDE="9. Markstein",
        nameFR="Retour à la maison 9",     labelFR="Point de repère 9",
        map={MapType.NONE, -1, -1},
        level=1
    })
    self.gen:AddSkill({
        id="0x7002FF5F",
        nameEN="Return Home 10",
        nameDE="Zum 10. Heim zurückkehren", labelDE="10. Markstein",
        nameFR="Retour à la maison 10",     labelFR="Point de repère 10",
        map={MapType.NONE, -1, -1},
        level=1
    })
    self.gen:AddSkill({
        id="0x7002FF63",
        nameEN="Return Home 11",
        nameDE="Zum 11. Heim zurückkehren", labelDE="11. Markstein",
        nameFR="Retour à la maison 11",     labelFR="Point de repère 11",
        map={MapType.NONE, -1, -1},
        level=1
    })
    self.gen:AddSkill({
        id="0x7000D046",
        nameEN="Travel to Personal House",       labelEN="Personal House",
        nameDE="Reist zu Eurem eigenen Heim",    labelDE="Eigenes Heim",
        nameFR="Retour à la maison personnelle", labelFR="Maison personnelle",
        map={MapType.NONE, -1, -1},
        level=1
    })
    self.gen:AddSkill({
        id="0x70046EE4",
        nameEN="Travel to Premium House",    labelEN="Premium House",
        nameDE="Reist zu Eurem Premiumheim", labelDE="Premiumheim",
        nameFR="Aller à une maison premium", labelFR="Maison premium",
        map={MapType.NONE, -1, -1},
        level=1
    })
    self.gen:AddSkill({
        id="0x7000D047",
        nameEN="Travel to Kinship House",         labelEN="Kinship House",
        nameDE="Reist zum Haus Eurer Sippe",      labelDE="Heim Eurer Sippe",
        nameFR="Retour à la maison de confrérie", labelFR="Maison de confrérie",
        map={MapType.NONE, -1, -1},
        level=1
    })
    self.gen:AddSkill({
        id="0x70057C36",
        nameEN="Travel to Kinship Member's House",            labelEN="Kinship Member's House",
        nameDE="Zum Haus des Sippenmitglieds reisen",         labelDE="Heim des Sippenmitglieds",
        nameFR="Retour à la maison d'un membre de confrérie", labelFR="Maison d'un membre de confrérie",
        map={MapType.NONE, -1, -1},
        level=1
    })

    -- add the obtainable travel skills
    self.rep:AddLabelTag({EN=" (Rep)", DE=" (Ruf)", FR=" (Rep)" })
    self.rep:AddSkill({
        id="0x70023262",
        nameEN="Return to Michel Delving",  labelEN="Michel Delving", zoneEN="Shire",
        nameDE="Rückkehr nach Michelbinge", labelDE="Michelbinge",    zoneDE="Auenland",
        nameFR="Retour à Grand'Cave",       labelFR="Grand'Cave",     zoneFR="Comté",
        labelTagEN=" (Store)", labelTagDE=" (Shop)", labelTagFR=" (Shop)",
        map={{MapType.ERIADOR, 375, 440}},
        level=1
    })
    self.rep:AddSkill({
        id="0x7001BF91",
        nameEN="Return to Thorin's Gate",     descEN="Thanks to your friendship", labelEN="Thorin's Gate",   zoneEN="Ered Luin",
        nameDE="Rückkehr zu Thorins Tor",     descDE="Dank Eurer Freundschaft",   labelDE="Thorins Tor",     zoneEN="Ered Luin",
        nameFR="Retour : Porte de Thorin", descFR="Grâce à l'amitié qui vous", labelFR="Porte de Thorin", zoneEN="Ered Luin",
        map={{MapType.ERIADOR, 345, 310}},
        level=1.1
    })
    self.rep:AddSkill({
        id="0x7001BF90",
        nameEN="Return to Bree",     descEN="Thanks to your friendship", labelEN="West Gate",   zoneEN="Bree",
        nameDE="Rückkehr nach Bree", descDE="Dank Eurer Freundschaft",   labelDE="Westtor",     zoneDE="Bree",
        nameFR="Retour à Bree",      descFR="Grâce à votre amitié",      labelFR="Porte Ouest", zoneFR="Bree",
        map={{MapType.ERIADOR, 555, 335}},
        level=5
    })
    self.rep:AddSkill({
        id="0x700364B1",
        nameEN="Return to Lalia's Market",     labelEN="Lalia's Market",  zoneEN="Bree",
        nameDE="Kehrt zu Lalias Markt zurück", labelDE="Lalias Markt",    zoneDE="Bree",
        nameFR="Retour au Marché de Lalia",    labelFR="Marché de Lalia", zoneFR="Bree",
        labelTag=" (Mithril)",
        map={{MapType.ERIADOR, 630, 360}},
        level=5.1
    })
    self.rep:AddSkill({
        id="0x70064F47",
        nameEN="Return to Clegur",      labelEN="Clegur", zoneEN="Swanfleet",
        nameDE="Rückkehr nach Clegur",  labelDE="Clegur", zoneDE="Schwanenfleet",
        nameFR="Retournez voir Clegur", labelFR="Clegur", zoneFR="Noues des cygnes",
        map={{MapType.ERIADOR, 725, 555}},
        level=7
    })
    self.rep:AddSkill({
        id="0x700634A4",
        nameEN="Return to Swanfleet",         labelEN="Lhan Garan", zoneEN="Swanfleet",
        nameDE="Rückkehr nach Schwanenfleet", labelDE="Lhan Garan", zoneDE="Schwanenfleet",
        nameFR="Retour aux Noues des cygnes", labelFR="Lhan Garan", zoneFR="Noues des cygnes",
        map={{MapType.ERIADOR, 795, 490}},
        level=10
    })
    self.rep:AddSkill({
        id="0x700634AE",
        nameEN="Return to Cardolan",     labelEN="Herne", zoneEN="Cardolan",
        nameDE="Rückkehr nach Cardolan", labelDE="Herne", zoneDE="Cardolan",
        nameFR="Retour au Cardolan",     labelFR="Herne", zoneFR="Cardolan",
        map={{MapType.ERIADOR, 590, 495}},
        level=15
    })
    self.rep:AddSkill({
        id="0x7006323D",
        nameEN="Return to Andrath",     labelEN="Andrath", zoneEN="Cardolan",
        nameDE="Rückkehr nach Andrath", labelDE="Andrath", zoneDE="Cardolan",
        nameFR="Retour à Andrath",      labelFR="Andrath", zoneFR="Cardolan",
        map={{MapType.ERIADOR, 550, 465}},
        level=17
    })
    self.rep:AddSkill({
        id="0x70061340",
        nameEN="Return to Nobottle",           labelEN="Nobottle",    zoneEN="Yondershire",
        nameDE="Kehrt nach Neuhausen zurück.", labelDE="Neuhausen",   zoneDE="Ferne Auen",
        nameFR="Retour à Bourdeneuve",         labelFR="Bourdeneuve", zoneFR="Comté lointain",
        map={{MapType.ERIADOR, 410, 350}},
        level=20
    })
    self.rep:AddSkill({
        id="0x70020441",
        nameEN="Return to Ost Guruth",      labelEN="Ost Guruth",   zoneEN="Lone-lands",
        nameDE="Rückkehr zur Feste Guruth", labelDE="Feste Guruth", zoneDE="Einsame Lande",
        nameFR="Retournez à Ost Guruth",    labelFR="Ost Guruth",   zoneFR="Terres Solitaires",
        map={{MapType.ERIADOR, 725, 400}},
        level=25
    })
    self.rep:AddSkill({
        id="0x70060EA8",
        nameEN="Return to Tornhad",          labelEN="Tornhad", zoneEN="Angle of Mitheithel",
        nameDE="Kehrt nach Tornhad zurück.", labelDE="Tornhad", zoneDE="Der Bogen von Mitheithel",
        nameFR="Retournez voir Tornhad",     labelFR="Tornhad", zoneFR="L'Angle de Mitheithel",
        map={{MapType.ERIADOR, 745, 435}},
        level=40
    })
    self.rep:AddSkill({
        id="0x70023263",
        nameEN="Return to Rivendell",    descEN="Thanks to your friendship", labelEN="Rivendell", zoneEN="Trollshaws",
        nameDE="Rückkehr nach Bruchtal", descDE="Dank Eurer Freundschaft",   labelDE="Bruchtal",  zoneDE="Die Trollhöhen",
        nameFR="Retour à Fondcombe",     descFR="Grâce à votre amitié avec", labelFR="Fondcombe", zoneFR="Trouée des Trolls",
        labelTagEN=" (Store)", labelTagDE=" (Shop)", labelTagFR=" (Shop)",
        map={{MapType.ERIADOR, 835, 410}},
        level=40.1
    })
    self.rep:AddSkill({
        id="0x700634A5",
        nameEN="Return to the Tracery Archives in Rivendell",         labelEN="Tracery Archive",       zoneEN="Trollshaws",
        nameDE="Rückkehr zu den Filigranmuster-Archiven in Bruchtal", labelDE="Filigranmuster-Archiv", zoneDE="Die Trollhöhen",
        nameFR="Retour aux Archives de gravures de Fondcombe",        labelFR="Archives de gravures",  zoneFR="Trouée des Trolls",
        labelTag=" (Delving)",
        map={{MapType.ERIADOR, 905, 345}},
        level=40.11
    })
    self.rep:AddSkill({
        id="0x7005B38E",
        nameEN="Return to Glân Vraig",         labelEN="Glân Vraig", zoneEN="Ettenmoors",
        nameDE="Nach Glân Vraig zurückkehren", labelDE="Glân Vraig", zoneDE="Die Ettenöden",
        nameFR="Retour à Glân Vraig",          labelFR="Glân Vraig", zoneFR="Les Landes d'Etten",
        labelTagEN=" (Quest)", labelTagDE=" (Aufgabe)", labelTagFR=" (Quête)",
        map={{MapType.ERIADOR, 835, 245}},
        level=40.12
    })
    self.rep:AddSkill({
        id="0x70059D12",
        nameEN="Return to Trestlebridge",     labelEN="Trestlebridge",   zoneEN="North Downs",
        nameDE="Kehrt nach Schragen zurück.", labelDE="Schragen",        zoneDE="Nordhöhen",
        nameFR="Retournez à Pont-à-Tréteaux", labelFR="Pont-à-Tréteaux", zoneFR="Hauts du Nord",
        map={{MapType.ERIADOR, 560, 285}},
        level=40.3
    })
    self.rep:AddSkill({
        id="0x70059D0E",
        nameEN="Return to Trader's Wharf",        labelEN="Trader's Wharf",     zoneEN="Evendim",
        nameDE="Kehrt zum Händlerkai zurück.",    labelDE="Händlerkai",         zoneDE="Evendim",
        nameFR="Retournez au Quai des marchands", labelFR="Quai des marchands", zoneFR="Evendim",
        map={{MapType.ERIADOR, 515, 275}},
        level=40.4
    })
    self.rep:AddSkill({
        id="0x7001F374",
        nameEN="Return to Mirkwood",         labelEN="Ost Galadh",   zoneEN="Mirkwood",
        nameDE="Rückkehr zum Düsterwald",    labelDE="Feste Galadh", zoneDE="Düsterwald",
        nameFR="Retour dans la Forêt Noire", labelFR="Ost Galadh",   zoneFR="Forêt Noire",
        map={{MapType.RHOVANION, 335, 630}},
        level=61
    })
    self.rep:AddSkill({
        id="0x70021FA2",
        nameEN="Return to Enedwaith",     labelEN="Lhanuch", zoneEN="Enedwaith",
        nameDE="Rückkehr nach Enedwaith", labelDE="Lhanuch", zoneDE="Enedwaith",
        nameFR="Retour en Enedwaith",     labelFR="Lhanuch", zoneFR="Enedwaith",
        map={{MapType.ERIADOR, 765, 620}},
        level=62
    })
    self.rep:AddSkill({
        id="0x7002C647",
        nameEN="Return to Galtrev",         labelEN="Galtrev", zoneEN="Dunland",
        nameDE="Kehrt nach Galtrev zurück", labelDE="Galtrev", zoneDE="Dunland",
        nameFR="Retour à Galtrev",          labelFR="Galtrev", zoneFR="Pays de Dun",
        map={{MapType.ERIADOR, 780, 715}},
        level=65
    })
    self.rep:AddSkill({
        id="0x7002C65D",
        nameEN="Return to Stangard",         labelEN="Stangard",  zoneEN="Great River",
        nameDE="Kehrt nach Stangard zurück", labelDE="Stangard",  zoneDE="Großer Fluss",
        nameFR="Retour à Stangarde",         labelFR="Stangarde", zoneFR="Grand Fleuve",
        map={{MapType.RHOVANION, 170, 720}, {MapType.ROHAN, 515, 90}},
        level=75
    })
    self.rep:AddSkill({
        id="0x70031A46",
        nameEN="Return to Snowbourn",            labelEN="Snowbourn",    zoneEN="East Rohan",
        nameDE="Kehrt nach Schneegrenze zurück", labelDE="Schneegrenze", zoneDE="Ost-Rohan",
        nameFR="Retourner à Neigebronne",        labelFR="Neigebronne",  zoneFR="Rohan est",
        map={{MapType.ROHAN, 485, 500}},
        level=85
    })
    self.rep:AddSkill({
        id="0x70036B5E",
        nameEN="Return to Forlaw",      labelEN="Forlaw",  zoneEN="Wildermore",
        nameDE="Rückkehr nach Forlach", labelDE="Forlach", zoneDE="Wildermark",
        nameFR="Retour à Forloi",       labelFR="Forloi",  zoneFR="Landes farouches",
        map={{MapType.ROHAN, 480, 175}},
        level=85
    })
    self.rep:AddSkill({
        id="0x7003DC81",
        nameEN="Return to Aldburg",         labelEN="Aldburg", zoneEN="West Rohan",
        nameDE="Kehrt nach Aldburg zurück", labelDE="Aldburg", zoneDE="West-Rohan",
        nameFR="Retour à Aldburg",          labelFR="Aldburg", zoneFR="Rohan de l'Ouest",
        map={{MapType.ROHAN, 540, 640}},
        level=88
    })
    self.rep:AddSkill({
        id="0x7003DC82",
        nameEN="Return to Helm's Deep",         labelEN="Helm's Deep",     zoneEN="West Rohan",
        nameDE="Kehrt nach Helms Klamm zurück", labelDE="Helms Klamm",     zoneDE="West-Rohan",
        nameFR="Retour au Gouffre de Helm",     labelFR="Gouffre de Helm", zoneFR="Rohan de l'Ouest",
        map={{MapType.ROHAN, 245, 565}},
        level=90
    })
    self.rep:AddSkill({
        id="0x7004128F",
        nameEN="Return to Derndingle",      labelEN="Derndingle",   zoneEN="West Rohan",
        nameDE="Rückkehr ins Geheimnistal", labelDE="Geheimnistal", zoneDE="West-Rohan",
        nameFR="Retour à Derunant",         labelFR="Derunant",     zoneFR="Rohan de l'Ouest",
        map={{MapType.RHOVANION, 45, 720}, {MapType.ROHAN, 295, 275}},
        level=90.1
    })
    self.rep:AddSkill({
        id="0x700411AC",
        nameEN="Return to Dol Amroth",     descEN="in western Gondor",        labelEN="Dol Amroth", zoneEN="Western Gondor",
        nameDE="Rückkehr nach Dol Amroth", descDE="West-Gondor zurückkehren", labelDE="Dol Amroth", zoneDE="West-Gondor",
        nameFR="Retour à Dol Amroth",      descFR="l'Ouest du Gondor",        labelFR="Dol Amroth", zoneFR="Gondor de l'Ouest",
        map={{MapType.GONDOR, 195, 550}},
        level=98
    })
    self.rep:AddSkill({
        id="0x70043A6A",
        nameEN="Return to Arnach",     labelEN="Arnach", zoneEN="Eastern Gondor",
        nameDE="Rückkehr nach Arnach", labelDE="Arnach", zoneDE="Ost-Gondor",
        nameFR="Retournez à Arnach",   labelFR="Arnach", zoneFR="Gondor de l'Ouest",
        map={{MapType.GONDOR, 685, 425}},
        level=100
    })
    self.rep:AddSkill({
        id="0x7004497E",
        nameEN="Return to Minas Tirith",          labelEN="Minas Tirith", zoneEN="Old Anórien",
        nameDE="Kehrt nach Minas Tirith zurück.", labelDE="Minas Tirith", zoneDE="Alt-Anórien",
        nameFR="Retour à Minas Tirith",           labelFR="Minas Tirith", zoneFR="Ancien Anórien",
        map={{MapType.GONDOR, 700, 345}},
        level=100.1
    })
    self.rep:AddSkill({
        id="0x700459A9",
        nameEN="Return to the War-stead",             labelEN="War-stead",                zoneEN="Far Anórien",
        nameDE="Zurück zum Kriegslager der Rohirrim", labelDE="Kriegslager der Rohirrim", zoneDE="Fernes Anórien",
        nameFR="Retour au camp militaire",            labelFR="Camp militaire",           zoneFR="Lointain Anórien",
        map={{MapType.GONDOR, 635, 140}},
        level=102
    })
    self.rep:AddSkill({
        id="0x70046CC0",
        nameEN="Return to after-battle Minas Tirith",           labelEN="Minas Tirith after-battle",      zoneEN="Anórien",
        nameDE="Rückkehr ins schlachtgezeichnete Minas Tirith", labelDE="Minas Tirith nach der Schlacht", zoneDE="Anórien",
        nameFR="Retour à Minas Tirith après la bataille",       labelFR="Minas Tirith après la bataille", zoneFR="Anórien",
        map={{MapType.GONDOR, 700, 375}},
        level=105
    })
    self.rep:AddSkill({
        id="0x7004707D",
        nameEN="Return to after-battle Osgiliath",           labelEN="Osgiliath after-battle",      zoneEN="Anórien",
        nameDE="Rückkehr ins schlachtgezeichnete Osgiliath", labelDE="Osgiliath nach der Schlacht", zoneDE="Anórien",
        nameFR="Retour à Osgiliath après la bataille",       labelFR="Osgiliath après la bataille", zoneFR="Anórien",
        map={{MapType.GONDOR, 825, 335}},
        level=105.1
    })
    self.rep:AddSkill({
        id="0x70047080",
        nameEN="Return to Henneth Annûn",     labelEN="Henneth Annûn", zoneEN="Ithilien",
        nameDE="Rückkehr nach Henneth Annûn", labelDE="Henneth Annûn", zoneDE="Ithilien",
        nameFR="Retour à Henneth Annûn",      labelFR="Henneth Annûn", zoneFR="Ithilien",
        map={{MapType.GONDOR, 845, 385}},
        level=105.2
    })
    self.rep:AddSkill({
        id="0x70047BF4",
        nameEN="Return to the Camp of the Host", labelEN="Camp of the Host", zoneEN="The Wastes",
        nameDE="Rückkehr ins Lager des Heeres",  labelDE="Lager des Heeres", zoneDE="Das Ödland",
        nameFR="Retour au Camp de l'armée",      labelFR="Camp de l'armée",  zoneFR="Les Landes désertiques",
        map={{MapType.GONDOR, 775, 170}},
        level=105.3
    })
    self.rep:AddSkill({
        id="0x70047C1B",
        nameEN="Return to Haerondir",     labelEN="Haerondir", zoneEN="The Wastes",
        nameDE="Rückkehr nach Haerondir", labelDE="Haerondir", zoneDE="Das Ödland",
        nameFR="Retour à Haerondir",      labelFR="Haerondir", zoneFR="Les Landes désertiques",
        map={{MapType.GONDOR, 825, 100}},
        level=105.4
    })
    self.rep:AddSkill({
        id="0x7004AE1D",
        nameEN="Return to the Udûn Foothold", labelEN="Udûn Foothold",    zoneEN="Mordor",
        nameDE="Zurück zum Udûn-Brückenkopf", labelDE="Udûn-Brückenkopf", zoneDE="Mordor",
        nameFR="Retour au fort d'Udûn",       labelFR="Fort d'Udûn",      zoneFR="Mordor",
        map={{MapType.GONDOR, 895, 230}},
        level=106
    })
    self.rep:AddSkill({
        id="0x7004B8C2",
        nameEN="Journey to the Court of Lothlórien",    labelEN="Court of Lothlórien", zoneEN="Lothlórien",
        nameDE="Reise zum Hof von Lothlórien",          labelDE="Hof von Lothlórien",  zoneDE="Lothlórien",
        nameFR="Voyager jusqu'à la Cour de Lothlórien", labelFR="Cour de Lothlórien",  zoneFR="Lothlórien",
        labelTagEN=" (Quest)", labelTagDE=" (Aufgabe)", labelTagFR=" (Quête)",
        map={{MapType.RHOVANION, 140, 585}},
        level=110
    })
    self.rep:AddSkill({
        id="0x7004B8C3",
        nameEN="Journey to the Hall of the King", labelEN="Hall of the King", zoneEN="Old Anórien",
        nameDE="Reise zur Halle des Königs",      labelDE="Halle des Königs", zoneDE="Alt-Anórien",
        nameFR="Voyager jusqu'au Palais du roi",  labelFR="Palais du roi",    zoneFR="Ancien Anórien",
        labelTagEN=" (Quest)", labelTagDE=" (Aufgabe)", labelTagFR=" (Quête)",
        map={{MapType.GONDOR, 740, 310}},
        level=110.1
    })
    self.rep:AddSkill({
        id="0x7004B8C4",
        nameEN="Journey to the Hall Under the Mountain",   labelEN="Hall Under the Mountain", zoneEN="Ered Mithrin",
        nameDE="Reise zur Halle unter dem Berg",           labelDE="Halle unter dem Berg",    zoneDE="Ered Mithrin",
        nameFR="Voyager jusqu'au Palais sous la Montagne", labelFR="Palais sous la Montagne", zoneFR="Ered Mithrin",
        labelTagEN=" (Quest)", labelTagDE=" (Aufgabe)", labelTagFR=" (Quête)",
        map={{MapType.RHOVANION, 630, 115}},
        level=110.2
    })
    self.rep:AddSkill({
        id="0x7004B8C5",
        nameEN="Journey to Bâr Thorenion",      labelEN="Bâr Thorenion", zoneEN="Ithilien",
        nameDE="Reise nach Bâr Thorenion",      labelDE="Bâr Thorenion", zoneDE="Ithilien",
        nameFR="Voyager jusqu'à Bâr Thorenion", labelFR="Bâr Thorenion", zoneFR="Ithilien",
        labelTagEN=" (Quest)", labelTagDE=" (Aufgabe)", labelTagFR=" (Quête)",
        map={{MapType.GONDOR, 965, 370}},
        level=110.3
    })
    self.rep:AddSkill({
        id="0x7004D738",
        nameEN="Return to Dale",     labelEN="Dale", zoneEN="Eryn Lasgalen",
        nameDE="Rückkehr nach Thal", labelDE="Thal", zoneDE="Eryn Lasgalen",
        nameFR="Revenir à Dale",     labelFR="Dale", zoneFR="Eryn Lasgalen",
        map={{MapType.RHOVANION, 690, 215}},
        level=115
    })
    self.rep:AddSkill({
        id="0x7004FAC3",
        nameEN="Return to Járnfast",     labelEN="Járnfast", zoneEN="The Ironfold",
        nameDE="Rückkehr nach Járnfast", labelDE="Járnfast", zoneDE="Der Eisenbruch",
        nameFR="Revenir à Jarnfast",     labelFR="Jarnfast", zoneFR="La Crevasse de Fer",
        map={{MapType.RHOVANION, 860, 110}},
        level=116
    })
    self.rep:AddSkill({
        id="0x7004FAC5",
        nameEN="Return to Skarháld",          labelEN="Skarháld", zoneEN="Ered Mithrin",
        nameDE="Kehrt nach Skarháld zurück.", labelDE="Skarháld", zoneDE="Ered Mithrin",
        nameFR="Revenir à Skarhald",          labelFR="Skarhald", zoneFR="Ered Mithrin",
        map={{MapType.RHOVANION, 400, 90}},
        level=117
    })
    self.rep:AddSkill({
        id="0x70052F12",
        nameEN="Return to Beorninghús",           labelEN="Beorninghús",   zoneEN="Vales of Anduin",
        nameDE="Kehrt zum Beorningerhús zurück.", labelDE="Beorningerhús", zoneDE="Die Täler des Anduin",
        nameFR="Retournez auprès de Beorninghus", labelFR="Beorninghus",   zoneFR="Val d'Anduin",
        map={{MapType.RHOVANION, 360, 300}},
        level=120
    })
    self.rep:AddSkill({
        id="0x70052F04",
        nameEN="Return to Hultvís",           labelEN="Hultvís", zoneEN="Vales of Anduin",
        nameDE="Kehrt zum Hultvís zurück.",   labelDE="Hultvís", zoneDE="Die Täler des Anduin",
        nameFR="Retournez auprès de Hultvis", labelFR="Hultvis", zoneFR="Val d'Anduin",
        map={{MapType.RHOVANION, 345, 400}},
        level=120.1
    })
    self.rep:AddSkill({
        id="0x700551F8",
        nameEN="Return to Estolad Lân",   labelEN="Estolad Lân", zoneEN="Imlad Morgul",
        nameDE="Zurück nach Estolad Lân", labelDE="Estolad Lân", zoneDE="Imlad Morgul",
        nameFR="Retour à Estolad Lân",    labelFR="Estolad Lân", zoneFR="Imlad Morgul",
        map={{MapType.GONDOR, 930, 460}},
        level=125
    })
    self.rep:AddSkill({
        id="0x70057629",
        nameEN="Return to Limlók",     labelEN="Limlók", zoneEN="Wells of Langflood",
        nameDE="Rückkehr nach Limlók", labelDE="Limlók", zoneDE="Quellen des Langflut",
        nameFR="Retour à Limlok",      labelFR="Limlok", zoneFR="Puits du Long Fleuve",
        map={{MapType.RHOVANION, 315, 230}},
        level=130
    })
    self.rep:AddSkill({
        id="0x7005856F",
        nameEN="Return to Annâk-khurfu",     labelEN="Annâk-khurfu", zoneEN="Elderslade",
        nameDE="Rückkehr nach Annâk-khurfu", labelDE="Annâk-khurfu", zoneDE="Elderslade",
        nameFR="Retournez à Annâk-khurfu",   labelFR="Annâk-khurfu", zoneFR="Elderslade",
        map={{MapType.RHOVANION, 500, 90}},
        level=130.1
    })
    self.rep:AddSkill({
        id="0x7005AA90",
        nameEN="Return to Akrâz-zahar",     labelEN="Akrâz-zahar", zoneEN="Eryn Lasgalen",
        nameDE="Rückkehr nach Akrâz-zahar", labelDE="Akrâz-zahar", zoneDE="Eryn Lasgalen",
        nameFR="Retour à Akrâz-zahar",      labelFR="Akrâz-zahar", zoneFR="Eryn Lasgalen",
        map={{MapType.RHOVANION, 720, 115}},
        level=130.2
    })
    self.rep:AddSkill({
        id="0x7005AA92",
        nameEN="Return to Azanulbizar",      labelEN="Amdân", zoneEN="Azanulbizar",
        nameDE="Rückkehre nach Azanulbizar", labelDE="Amdân", zoneDE="Azanulbizar",
        nameFR="Retour à Azanulbizar",       labelFR="Amdân", zoneFR="Azanulbizar",
        map={{MapType.RHOVANION, 180, 555}},
        level=130.3
    })
    self.rep:AddSkill({
        id="0x7005D47C",
        nameEN="Return to the Noble Gate",   labelEN="Noble Gate",  zoneEN="Gundabad",
        nameDE="Rückkehr zum Prachttor",     labelDE="Prachttor",   zoneDE="Gundabad",
        nameFR="Retourner à la Porte Noble", labelFR="Porte Noble", zoneFR="Gundabad",
        map={{MapType.RHOVANION, 160, 130}},
        level=131
    })
    self.rep:AddSkill({
        id="0x7005D484",
        nameEN="Return to Leitstáth",     labelEN="Leitstáth", zoneEN="Gundabad",
        nameDE="Rückkehr nach Leitstáth", labelDE="Leitstáth", zoneDE="Gundabad",
        nameFR="Retourner à Leitstath",   labelFR="Leitstath", zoneFR="Gundabad",
        map={{MapType.RHOVANION, 240, 65}},
        level=135
    })
    self.rep:AddSkill({
        id="0x7005A596",
        nameEN="Journey to the Hall of Vérnozal",            labelEN="Vérnozal", zoneEN="Gundabad",
        nameDE="Reise zur Halle Vérnozal",                   labelDE="Vérnozal", zoneDE="Gundabad",
        nameFR="Voyage jusqu'à la Grande salle de Vérnozal", labelFR="Vérnozal", zoneFR="Gundabad",
        labelTagEN=" (Quest)", labelTagDE=" (Aufgabe)", labelTagFR=" (Quête)",
        map={{MapType.RHOVANION, 155, 45}},
        level=140
    })
    self.rep:AddSkill({
        id="0x70064ACA",
        nameEN="Return to Carn Dûm",     labelEN="Carn Dûm", zoneEN="Angmar",
        nameDE="Rückkehr nach Carn Dûm", labelDE="Carn Dûm", zoneDE="Angmar",
        nameFR="Retour à Carn Dûm",      labelFR="Carn Dûm", zoneFR="Angmar",
        map={{MapType.ERIADOR, 705, 100}},
        level=140.1
    })
    self.rep:AddSkill({
        id="0x700658EB",
        nameEN="Return to Pelargir",     labelEN="Pelargir", zoneEN="King's Gondor",
        nameDE="Rückkehr nach Pelargir", labelDE="Pelargir", zoneDE="Königreich Gondor",
        nameFR="Retournez à Pelargir",   labelFR="Pelargir", zoneFR="Gondor royal",
        map={{MapType.GONDOR, 640, 625}},
        level=141
    })
    self.rep:AddSkill({
        id="0x70068700",
        nameEN="Return to Dol Amroth",     descEN="King's Gondor",     labelEN="Dol Amroth", zoneEN="King's Gondor",
        nameDE="Rückkehr nach Dol Amroth", descDE="Königreich Gondor", labelDE="Dol Amroth", zoneDE="Königreich Gondor",
        nameFR="Retour à Dol Amroth",      descFR="le Gondor royal",   labelFR="Dol Amroth", zoneFR="Gondor royal",
        map={{MapType.GONDOR, 180, 485}, {MapType.HARADWAITH, 355, 70}},
        level=142
    })
    self.rep:AddSkill({
        id="0x70068703",
        nameEN="Return to Lond Cirion",         labelEN="Lond Cirion", zoneEN="Anfalas",
        nameDE="Nach Lond Cirion zurückkehren", labelDE="Lond Cirion", zoneDE="Anfalas",
        nameFR="Retour à Lond Cirion",          labelFR="Lond Cirion", zoneFR="Anfalas",
        map={{MapType.GONDOR, 225, 420}, {MapType.HARADWAITH, 200, 20}},
        level=143
    })
    self.rep:AddSkill({
        id="0x70068702",
        nameEN="Return to Halrax",        labelEN="Halrax", zoneEN="Shield Isles",
        nameDE="Kehrt zu Halrax zurück.", labelDE="Halrax", zoneDE="Die Schildinseln",
        nameFR="Retournez voir Halrax",   labelFR="Halrax", zoneFR="Les îles du Bouclier",
        map={{MapType.HARADWAITH, 245, 260}},
        level=145
    })
    self.rep:AddSkill({
        id="0x70068701",
        nameEN="Return to Jax Phanâl",         labelEN="Jax Phanâl", zoneEN="Umbar",
        nameDE="Nach Jax Phanâl zurückkehren", labelDE="Jax Phanâl", zoneDE="Umbar",
        nameFR="Retour à Jax Phanâl",          labelFR="Jax Phanâl", zoneFR="Umbar",
        map={{MapType.HARADWAITH, 335, 315}},
        level=146
    })
    self.rep:AddSkill({
        id="0x700686FF",
        nameEN="Return to Umbar",         labelEN="Umbar Baharbêl", zoneEN="Umbar",
        nameDE="Nach Umbar zurückkehren", labelDE="Umbar Baharbêl", zoneDE="Umbar",
        nameFR="Retour à Umbar",          labelFR="Umbar Baharbêl", zoneFR="Umbar",
        map={{MapType.HARADWAITH, 475, 370}},
        level=148
    })
    self.rep:AddSkill({
        id="0x700697F2",
        nameEN="Return to the Bloody Eagle Tavern",           labelEN="Bloody Eagle Tavern",         zoneEN="Umbar",
        nameDE="Rückkehr zur Taverne \"Zum Blutigen Adler\"", labelDE="Zum Blutigen Adler",          zoneDE="Umbar",
        nameFR="Retour à la taverne de l'Aigle Sanglant",     labelFR="Taverne de l'Aigle Sanglant", zoneFR="Umbar",
        map={{MapType.HARADWAITH, 445, 400}},
        level=149
    })
    self.rep:AddSkill({
        id="0x70068704",
        nameEN="Journey to the Ledger-keepers",        labelEN="Ledger-Keepers",      zoneEN="Umbar",
        nameDE="Zu den Buchhütern reisen",             labelDE="Ledger-Keepers",      zoneDE="Umbar",
        nameFR="Voyager vers les Gardiens des écrits", labelFR="Gardiens des écrits", zoneFR="Umbar",
        labelTagEN=" (Quest)", labelTagDE=" (Aufgabe)", labelTagFR=" (Quête)",
        map={{MapType.HARADWAITH, 415, 340}},
        level=150
    })
    self.rep:AddSkill({
        id="0x700686FE",
        nameEN="Journey to the Order of the Eagle", labelEN="Order of the Eagle", zoneEN="Umbar",
        nameDE="Zum Orden des Adlers reisen",       labelDE="Orden des Adlers",   zoneDE="Umbar",
        nameFR="Voyager vers l'Ordre de l'Aigle",   labelFR="L'Ordre de l'Aigle", zoneFR="Umbar",
        labelTagEN=" (Quest)", labelTagDE=" (Aufgabe)", labelTagFR=" (Quête)",
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
