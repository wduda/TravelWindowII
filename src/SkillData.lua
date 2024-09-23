---[[ travel skills ]] --
--[[ Add all the travel skills ]] --
-- add the data to custom dictionaries to maintain the order
function TravelDictionary:CreateDictionaries()
    -- add the hunter locations
    self.hunter:AddLabelTag({EN="Guide", DE="Führer", FR="Guide", RU="Путь" })
    self.hunter:AddSkill({
        id="0x7000A2C1",
        EN={ name="Return to Camp", },
        DE={ name="Zurück zum Lager", },
        FR={ name="Retour au campement", },
        RU={ name="Возвращение в лагерь", },
        map={{MapType.NONE, -1, -1}},
        level=1
    })
    self.hunter:AddSkill({
        id="0x7000A2C3",
        EN={ name="Guide to Michel Delving", label="Michel Delving", zone="Shire", },
        DE={ name="Führer nach Michelbinge", label="Michelbinge",    zone="Auenland", },
        FR={ name="Guide vers Grand'Cave",   label="Grand'Cave",     zone="Comté", },
        RU={ name="Путь в Занорье",          label="Занорье",        zone="Шир", },
        map={{MapType.ERIADOR, 360, 390}},
        overlap={"0x700062C8", "0x70023262"},
        level=1
    })
    self.hunter:AddSkill({
        id="0x70003F41",
        EN={ name="Guide to Thorin's Hall",         label="Thorin's Hall",    zone="Ered Luin", },
        DE={ name="Führer zu Thorins Halle",        label="Thorins Halle",    zone="Ered Luin", },
        FR={ name="Guide vers le Palais de Thorin", label="Palais de Thorin", zone="Ered Luin", },
        RU={ name="Путь в Чертоги Торина",          label="Чертоги Торина",   zone="Эред Луин", },
        map={{MapType.ERIADOR, 305, 270}},
        overlap={"0x70006346", "0x70053C0F", "0x7001BF91"},
        level=1.1
    })
    self.hunter:AddSkill({
        id="0x70003F42",
        EN={ name="Guide to Bree",    label="Bree", zlabel="West Gate",       zone="Bree", },
        DE={ name="Führer nach Bree", label="Bree", zlabel="Westtor",         zone="Bree", },
        FR={ name="Guide vers Bree",  label="Bree", zlabel="Porte Ouest",     zone="Bree", },
        RU={ name="Путь в Бри",       label="Бри",  zlabel="Западные ворота", zone="Бри", },
        map={{MapType.ERIADOR, 585, 335}},
        overlap={"0x700062F6", "0x7001BF90"},
        level=5
    })
    self.hunter:AddSkill({
        id="0x70064F4C",
        EN={ name="Guide to Clegur",    label="Clegur", zone="Swanfleet", },
        DE={ name="Führer nach Clegur", label="Clegur", zone="Schwanenfleet", },
        FR={ name="Guide vers Clegur",  label="Clegur", zone="Noues des cygnes", },
        RU={ name="Путь в Клегур",      label="Клегур", zone="Лебедянь", },
        map={{MapType.ERIADOR, 755, 555}},
        overlap={"0x70064F47"},
        level=7
    })
    self.hunter:AddSkill({
        id="0x700634AA",
        EN={ name="Guide to Swanfleet",              label="Swanfleet",        detail="Lhan Garan", zone="Swanfleet", },
        DE={ name="Führer nach Schwanenfleet",       label="Schwanenfleet",    detail="Lhan Garan", zone="Schwanenfleet", },
        FR={ name="Guide vers les Noues des cygnes", label="Noues des cygnes", detail="Lhan Garan", zone="Noues des cygnes", },
        RU={ name="Путь в Лебедянь",                 label="Лебедянь",         detail="Лхан-Гаран", zone="Лебедянь", },
        map={{MapType.ERIADOR, 825, 490}},
        overlap={"0x700634A4"},
        level=10
    })
    self.hunter:AddSkill({
        id="0x700634A7",
        EN={ name="Guide to Cardolan",      label="Cardolan", detail="Herne", zone="Cardolan", },
        DE={ name="Führer nach Cardolan",   label="Cardolan", detail="Herne", zone="Cardolan", },
        FR={ name="Guide vers le Cardolan", label="Cardolan", detail="Herne", zone="Cardolan", },
        RU={ name="Путь в Кардолан",        label="Кардолан", detail="Хэрне", zone="Кардолан", },
        map={{MapType.ERIADOR, 560, 495}},
        overlap={"0x700634AE"},
        level=15
    })
    self.hunter:AddSkill({
        id="0x7006323C",
        EN={ name="Guide to Andrath",    label="Andrath", zone="Cardolan", },
        DE={ name="Führer nach Andrath", label="Andrath", zone="Cardolan", },
        FR={ name="Guide vers Andrath",  label="Andrath", zone="Cardolan", },
        RU={ name="Путь в Андрат",       label="Андрат",  zone="Кардолан", },
        map={{MapType.ERIADOR, 580, 465}},
        overlap={"0x7006323D"},
        level=17
    })
    self.hunter:AddSkill({
        id="0x7006133F",
        EN={ name="Guide to Nobottle",      label="Nobottle",    zone="Yondershire", },
        DE={ name="Führer nach Neuhausen",  label="Neuhausen",   zone="Ferne Auen", },
        FR={ name="Guide vers Bourdeneuve", label="Bourdeneuve", zone="Comté lointain", },
        RU={ name="Путь в Новодворье",      label="Новодворье",  zone="Дальний Шир", },
        map={{MapType.ERIADOR, 440, 350}},
        overlap={"0x70061340"},
        level=20
    })
    self.hunter:AddSkill({
        id="0x7000A2C2",
        EN={ name="Guide to Ost Guruth",     label="Ost Guruth",   zone="Lone-lands", },
        DE={ name="Führer zur Feste Guruth", label="Feste Guruth", zone="Einsame Lande", },
        FR={ name="Guide vers Ost Guruth",   label="Ost Guruth",   zone="Terres Solitaires", },
        RU={ name="Путь в Ост Гурут",        label="Ост Гурут",    zone="Пустоши", },
        map={{MapType.ERIADOR, 755, 400}},
        overlap={"0x70020441"},
        level=25
    })
    self.hunter:AddSkill({
        id="0x70003F43",
        EN={ name="Guide to Esteldín",    label="Esteldín",  zone="North Downs", },
        DE={ name="Führer nach Esteldín", label="Esteldín",  zone="Nordhöhen", },
        FR={ name="Guide vers Esteldin",  label="Esteldin",  zone="Hauts du Nord", },
        RU={ name="Путь в Эстельдин",     label="Эстельдин", zone="Северное нагорье", },
        map={{MapType.ERIADOR, 655, 290}},
        level=30
    })
    self.hunter:AddSkill({
        id="0x7000A2C4",
        EN={ name="Guide to Evendim",    label="Evendim", detail="Tinnudir", zone="Evendim", },
        DE={ name="Führer nach Evendim", label="Evendim", detail="Tinnudir", zone="Evendim", },
        FR={ name="Guide vers Evendim",  label="Evendim", detail="Tinnudir", zone="Evendim", },
        RU={ name="Путь в Эвендим",      label="Эвендим", detail="Тиннудир", zone="Эвендим", },
        map={{MapType.ERIADOR, 490, 235}},
        level=35
    })
    self.hunter:AddSkill({
        id="0x70060EA6",
        EN={ name="Guide to Tornhad",    label="Tornhad", zone="Angle of Mitheithel", },
        DE={ name="Führer nach Tornhad", label="Tornhad", zone="Der Bogen von Mitheithel", },
        FR={ name="Guide vers Tornhad",  label="Tornhad", zone="L'Angle de Mitheithel", },
        RU={ name="Путь в Торнхад",      label="Торнхад", zone="Митейтельская стрелка", },
        map={{MapType.ERIADOR, 775, 435}},
        overlap={"0x70060EA8"},
        level=40
    })
    self.hunter:AddSkill({
        id="0x70003F44",
        EN={ name="Guide to Rivendell",   label="Rivendell", zone="Trollshaws", },
        DE={ name="Führer nach Bruchtal", label="Bruchtal",  zone="Die Trollhöhen", },
        FR={ name="Guide vers Fondcombe", label="Fondcombe", zone="Trouée des Trolls", },
        RU={ name="Путь в Ривенделл",     label="Ривенделл", zone="Троллистая пуща", },
        map={{MapType.ERIADOR, 865, 410}},
        overlap={"0x7000631F", "0x70023263"},
        level=40.1
    })
    self.hunter:AddSkill({
        id="0x7002E756",
        EN={ name="Guide to the Misty Mountains", label="Misty Mountains", detail="Hrimbarg", zone="Misty Mountains", },
        DE={ name="Führer ins Nebelgebirge",      label="Nebelgebirge",    detail="Hrimbarg", zone="Nebelgebirge", },
        FR={ name="Guide vers les Monts Brumeux", label="Monts Brumeux",   detail="Hrimbarg", zone="Monts Brumeux", },
        RU={ name="Путь в Мглистые горы",         label="Мглистые горы",   detail="Хримбарг", zone="Мглистые горы", },
        map={{MapType.ERIADOR, 915, 265}},
        level=40.2
    })
    self.hunter:AddSkill({
        id="0x70059D16",
        EN={ name="Guide to Trestlebridge",     label="Trestlebridge",   zone="North Downs", },
        DE={ name="Führer nach Schragen",       label="Schragen",        zone="Nordhöhen", },
        FR={ name="Guide vers Pont-à-Tréteaux", label="Pont-à-Tréteaux", zone="Hauts du Nord", },
        RU={ name="Путь в Примостье",           label="Примостье",       zone="Северное нагорье", },
        map={{MapType.ERIADOR, 590, 285}},
        overlap={"0x70059D12"},
        level=40.3
    })
    self.hunter:AddSkill({
        id="0x70059D0C",
        EN={ name="Guide to Trader's Wharf",          label="Trader's Wharf",     zone="Evendim", },
        DE={ name="Führer zum Händlerkai",            label="Händlerkai",         zone="Evendim", },
        FR={ name="Guide vers le Quai des marchands", label="Quai des marchands", zone="Evendim", },
        RU={ name="Путь к Торговой пристани",         label="Торговая пристань",  zone="Эвендим", },
        map={{MapType.ERIADOR, 515, 305}},
        overlap={"0x70059D0E"},
        level=40.4
    })
    self.hunter:AddSkill({
        id="0x70017C82",
        EN={ name="Guide to Sûri-kylä",    label="Sûri-kylä",  zone="Forochel", },
        DE={ name="Führer nach Sûri-kylä", label="Sûri-kylä",  zone="Forochel", },
        FR={ name="Guide vers Sûri-kylä",  label="Sûri-kylä",  zone="Forochel", },
        RU={ name="Путь в Сури-кила",       label="Сури-кила", zone="Форохель", },
        map={{MapType.ERIADOR, 430, 50}},
        level=42
    })
    self.hunter:AddSkill({
        id="0x7000A2C5",
        EN={ name="Guide to West Angmar",           label="West Angmar",     detail="Aughaire", zone="Angmar", },
        DE={ name="Führer in das westliche Angmar", label="West-Angmar",     detail="Aughaire", zone="Angmar", },
        FR={ name="Guide vers l'ouest d'Angmar",    label="Angmar ouest",    detail="Aughaire", zone="Angmar", },
        RU={ name="Путь в западный Ангмар",         label="Западный Ангмар", detail="Огайр",    zone="Ангмар", },
        map={{MapType.ERIADOR, 825, 185}},
        level=45
    })
    self.hunter:AddSkill({
        id="0x7000A2C6",
        EN={ name="Guide to East Angmar",       label="East Angmar",        detail="Gath Forthnír", zone="Angmar", },
        RU={ name="Путь в восточный Ангмар",    label="Восточный Ангмар",   detail="Гат Фортнир",   zone="Ангмар", },
        DE={ name="Führer nach Ost-Angmar",     label="East-Angmar",        detail="Gath Forthnír", zone="Angmar", },
        FR={ name="Guide vers l'est d'Angmar",  label="Angmar est",         detail="Gath Forthnír", zone="Angmar", },
        map={{MapType.ERIADOR, 705, 180}},
        level=49
    })
    self.hunter:AddSkill({
        id="0x70017C81",
        EN={ name="Guide to Echad Dúnann",      label="Echad Dúnann",   zone="Eregion", },
        RU={ name="Путь в Эхад Дунанн",         label="Эхад Дунанн",    zone="Эрегион", },
        DE={ name="Führer nach Echad Dúnann",   label="Echad Dúnann",   zone="Eregion", },
        FR={ name="Guide vers Echad Dunann",    label="Echad Dunann",   zone="Eregion", },
        map={{MapType.ERIADOR, 855, 535}},
        level=50
    })
    self.hunter:AddSkill({
        id="0x70017C7A",
        EN={ name="Guide to the Twenty-first Hall",         label="Twenty-first Hall",      zone="Moria", },
        RU={ name="Путь в Двадцать первый чертог",          label="Двадцать первый чертог", zone="Мория", },
        DE={ name="Führer zur Einundzwanzigsten Halle",     label="Einundzwanzigste Halle", zone="Moria", },
        FR={ name="Guide vers la vingt et unième salle",    label="Vingt et unième salle",  zone="Moria", },
        map={{MapType.RHOVANION, 95, 585}, {MapType.ERIADOR, 950, 510}},
        level=55
    })
    self.hunter:AddSkill({
        id="0x7002E754",
        EN={ name="Guide to Caras Galadhon",    label="Caras Galadhon", zone="Lothlórien", },
        RU={ name="Путь в Карас Галадон",       label="Карас Галадон",  zone="Лотлориэн", },
        DE={ name="Führer nach Caras Galadhon", label="Caras Galadhon", zone="Lothlórien", },
        FR={ name="Guide vers Caras Galadhon",  label="Caras Galadhon", zone="Lothlórien", },
        map={{MapType.RHOVANION, 120, 660}},
        overlap={"0x70048C8C"},
        level=60
    })
    self.hunter:AddSkill({
        id="0x7001F459",
        EN={ name="Guide to Mirk-eaves",        label="Mirk-eaves",     zone="Mirkwood", },
        RU={ name="Путь в Черную рощу",         label="Черная роща",    zone="Лихолесье", },
        DE={ name="Führer zur Dunkelsenke",     label="Dunkelsenke",    zone="Düsterwald", },
        FR={ name="Guide vers l'Orée noire",    label="Orée noire",     zone="Forêt Noire", },
        map={{MapType.RHOVANION, 365, 630}},
        level=61
    })
    self.hunter:AddSkill({
        id="0x700235EF",
        EN={ name="Guide to Harndirion",    label="Harndirion", zone="Enedwaith", },
        RU={ name="Путь в Харндирион",      label="Харндирион", zone="Энедвайт", },
        DE={ name="Führer nach Harndirion", label="Harndirion", zone="Enedwaith", },
        FR={ name="Guide vers Harndirion",  label="Harndirion", zone="Enedwaith", },
        map={{MapType.ERIADOR, 815, 635}},
        level=62
    })
    self.hunter:AddSkill({
        id="0x7002A93F",
        EN={ name="Guide to Galtrev",       label="Galtrev",    zone="Dunland", },
        RU={ name="Путь в Галтрев",         label="Галтрев",    zone="Дунланд", },
        DE={ name="Führer nach Galtrev",    label="Galtrev",    zone="Dunland", },
        FR={ name="Guide pour Galtrev",     label="Galtrev",    zone="Pays de Dun", },
        map={{MapType.ERIADOR, 810, 715}},
        overlap={"0x7002C647"},
        level=65
    })
    self.hunter:AddSkill({
        id="0x7002C62C",
        EN={ name="Guide to Stangard",      label="Stangard",   zone="Great River", },
        RU={ name="Путь в Стангард",        label="Стангард",   zone="Великая река", },
        DE={ name="Führer nach Stangard",   label="Stangard",   zone="Großer Fluss", },
        FR={ name="Guide vers Stangarde",   label="Stangarde",  zone="Grand Fleuve", },
        map={{MapType.RHOVANION, 200, 720}, {MapType.ROHAN, 545, 90}},
        overlap={"0x7002C65D"},
        level=75
    })
    self.hunter:AddSkill({
        id="0x7003198E",
        EN={ name="Guide to Snowbourn",         label="Snowbourn",      zone="East Rohan", },
        RU={ name="Путь в Сноуборн",            label="Сноуборн",       zone="Восточный Рохан", },
        DE={ name="Führer nach Schneegrenze",   label="Schneegrenze",   zone="Ost-Rohan", },
        FR={ name="Guide vers Neigebronne",     label="Neigebronne",    zone="Rohan est", },
        map={{MapType.ROHAN, 515, 500}},
        overlap={"0x70031A46"},
        level=80
    })
    self.hunter:AddSkill({
        id="0x70036B5D",
        EN={ name="Guide to Forlaw",        label="Forlaw",     zone="Wildermore", },
        RU={ name="Путь в Форлоу",          label="Форлоу",     zone="Вилдермор", },
        DE={ name="Führer nach Forlach",    label="Forlach",    zone="Wildermark", },
        FR={ name="Guide vers Forloi",      label="Forloi",     zone="Landes farouches", },
        map={{MapType.ROHAN, 450, 175}},
        overlap={"0x70036B5E"},
        level=85
    })
    self.hunter:AddSkill({
        id="0x7003DC71",
        EN={ name="Guide to Aldburg",       label="Aldburg",    zone="West Rohan", },
        RU={ name="Путь в Альдбург",        label="Альдбург",   zone="Западный Рохан", },
        DE={ name="Führer nach Aldburg",    label="Aldburg",    zone="West-Rohan", },
        FR={ name="Guide vers Aldburg",     label="Aldburg",    zone="Rohan de l'Ouest", },
        map={{MapType.ROHAN, 570, 640}},
        overlap={"0x7003DC81"},
        level=88
    })
    self.hunter:AddSkill({
        id="0x7003DC72",
        EN={ name="Guide to Helm's Deep",           label="Helm's Deep",        zone="West Rohan", },
        RU={ name="Путь в Хельмову Падь",           label="Хельмова Падь",      zone="Западный Рохан", },
        DE={ name="Führer nach Helms Klamm",        label="Helms Klamm",        zone="West-Rohan", },
        FR={ name="Guide vers le Gouffre de Helm",  label="Gouffre de Helm",    zone="Rohan de l'Ouest", },
        map={{MapType.ROHAN, 275, 565}},
        overlap={"0x7003DC82"},
        level=90
    })
    self.hunter:AddSkill({
        id="0x70041197",
        EN={ name="Guide to Dol Amroth",    desc="in western Gondor",   label="Dol Amroth", zone="Western Gondor", },
        RU={ name="Путь в Дол Амрот",       desc="в Западном Гондоре",  label="Дол Амрот",  zone="Западный Гондор", },
        DE={ name="Führer nach Dol Amroth", desc="nach Dol Amroth.",    label="Dol Amroth", zone="West-Gondor", },
        FR={ name="Guide vers Dol Amroth",  desc="l'Ouest du Gondor",   label="Dol Amroth", zone="Gondor de l'Ouest", },
        map={{MapType.GONDOR, 225, 550}},
        overlap={"0x700411AC"},
        level=98
    })
    self.hunter:AddSkill({
        id="0x70043A63",
        EN={ name="Guide to Arnach",    label="Arnach", zone="Eastern Gondor", },
        RU={ name="Путь в Арнах",       label="Арнах",  zone="Восточный Гондор", },
        DE={ name="Führer nach Arnach", label="Arnach", zone="Ost-Gondor", },
        FR={ name="Guide pour Arnach",  label="Arnach", zone="Gondor de l'Ouest", },
        map={{MapType.GONDOR, 715, 425}},
        overlap={"0x70043A6A"},
        level=100
    })
    self.hunter:AddSkill({
        id="0x70044985",
        EN={ name="Guide to Minas Tirith",      label="Minas Tirith", zone="Old Anórien", },
        RU={ name="Путь в Минас Тирит",         label="Минас Тирит",  zone="Старый Анориен", },
        DE={ name="Führer nach Minas Tirith",   label="Minas Tirith", zone="Alt-Anórien", },
        FR={ name="Guide vers Minas Tirith",    label="Minas Tirith", zone="Ancien Anórien", },
        map={{MapType.GONDOR, 670, 345}},
        overlap={"0x7004497E"},
        level=100.1
    })
    self.hunter:AddSkill({
        id="0x700459AF",
        EN={ name="Guide to the War-stead",                 label="War-stead",                  zone="Far Anórien", },
        RU={ name="Путь в военный лагерь Рохиррим",         label="Лагерь Рохиррим",            zone="Дальний Анориен", },
        DE={ name="Führer zum Kriegslager der Rohirrim",    label="Kriegslager der Rohirrim",   zone="Fernes Anórien", },
        FR={ name="Guide pour se rendre au camp militaire", label="Camp militaire",             zone="Lointain Anórien", },
        map={{MapType.GONDOR, 665, 140}},
        overlap={"0x700459A9"},
        level=102
    })
    self.hunter:AddSkill({
        id="0x70046CBB",
        EN={ name="Guide to after-battle Minas Tirith",             label="Minas Tirith after battle",      zone="Anórien", },
        RU={ name="Путь в Минас Тирит (после битвы)",               label="Минас Тирит (после битвы)",      zone="Анориен", },
        DE={ name="Führer zum schlachtgezeichneten Minas Tirith",   label="Minas Tirith nach der Schlacht", zone="Anórien", },
        FR={ name="Guide de Minas Tirith après la bataille",        label="Minas Tirith après la bataille", zone="Anórien", },
        map={{MapType.GONDOR, 670, 375}},
        overlap={"0x70046CC0"},
        level=105
    })
    self.hunter:AddSkill({
        id="0x70047074",
        EN={ name="Guide to after-battle Osgiliath",            label="Osgiliath after-battle",         zone="Anórien", },
        RU={ name="Путь в Осгилиат (после битвы)",              label="Осгилиат (после битвы)",         zone="Анориен", },
        DE={ name="Führer zum schlachtgezeichneten Osgiliath",  label="Osgiliath nach der Schlacht",    zone="Anórien", },
        FR={ name="Guide vers Osgiliath après la bataille",     label="Osgiliath après la bataille",    zone="Anórien", },
        map={{MapType.GONDOR, 855, 335}},
        overlap={"0x7004707D"},
        level=105.1
    })
    self.hunter:AddSkill({
        id="0x70047077",
        EN={ name="Guide to Henneth Annûn",   label="Henneth Annûn", zone="Ithilien", },
        DE={ name="Führer zu Henneth Annûn",  label="Henneth Annûn", zone="Ithilien", },
        FR={ name="Guide vers Henneth Annûn", label="Henneth Annûn", zone="Ithilien", },
        RU={ name="Путь в Хеннет Аннун",      label="Хеннет Аннун",  zone="Итилиен", },
        map={{MapType.GONDOR, 875, 385}},
        overlap={"0x70047080"},
        level=105.2
    })
    self.hunter:AddSkill({
        id="0x70047BFA",
        EN={ name="Guide to the Camp of the Host", label="Camp of the Host",       zone="The Wastes", },
        DE={ name="Führer zum Lager des Heeres",   label="Lager des Heeres",       zone="Das Ödland", },
        FR={ name="Guide vers le Camp de l'armée", label="Camp de l'armée",        zone="Les Landes désertiques", },
        RU={ name="Путь в лагерь Воинства Запада", label="Лагерь Воинства Запада", zone="Гиблые земли", },
        map={{MapType.GONDOR, 805, 170}},
        overlap={"0x70047BF4"},
        level=105.3
    })
    self.hunter:AddSkill({
        id="0x70047C1D",
        EN={ name="Guide to Haerondir",    label="Haerondir", zone="The Wastes", },
        DE={ name="Führer nach Haerondir", label="Haerondir", zone="Das Ödland", },
        FR={ name="Guide vers Haerondir",  label="Haerondir", zone="Les Landes désertiques", },
        RU={ name="Путь в Хаэрондир",      label="Хаэрондир", zone="Гиблые земли", },
        map={{MapType.GONDOR, 855, 100}},
        overlap={"0x70047C1B"},
        level=105.4
    })
    self.hunter:AddSkill({
        id="0x7004AE1E",
        EN={ name="Guide to the Udûn Foothold",  label="Udûn Foothold",    zone="Mordor", },
        DE={ name="Führer zum Udûn-Brückenkopf", label="Udûn-Brückenkopf", zone="Mordor", },
        FR={ name="Guide vers le fort d'Udûn",   label="Fort d'Udûn",      zone="Mordor", },
        RU={ name="Путь на заставу Удуна",       label="Застава Удуна",    zone="Мордор", },
        map={{MapType.GONDOR, 925, 230}},
        overlap={"0x7004AE1D"},
        level=106
    })
    self.hunter:AddSkill({
        id="0x7004D73B",
        EN={ name="Guide to Dale",    label="Dale", zone="Eryn Lasgalen", },
        DE={ name="Führer nach Thal", label="Thal", zone="Eryn Lasgalen", },
        FR={ name="Guide vers Dale",  label="Dale", zone="Eryn Lasgalen", },
        RU={ name="Путь в Дейл",      label="Дейл", zone="Эрин Ласгален", },
        map={{MapType.RHOVANION, 720, 215}},
        overlap={"0x7004D738"},
        level=115
    })
    self.hunter:AddSkill({
        id="0x7004FACC",
        EN={ name="Guide to Járnfast",    label="Járnfast", zone="The Ironfold", },
        DE={ name="Führer nach Járnfast", label="Járnfast", zone="Der Eisenbruch", },
        FR={ name="Guide vers Jarnfast",  label="Jarnfast", zone="La Crevasse de Fer", },
        RU={ name="Путь в Ярнфаст",       label="Ярнфаст",  zone="Железное взгорье", },
        map={{MapType.RHOVANION, 890, 110}},
        overlap={"0x7004FAC3"},
        level=116
    })
    self.hunter:AddSkill({
        id="0x7004FACB",
        EN={ name="Guide to Skarháld",    label="Skarháld",  zone="Ered Mithrin", },
        DE={ name="Führer nach Skarháld", label="Skarháld",  zone="Ered Mithrin", },
        FR={ name="Guide vers Skarhald",  label="Skarhald",  zone="Ered Mithrin", },
        RU={ name="Путь в Скархальд",     label="Скархальд", zone="Эред Митрин", },
        map={{MapType.RHOVANION, 430, 90}},
        overlap={"0x7004FAC5"},
        level=117
    })
    self.hunter:AddSkill({
        id="0x70052F07",
        EN={ name="Guide to Beorninghús",      label="Beorninghús",   zone="Vales of Anduin", },
        DE={ name="Führer nach Beorningerhús", label="Beorningerhús", zone="Die Täler des Anduin", },
        FR={ name="Guide pour Beorninghus",    label="Beorninghus",   zone="Val d'Anduin", },
        RU={ name="Путь в Беорнингус",         label="Беорнингус",    zone="Долина Андуина", },
        map={{MapType.RHOVANION, 390, 300}},
        overlap={"0x70041A22", "0x70052F12"},
        level=120
    })
    self.hunter:AddSkill({
        id="0x70052F08",
        EN={ name="Guide to Hultvís",      label="Hultvís",  zone="Vales of Anduin", },
        DE={ name="Leitfaden für Hultvís", label="Hultvís",  zone="Die Täler des Anduin", },
        FR={ name="Guide de Hultvis",      label="Hultvis",  zone="Val d'Anduin", },
        RU={ name="Путь в Хультвис",       label="Хультвис", zone="Долина Андуина", },
        map={{MapType.RHOVANION, 375, 400}},
        overlap={"0x70052F04"},
        level=120.1
    })
    self.hunter:AddSkill({
        id="0x700551F4",
        EN={ name="Guide to Estolad Lân",    label="Estolad Lân", zone="Imlad Morgul", },
        DE={ name="Führer nach Estolad Lân", label="Estolad Lân", zone="Imlad Morgul", },
        FR={ name="Guide vers Estolad Lân",  label="Estolad Lân", zone="Imlad Morgul", },
        RU={ name="Путь в Эстолад Лан",      label="Эстолад Лан", zone="Имлад Моргул", },
        map={{MapType.GONDOR, 960, 460}},
        overlap={"0x700551F8"},
        level=125
    })
    self.hunter:AddSkill({
        id="0x7005762D",
        EN={ name="Guide to Limlók",    label="Limlók", zone="Wells of Langflood", },
        DE={ name="Führer nach Limlók", label="Limlók", zone="Quellen des Langflut", },
        FR={ name="Guide de Limlok",    label="Limlok", zone="Puits du Long Fleuve", },
        RU={ name="Путь в Лимлок",      label="Лимлок", zone="Истоки Долгой реки", },
        map={{MapType.RHOVANION, 345, 230}},
        overlap={"0x70057629"},
        level=130
    })
    self.hunter:AddSkill({
        id="0x70058571",
        EN={ name="Guide to Annâk-khurfu",      label="Annâk-khurfu",   zone="Elderslade", },
        RU={ name="Путь в Аннак-Курфу",         label="Аннак-Курфу",    zone="Долина предков", },
        DE={ name="Führer nach Annâk-khurfu",   label="Annâk-khurfu",   zone="Elderslade", },
        FR={ name="Guide vers Annâk-khurfu",    label="Annâk-khurfu",   zone="Elderslade", },
        map={{MapType.RHOVANION, 530, 90}},
        overlap={"0x7005856F"},
        level=130.1
    })
    self.hunter:AddSkill({
        id="0x7005AA91",
        EN={ name="Guide to Akrâz-zahar",       label="Akrâz-zahar",    zone="Eryn Lasgalen", },
        RU={ name="Путь в Акраз-Захар",         label="Акраз-Захар",    zone="Эрин Ласгален", },
        DE={ name="Führer nach Akrâz-zahar",    label="Akrâz-zahar",    zone="Eryn Lasgalen", },
        FR={ name="Guide vers Akrâz-zahar",     label="Akrâz-zahar",    zone="Eryn Lasgalen", },
        map={{MapType.RHOVANION, 750, 115}},
        overlap={"0x7005AA90"},
        level=130.2
    })
    self.hunter:AddSkill({
        id="0x7005AA95",
        EN={ name="Guide to Azanulbizar",       label="Azanulbizar",    detail="Amdân", zone="Azanulbizar", },
        RU={ name="Путь в Азанулбизар",         label="Азанулбизар",    detail="Амдан", zone="Азанулбизар", },
        DE={ name="Führer nach Azanulbizar",    label="Azanulbizar",    detail="Amdân", zone="Azanulbizar", },
        FR={ name="Guide vers Azanulbizar",     label="Azanulbizar",    detail="Amdân", zone="Azanulbizar", },
        map={{MapType.RHOVANION, 210, 555}},
        overlap={"0x7005AA92"},
        level=130.3
    })
    self.hunter:AddSkill({
        id="0x7005D487",
        EN={ name="Guide to the Noble Gate",    label="Noble Gate",         zone="Gundabad", },
        RU={ name="Путь к Благородным вратам",  label="Благородные врата",  zone="Гундабад", },
        DE={ name="Führer zum Prachttor",       label="Prachttor",          zone="Gundabad", },
        FR={ name="Guide vers la Porte Noble",  label="Porte Noble",        zone="Gundabad", },
        map={{MapType.RHOVANION, 190, 130}},
        overlap={"0x7005D47C"},
        level=131
    })
    self.hunter:AddSkill({
        id="0x7005D47D",
        EN={ name="Guide to Leitstáth",     label="Leitstáth",  zone="Gundabad", },
        RU={ name="Путь в Лейтстат",        label="Лейтстат",   zone="Гундабад", },
        DE={ name="Führer nach Leitstáth",  label="Leitstáth",  zone="Gundabad", },
        FR={ name="Guide vers Leitstath",   label="Leitstath",  zone="Gundabad", },
        map={{MapType.RHOVANION, 270, 65}},
        overlap={"0x7005D484"},
        level=135
    })
    self.hunter:AddSkill({
        id="0x70064AC8",
        EN={ name="Guide to Carn Dûm",      label="Carn Dûm",   zone="Angmar", },
        RU={ name="Путь в Карн-Дум",        label="Карн-Дум",   zone="Ангмар", },
        DE={ name="Führer nach Carn Dûm",   label="Carn Dûm",   zone="Angmar", },
        FR={ name="Guide vers Carn Dûm",    label="Carn Dûm",   zone="Angmar", },
        map={{MapType.ERIADOR, 735, 100}},
        overlap={"0x70064ACA"},
        level=140.1
    })
    self.hunter:AddSkill({
        id="0x700658EA",
        EN={ name="Guide to Pelargir",      label="Pelargir",   zone="King's Gondor", },
        RU={ name="Путь в Пеларгир",        label="Пеларгир",   zone="Королевский Гондор", },
        DE={ name="Führer nach Pelargir",   label="Pelargir",   zone="Königreich Gondor", },
        FR={ name="Guide vers Pelargir",    label="Pelargir",   zone="Gondor royal", },
        map={{MapType.GONDOR, 670, 625}},
        overlap={"0x700658EB"},
        level=141
    })
    self.hunter:AddSkill({
        id="0x70068711",
        EN={ name="Guide to Dol Amroth",    desc="King's Gondor",       label="King's Dol Amroth",      zlabel="Dol Amroth",    zone="King's Gondor", },
        RU={ name="Путь в Дол Амрот",       desc="Королевский Гондор",  label="Королевский Дол Амрот",  zlabel="Дол Амрот",     zone="Королевский Гондор", },
        DE={ name="Führer nach Dol Amroth", desc="Königreich Gondor",   label="Königreich Dol Amroth",  zlabel="Dol Amroth",    zone="Königreich Gondor", },
        FR={ name="Guide vers Dol Amroth",  desc="le Gondor royal",     label="Dol Amroth royal",       zlabel="Dol Amroth",    zone="Gondor royal", },
        map={{MapType.GONDOR, 210, 485}, {MapType.HARADWAITH, 210, 485}},
        overlap={"0x70068700"},
        level=142
    })
    self.hunter:AddSkill({
        id="0x70068717",
        EN={ name="Guide to Lond Cirion",       label="Lond Cirion",    zone="Anfalas", },
        RU={ name="Путь в Лонд-Кирион",         label="Лонд-Кирион",    zone="Анфалас", },
        DE={ name="Führer nach Lond Cirion",    label="Lond Cirion",    zone="Anfalas", },
        FR={ name="Guide vers Lond Cirion",     label="Lond Cirion",    zone="Anfalas", },
        map={{MapType.GONDOR, 255, 420}, {MapType.HARADWAITH, 230, 20}},
        overlap={"0x70068703"},
        level=143
    })
    self.hunter:AddSkill({
        id="0x70068713",
        EN={ name="Guide to Halrax",    label="Halrax",     zone="Shield Isles", },
        RU={ name="Путь в Халракс",     label="Халракс",    zone="Острова Щита", },
        DE={ name="Führer nach Halrax", label="Halrax",     zone="Die Schildinseln", },
        FR={ name="Guide vers Halrax",  label="Halrax",     zone="Les îles du Bouclier", },
        map={{MapType.HARADWAITH, 275, 160}},
        overlap={"0x70068702"},
        level=145
    })
    self.hunter:AddSkill({
        id="0x70068719",
        EN={ name="Guide to Jax Phanâl",    label="Jax Phanâl",     zone="Umbar", },
        RU={ name="Путь в Джакс-Фанал",     label="Джакс-Фанал",    zone="Умбар", },
        DE={ name="Führer nach Jax Phanâl", label="Jax Phanâl",     zone="Umbar", },
        FR={ name="Guide vers Jax Phanâl",  label="Jax Phanâl",     zone="Umbar", },
        map={{MapType.HARADWAITH, 305, 315}},
        overlap={"0x70068701"},
        level=146
    })
    self.hunter:AddSkill({
        id="0x7006A9BF",
        EN={ name="Guide to Bej Mâghda",    label="Bej Mâghda", zone="Umbar", },
        DE={ name="Führer nach Bej Mâghda", label="Bej Mâghda", zone="Umbar", },
        FR={ name="Guide vers Bej Mâghda",  label="Bej Mâghda", zone="Umbar", },
        RU={ name="Путь в Бедж-Магда",      label="Бедж-Магда", zone="Умбар", },
        map={{MapType.HARADWAITH, 350, 380}},
        overlap={"0x7006A9C1"},
        level=147
    })
    self.hunter:AddSkill({
        id="0x70068718",
        EN={ name="Guide to Umbar",     label="Umbar",  detail="Baharbêl",  zone="Umbar", },
        RU={ name="Путь в Умбар",       label="Умбар",  detail="Бахарбель", zone="Умбар", },
        DE={ name="Führer nach Umbar",  label="Umbar",  detail="Baharbêl",  zone="Umbar", },
        FR={ name="Guide vers Umbar",   label="Umbar",  detail="Baharbêl",  zone="Umbar", },
        map={{MapType.HARADWAITH, 505, 370}},
        overlap={"0x700686FF"},
        level=148
    })
    self.hunter:AddSkill({
        id="0x700697EF",
        EN={ name="Guide to the Bloody Eagle Tavern",           label="Bloody Eagle Tavern",            zone="Umbar", },
        RU={ name="Путь в таверну \'Кровавый орёл\'",           label="Таверна Кровавый Орёл",          zone="Умбар", },
        DE={ name="Führer zur Taverne \"Zum Blutigen Adler\"",  label="Zum Blutigen Adler",             zone="Umbar", },
        FR={ name="Guide vers la taverne de l'Aigle sanglant",  label="Taverne de l'Aigle sanglant",    zone="Umbar", },
        map={{MapType.HARADWAITH, 475, 400}},
        overlap={"0x700697F2"},
        level=149
    })

    -- add the Warden locations
    self.warden:AddLabelTag({EN="Muster", DE="Appell", FR="Rassemblement" })
    self.warden:AddSkill({
        id="0x70064F4D",
        EN={ name="Muster at Clegur",       label="Clegur", zone="Swanfleet", },
        DE={ name="Appell in Clegur",       label="Clegur", zone="Schwanenfleet", },
        FR={ name="Rassemblement à Clegur", label="Clegur", zone="Noues des cygnes", },
        map={{MapType.ERIADOR, 755, 555}},
        overlap={"0x70064F47"},
        level=7
    })
    self.warden:AddSkill({
        id="0x700634B6",
        EN={ name="Muster at Swanfleet",                label="Swanfleet",        detail="Lhan Garan", zone="Swanfleet", },
        DE={ name="Appell in Schwanenfleet",            label="Schwanenfleet",    detail="Lhan Garan", zone="Schwanenfleet", },
        FR={ name="Rassemblement aux Noues des cygnes", label="Noues des cygnes", detail="Lhan Garan", zone="Noues des cygnes", },
        map={{MapType.ERIADOR, 825, 490}},
        overlap={"0x700634A4"},
        level=10
    })
    self.warden:AddSkill({
        id="0x700634AD",
        EN={ name="Muster at Cardolan",        label="Cardolan", detail="Herne", zone="Cardolan", },
        DE={ name="Appell in Cardolan",        label="Cardolan", detail="Herne", zone="Cardolan", },
        FR={ name="Rassemblement au Cardolan", label="Cardolan", detail="Herne", zone="Cardolan", },
        map={{MapType.ERIADOR, 560, 495}},
        overlap={"0x700634AE"},
        level=15
    })
    self.warden:AddSkill({
        id="0x70063242",
        EN={ name="Muster at Andrath",       label="Andrath", zone="Cardolan", },
        DE={ name="Appell in Andrath",       label="Andrath", zone="Cardolan", },
        FR={ name="Rassemblement à Andrath", label="Andrath", zone="Cardolan", },
        map={{MapType.ERIADOR, 580, 465}},
        overlap={"0x7006323D"},
        level=17
    })
    self.warden:AddSkill({
        id="0x7006133E",
        EN={ name="Muster at Nobottle",          label="Nobottle",    zone="Yondershire", },
        DE={ name="Appell in Neuhausen",         label="Neuhausen",   zone="Ferne Auen", },
        FR={ name="Rassemblement à Bourdeneuve", label="Bourdeneuve", zone="Comté lointain", },
        map={{MapType.ERIADOR, 440, 350}},
        overlap={"0x70061340"},
        level=20
    })
    self.warden:AddSkill({
        id="0x70014786",
        EN={ name="Muster in Ost Guruth",       label="Ost Guruth",   zone="Lone-lands", },
        DE={ name="Appell in der Feste Guruth", label="Feste Guruth", zone="Einsame Lande", },
        FR={ name="Rassemblement : Ost Guruth", label="Ost Guruth",   zone="Terres Solitaires", },
        map={{MapType.ERIADOR, 755, 400}},
        overlap={"0x70020441"},
        level=25
    })
    self.warden:AddSkill({
        id="0x70014798",
        EN={ name="Muster in Esteldín",       label="Esteldín", zone="North Downs", },
        DE={ name="Appell in Esteldín",       label="Esteldín", zone="Nordhöhen", },
        FR={ name="Rassemblement : Esteldin", label="Esteldin", zone="Hauts du Nord", },
        map={{MapType.ERIADOR, 655, 290}},
        level=30
    })
    self.warden:AddSkill({
        id="0x7001478E",
        EN={ name="Muster in Evendim",                   label="Evendim", detail="Tinnudir", zone="Evendim", },
        DE={ name="Appell in Evendim",                   label="Evendim", detail="Tinnudir", zone="Evendim", },
        FR={ name="Rassemblement : La région d'Evendim", label="Evendim", detail="Tinnudir", zone="Evendim", },
        map={{MapType.ERIADOR, 490, 235}},
        level=35
    })
    self.warden:AddSkill({
        id="0x70060EA5",
        EN={ name="Muster at Tornhad", label="Tornhad", zone="Angle of Mitheithel", },
        DE={ name="Appell in Tornhad", label="Tornhad", zone="Der Bogen von Mitheithel", },
        FR={ name="Retour à Tornhad",  label="Tornhad", zone="L'Angle de Mitheithel", },
        map={{MapType.ERIADOR, 775, 435}},
        overlap={"0x70060EA8"},
        level=40
    })
    self.warden:AddSkill({
        id="0x70014791",
        EN={ name="Muster in Rivendell",       label="Rivendell", zone="Trollshaws", },
        DE={ name="Appell in Bruchtal",        label="Bruchtal",  zone="Die Trollhöhen", },
        FR={ name="Rassemblement : Fondcombe", label="Fondcombe", zone="Trouée des Trolls", },
        map={{MapType.ERIADOR, 865, 410}},
        overlap={"0x7000631F", "0x70023263"},
        level=40.1
    })
    self.warden:AddSkill({
        id="0x700303DD",
        EN={ name="Muster in the Misty Mountains",     label="Misty Mountains", detail="Hrimbarg", zone="Misty Mountains", },
        DE={ name="Appell im Nebelgebirge",            label="Nebelgebirge",    detail="Hrimbarg", zone="Nebelgebirge", },
        FR={ name="Rassemblement : Les Monts Brumeux", label="Monts Brumeux",   detail="Hrimbarg", zone="Monts Brumeux", },
        map={{MapType.ERIADOR, 915, 265}},
        level=40.2
    })
    self.warden:AddSkill({
        id="0x70059D10",
        EN={ name="Muster in Trestlebridge",         label="Trestlebridge",   zone="North Downs", },
        DE={ name="Appell in Schragen",              label="Schragen",        zone="Nordhöhen", },
        FR={ name="Rassemblement : Pont-à-Tréteaux", label="Pont-à-Tréteaux", zone="Hauts du Nord", },
        map={{MapType.ERIADOR, 590, 285}},
        overlap={"0x70059D12"},
        level=40.3
    })
    self.warden:AddSkill({
        id="0x70059D09",
        EN={ name="Muster in Trader's Wharf",           label="Trader's Wharf",     zone="Evendim", },
        DE={ name="Appell am Händlerkai",               label="Händlerkai",         zone="Evendim", },
        FR={ name="Rassemblement : Quai des marchands", label="Quai des marchands", zone="Evendim", },
        map={{MapType.ERIADOR, 515, 305}},
        overlap={"0x70059D0E"},
        level=40.4
    })
    self.warden:AddSkill({
        id="0x700237D4",
        EN={ name="Muster in Sûri-kylä",       label="Sûri-kylä", zone="Forochel", },
        DE={ name="Appell in Sûri-kylä",       label="Sûri-kylä", zone="Forochel", },
        FR={ name="Rassemblement : Sûri-kylä", label="Sûri-kylä", zone="Forochel", },
        map={{MapType.ERIADOR, 430, 50}},
        level=42
    })
    self.warden:AddSkill({
        id="0x7001819E",
        EN={ name="Muster in the Twenty-first Hall",          label="Twenty-first Hall",     zone="Moria", },
        DE={ name="Appell in der Einundzwanzigsten Halle",    label="21. Halle",             zone="Moria", },
        FR={ name="Rassemblement : La vingt et unième salle", label="Vingt et unième salle", zone="Moria", },
        map={{MapType.RHOVANION, 95, 585}, {MapType.ERIADOR, 950, 510}},
        level=55
    })
    self.warden:AddSkill({
        id="0x700303DF",
        EN={ name="Muster in Caras Galadhon",       label="Caras Galadhon", zone="Lothlórien", },
        DE={ name="Appell in Caras Galadhon",       label="Caras Galadhon", zone="Lothlórien", },
        FR={ name="Rassemblement : Caras Galadhon", label="Caras Galadhon", zone="Lothlórien", },
        map={{MapType.RHOVANION, 120, 660}},
        overlap={"0x70048C8C"},
        level=60
    })
    self.warden:AddSkill({
        id="0x7001F45C",
        EN={ name="Muster in Mirk-eaves",         label="Mirk-Eaves",  zone="Mirkwood", },
        DE={ name="Appell in der Dunkelsenke",    label="Dunkelsenke", zone="Düsterwald", },
        FR={ name="Rassemblement : L'Orée noire", label="Orée noire",  zone="Forêt Noire", },
        map={{MapType.RHOVANION, 365, 630}},
        level=61
    })
    self.warden:AddSkill({
        id="0x700235EB",
        EN={ name="Muster in Harndirion",       label="Harndirion", zone="Enedwaith", },
        DE={ name="Appell in Harndirion",       label="Harndirion", zone="Enedwaith", },
        FR={ name="Rassemblement : Harndirion", label="Harndirion", zone="Enedwaith", },
        map={{MapType.ERIADOR, 815, 635}},
        level=62
    })
    self.warden:AddSkill({
        id="0x7002A90A",
        EN={ name="Muster in Galtrev",       label="Galtrev", zone="Dunland", },
        DE={ name="Appell in Galtrev",       label="Galtrev", zone="Dunland", },
        FR={ name="Rassemblement : Galtrev", label="Galtrev", zone="Pays de Dun", },
        map={{MapType.ERIADOR, 810, 715}},
        overlap={"0x7002C647"},
        level=65
    })
    self.warden:AddSkill({
        id="0x7002C646",
        EN={ name="Muster in Stangard",        label="Stangard",  zone="Great River", },
        DE={ name="Appell in Stangard",        label="Stangard",  zone="Großer Fluss", },
        FR={ name="Rassemblement : Stangarde", label="Stangarde", zone="Grand Fleuve", },
        map={{MapType.RHOVANION, 200, 720}, {MapType.ROHAN, 545, 90}},
        overlap={"0x7002C65D"},
        level=75
    })
    self.warden:AddSkill({
        id="0x7003198D",
        EN={ name="Muster in Snowbourn",         label="Snowbourn",    zone="East Rohan", },
        DE={ name="Appell in Schneegrenze",      label="Schneegrenze", zone="Ost-Rohan", },
        FR={ name="Rassemblement : Neigebronne", label="Neigebronne",  zone="Rohan est", },
        map={{MapType.ROHAN, 515, 500}},
        overlap={"0x70031A46"},
        level=80
    })
    self.warden:AddSkill({
        id="0x70036B5B",
        EN={ name="Muster in Forlaw",       label="Forlaw",  zone="Wildermore", },
        DE={ name="Appell in Forlach",      label="Forlach", zone="Wildermark", },
        FR={ name="Rassemblement : Forloi", label="Forloi",  zone="Landes farouches", },
        map={{MapType.ROHAN, 450, 175}},
        overlap={"0x70036B5E"},
        level=85
    })
    self.warden:AddSkill({
        id="0x7003DC7A",
        EN={ name="Muster in Aldburg",       label="Aldburg", zone="West Rohan", },
        DE={ name="Appell in Aldburg",       label="Aldburg", zone="West-Rohan", },
        FR={ name="Rassemblement : Aldburg", label="Aldburg", zone="Rohan de l'Ouest", },
        map={{MapType.ROHAN, 570, 640}},
        overlap={"0x7003DC81"},
        level=88
    })
    self.warden:AddSkill({
        id="0x7003DC79",
        EN={ name="Muster in Helm's Deep",           label="Helm's Deep",     zone="West Rohan", },
        DE={ name="Appell in Helms Klamm",           label="Helms Klamm",     zone="West-Rohan", },
        FR={ name="Rassemblement : Gouffre de Helm", label="Gouffre de Helm", zone="Rohan de l'Ouest", },
        map={{MapType.ROHAN, 275, 565}},
        overlap={"0x7003DC82"},
        level=90
    })
    self.warden:AddSkill({
        id="0x70041198",
        EN={ name="Muster in Dol Amroth",       desc="in western Gondor",     label="Dol Amroth", zone="Western Gondor", },
        DE={ name="Appell in Dol Amroth",       desc="West-Gondor zu reisen", label="Dol Amroth", zone="West-Gondor", },
        FR={ name="Rassemblement : Dol Amroth", desc="l'Ouest du Gondor",     label="Dol Amroth", zone="Gondor de l'Ouest", },
        map={{MapType.GONDOR, 225, 550}},
        overlap={"0x700411AC"},
        level=98
    })
    self.warden:AddSkill({
        id="0x70043A66",
        EN={ name="Muster in Arnach",       label="Arnach", zone="Eastern Gondor", },
        DE={ name="Appell in Arnach",       label="Arnach", zone="Ost-Gondor", },
        FR={ name="Rassemblement : Arnach", label="Arnach", zone="Gondor de l'Ouest", },
        map={{MapType.GONDOR, 715, 425}},
        overlap={"0x70043A6A"},
        level=100
    })
    self.warden:AddSkill({
        id="0x70044982",
        EN={ name="Muster in Minas Tirith",       label="Minas Tirith", zone="Old Anórien", },
        DE={ name="Appell in Minas Tirith",       label="Minas Tirith", zone="Alt-Anórien", },
        FR={ name="Rassemblement : Minas Tirith", label="Minas Tirith", zone="Ancien Anórien", },
        map={{MapType.GONDOR, 670, 345}},
        overlap={"0x7004497E"},
        level=100.1
    })
    self.warden:AddSkill({
        id="0x700459AA",
        EN={ name="Muster in the War-stead",        label="War-stead",                zone="Far Anórien", },
        DE={ name="Appell im Kriegslager",          label="Kriegslager der Rohirrim", zone="Fernes Anórien", },
        FR={ name="Rassemblement : Camp militaire", label="Camp militaire",           zone="Lointain Anórien", },
        map={{MapType.GONDOR, 665, 140}},
        overlap={"0x700459A9"},
        level=102
    })
    self.warden:AddSkill({
        id="0x70046CBF",
        EN={ name="Muster in after-battle Minas Tirith",            label="Minas Tirith after battle",      zone="Anórien", },
        DE={ name="Appell im schlachtgezeichneten Minas Tirith",    label="Minas Tirith nach der Schlacht", zone="Anórien", },
        FR={ name="Rassemblement : Minas Tirith après la bataille", label="Minas Tirith après la bataille", zone="Anórien", },
        map={{MapType.GONDOR, 670, 375}},
        overlap={"0x70046CC0"},
        level=105
    })
    self.warden:AddSkill({
        id="0x70047076",
        EN={ name="Muster in after-battle Osgiliath",            label="Osgiliath after-battle",      zone="Anórien", },
        DE={ name="Appell im schlachtgezeichneten Osgiliath",    label="Osgiliath nach der Schlacht", zone="Anórien", },
        FR={ name="Rassemblement : Osgiliath après la bataille", label="Osgiliath après la bataille", zone="Anórien", },
        map={{MapType.GONDOR, 855, 335}},
        overlap={"0x7004707D"},
        level=105.1
    })
    self.warden:AddSkill({
        id="0x70047075",
        EN={ name="Muster in Henneth Annûn",       label="Henneth Annûn", zone="Ithilien", },
        DE={ name="Appell in Henneth Annûn",       label="Henneth Annûn", zone="Ithilien", },
        FR={ name="Rassemblement : Henneth Annûn", label="Henneth Annûn", zone="Ithilien", },
        map={{MapType.GONDOR, 875, 385}},
        overlap={"0x70047080"},
        level=105.2
    })
    self.warden:AddSkill({
        id="0x70047BFC",
        EN={ name="Muster in the Camp of the Host",  label="Camp of the Host", zone="The Wastes", },
        DE={ name="Appell im Lager des Heeres",      label="Lager des Heeres", zone="Das Ödland", },
        FR={ name="Rassemblement : Camp de l'armée", label="Camp de l'armée",  zone="Les Landes désertiques", },
        map={{MapType.GONDOR, 805, 170}},
        overlap={"0x70047BF4"},
        level=105.3
    })
    self.warden:AddSkill({
        id="0x70047C23",
        EN={ name="Muster in Haerondir",       label="Haerondir", zone="The Wastes", },
        DE={ name="Appell in Haerondir",       label="Haerondir", zone="Das Ödland", },
        FR={ name="Rassemblement : Haerondir", label="Haerondir", zone="Les Landes désertiques", },
        map={{MapType.GONDOR, 855, 100}},
        overlap={"0x70047C1B"},
        level=105.4
    })
    self.warden:AddSkill({
        id="0x7004AE1F",
        EN={ name="Muster in the Udûn Foothold",    label="Udûn Foothold",    zone="Mordor", },
        DE={ name="Appell am Udûn-Brückenkopf",     label="Udûn-Brückenkopf", zone="Mordor", },
        FR={ name="Rassemblement : Le fort d'Udûn", label="Fort d'Udûn",      zone="Mordor", },
        map={{MapType.GONDOR, 925, 230}},
        overlap={"0x7004AE1D"},
        level=106
    })
    self.warden:AddSkill({
        id="0x7004D73A",
        EN={ name="Muster in Dale",       label="Dale", zone="Eryn Lasgalen", },
        DE={ name="Appell in Thal",       label="Thal", zone="Eryn Lasgalen", },
        FR={ name="Rassemblement : Dale", label="Dale", zone="Eryn Lasgalen", },
        map={{MapType.RHOVANION, 720, 215}},
        overlap={"0x7004D738"},
        level=115
    })
    self.warden:AddSkill({
        id="0x7004FACA",
        EN={ name="Muster in Járnfast",       label="Járnfast", zone="The Ironfold", },
        DE={ name="Appell in Járnfast",       label="Jarnfast", zone="Der Eisenbruch", },
        FR={ name="Rassemblement : Jarnfast", label="Jarnfast", zone="La Crevasse de Fer", },
        map={{MapType.RHOVANION, 890, 110}},
        overlap={"0x7004FAC3"},
        level=116
    })
    self.warden:AddSkill({
        id="0x7004FACD",
        EN={ name="Muster in Skarháld",       label="Skarháld", zone="Ered Mithrin", },
        DE={ name="Appell in Skarháld",       label="Skarhald", zone="Ered Mithrin", },
        FR={ name="Rassemblement : Skarhald", label="Skarhald", zone="Ered Mithrin", },
        map={{MapType.RHOVANION, 430, 90}},
        overlap={"0x7004FAC5"},
        level=117
    })
    self.warden:AddSkill({
        id="0x70052F0A",
        EN={ name="Muster in Beorninghús",       label="Beorninghús",   zone="Vales of Anduin", },
        DE={ name="Appell im Beorningerhús",     label="Beorningerhús", zone="Die Täler des Anduin", },
        FR={ name="Rassemblement : Beorninghus", label="Beorninghus",   zone="Val d'Anduin", },
        map={{MapType.RHOVANION, 390, 300}},
        overlap={"0x70041A22", "0x70052F12"},
        level=120
    })
    self.warden:AddSkill({
        id="0x70052F06",
        EN={ name="Muster in Hultvís",       label="Hultvís", zone="Vales of Anduin", },
        DE={ name="Appell in Hultvís",       label="Hultvís", zone="Die Täler des Anduin", },
        FR={ name="Rassemblement : Hultvis", label="Hultvis", zone="Val d'Anduin", },
        map={{MapType.RHOVANION, 375, 400}},
        overlap={"0x70052F04"},
        level=120.1
    })
    self.warden:AddSkill({
        id="0x700551F2",
        EN={ name="Muster in Estolad Lân",       label="Estolad Lân", zone="Imlad Morgul", },
        DE={ name="Appell in Estolad Lân",       label="Estolad Lân", zone="Imlad Morgul", },
        FR={ name="Rassemblement : Estolad Lân", label="Estolad Lân", zone="Imlad Morgul", },
        map={{MapType.GONDOR, 960, 460}},
        overlap={"0x700551F8"},
        level=125
    })
    self.warden:AddSkill({
        id="0x70057635",
        EN={ name="Muster in Limlók",       label="Limlók", zone="Wells of Langflood", },
        DE={ name="Appell in Limlók",       label="Limlók", zone="Quellen des Langflut", },
        FR={ name="Rassemblement : Limlok", label="Limlok", zone="Puits du Long Fleuve", },
        map={{MapType.RHOVANION, 345, 230}},
        overlap={"0x70057629"},
        level=130
    })
    self.warden:AddSkill({
        id="0x70058572",
        EN={ name="Muster in Annâk-khurfu",       label="Annâk-khurfu", zone="Elderslade", },
        DE={ name="Appell in Annâk-khurfu",       label="Annâk-khurfu", zone="Elderslade", },
        FR={ name="Rassemblement : Annâk-khurfu", label="Annâk-khurfu", zone="Elderslade", },
        map={{MapType.RHOVANION, 530, 90}},
        overlap={"0x7005856F"},
        level=130.1
    })
    self.warden:AddSkill({
        id="0x7005AA8F",
        EN={ name="Muster in Akrâz-zahar",       label="Akrâz-zahar", zone="Eryn Lasgalen", },
        DE={ name="Appell in Akrâz-zahar",       label="Akrâz-zahar", zone="Eryn Lasgalen", },
        FR={ name="Rassemblement : Akrâz-zahar", label="Akrâz-zahar", zone="Eryn Lasgalen", },
        map={{MapType.RHOVANION, 750, 115}},
        overlap={"0x7005AA90"},
        level=130.2
    })
    self.warden:AddSkill({
        id="0x7005AA8C",
        EN={ name="Muster in Azanulbizar",       label="Azanulbizar", detail="Amdân", zone="Azanulbizar", },
        DE={ name="Appell in Azanulbizar",       label="Azanulbizar", detail="Amdân", zone="Azanulbizar", },
        FR={ name="Rassemblement : Azanulbizar", label="Azanulbizar", detail="Amdân", zone="Azanulbizar", },
        map={{MapType.RHOVANION, 210, 555}},
        overlap={"0x7005AA92"},
        level=130.3
    })
    self.warden:AddSkill({
        id="0x7005D48A",
        EN={ name="Muster at the Noble Gate",       label="Noble Gate",  zone="Gundabad", },
        DE={ name="Appell am Prachttor",            label="Prachttor",   zone="Gundabad", },
        FR={ name="Rassemblement : La Porte Noble", label="Porte Noble", zone="Gundabad", },
        map={{MapType.RHOVANION, 190, 130}},
        overlap={"0x7005D47C"},
        level=131
    })
    self.warden:AddSkill({
        id="0x7005D488",
        EN={ name="Muster at Leitstáth",       label="Leitstáth", zone="Gundabad", },
        DE={ name="Appell in Leitstáth",       label="Leitstáth", zone="Gundabad", },
        FR={ name="Rassemblement : Leitstath", label="Leitstath", zone="Gundabad", },
        map={{MapType.RHOVANION, 270, 65}},
        overlap={"0x7005D484"},
        level=135
    })
    self.warden:AddSkill({
        id="0x70064ACB",
        EN={ name="Muster at Carn Dûm",       label="Carn Dûm", zone="Angmar", },
        DE={ name="Appell in Carn Dûm",       label="Carn Dûm", zone="Angmar", },
        FR={ name="Rassemblement : Carn Dûm", label="Carn Dûm", zone="Angmar", },
        map={{MapType.ERIADOR, 735, 100}},
        overlap={"0x70064ACA"},
        level=140.1
    })
    self.warden:AddSkill({
        id="0x700658E8",
        EN={ name="Muster at Pelargir",       label="Pelargir", zone="King's Gondor", },
        DE={ name="Heerschau in Pelargir",    label="Pelargir", zone="Königreich Gondor", },
        FR={ name="Rassemblement à Pelargir", label="Pelargir", zone="Gondor royal", },
        map={{MapType.GONDOR, 670, 625}},
        overlap={"0x700658EB"},
        level=141
    })
    self.warden:AddSkill({
        id="0x70068712",
        EN={ name="Muster at Dol Amroth",       desc="King's Gondor",     label="King's Dol Amroth",     zlabel="Dol Amroth", zone="King's Gondor", },
        DE={ name="Appell in Dol Amroth",       desc="Königreich Gondor", label="Königreich Dol Amroth", zlabel="Dol Amroth", zone="Königreich Gondor", },
        FR={ name="Rassemblement à Dol Amroth", desc="le Gondor royal",   label="Dol Amroth royal",      zlabel="Dol Amroth", zone="Gondor royal", },
        map={{MapType.GONDOR, 210, 485}, {MapType.HARADWAITH, 385, 70}},
        overlap={"0x70068700"},
        level=142
    })
    self.warden:AddSkill({
        id="0x70068715",
        EN={ name="Muster at Lond Cirion",       label="Lond Cirion", zone="Anfalas", },
        DE={ name="Appell in Lond Cirion",       label="Lond Cirion", zone="Anfalas", },
        FR={ name="Rassemblement à Lond Cirion", label="Lond Cirion", zone="Anfalas", },
        map={{MapType.GONDOR, 255, 420}, {MapType.HARADWAITH, 230, 20}},
        overlap={"0x70068703"},
        level=143
    })
    self.warden:AddSkill({
        id="0x70068710",
        EN={ name="Muster at Halrax",       label="Halrax", zone="Shield Isles", },
        DE={ name="Appell in Halrax",       label="Halrax", zone="Die Schildinseln", },
        FR={ name="Rassemblement à Halrax", label="Halrax", zone="Les îles du Bouclier", },
        map={{MapType.HARADWAITH, 275, 260}},
        overlap={"0x70068702"},
        level=145
    })
    self.warden:AddSkill({
        id="0x7006870C",
        EN={ name="Muster at Jax Phanâl",       label="Jax Phanâl", zone="Umbar", },
        DE={ name="Appell in Jax Phanâl",       label="Jax Phanâl", zone="Umbar", },
        FR={ name="Rassemblement à Jax Phanâl", label="Jax Phanâl", zone="Umbar", },
        map={{MapType.HARADWAITH, 305, 315}},
        overlap={"0x70068701"},
        level=146
    })
    self.warden:AddSkill({
        id="0x7006A9C2",
        EN={ name="Muster in Bej Mâghda",       label="Bej Mâghda", zone="Umbar", },
        DE={ name="Appell in Bej Mâghda",       label="Bej Mâghda", zone="Umbar", },
        FR={ name="Rassemblement à Bej Mâghda", label="Bej Mâghda", zone="Umbar", },
        map={{MapType.HARADWAITH, 350, 380}},
        overlap={"0x7006A9C1"},
        level=147
    })
    self.warden:AddSkill({
        id="0x7006870F",
        EN={ name="Muster at Umbar",       label="Umbar", detail="Baharbêl", zone="Umbar", },
        DE={ name="Appell in Umbar",       label="Umbar", detail="Baharbêl", zone="Umbar", },
        FR={ name="Rassemblement à Umbar", label="Umbar", detail="Baharbêl", zone="Umbar", },
        map={{MapType.HARADWAITH, 505, 370}},
        overlap={"0x700686FF"},
        level=148
    })
    self.warden:AddSkill({
        id="0x700697F3",
        EN={ name="Muster at the Bloody Eagle Tavern",              label="Bloody Eagle Tavern",         zone="Umbar", },
        DE={ name="Appell in der Taverne \"Zum Blutigen Adler\"",   label="Zum Blutigen Adler",          zone="Umbar", },
        FR={ name="Rassemblement à la taverne de l'Aigle sanglant", label="Taverne de l'Aigle sanglant", zone="Umbar", },
        map={{MapType.HARADWAITH, 475, 400}},
        overlap={"0x700697F2"},
        level=149
    })

    -- add the Mariner locations
    self.mariner:AddLabelTag({EN="Sail", DE="Segeln", FR="Naviguer" })
    self.mariner:AddSkill({
        id="0x70066100",
        EN={ name="Sail to Celondim",       label="Celondim", zone="Ered Luin", },
        DE={ name="Segelt nach Celondim",   label="Celondim", zone="Ered Luin", },
        FR={ name="Naviguer vers Celondim", label="Celondim", zone="Ered Luin", },
        map={{MapType.ERIADOR, 310, 380}},
        level=1
    })
    self.mariner:AddSkill({
        id="0x7006611A",
        EN={ name="Sail to Buckland",              label="Buckland",     zone="Bree", },
        DE={ name="Segelt nach Bockland",          label="Bockland",     zone="Bree", },
        FR={ name="Naviguer vers le Pays de Bouc", label="Pays de Bouc", zone="Bree", },
        map={{MapType.ERIADOR, 515, 405}},
        level=4
    })
    self.mariner:AddSkill({
        id="0x70066120",
        EN={ name="Sail to Tharbad",       label="Tharbad", zone="Swanfleet", },
        DE={ name="Nach Tharbad segeln",   label="Tharbad", zone="Schwanenfleet", },
        FR={ name="Naviguer vers Tharbad", label="Tharbad", zone="Noues des cygnes", },
        map={{MapType.ERIADOR, 650, 525}},
        level=5
    })
    self.mariner:AddSkill({
        id="0x7006610F",
        EN={ name="Sail to Tinnudir",       label="Tinnudir", zone="Evendim", },
        DE={ name="Segelt nach Tinnudir",   label="Tinnudir", zone="Evendim", },
        FR={ name="Naviguer vers Tinnudir", label="Tinnudir", zone="Evendim", },
        map={{MapType.ERIADOR, 420, 250}},
        level=30
    })
    self.mariner:AddSkill({
        id="0x70066105",
        EN={ name="Sail to Trader's Wharf",              label="Trader's Wharf",     zone="Evendim", },
        DE={ name="Segelt zum Händlerkai",               label="Händlerkai",         zone="Evendim", },
        FR={ name="Naviguer vers le Quai des marchands", label="Quai des marchands", zone="Evendim", },
        map={{MapType.ERIADOR, 515, 305}},
        overlap={"0x70059D0E"},
        level=40.4
    })
    self.mariner:AddSkill({
        id="0x7006611C",
        EN={ name="Sail to Sûri-kylä",       label="Sûri-kylä", zone="Forochel", },
        DE={ name="Segelt nach Sûri-kylä",   label="Sûri-kylä", zone="Forochel", },
        FR={ name="Naviguer vers Sûri-kylä", label="Sûri-kylä", zone="Forochel", },
        map={{MapType.ERIADOR, 430, 50}},
        level=42
    })
    self.mariner:AddSkill({
        id="0x7006611E",
        EN={ name="Sail to Lothlórien",          label="Lothlórien", detail="Egladil", zone="Lothlórien", },
        DE={ name="Segelt nach Lothlórien",      label="Lothlórien", detail="Egladil", zone="Lothlórien", },
        FR={ name="Naviguer vers la Lothlorien", label="Lothlórien", detail="Egladil", zone="Lothlórien", },
        map={{MapType.RHOVANION, 245, 670}},
        overlap={"0x70048C8C"},
        level=60
    })
    self.mariner:AddSkill({
        id="0x7006610E",
        EN={ name="Sail to the Mirk-eaves",     label="Mirk-eaves",  zone="Mirkwood", },
        DE={ name="Segelt zur Dunkelsenke",     label="Dunkelsenke", zone="Düsterwald", },
        FR={ name="Naviguer vers l'Orée Noire", label="Orée Noire",  zone="Forêt Noire", },
        map={{MapType.RHOVANION, 365, 630}},
        level=61
    })
    self.mariner:AddSkill({
        id="0x70066101",
        EN={ name="Sail to the Brown Lands",         label="Brown Lands",   zone="Great River", },
        DE={ name="Segelt in die Braunen Lande",     label="Braune Lande",  zone="Großer Fluss", },
        FR={ name="Naviguer vers les Terres brunes", label="Terres brunes", zone="Grand Fleuve", },
        map={{MapType.ROHAN, 700, 180}},
        level=75.1
    })
    self.mariner:AddSkill({
        id="0x70066121",
        EN={ name="Sail to Snowbourn",         label="Snowbourn",    zone="East Rohan", },
        DE={ name="Segelt nach Schneegrenze",  label="Schneegrenze", zone="Ost-Rohan", },
        FR={ name="Naviguer vers Neigebronne", label="Neigebronne",  zone="Rohan est", },
        map={{MapType.ROHAN, 515, 500}},
        overlap={"0x70031A46"},
        level=80
    })
    self.mariner:AddSkill({
        id="0x70066117",
        EN={ name="Sail to Dol Amroth",       desc="Dol Amroth with nearby",     label="Dol Amroth", zone="Western Gondor", },
        DE={ name="Segelt nach Dol Amroth",   desc="nach Dol Amroth.",           label="Dol Amroth", zone="West-Gondor", },
        FR={ name="Naviguer vers Dol Amroth", desc="Amroth en bonne compagnie.", label="Dol Amroth", zone="Gondor de l'Ouest", },
        map={{MapType.GONDOR, 225, 550}},
        overlap={"0x700411AC"},
        level=98
    })
    self.mariner:AddSkill({
        id="0x70066109",
        EN={ name="Sail to after-battle Osgiliath",            label="Osgiliath after-battle",         zone="Anórien", },
        DE={ name="Segelt ins schlachtgezeichnete Osgiliath",  label="Schlachtgezeichnetes Osgiliath", zone="Anórien", },
        FR={ name="Naviguer vers Osgiliath après la bataille", label="Osgiliath après la bataille",    zone="Anórien", },
        map={{MapType.GONDOR, 855, 335}},
        overlap={"0x7004707D"},
        level=105.1
    })
    self.mariner:AddSkill({
        id="0x7006610C",
        EN={ name="Sail to Lake-town",       label="Lake-town",    zone="Eryn Lasgalen", },
        DE={ name="Segelt nach Seestadt.",   label="Seestadt",     zone="Eryn Lasgalen", },
        FR={ name="Cap sur la Ville du Lac", label="Ville du Lac", zone="Eryn Lasgalen", },
        map={{MapType.RHOVANION, 740, 275}},
        overlap={"0x7004D738"},
        level=115
    })
    self.mariner:AddSkill({
        id="0x7006611B",
        EN={ name="Sail to Pelargir",       label="Pelargir", zone="King's Gondor", },
        DE={ name="Segelt nach Pelargir",   label="Pelargir", zone="Königreich Gondor", },
        FR={ name="Naviguer vers Pelargir", label="Pelargir", zone="Gondor royal", },
        map={{MapType.GONDOR, 670, 625}},
        overlap={"0x700658EB"},
        level=141
    })
    self.mariner:AddSkill({
        id="0x700687C1",
        EN={ name="Sail to Dol Amroth",       desc="King's Gondor",     label="King's Dol Amroth",     zlabel="Dol Amroth", zone="King's Gondor", },
        DE={ name="Segelt nach Dol Amroth",   desc="Königreich Gondor", label="Königreich Dol Amroth", zlabel="Dol Amroth", zone="Königreich Gondor", },
        FR={ name="Naviguer vers Dol Amroth", desc="le Gondor royal",   label="Dol Amroth royal",      zlabel="Dol Amroth", zone="Gondor royal", },
        map={{MapType.GONDOR, 210, 485}, {MapType.HARADWAITH, 385, 70}},
        overlap={"0x70068700"},
        level=142
    })
    self.mariner:AddSkill({
        id="0x700687BD",
        EN={ name="Sail to Lond Cirion",       label="Lond Cirion", zone="Anfalas", },
        DE={ name="Nach Lond Cirion segeln",   label="Lond Cirion", zone="Anfalas", },
        FR={ name="Naviguer vers Lond Cirion", label="Lond Cirion", zone="Anfalas", },
        map={{MapType.GONDOR, 255, 420}, {MapType.HARADWAITH, 230, 20}},
        overlap={"0x70068703"},
        level=143
    })
    self.mariner:AddSkill({
        id="0x700687C3",
        EN={ name="Sail to Halrax",       label="Halrax", zone="Shield Isles", },
        DE={ name="Nach Halrax segeln",   label="Halrax", zone="Die Schildinseln", },
        FR={ name="Naviguer vers Halrax", label="Halrax", zone="Les îles du Bouclier", },
        map={{MapType.HARADWAITH, 275, 160}},
        overlap={"0x70068702"},
        level=145
    })
    self.mariner:AddSkill({
        id="0x700687C0",
        EN={ name="Sail to Jax Phanâl",       label="Jax Phanâl", zone="Umbar", },
        DE={ name="Nach Jax Phanâl segeln",   label="Jax Phanâl", zone="Umbar", },
        FR={ name="Naviguer vers Jax Phanâl", label="Jax Phanâl", zone="Umbar", },
        map={{MapType.HARADWAITH, 305, 315}},
        overlap={"0x70068701"},
        level=146
    })
    self.mariner:AddSkill({
        id="0x7006A9C4",
        EN={ name="Sail to Bej Mâghda",       label="Bej Mâghda", zone="Umbar", },
        DE={ name="Nach Bej Mâghda segeln",   label="Bej Mâghda", zone="Umbar", },
        FR={ name="Naviguer vers Bej Mâghda", label="Bej Mâghda", zone="Umbar", },
        map={{MapType.HARADWAITH, 350, 380}},
        overlap={"0x7006A9C1"},
        level=147
    })
    self.mariner:AddSkill({
        id="0x700687BB",
        EN={ name="Sail to Umbar",       label="Umbar", detail="Baharbêl", zone="Umbar", },
        DE={ name="Nach Umbar segeln",   label="Umbar", detail="Baharbêl", zone="Umbar", },
        FR={ name="Naviguer vers Umbar", label="Umbar", detail="Baharbêl", zone="Umbar", },
        map={{MapType.HARADWAITH, 505, 370}},
        overlap={"0x700686FF"},
        level=148
    })

    -- add the racial travel skills
    self.racials:AddLabelTag({EN="Racial", DE="Rasse", FR="Race" })
    self.racials:AddSkill({
        -- man
        id="0x700062F6",
        EN={ name="Return to Bree",     desc="enables you to quickly return", label="Bree", zlabel="West Gate",   zone="Bree", },
        DE={ name="Rückkehr nach Bree", desc="Ihr könnt schnell nach Bree",   label="Bree", zlabel="Westtor",     zone="Bree", },
        FR={ name="Retour à Bree",      desc="Permet de retourner",           label="Bree", zlabel="Porte Ouest", zone="Bree", },
        map={MapType.ERIADOR, 525, 335},
        level=5
    })
    self.racials:AddSkill({
        -- hobbit
        id="0x700062C8",
        EN={ name="Return to the Shire",     label="Michel Delving", zone="Shire", },
        DE={ name="Rückkehr ins Auenland",   label="Michelbinge",    zone="Auenland", },
        FR={ name="Retournez dans la Comté", label="Grand'Cave",     zone="Comté", },
        map={MapType.ERIADOR, 405, 440},
        level=1
    })
    self.racials:AddSkill({
        -- dwarf
        id="0x70006346",
        EN={ name="Return to Thorin's Gate",  desc="This enables you to quickly return", label="Thorin's Gate",   zone="Ered Luin", },
        DE={ name="Rückkehr zu Thorins Tor",  desc="Hiermit gelangt Ihr schnell",        label="Thorins Tor",     zone="Ered Luin", },
        FR={ name="Retour : Porte de Thorin", desc="Ceci vous permet de retourner",      label="Porte de Thorin", zone="Ered Luin", },
        map={MapType.ERIADOR, 310, 270},
        level=1.2
    })
    self.racials:AddSkill({
        -- elf
        id="0x7000631F",
        EN={ name="Return to Rivendell",    desc="This enables you to quickly return", label="Rivendell", zone="Trollshaws", },
        DE={ name="Rückkehr nach Bruchtal", desc="Hiermit gelangt Ihr schnell",        label="Bruchtal",  zone="Die Trollhöhen", },
        FR={ name="Retour à Fondcombe",     desc="Ceci vous permet de retourner",      label="Fondcombe", zone="Trouée des Trolls", },
        map={MapType.ERIADOR, 900, 375},
        level=40.1
    })
    self.racials:AddSkill({
        -- beorning
        id="0x70041A22",
        EN={ name="Return Home",              desc="Grimbeorn's Lodge.",     label="Beorning Home",    zone="Vales of Anduin", },
        DE={ name="Zum 1. Heim zurückkehren", desc="Grimbeorns Hütte.",      label="Grimbeorns Hütte", zone="Die Täler des Anduin", },
        FR={ name="Retour à la maison",       desc="Pavillon de Grimbeorn.", label="Maison Beorning",  zone="Val d'Anduin", },
        map={MapType.RHOVANION, 285, 340},
        level=120
    })
    self.racials:AddSkill({
        -- high elf
        id="0x70048C8C",
        EN={ name="Travel to Caras Galadhon in Lothlórien",    label="Caras Galadhon", zone="Lothlórien", },
        DE={ name="Reise nach Caras Galadhon in Lothlórien",   label="Caras Galadhon", zone="Lothlórien", },
        FR={ name="Voyage vers Caras Galadhon, en Lothlórien", label="Caras Galadhon", zone="Lothlórien", },
        map={MapType.RHOVANION, 120, 690},
        level=60
    })
    self.racials:AddSkill({
        -- stoutaxe
        id="0x70053C0F",
        EN={ name="Travel to Thorin's Hall",   label="Thorin's Hall",    zone="Ered Luin", },
        DE={ name="Reise zu Thorins Halle",    label="Thorins Halle",    zone="Ered Luin", },
        FR={ name="Aller au Palais de Thorin", label="Palais de Thorin", zone="Ered Luin", },
        map={MapType.ERIADOR, 345, 310},
        level=1.2
    })
    self.racials:AddSkill({
        -- river hobbit
        id="0x70066D31",
        EN={ name="Return to Lyndelby",        label="Lyndelby", zone="Wells of Langflood", },
        DE={ name="Kehrt zu Lyndelby zurück.", label="Lyndelby", zone="Quellen des Langflut", },
        FR={ name="Retour à Lyndelby",         label="Lyndelby", zone="Puits du Long Fleuve", },
        map={MapType.RHOVANION, 155, 165},
        level=1.3
    })

    -- add the Return Home and housing skills
    self.gen:AddSkill({
        id="0x700256BA",
        EN={ name="Return Home",              desc="bound milestone" },
        DE={ name="Zum 1. Heim zurückkehren", desc="Markstein zurückkehren", label="1. Markstein", },
        FR={ name="Retour à la maison",       desc="point de repère lié",    label="Point de repère 1", },
        map={MapType.NONE, -1, -1},
        level=1
    })
    self.gen:AddSkill({
        id="0x70025792",
        EN={ name="Return Home 2", },
        DE={ name="Zum 2. Heim zurückkehren", label="2. Markstein", },
        FR={ name="Retour à la maison 2",     label="Point de repère 2", },
        map={MapType.NONE, -1, -1},
        level=1
    })
    self.gen:AddSkill({
        id="0x70025793",
        EN={ name="Return Home 3", },
        DE={ name="Zum 3. Heim zurückkehren", label="3. Markstein", },
        FR={ name="Retour à la maison 3",     label="Point de repère 3", },
        map={MapType.NONE, -1, -1},
        level=1
    })
    self.gen:AddSkill({
        id="0x70025794",
        EN={ name="Return Home 4", },
        DE={ name="Zum 4. Heim zurückkehren", label="4. Markstein", },
        FR={ name="Retour à la maison 4",     label="Point de repère 4", },
        map={MapType.NONE, -1, -1},
        level=1
    })
    self.gen:AddSkill({
        id="0x70025795",
        EN={ name="Return Home 5", },
        DE={ name="Zum 5. Heim zurückkehren", label="5. Markstein", },
        FR={ name="Retour à la maison 5",     label="Point de repère 5", },
        map={MapType.NONE, -1, -1},
        level=1
    })
    self.gen:AddSkill({
        id="0x70025796",
        EN={ name="Return Home 6", },
        DE={ name="Zum 6. Heim zurückkehren", label="6. Markstein", },
        FR={ name="Retour à la maison 6",     label="Point de repère 6", },
        map={MapType.NONE, -1, -1},
        level=1
    })
    self.gen:AddSkill({
        id="0x7002FF62",
        EN={ name="Return Home 7", },
        DE={ name="Zum 7. Heim zurückkehren", label="7. Markstein", },
        FR={ name="Retour à la maison 7",     label="Point de repère 7", },
        map={MapType.NONE, -1, -1},
        level=1
    })
    self.gen:AddSkill({
        id="0x7002FF61",
        EN={ name="Return Home 8", },
        DE={ name="Zum 8. Heim zurückkehren", label="8. Markstein", },
        FR={ name="Retour à la maison 8",     label="Point de repère 8", },
        map={MapType.NONE, -1, -1},
        level=1
    })
    self.gen:AddSkill({
        id="0x7002FF60",
        EN={ name="Return Home 9", },
        DE={ name="Zum 9. Heim zurückkehren", label="9. Markstein", },
        FR={ name="Retour à la maison 9",     label="Point de repère 9", },
        map={MapType.NONE, -1, -1},
        level=1
    })
    self.gen:AddSkill({
        id="0x7002FF5F",
        EN={ name="Return Home 10", },
        DE={ name="Zum 10. Heim zurückkehren", label="10. Markstein", },
        FR={ name="Retour à la maison 10",     label="Point de repère 10", },
        map={MapType.NONE, -1, -1},
        level=1
    })
    self.gen:AddSkill({
        id="0x7002FF63",
        EN={ name="Return Home 11", },
        DE={ name="Zum 11. Heim zurückkehren", label="11. Markstein", },
        FR={ name="Retour à la maison 11",     label="Point de repère 11", },
        map={MapType.NONE, -1, -1},
        level=1
    })
    self.gen:AddSkill({
        id="0x7000D046",
        EN={ name="Travel to Personal House",       label="Personal House", },
        DE={ name="Reist zu Eurem eigenen Heim",    label="Eigenes Heim", },
        FR={ name="Retour à la maison personnelle", label="Maison personnelle", },
        map={MapType.NONE, -1, -1},
        level=1
    })
    self.gen:AddSkill({
        id="0x70046EE4",
        EN={ name="Travel to Premium House",    label="Premium House", },
        DE={ name="Reist zu Eurem Premiumheim", label="Premiumheim", },
        FR={ name="Aller à une maison premium", label="Maison premium", },
        map={MapType.NONE, -1, -1},
        level=1
    })
    self.gen:AddSkill({
        id="0x7000D047",
        EN={ name="Travel to Kinship House",         label="Kinship House", },
        DE={ name="Reist zum Haus Eurer Sippe",      label="Heim Eurer Sippe", },
        FR={ name="Retour à la maison de confrérie", label="Maison de confrérie", },
        map={MapType.NONE, -1, -1},
        level=1
    })
    self.gen:AddSkill({
        id="0x70057C36",
        EN={ name="Travel to Kinship Member's House",            label="Kinship Member's House", },
        DE={ name="Zum Haus des Sippenmitglieds reisen",         label="Heim des Sippenmitglieds", },
        FR={ name="Retour à la maison d'un membre de confrérie", label="Maison d'un membre de confrérie", },
        map={MapType.NONE, -1, -1},
        level=1
    })

    -- add the obtainable travel skills
    self.rep:AddLabelTag({EN="Rep", DE="Ruf", FR="Rep" })
    self.rep:AddSkill({
        id="0x70023262",
        EN={ name="Return to Michel Delving",  label="Michel Delving", tag="Store", zone="Shire", },
        DE={ name="Rückkehr nach Michelbinge", label="Michelbinge",    tag="Shop",  zone="Auenland", },
        FR={ name="Retour à Grand'Cave",       label="Grand'Cave",     tag="Shop",  zone="Comté", },
        map={{MapType.ERIADOR, 375, 440}},
        level=1
    })
    self.rep:AddSkill({
        id="0x7001BF91",
        EN={ name="Return to Thorin's Gate",  desc="Thanks to your friendship", label="Thorin's Gate",   zone="Ered Luin", },
        DE={ name="Rückkehr zu Thorins Tor",  desc="Dank Eurer Freundschaft",   label="Thorins Tor",     zone="Ered Luin", },
        FR={ name="Retour : Porte de Thorin", desc="Grâce à l'amitié qui vous", label="Porte de Thorin", zone="Ered Luin", },
        map={{MapType.ERIADOR, 345, 310}},
        level=1.1
    })
    self.rep:AddSkill({
        id="0x7001BF90",
        EN={ name="Return to Bree",     desc="Thanks to your friendship", label="Bree", zlabel="West Gate",   zone="Bree", },
        DE={ name="Rückkehr nach Bree", desc="Dank Eurer Freundschaft",   label="Bree", zlabel="Westtor",     zone="Bree", },
        FR={ name="Retour à Bree",      desc="Grâce à votre amitié",      label="Bree", zlabel="Porte Ouest", zone="Bree", },
        map={{MapType.ERIADOR, 555, 335}},
        level=5
    })
    self.rep:AddSkill({
        id="0x700364B1",
        EN={ name="Return to Lalia's Market",     label="Lalia's Market",  zone="Bree", },
        DE={ name="Kehrt zu Lalias Markt zurück", label="Lalias Markt",    zone="Bree", },
        FR={ name="Retour au Marché de Lalia",    label="Marché de Lalia", zone="Bree", },
        tag="Mithril",
        map={{MapType.ERIADOR, 630, 360}},
        level=5.1
    })
    self.rep:AddSkill({
        id="0x70064F47",
        EN={ name="Return to Clegur",      label="Clegur", zone="Swanfleet", },
        DE={ name="Rückkehr nach Clegur",  label="Clegur", zone="Schwanenfleet", },
        FR={ name="Retournez voir Clegur", label="Clegur", zone="Noues des cygnes", },
        map={{MapType.ERIADOR, 725, 555}},
        level=7
    })
    self.rep:AddSkill({
        id="0x700634A4",
        EN={ name="Return to Swanfleet",         label="Swanfleet",        detail="Lhan Garan", zone="Swanfleet", },
        DE={ name="Rückkehr nach Schwanenfleet", label="Schwanenfleet",    detail="Lhan Garan", zone="Schwanenfleet", },
        FR={ name="Retour aux Noues des cygnes", label="Noues des cygnes", detail="Lhan Garan", zone="Noues des cygnes", },
        map={{MapType.ERIADOR, 795, 490}},
        level=10
    })
    self.rep:AddSkill({
        id="0x700634AE",
        EN={ name="Return to Cardolan",     label="Cardolan", detail="Herne", zone="Cardolan", },
        DE={ name="Rückkehr nach Cardolan", label="Cardolan", detail="Herne", zone="Cardolan", },
        FR={ name="Retour au Cardolan",     label="Cardolan", detail="Herne", zone="Cardolan", },
        map={{MapType.ERIADOR, 590, 495}},
        level=15
    })
    self.rep:AddSkill({
        id="0x7006323D",
        EN={ name="Return to Andrath",     label="Andrath", zone="Cardolan", },
        DE={ name="Rückkehr nach Andrath", label="Andrath", zone="Cardolan", },
        FR={ name="Retour à Andrath",      label="Andrath", zone="Cardolan", },
        map={{MapType.ERIADOR, 550, 465}},
        level=17
    })
    self.rep:AddSkill({
        id="0x70061340",
        EN={ name="Return to Nobottle",           label="Nobottle",    zone="Yondershire", },
        DE={ name="Kehrt nach Neuhausen zurück.", label="Neuhausen",   zone="Ferne Auen", },
        FR={ name="Retour à Bourdeneuve",         label="Bourdeneuve", zone="Comté lointain", },
        map={{MapType.ERIADOR, 410, 350}},
        level=20
    })
    self.rep:AddSkill({
        id="0x70020441",
        EN={ name="Return to Ost Guruth",      label="Ost Guruth",   zone="Lone-lands", },
        DE={ name="Rückkehr zur Feste Guruth", label="Feste Guruth", zone="Einsame Lande", },
        FR={ name="Retournez à Ost Guruth",    label="Ost Guruth",   zone="Terres Solitaires", },
        map={{MapType.ERIADOR, 725, 400}},
        level=25
    })
    self.rep:AddSkill({
        id="0x70060EA8",
        EN={ name="Return to Tornhad",          label="Tornhad", zone="Angle of Mitheithel", },
        DE={ name="Kehrt nach Tornhad zurück.", label="Tornhad", zone="Der Bogen von Mitheithel", },
        FR={ name="Retournez voir Tornhad",     label="Tornhad", zone="L'Angle de Mitheithel", },
        map={{MapType.ERIADOR, 745, 435}},
        level=40
    })
    self.rep:AddSkill({
        id="0x70023263",
        EN={ name="Return to Rivendell",    desc="Thanks to your friendship", label="Rivendell", tag="Store", zone="Trollshaws", },
        DE={ name="Rückkehr nach Bruchtal", desc="Dank Eurer Freundschaft",   label="Bruchtal",  tag="Shop",  zone="Die Trollhöhen", },
        FR={ name="Retour à Fondcombe",     desc="Grâce à votre amitié avec", label="Fondcombe", tag="Shop",  zone="Trouée des Trolls", },
        map={{MapType.ERIADOR, 835, 410}},
        level=40.1
    })
    self.rep:AddSkill({
        id="0x700634A5",
        EN={ name="Return to the Tracery Archives in Rivendell",         label="Tracery Archive",       zone="Trollshaws", },
        DE={ name="Rückkehr zu den Filigranmuster-Archiven in Bruchtal", label="Filigranmuster-Archiv", zone="Die Trollhöhen", },
        FR={ name="Retour aux Archives de gravures de Fondcombe",        label="Archives de gravures",  zone="Trouée des Trolls", },
        tag="Delving",
        map={{MapType.ERIADOR, 905, 345}},
        level=40.11
    })
    self.rep:AddSkill({
        id="0x7005B38E",
        EN={ name="Return to Glân Vraig",         label="Glân Vraig", tag="Quest",   zone="Ettenmoors", },
        DE={ name="Nach Glân Vraig zurückkehren", label="Glân Vraig", tag="Aufgabe", zone="Die Ettenöden", },
        FR={ name="Retour à Glân Vraig",          label="Glân Vraig", tag="Quête",   zone="Les Landes d'Etten", },
        map={{MapType.ERIADOR, 835, 245}},
        level=40.12
    })
    self.rep:AddSkill({
        id="0x70059D12",
        EN={ name="Return to Trestlebridge",     label="Trestlebridge",   zone="North Downs", },
        DE={ name="Kehrt nach Schragen zurück.", label="Schragen",        zone="Nordhöhen", },
        FR={ name="Retournez à Pont-à-Tréteaux", label="Pont-à-Tréteaux", zone="Hauts du Nord", },
        map={{MapType.ERIADOR, 560, 285}},
        level=40.3
    })
    self.rep:AddSkill({
        id="0x70059D0E",
        EN={ name="Return to Trader's Wharf",        label="Trader's Wharf",     zone="Evendim", },
        DE={ name="Kehrt zum Händlerkai zurück.",    label="Händlerkai",         zone="Evendim", },
        FR={ name="Retournez au Quai des marchands", label="Quai des marchands", zone="Evendim", },
        map={{MapType.ERIADOR, 515, 275}},
        level=40.4
    })
    self.rep:AddSkill({
        id="0x7001F374",
        EN={ name="Return to Mirkwood",         label="Mirkwood",    detail="Ost Galadh",   zone="Mirkwood", },
        DE={ name="Rückkehr zum Düsterwald",    label="Düsterwald",  detail="Feste Galadh", zone="Düsterwald", },
        FR={ name="Retour dans la Forêt Noire", label="Forêt Noire", detail="Ost Galadh",   zone="Forêt Noire", },
        map={{MapType.RHOVANION, 335, 630}},
        level=61
    })
    self.rep:AddSkill({
        id="0x70021FA2",
        EN={ name="Return to Enedwaith",     label="Enedwaith", detail="Lhanuch", zone="Enedwaith", },
        DE={ name="Rückkehr nach Enedwaith", label="Enedwaith", detail="Lhanuch", zone="Enedwaith", },
        FR={ name="Retour en Enedwaith",     label="Enedwaith", detail="Lhanuch", zone="Enedwaith", },
        map={{MapType.ERIADOR, 765, 620}},
        level=62
    })
    self.rep:AddSkill({
        id="0x7002C647",
        EN={ name="Return to Galtrev",         label="Galtrev", zone="Dunland", },
        DE={ name="Kehrt nach Galtrev zurück", label="Galtrev", zone="Dunland", },
        FR={ name="Retour à Galtrev",          label="Galtrev", zone="Pays de Dun", },
        map={{MapType.ERIADOR, 780, 715}},
        level=65
    })
    self.rep:AddSkill({
        id="0x7002C65D",
        EN={ name="Return to Stangard",         label="Stangard",  zone="Great River", },
        DE={ name="Kehrt nach Stangard zurück", label="Stangard",  zone="Großer Fluss", },
        FR={ name="Retour à Stangarde",         label="Stangarde", zone="Grand Fleuve", },
        map={{MapType.RHOVANION, 170, 720}, {MapType.ROHAN, 515, 90}},
        level=75
    })
    self.rep:AddSkill({
        id="0x70031A46",
        EN={ name="Return to Snowbourn",            label="Snowbourn",    zone="East Rohan", },
        DE={ name="Kehrt nach Schneegrenze zurück", label="Schneegrenze", zone="Ost-Rohan", },
        FR={ name="Retourner à Neigebronne",        label="Neigebronne",  zone="Rohan est", },
        map={{MapType.ROHAN, 485, 500}},
        level=85
    })
    self.rep:AddSkill({
        id="0x70036B5E",
        EN={ name="Return to Forlaw",      label="Forlaw",  zone="Wildermore", },
        DE={ name="Rückkehr nach Forlach", label="Forlach", zone="Wildermark", },
        FR={ name="Retour à Forloi",       label="Forloi",  zone="Landes farouches", },
        map={{MapType.ROHAN, 480, 175}},
        level=85
    })
    self.rep:AddSkill({
        id="0x7003DC81",
        EN={ name="Return to Aldburg",         label="Aldburg", zone="West Rohan", },
        DE={ name="Kehrt nach Aldburg zurück", label="Aldburg", zone="West-Rohan", },
        FR={ name="Retour à Aldburg",          label="Aldburg", zone="Rohan de l'Ouest", },
        map={{MapType.ROHAN, 540, 640}},
        level=88
    })
    self.rep:AddSkill({
        id="0x7003DC82",
        EN={ name="Return to Helm's Deep",         label="Helm's Deep",     zone="West Rohan", },
        DE={ name="Kehrt nach Helms Klamm zurück", label="Helms Klamm",     zone="West-Rohan", },
        FR={ name="Retour au Gouffre de Helm",     label="Gouffre de Helm", zone="Rohan de l'Ouest", },
        map={{MapType.ROHAN, 245, 565}},
        level=90
    })
    self.rep:AddSkill({
        id="0x7004128F",
        EN={ name="Return to Derndingle",      label="Derndingle",   zone="West Rohan", },
        DE={ name="Rückkehr ins Geheimnistal", label="Geheimnistal", zone="West-Rohan", },
        FR={ name="Retour à Derunant",         label="Derunant",     zone="Rohan de l'Ouest", },
        map={{MapType.RHOVANION, 45, 720}, {MapType.ROHAN, 295, 275}},
        level=90.1
    })
    self.rep:AddSkill({
        id="0x700411AC",
        EN={ name="Return to Dol Amroth",     desc="in western Gondor",        label="Dol Amroth", zone="Western Gondor", },
        DE={ name="Rückkehr nach Dol Amroth", desc="West-Gondor zurückkehren", label="Dol Amroth", zone="West-Gondor", },
        FR={ name="Retour à Dol Amroth",      desc="l'Ouest du Gondor",        label="Dol Amroth", zone="Gondor de l'Ouest", },
        map={{MapType.GONDOR, 195, 550}},
        level=98
    })
    self.rep:AddSkill({
        id="0x70043A6A",
        EN={ name="Return to Arnach",     label="Arnach", zone="Eastern Gondor", },
        DE={ name="Rückkehr nach Arnach", label="Arnach", zone="Ost-Gondor", },
        FR={ name="Retournez à Arnach",   label="Arnach", zone="Gondor de l'Ouest", },
        map={{MapType.GONDOR, 685, 425}},
        level=100
    })
    self.rep:AddSkill({
        id="0x7004497E",
        EN={ name="Return to Minas Tirith",          label="Minas Tirith", zone="Old Anórien", },
        DE={ name="Kehrt nach Minas Tirith zurück.", label="Minas Tirith", zone="Alt-Anórien", },
        FR={ name="Retour à Minas Tirith",           label="Minas Tirith", zone="Ancien Anórien", },
        map={{MapType.GONDOR, 700, 345}},
        level=100.1
    })
    self.rep:AddSkill({
        id="0x700459A9",
        EN={ name="Return to the War-stead",             label="War-stead",                zone="Far Anórien", },
        DE={ name="Zurück zum Kriegslager der Rohirrim", label="Kriegslager der Rohirrim", zone="Fernes Anórien", },
        FR={ name="Retour au camp militaire",            label="Camp militaire",           zone="Lointain Anórien", },
        map={{MapType.GONDOR, 635, 140}},
        level=102
    })
    self.rep:AddSkill({
        id="0x70046CC0",
        EN={ name="Return to after-battle Minas Tirith",           label="Minas Tirith after-battle",      zone="Anórien", },
        DE={ name="Rückkehr ins schlachtgezeichnete Minas Tirith", label="Minas Tirith nach der Schlacht", zone="Anórien", },
        FR={ name="Retour à Minas Tirith après la bataille",       label="Minas Tirith après la bataille", zone="Anórien", },
        map={{MapType.GONDOR, 700, 375}},
        level=105
    })
    self.rep:AddSkill({
        id="0x7004707D",
        EN={ name="Return to after-battle Osgiliath",           label="Osgiliath after-battle",      zone="Anórien", },
        DE={ name="Rückkehr ins schlachtgezeichnete Osgiliath", label="Osgiliath nach der Schlacht", zone="Anórien", },
        FR={ name="Retour à Osgiliath après la bataille",       label="Osgiliath après la bataille", zone="Anórien", },
        map={{MapType.GONDOR, 825, 335}},
        level=105.1
    })
    self.rep:AddSkill({
        id="0x70047080",
        EN={ name="Return to Henneth Annûn",     label="Henneth Annûn", zone="Ithilien", },
        DE={ name="Rückkehr nach Henneth Annûn", label="Henneth Annûn", zone="Ithilien", },
        FR={ name="Retour à Henneth Annûn",      label="Henneth Annûn", zone="Ithilien", },
        map={{MapType.GONDOR, 845, 385}},
        level=105.2
    })
    self.rep:AddSkill({
        id="0x70047BF4",
        EN={ name="Return to the Camp of the Host", label="Camp of the Host", zone="The Wastes", },
        DE={ name="Rückkehr ins Lager des Heeres",  label="Lager des Heeres", zone="Das Ödland", },
        FR={ name="Retour au Camp de l'armée",      label="Camp de l'armée",  zone="Les Landes désertiques", },
        map={{MapType.GONDOR, 775, 170}},
        level=105.3
    })
    self.rep:AddSkill({
        id="0x70047C1B",
        EN={ name="Return to Haerondir",     label="Haerondir", zone="The Wastes", },
        DE={ name="Rückkehr nach Haerondir", label="Haerondir", zone="Das Ödland", },
        FR={ name="Retour à Haerondir",      label="Haerondir", zone="Les Landes désertiques", },
        map={{MapType.GONDOR, 825, 100}},
        level=105.4
    })
    self.rep:AddSkill({
        id="0x7004AE1D",
        EN={ name="Return to the Udûn Foothold", label="Udûn Foothold",    zone="Mordor", },
        DE={ name="Zurück zum Udûn-Brückenkopf", label="Udûn-Brückenkopf", zone="Mordor", },
        FR={ name="Retour au fort d'Udûn",       label="Fort d'Udûn",      zone="Mordor", },
        map={{MapType.GONDOR, 895, 230}},
        level=106
    })
    self.rep:AddSkill({
        id="0x7004B8C2",
        EN={ name="Journey to the Court of Lothlórien",    label="Court of Lothlórien", tag="Quest",   zone="Lothlórien", },
        DE={ name="Reise zum Hof von Lothlórien",          label="Hof von Lothlórien",  tag="Aufgabe", zone="Lothlórien", },
        FR={ name="Voyager jusqu'à la Cour de Lothlórien", label="Cour de Lothlórien",  tag="Quête",   zone="Lothlórien", },
        map={{MapType.RHOVANION, 140, 585}},
        level=110
    })
    self.rep:AddSkill({
        id="0x7004B8C3",
        EN={ name="Journey to the Hall of the King", label="Hall of the King", tag="Quest",   zone="Old Anórien", },
        DE={ name="Reise zur Halle des Königs",      label="Halle des Königs", tag="Aufgabe", zone="Alt-Anórien", },
        FR={ name="Voyager jusqu'au Palais du roi",  label="Palais du roi",    tag="Quête",   zone="Ancien Anórien", },
        map={{MapType.GONDOR, 740, 310}},
        level=110.1
    })
    self.rep:AddSkill({
        id="0x7004B8C4",
        EN={ name="Journey to the Hall Under the Mountain",   label="Hall Under the Mountain", tag="Quest",   zone="Ered Mithrin", },
        DE={ name="Reise zur Halle unter dem Berg",           label="Halle unter dem Berg",    tag="Aufgabe", zone="Ered Mithrin", },
        FR={ name="Voyager jusqu'au Palais sous la Montagne", label="Palais sous la Montagne", tag="Quête",   zone="Ered Mithrin", },
        map={{MapType.RHOVANION, 630, 115}},
        level=110.2
    })
    self.rep:AddSkill({
        id="0x7004B8C5",
        EN={ name="Journey to Bâr Thorenion",      label="Bâr Thorenion", tag="Quest",   zone="Ithilien", },
        DE={ name="Reise nach Bâr Thorenion",      label="Bâr Thorenion", tag="Aufgabe", zone="Ithilien", },
        FR={ name="Voyager jusqu'à Bâr Thorenion", label="Bâr Thorenion", tag="Quête",   zone="Ithilien", },
        map={{MapType.GONDOR, 965, 370}},
        level=110.3
    })
    self.rep:AddSkill({
        id="0x7004D738",
        EN={ name="Return to Dale",     label="Dale", zone="Eryn Lasgalen", },
        DE={ name="Rückkehr nach Thal", label="Thal", zone="Eryn Lasgalen", },
        FR={ name="Revenir à Dale",     label="Dale", zone="Eryn Lasgalen", },
        map={{MapType.RHOVANION, 690, 215}},
        level=115
    })
    self.rep:AddSkill({
        id="0x7004FAC3",
        EN={ name="Return to Járnfast",     label="Járnfast", zone="The Ironfold", },
        DE={ name="Rückkehr nach Járnfast", label="Járnfast", zone="Der Eisenbruch", },
        FR={ name="Revenir à Jarnfast",     label="Jarnfast", zone="La Crevasse de Fer", },
        map={{MapType.RHOVANION, 860, 110}},
        level=116
    })
    self.rep:AddSkill({
        id="0x7004FAC5",
        EN={ name="Return to Skarháld",          label="Skarháld", zone="Ered Mithrin", },
        DE={ name="Kehrt nach Skarháld zurück.", label="Skarháld", zone="Ered Mithrin", },
        FR={ name="Revenir à Skarhald",          label="Skarhald", zone="Ered Mithrin", },
        map={{MapType.RHOVANION, 400, 90}},
        level=117
    })
    self.rep:AddSkill({
        id="0x70052F12",
        EN={ name="Return to Beorninghús",           label="Beorninghús",   zone="Vales of Anduin", },
        DE={ name="Kehrt zum Beorningerhús zurück.", label="Beorningerhús", zone="Die Täler des Anduin", },
        FR={ name="Retournez auprès de Beorninghus", label="Beorninghus",   zone="Val d'Anduin", },
        map={{MapType.RHOVANION, 360, 300}},
        level=120
    })
    self.rep:AddSkill({
        id="0x70052F04",
        EN={ name="Return to Hultvís",           label="Hultvís", zone="Vales of Anduin", },
        DE={ name="Kehrt zum Hultvís zurück.",   label="Hultvís", zone="Die Täler des Anduin", },
        FR={ name="Retournez auprès de Hultvis", label="Hultvis", zone="Val d'Anduin", },
        map={{MapType.RHOVANION, 345, 400}},
        level=120.1
    })
    self.rep:AddSkill({
        id="0x700551F8",
        EN={ name="Return to Estolad Lân",   label="Estolad Lân", zone="Imlad Morgul", },
        DE={ name="Zurück nach Estolad Lân", label="Estolad Lân", zone="Imlad Morgul", },
        FR={ name="Retour à Estolad Lân",    label="Estolad Lân", zone="Imlad Morgul", },
        map={{MapType.GONDOR, 930, 460}},
        level=125
    })
    self.rep:AddSkill({
        id="0x70057629",
        EN={ name="Return to Limlók",     label="Limlók", zone="Wells of Langflood", },
        DE={ name="Rückkehr nach Limlók", label="Limlók", zone="Quellen des Langflut", },
        FR={ name="Retour à Limlok",      label="Limlok", zone="Puits du Long Fleuve", },
        map={{MapType.RHOVANION, 315, 230}},
        level=130
    })
    self.rep:AddSkill({
        id="0x7005856F",
        EN={ name="Return to Annâk-khurfu",     label="Annâk-khurfu", zone="Elderslade", },
        DE={ name="Rückkehr nach Annâk-khurfu", label="Annâk-khurfu", zone="Elderslade", },
        FR={ name="Retournez à Annâk-khurfu",   label="Annâk-khurfu", zone="Elderslade", },
        map={{MapType.RHOVANION, 500, 90}},
        level=130.1
    })
    self.rep:AddSkill({
        id="0x7005AA90",
        EN={ name="Return to Akrâz-zahar",     label="Akrâz-zahar", zone="Eryn Lasgalen", },
        DE={ name="Rückkehr nach Akrâz-zahar", label="Akrâz-zahar", zone="Eryn Lasgalen", },
        FR={ name="Retour à Akrâz-zahar",      label="Akrâz-zahar", zone="Eryn Lasgalen", },
        map={{MapType.RHOVANION, 720, 115}},
        level=130.2
    })
    self.rep:AddSkill({
        id="0x7005AA92",
        EN={ name="Return to Azanulbizar",      label="Azanulbizar", detail="Amdân", zone="Azanulbizar", },
        DE={ name="Rückkehre nach Azanulbizar", label="Azanulbizar", detail="Amdân", zone="Azanulbizar", },
        FR={ name="Retour à Azanulbizar",       label="Azanulbizar", detail="Amdân", zone="Azanulbizar", },
        map={{MapType.RHOVANION, 180, 555}},
        level=130.3
    })
    self.rep:AddSkill({
        id="0x7005D47C",
        EN={ name="Return to the Noble Gate",   label="Noble Gate",  zone="Gundabad", },
        DE={ name="Rückkehr zum Prachttor",     label="Prachttor",   zone="Gundabad", },
        FR={ name="Retourner à la Porte Noble", label="Porte Noble", zone="Gundabad", },
        map={{MapType.RHOVANION, 160, 130}},
        level=131
    })
    self.rep:AddSkill({
        id="0x7005D484",
        EN={ name="Return to Leitstáth",     label="Leitstáth", zone="Gundabad", },
        DE={ name="Rückkehr nach Leitstáth", label="Leitstáth", zone="Gundabad", },
        FR={ name="Retourner à Leitstath",   label="Leitstath", zone="Gundabad", },
        map={{MapType.RHOVANION, 240, 65}},
        level=135
    })
    self.rep:AddSkill({
        id="0x7005A596",
        EN={ name="Journey to the Hall of Vérnozal",            label="Vérnozal", tag="Quest",   zone="Gundabad", },
        DE={ name="Reise zur Halle Vérnozal",                   label="Vérnozal", tag="Aufgabe", zone="Gundabad", },
        FR={ name="Voyage jusqu'à la Grande salle de Vérnozal", label="Vérnozal", tag="Quête",   zone="Gundabad", },
        map={{MapType.RHOVANION, 155, 45}},
        level=140
    })
    self.rep:AddSkill({
        id="0x70064ACA",
        EN={ name="Return to Carn Dûm",     label="Carn Dûm", zone="Angmar", },
        DE={ name="Rückkehr nach Carn Dûm", label="Carn Dûm", zone="Angmar", },
        FR={ name="Retour à Carn Dûm",      label="Carn Dûm", zone="Angmar", },
        map={{MapType.ERIADOR, 705, 100}},
        level=140.1
    })
    self.rep:AddSkill({
        id="0x700658EB",
        EN={ name="Return to Pelargir",     label="Pelargir", zone="King's Gondor", },
        DE={ name="Rückkehr nach Pelargir", label="Pelargir", zone="Königreich Gondor", },
        FR={ name="Retournez à Pelargir",   label="Pelargir", zone="Gondor royal", },
        map={{MapType.GONDOR, 640, 625}},
        level=141
    })
    self.rep:AddSkill({
        id="0x70068700",
        EN={ name="Return to Dol Amroth",     desc="King's Gondor",     label="King's Dol Amroth",     zlabel="Dol Amroth", zone="King's Gondor", },
        DE={ name="Rückkehr nach Dol Amroth", desc="Königreich Gondor", label="Königreich Dol Amroth", zlabel="Dol Amroth", zone="Königreich Gondor", },
        FR={ name="Retour à Dol Amroth",      desc="le Gondor royal",   label="Dol Amroth royal",      zlabel="Dol Amroth", zone="Gondor royal", },
        map={{MapType.GONDOR, 180, 485}, {MapType.HARADWAITH, 355, 70}},
        level=142
    })
    self.rep:AddSkill({
        id="0x70068703",
        EN={ name="Return to Lond Cirion",         label="Lond Cirion", zone="Anfalas", },
        DE={ name="Nach Lond Cirion zurückkehren", label="Lond Cirion", zone="Anfalas", },
        FR={ name="Retour à Lond Cirion",          label="Lond Cirion", zone="Anfalas", },
        map={{MapType.GONDOR, 225, 420}, {MapType.HARADWAITH, 200, 20}},
        level=143
    })
    self.rep:AddSkill({
        id="0x70068702",
        EN={ name="Return to Halrax",        label="Halrax", zone="Shield Isles", },
        DE={ name="Kehrt zu Halrax zurück.", label="Halrax", zone="Die Schildinseln", },
        FR={ name="Retournez voir Halrax",   label="Halrax", zone="Les îles du Bouclier", },
        map={{MapType.HARADWAITH, 245, 260}},
        level=145
    })
    self.rep:AddSkill({
        id="0x70068701",
        EN={ name="Return to Jax Phanâl",         label="Jax Phanâl", zone="Umbar", },
        DE={ name="Nach Jax Phanâl zurückkehren", label="Jax Phanâl", zone="Umbar", },
        FR={ name="Retour à Jax Phanâl",          label="Jax Phanâl", zone="Umbar", },
        map={{MapType.HARADWAITH, 335, 315}},
        level=146
    })
    self.rep:AddSkill({
        id="0x7006A9C1",
        EN={ name="Return to Bej Mâghda",         label="Bej Mâghda", zone="Umbar", },
        DE={ name="Nach Bej Mâghda zurückkehren", label="Bej Mâghda", zone="Umbar", },
        FR={ name="Retour à Bej Mâghda",          label="Bej Mâghda", zone="Umbar", },
        map={{MapType.HARADWAITH, 380, 380}},
        level=147
    })
    self.rep:AddSkill({
        id="0x700686FF",
        EN={ name="Return to Umbar",         label="Umbar", detail="Baharbêl", zone="Umbar", },
        DE={ name="Nach Umbar zurückkehren", label="Umbar", detail="Baharbêl", zone="Umbar", },
        FR={ name="Retour à Umbar",          label="Umbar", detail="Baharbêl", zone="Umbar", },
        map={{MapType.HARADWAITH, 475, 370}},
        level=148
    })
    self.rep:AddSkill({
        id="0x700697F2",
        EN={ name="Return to the Bloody Eagle Tavern",           label="Bloody Eagle Tavern",         zone="Umbar", },
        DE={ name="Rückkehr zur Taverne \"Zum Blutigen Adler\"", label="Zum Blutigen Adler",          zone="Umbar", },
        FR={ name="Retour à la taverne de l'Aigle Sanglant",     label="Taverne de l'Aigle Sanglant", zone="Umbar", },
        map={{MapType.HARADWAITH, 445, 400}},
        level=149
    })
    self.rep:AddSkill({
        id="0x70068704",
        EN={ name="Journey to the Ledger-keepers",        label="Ledger-Keepers",      tag="Quest",   zone="Umbar", },
        DE={ name="Zu den Buchhütern reisen",             label="Ledger-Keepers",      tag="Aufgabe", zone="Umbar", },
        FR={ name="Voyager vers les Gardiens des écrits", label="Gardiens des écrits", tag="Quête",   zone="Umbar", },
        map={{MapType.HARADWAITH, 415, 340}},
        level=150
    })
    self.rep:AddSkill({
        id="0x700686FE",
        EN={ name="Journey to the Order of the Eagle", label="Order of the Eagle", tag="Quest",   zone="Umbar", },
        DE={ name="Zum Orden des Adlers reisen",       label="Orden des Adlers",   tag="Aufgabe", zone="Umbar", },
        FR={ name="Voyager vers l'Ordre de l'Aigle",   label="L'Ordre de l'Aigle", tag="Quête",   zone="Umbar", },
        map={{MapType.HARADWAITH, 415, 370}},
        level=150.1
    })
end

function TravelDictionary:CreateCreepDictionary()
    -- monster player maps
    self.creep:AddSkill({
        id="0x70028BBC",
        EN={ name="Return to Gramsfoot", },
        DE={ name="Rückkehr nach Gramfuß", },
        FR={ name="Retournez au Pied de Gram", },
        RU={ name="Возвращение к Подножию Грэм", },
        map={MapType.CREEPS, 180, 120},
        level=1
    })
    self.creep:AddSkill({
        id="0x70028BC1",
        EN={ name="Map to Gramsfoot", },
        DE={ name="Karte zum Gramfuss", },
        FR={ name="Carte pour aller au Pied de Gram", },
        RU={ name="Карта пути к Подножию Грэм", },
        map={MapType.CREEPS, 215, 120},
        hasSameText={"0x7002A7B9"},
        level=1
    })
    self.creep:AddSkill({
        id="0x7002A7B9",
        EN={ name="Map to Gramsfoot", },
        DE={ name="Karte zum Gramfuss", },
        FR={ name="Carte pour aller au Pied de Gram", },
        RU={ name="Карта пути к Подножию Грэм", },
        map={MapType.CREEPS, 245, 120},
        hasSameText={"0x70028BC1"},
        level=1
    })
    self.creep:AddSkill({
        id="0x70028BB3",
        EN={ name="Crude Map to Isendeep", },
        DE={ name="Kartenskizze zur Isenbinge", },
        FR={ name="Carte grossière pour aller au Gouffre d'Isen", },
        RU={ name="Грубая карта пути в Изендип", },
        map={MapType.CREEPS, 700, 200},
        level=1
    })
    self.creep:AddSkill({
        id="0x70028BB6",
        EN={ name="Crude Map to Tol Ascarnen", },
        DE={ name="Grobe Karte zur Feste Tol Ascarnen", },
        FR={ name="Carte grossière pour aller à Tol Ascarnen", },
        RU={ name="Грубая карта пути на Тол Аскарнен", },
        map={MapType.CREEPS, 350, 440},
        level=1
    })
    self.creep:AddSkill({
        id="0x70028BB7",
        EN={ name="Crude Map to Lugazag", },
        DE={ name="Kartenskizze zur Feste Lugazag", },
        FR={ name="Carte grossière pour aller à Lugazag", },
        RU={ name="Грубая карта пути в Лугазаг", },
        map={MapType.CREEPS, 180, 380},
        level=1
    })
    self.creep:AddSkill({
        id="0x70028BBE",
        EN={ name="Crude Map to Tirith Rhaw", },
        DE={ name="Grobe Karte zur Feste Tirith Rhaw", },
        FR={ name="Carte grossière pour aller à Tirith Rhaw", },
        RU={ name="Грубая карта пути в Тирит Роу", },
        map={MapType.CREEPS, 500, 295},
        level=1
    })
    self.creep:AddSkill({
        id="0x70028BBF",
        EN={ name="Crude Map to Grimwood", },
        DE={ name="Kartenskizze zum Grimmwald", },
        FR={ name="Carte grossière pour aller au Bois Funeste", },
        RU={ name="Грубая карта пути в Мрачный лес", },
        map={MapType.CREEPS, 340, 510},
        level=1
    })
    self.creep:AddSkill({
        id="0x70028BAF",
        EN={ name="Poor Map to Isendeep", },
        DE={ name="Minderwertige Karte zur Isenbinge", },
        FR={ name="Piètre carte pour aller au Gouffre d'Isen", },
        RU={ name="Неважная карта пути в Изендип", },
        map={MapType.CREEPS, 610, 300},
        level=1
    })
    self.creep:AddSkill({
        id="0x70028BB1",
        EN={ name="Poor Map to Tol Ascarnen", },
        DE={ name="Minderwertige Karte zur Feste Tol Ascarnen", },
        FR={ name="Piètre carte pour aller à Tol Ascarnen", },
        RU={ name="Неважная карта пути на Тол Аскарнен", },
        map={MapType.CREEPS, 435, 365},
        level=1
    })
    self.creep:AddSkill({
        id="0x70028BB2",
        EN={ name="Poor Map to Lugazag", },
        DE={ name="Minderwertige Karte zur Feste Lugazag", },
        FR={ name="Piètre carte pour aller à Lugazag", },
        RU={ name="Неважная карта пути в Лугазаг", },
        map={MapType.CREEPS, 180, 270},
        level=1
    })
    self.creep:AddSkill({
        id="0x70028BB4",
        EN={ name="Poor Map to Tirith Rhaw", },
        DE={ name="Minderwertige Karte zur Feste Tirith Rhaw", },
        FR={ name="Piètre carte pour aller à Tirith Rhaw", },
        RU={ name="Неважная карта пути в Тирит Роу", },
        map={MapType.CREEPS, 625, 365},
        level=1
    })
    self.creep:AddSkill({
        id="0x70028BB9",
        EN={ name="Poor Map to Grimwood", },
        DE={ name="Minderwertige Karte zum Grimmwald", },
        FR={ name="Piètre carte pour aller au Bois Funeste", },
        RU={ name="Неважная карта пути в Мрачный лес", },
        map={MapType.CREEPS, 380, 540},
        level=1
    })
    self.creep:AddSkill({
        id="0x70028BC0",
        EN={ name="Good Map to Isendeep", },
        DE={ name="Gute Karte zur Isenbinge", },
        FR={ name="Bonne carte pour aller au Gouffre d'Isen", },
        RU={ name="Хорошая карта пути в Изендип", },
        map={MapType.CREEPS, 310, 95},
        hasSameText={"0x7002A7B7"},
        level=1
    })
    self.creep:AddSkill({
        id="0x7002A7B7",
        EN={ name="Good Map to Isendeep", },
        DE={ name="Gute Karte zur Isenbinge", },
        FR={ name="Bonne carte pour aller au Gouffre d'Isen", },
        RU={ name="Хорошая карта пути в Изендип", },
        map={MapType.CREEPS, 340, 95},
        hasSameText={"0x70028BC0"},
        level=1
    })
    self.creep:AddSkill({
        id="0x70028BC2",
        EN={ name="Good Map to Tol Ascarnen", },
        DE={ name="Gute Karte zur Feste Tol Ascarnen", },
        FR={ name="Bonne carte pour aller à Tol Ascarnen", },
        RU={ name="Хорошая карта пути в Тол Аскарнен", },
        map={MapType.CREEPS, 375, 480},
        hasSameText={"0x7002A7B4"},
        level=1
    })
    self.creep:AddSkill({
        id="0x7002A7B4",
        EN={ name="Good Map to Tol Ascarnen", },
        DE={ name="Gute Karte zur Feste Tol Ascarnen", },
        FR={ name="Bonne carte pour aller à Tol Ascarnen", },
        RU={ name="Хорошая карта пути в Тол Аскарнен", },
        map={MapType.CREEPS, 405, 480},
        hasSameText={"0x70028BC2"},
        level=1
    })
    self.creep:AddSkill({
        id="0x70028BB5",
        EN={ name="Good Map to Lugazag", },
        DE={ name="Gute Karte zur Feste Lugazag", },
        FR={ name="Bonne carte pour aller à Lugazag", },
        RU={ name="Хорошая карта пути в Лугазаг", },
        map={MapType.CREEPS, 305, 275},
        hasSameText={"0x7002A7B6"},
        level=1
    })
    self.creep:AddSkill({
        id="0x7002A7B6",
        EN={ name="Good Map to Lugazag", },
        DE={ name="Gute Karte zur Feste Lugazag", },
        FR={ name="Bonne carte pour aller à Lugazag", },
        RU={ name="Хорошая карта пути в Лугазаг", },
        map={MapType.CREEPS, 335, 275},
        hasSameText={"0x70028BB5"},
        level=1
    })
    self.creep:AddSkill({
        id="0x70028BB0",
        EN={ name="Good Map to Tirith Rhaw", },
        DE={ name="Gute Karte zur Feste Tirith Rhaw", },
        FR={ name="Bonne carte pour aller à Tirith Rhaw", },
        RU={ name="Хорошая карта пути в Тирит Роу", },
        map={MapType.CREEPS, 555, 470},
        hasSameText={"0x7002A7B5"},
        level=1
    })
    self.creep:AddSkill({
        id="0x7002A7B5",
        EN={ name="Good Map to Tirith Rhaw", },
        DE={ name="Gute Karte zur Feste Tirith Rhaw", },
        FR={ name="Bonne carte pour aller à Tirith Rhaw", },
        RU={ name="Хорошая карта пути в Тирит Роу", },
        map={MapType.CREEPS, 585, 470},
        hasSameText={"0x70028BB0"},
        level=1
    })
    self.creep:AddSkill({
        id="0x70028BBD",
        EN={ name="Good Map to Grimwood", },
        DE={ name="Gute Karte zum Grimmwald", },
        FR={ name="Bonne carte pour aller au Bois Funeste", },
        RU={ name="Хорошая карта пути в Мрачный лес", },
        map={MapType.CREEPS, 445, 650},
        hasSameText={"0x7002A7B3"},
        level=1
    })
    self.creep:AddSkill({
        id="0x7002A7B3",
        EN={ name="Good Map to Grimwood", },
        DE={ name="Gute Karte zum Grimmwald", },
        FR={ name="Bonne carte pour aller au Bois Funeste", },
        RU={ name="Хорошая карта пути в Мрачный лес", },
        map={MapType.CREEPS, 475, 650},
        hasSameText={"0x70028BBD"},
        level=1
    })
end
