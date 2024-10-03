--[[ string constants ]] --
--[[ put all the strings that might require translation in ]] --
--[[ one location for easier access ]] --

import "Turbine";
import "Turbine.Gameplay";
import "Turbine.UI";
import "Turbine.UI.Lotro";

Turbine.Language.Russian = 0x10000007; -- removed in Update 22 and again in Update 34

-- Add detection for the Russian language client
Turbine.Engine._GetLanguage = Turbine.Engine.GetLanguage;
function Turbine.Engine.GetLanguage()
    local language = Turbine.Engine._GetLanguage();
    if (language == Turbine.Language.English) then
        local russianAlphabet = "АаБбВвГгДдЕеЁёЖжЗзИиЙйКкЛлМмНнОоПпРрСсТтУуФфХхЦцЧчШшЩщЪъЫыЬьЭэЮюЯя"; -- wide characters, 2 bytes each
        local skillName = Turbine.Gameplay.LocalPlayer:GetInstance():GetTrainedSkills():GetItem(1):GetSkillInfo():GetName();
        if (russianAlphabet:match(skillName:sub(1, 2))) then
            return Turbine.Language.Russian;
        end
    end
    return language;
end

GLocale = Turbine.Engine.GetLanguage();

local Locale = {
    [Turbine.Language.English] = {},
    [Turbine.Language.German] = {},
    [Turbine.Language.French] = {},
    [Turbine.Language.Russian] = {}
}
LC = Locale[Turbine.Engine.GetLanguage()]
local LC_EN = Locale[Turbine.Language.English]
local LC_DE = Locale[Turbine.Language.German]
local LC_FR = Locale[Turbine.Language.French]
local LC_RU = Locale[Turbine.Language.Russian]


LC_EN.help = "Travel\n\ntrav show: Display the Travel Window\n" ..
"trav hide: Hides the Travel Window\n" ..
"trav toggle: Toggle the Travel Window\n"
LC_DE.help = "Travel\n\ntrav show: Zeigt das Travel-Fenster an\n" ..
"trav hide: Versteckt das Travel-Fenster\n" ..
"trav toggle: Schaltet das Travel-Fenster um\n"
LC_FR.help = "Travel\n\ntrav show: Afficher Travel Window\n" ..
"trav hide: Masquer Travel Window\n" ..
"trav toggle: Toggle the Travel Window\n"
LC_RU.help = "Travel\n\ntrav show: Показать Travel Window\n" ..
"trav hide: Спрятать Travel Window\n" ..
"trav toggle: Переключить показ Travel Window\n"

-- window title strings
LC_EN.mainTitle = "Travel"
LC_DE.mainTitle = "Travel"
LC_FR.mainTitle = "Travel"
LC_RU.mainTitle = "Travel"

LC_EN.mainShortTitle = "TW"
LC_DE.mainShortTitle = "TW"
LC_FR.mainShortTitle = "TW"
LC_RU.mainShortTitle = "TW"

LC_EN.miniTitle = "Travel Window II"
LC_DE.miniTitle = "Travel Window II"
LC_FR.MiniTitle = "Travel Window II"
LC_RU.miniTitle = "Travel Window II"

LC_EN.optionsTitle = "Travel Options"
LC_DE.optionsTitle = "Travel Optionen"
LC_FR.optionsTitle = "Options de Travel"
LC_RU.optionsTitle = "Настройки Travel"

LC_EN.skillNotTrained = "Skills not trained: "
LC_DE.skillNotTrained = "Nicht erlernte Fertigkeiten: "
LC_FR.skillNotTrained = "Compétences non utilisée: "
LC_RU.skillNotTrained = "Навыки не изучены: "

-- options window strings
LC_EN.generalTab = "General"
LC_DE.generalTab = "Allgemein"
LC_FR.generalTab = "Général"
LC_RU.generalTab = "Общие"

LC_EN.selectTab = "Enable"
LC_DE.selectTab = "Auswahl"
LC_FR.selectTab = "Sélection"
LC_RU.selectTab = "Включение в список"

LC_EN.sortTab = "Sort"
LC_DE.sortTab = "Sortierung"
LC_FR.sortTab = "Tri"
LC_RU.sortTab = "Сортировка"

LC_EN.hide = "Hide Travel window at startup"
LC_DE.hide = "Verstecke Travel-Fenster beim Start"
LC_FR.hide = "Cacher la fenêtre au démarrage"
LC_RU.hide = "Убрать окно Travel при старте"

LC_EN.toggle = "Show Travel Button"
LC_DE.toggle = "Zeige Travel-Knopf"
LC_FR.toggle = "Montrer le bouton Travel"
LC_RU.toggle = "Показать кнопку Travel"

LC_EN.findTab = "Find Skills"
LC_DE.findTab = "Fertigkeiten finden"
LC_FR.findTab = "Trouver des compétences"
LC_RU.findTab = "Поиск навыков"

LC_EN.hideOnStart = "Hide Travel Window at startup"
LC_DE.hideOnStart = "Verstecke Travel-Fenster beim Start"
LC_FR.hideOnStart = "Masquer Travel Window au début"
LC_RU.hideOnStart = "Убрать окно Travel при старте"

LC_EN.showButton = "Show Travel Button"
LC_DE.showButton = "Zeige Travel-Knopf"
LC_FR.showButton = "Montrer le bouton Travel"
LC_RU.showButton = "Показать кнопку Travel"

LC_EN.pulldownTravel = "Travel when pulldown skill selected"
LC_DE.pulldownTravel = "Reise wenn Fertigkeits-Pulldown selektiert"
LC_FR.pulldownTravel = "Voyager lorsque la compétence déroulante est sélectionnée"
LC_RU.pulldownTravel = "Travel when pulldown skill selected"

LC_EN.hideOnTravel = "Hide main window on travel"
LC_DE.hideOnTravel = "Verstecke Fenster bei Reise"
LC_FR.hideOnTravel = "Masquer Travel Window quand une compétence de voyage est utilisée"
LC_RU.hideOnTravel = "Убрать основное окно во время путешествия"

LC_EN.hideOnCombat = "Hide main window when entering combat"
LC_DE.hideOnCombat = "Verstecke Fenster bei Kampfbeginn"
LC_FR.hideOnCombat = "Cacher la fenêtre à l'entrée en combat"
LC_RU.hideOnCombat = "Убрать основное окно во время боя"

LC_EN.genericLabel = "Generic Skills"
LC_DE.genericLabel = "Allgemeine Fertigkeiten"
LC_FR.genericLabel = "Compétences générales"
LC_RU.genericLabel = "Общие навыки"

LC_EN.racialLabel = "Racial Skills"
LC_DE.racialLabel = "Rassenfertigkeiten"
LC_FR.racialLabel = "Compétences raciales"
LC_RU.racialLabel = "Расовые навыки"

LC_EN.classLabel = "Class Skills"
LC_DE.classLabel = "Klassenfertigkeiten"
LC_FR.classLabel = "Compétences de classe"
LC_RU.classLabel = "Классовые навыки"

LC_EN.repLabel = "Reputation Skills"
LC_DE.repLabel = "Ruffertigkeiten"
LC_FR.repLabel = "Compétences de réputation"
LC_RU.repLabel = "Репутационные навыки"

LC_EN.moveUp = "Move Up"
LC_DE.moveUp = "Hoch"
LC_FR.moveUp = "Vers le haut"
LC_RU.moveUp = "Вверх"

LC_EN.moveDown = "Move Down"
LC_DE.moveDown = "Runter"
LC_FR.moveDown = "Vers le bas"
LC_RU.moveDown = "Вниз"

LC_EN.moveUpChunk = "Move Up 10"
LC_DE.moveUpChunk = "Hoch um 10"
LC_FR.moveUpChunk = "Vers le haut 10"
LC_RU.moveUpChunk = "Вверх на 10"

LC_EN.moveDownChunk = "Move Down 10"
LC_DE.moveDownChunk = "Runter um 10"
LC_FR.moveDownChunk = "Vers le bas 10"
LC_RU.moveDownChunk = "Вниз на 10"

LC_EN.moveTop = "Move To Top"
LC_DE.moveTop = "Zum Anfang"
LC_FR.moveTop = "Tout en haut"
LC_RU.moveTop = "В начало списка"

LC_EN.moveBottom = "Move To Bottom"
LC_DE.moveBottom = "Zum Ende"
LC_FR.moveBottom = "Tout en bas"
LC_RU.moveBottom = "В конец списка"

LC_EN.toggleSliders = "Toggle Button Opacity"
LC_DE.toggleSliders = "Travel-Knopf Transparenz"
LC_FR.toggleSliders = "Modifier l'opacité du bouton"
LC_RU.toggleSliders = "Прозрачность кнопки"

LC_EN.mainSliders = "Main Window Opacity"
LC_DE.mainSliders = "Hauptfenster Transparenz"
LC_FR.mainSliders = "Modifier l'opacité de la fenêtre"
LC_RU.mainSliders = "Прозрачность основного окна"

LC_EN.min = "Min: "
LC_DE.min = "Min: "
LC_FR.min = "Min: "
LC_RU.min = "Мин: "

LC_EN.max = "Max: "
LC_DE.max = "Max: "
LC_FR.max = "Max: "
LC_RU.max = "Макс: "

LC_EN.resetSettings = "Reset to Defaults"
LC_DE.resetSettings = "Rücksetzen auf Standard"
LC_FR.resetSettings = "Remise a zéro"
LC_RU.resetSettings = "Сброс настроек"

LC_EN.saveGlobalDefaults = "Save Global Defaults"
LC_DE.saveGlobalDefaults = "Globale Standardwerte speichern"
LC_FR.saveGlobalDefaults = "Enregistrer par défaut globales"
LC_RU.saveGlobalDefaults = "Сохранить настройки"

LC_EN.loadGlobalDefaults = "Load Global Defaults"
LC_DE.loadGlobalDefaults = "Globale Standardwerte laden"
LC_FR.loadGlobalDefaults = "Charger par défaut globales"
LC_RU.loadGlobalDefaults = "Загрузить настройки"

LC_EN.defaultSort = "Reset to Default"
LC_DE.defaultSort = "Auf Standard zurücksetzen"
LC_FR.defaultSort = "Réinitialiser par défaut"
LC_RU.defaultSort = "Сброс"

LC_EN.sortName = "Sort by Name"
LC_DE.sortName = "Nach Namen sortieren"
LC_FR.sortName = "Trier par Nom"
LC_RU.sortName = "По имени"

LC_EN.sortLabel = "Sort by Label"
LC_DE.sortLabel = "Nach Label sortieren"
LC_FR.sortLabel = "Trier par étiquette"
LC_RU.sortLabel = "По метке"

LC_EN.sortLevel = "Sort by Level"
LC_DE.sortLevel = "Nach Level sortieren"
LC_FR.sortLevel = "Trier par niveau"
LC_RU.sortLevel = "По уровню"

LC_EN.checkSkills = "Check Untrained Skills"
LC_DE.checkSkills = "Nicht erlernte Fertigkeiten prüfen"
LC_FR.checkSkills = "Vérification des compétences non utilisées"
LC_RU.checkSkills = "Проверка доступности навыков"

LC_EN.enableRepSkills = "Enable Overlapping"
LC_DE.enableRepSkills = "Überlappende Aktivieren"
LC_FR.enableRepSkills = "Activer le chevauchement"
LC_RU.enableRepSkills = "Разрешить дубликаты"

LC_EN.disableRepSkills = "Disable Overlapping"
LC_DE.disableRepSkills = "Überlappende Deaktivieren"
LC_FR.disableRepSkills = "Désactiver le chevauchement"
LC_RU.disableRepSkills = "Убрать дубликаты"

LC_EN.enableAll = "Enable All"
LC_DE.enableAll = "Alle Aktivieren"
LC_FR.enableAll = "Activer tout"
LC_RU.enableAll = "Включить всё"

LC_EN.disableAll = "Disable All"
LC_DE.disableAll = "Alle Deaktivieren"
LC_FR.disableAll = "Désactiver tout"
LC_RU.disableAll = "Выключить всё"

LC_EN.lockUI = "Lock UI"
LC_DE.lockUI = "Benutzeroberfläche sperren"
LC_FR.lockUI = "Verrouiller l’interface utilisateur"
LC_RU.lockUI = "Зафиксировать интерфейс"

LC_EN.useZoneNames = "Use Zone names"
LC_DE.useZoneNames = "Verwenden von Zonennamen"
LC_FR.useZoneNames = "Utiliser les noms de zone"
LC_RU.useZoneNames = "Использовать название зон"

LC_EN.useSkillNames = "Use Skill names"
LC_DE.useSkillNames = "Verwenden von Skill-Namen"
LC_FR.useSkillNames = "Utiliser les noms de compétence"
LC_RU.useSkillNames = "Использовать названия навыков"

LC_EN.unlockKeyPress = "Hold Shift to unlock"
LC_DE.unlockKeyPress = "Halten Sie die Umschalttaste gedrückt, um zu entsperren"
LC_FR.unlockKeyPress = "Maintenez la touche Maj enfoncée pour déverrouiller"
LC_RU.unlockKeyPress = "Передвигать с нажатым Shift"

LC_EN.escapeToClose = "Escape closes main window"
LC_DE.escapeToClose = "Escape schliesst Travel-Fenster"
LC_FR.escapeToClose = "Escape fermer la fenêtre principale"
LC_RU.escapeToClose = "ESC закрывает главное окно"

LC_EN.useMinWindow = "Use Mini-Window"
LC_DE.useMinWindow = "Mini-Fenster verwenden"
LC_FR.useMinWindow = "Utiliser la mini-fenêtre"
LC_RU.useMinWindow = "Использовать мини-окно"

LC_EN.fadeOutSteps = "Fade Window Speed"
LC_DE.fadeOutSteps = "Geschwindigkeit des Fenster-Fadeouts"
LC_FR.fadeOutSteps = "Fondu de la vitesse de la fenêtre"
LC_RU.fadeOutSteps = "Fade Window Speed"

LC_EN.fadeOutDelay = "Fade Window Delay"
LC_DE.fadeOutDelay = "Verzögerung des Fenster-Fadeouts"
LC_FR.fadeOutDelay = "Délai de la fenêtre de fondu"
LC_RU.fadeOutDelay = "Fade Window Delay"

-- menu strings
LC_EN.menuFilters = "Filters"
LC_DE.menuFilters = "Filter"
LC_FR.menuFilters = "Filtres"
LC_RU.menuFilters = "Фильтры"

LC_EN.menuGen = "Show Generic Travels"
LC_DE.menuGen = "Zeige generische Fertigkeiten"
LC_FR.menuGen = "Voir les voyages génériques"
LC_RU.menuGen = "Показать общие путешествия"

LC_EN.menuRace = "Show Racial Travels"
LC_DE.menuRace = "Zeige Rassenfertigkeiten"
LC_FR.menuRace = "Voir les voyages raciaux"
LC_RU.menuRace = "Показать расовые путешествия"

LC_EN.menuRep = "Show Reputation Travels"
LC_DE.menuRep = "Zeige Ruffertigkeiten"
LC_FR.menuRep = "Voir les voyages de réputation"
LC_RU.menuRep = "Показать путешествия за репутацию"

LC_EN.menuClass = "Show Class Travels"
LC_DE.menuClass = "Zeige Klassenfertigkeiten"
LC_FR.menuClass = "Voir les voyages de classe"
LC_RU.menuClass = "Показать классовые путешествия"

LC_EN.menuMode = "Mode"
LC_DE.menuMode = "Modus"
LC_FR.menuMode = "Mode"
LC_RU.menuMode = "Режим"

LC_EN.menuText = "Text List"
LC_DE.menuText = "Liste"
LC_FR.menuText = "Liste de texte"
LC_RU.menuText = "Список текстом"

LC_EN.menuIcon = "Icon Grid"
LC_DE.menuIcon = "Icons"
LC_FR.menuIcon = "Grille d'icône"
LC_RU.menuIcon = "Сетка иконок"

LC_EN.menuCaro = "Carousel"
LC_DE.menuCaro = "Karussell"
LC_FR.menuCaro = "Caroussel"
LC_RU.menuCaro = "Карусель"

LC_EN.menuPull = "Pulldown List"
LC_DE.menuPull = "Pulldown-Liste"
LC_FR.menuPull = "Menu déroulant"
LC_RU.menuPull = "Выпадающий список"

LC_EN.mapWindow = "Maps"
LC_DE.mapWindow = "Karten"
LC_FR.mapWindow = "Destinations"
LC_RU.mapWindow = "Карты"

LC_EN.menuOptions = "Options"
LC_DE.menuOptions = "Optionen"
LC_FR.menuOptions = "Options"
LC_RU.menuOptions = "Настройки"

LC_EN.moorMap = "Open Moor Map"
LC_DE.moorMap = "Öffne Etten-Karte"
LC_FR.moorMap = "Destinations aux Landes d'Etten"
LC_RU.moorMap = "Открыть Moor Map"

LC_EN.eriadorMap = "Open Eriador Map"
LC_DE.eriadorMap = "Öffne Eriador-Karte"
LC_FR.eriadorMap = "Destinations en Eriador"
LC_RU.eriadorMap = "Открыть карту Эриадора"

LC_EN.rhovanionMap = "Open Rhovanion Map"
LC_DE.rhovanionMap = "Öffne Rhovanion-Karte"
LC_FR.rhovanionMap = "Destination dans le Rhovanion"
LC_RU.rhovanionMap = "Открыть карту Рованиона"

LC_EN.rohanMap = "Open Rohan Map"
LC_DE.rohanMap = "Öffne Rohan-Karte"
LC_FR.rohanMap = "Destinations dans le Rohan"
LC_RU.rohanMap = "Открыть карту Рохана"

LC_EN.gondorMap = "Open Gondor Map"
LC_DE.gondorMap = "Öffne Gondor-Karte"
LC_FR.gondorMap = "Destinations dans le Gondor"
LC_RU.gondorMap = "Открыть карту Гондора"

LC_EN.haradwaithMap = "Open Haradwaith Map"
LC_DE.haradwaithMap = "Öffne Haradwaith-Karte"
LC_FR.haradwaithMap = "Destinations dans le Haradwaith"
LC_RU.haradwaithMap = "Открыть карту Харадвайта"

LC_EN.menuSkills = "Check Untrained Skills"
LC_DE.menuSkills = "Nicht erlernte Fertigkeiten prüfen"
LC_FR.menuSkills = "Vérification des compétences non utilisées"
LC_RU.menuSkills = "Проверить доступность навыков"


LC_EN.acquired = "You have acquired the (.*) skill%."
LC_DE.acquired = "Ihr habt Euch die Fertigkeit (.*) angeeignet%."
LC_FR.acquired = "Vous avez acquis la compétence (.*)%."
LC_RU.acquired = "Вы приобрели навык (.*)%."

LC_EN.store = "LOTRO Store"
LC_DE.store = ""
LC_FR.store = ""
LC_RU.store = "LOTRO Store"

LC_EN.quest = "Quest: "
LC_DE.quest = ""
LC_FR.quest = ""
LC_RU.quest = "Задание: "

LC_EN.deed = "Deed: "
LC_DE.deed = ""
LC_FR.deed = ""
LC_RU.deed = "Деяние: "

LC_EN.source = "Source: "
LC_DE.source = ""
LC_FR.source = ""
LC_RU.source = "Источник: "

LC_EN.cost = "Cost: "
LC_DE.cost = ""
LC_FR.cost = ""
LC_RU.cost = "Стоимость: "

LC_EN.requires = "Requires: "
LC_DE.requires = ""
LC_FR.requires = ""
LC_RU.requires = "Требуется: "

LC_EN.allegiance = "Allegiance: "
LC_DE.allegiance = ""
LC_FR.allegiance = ""
LC_RU.allegiance = "Альянс: "

LC_EN.rank = "Rank: "
LC_DE.rank = ""
LC_FR.rank = ""
LC_RU.rank = "Ранг: "

LC_EN.with = " with "
LC_DE.with = ""
LC_FR.with = ""
LC_RU.with = " с "

LC_EN.minLevel = "Minimum Level "
LC_DE.minLevel = ""
LC_FR.minLevel = ""
LC_RU.minLevel = "Минимальный уровень "

-- Add reputation levels
LC_EN.repLevel = {}
LC_DE.repLevel = {}
LC_FR.repLevel = {}
LC_RU.repLevel = {}

LC_EN.repLevel.NEUTRAL = "Neutral"
LC_DE.repLevel.NEUTRAL = ""
LC_FR.repLevel.NEUTRAL = ""
LC_RU.repLevel.NEUTRAL = "Нейтральный"

LC_EN.repLevel.ACQUAINTANCE = "Acquaintance"
LC_DE.repLevel.ACQUAINTANCE = ""
LC_FR.repLevel.ACQUAINTANCE = ""
LC_RU.repLevel.ACQUAINTANCE = "Знакомый"

LC_EN.repLevel.DUMUL = "Dumul (Acquaintance)"
LC_DE.repLevel.DUMUL = ""
LC_FR.repLevel.DUMUL = ""
LC_RU.repLevel.DUMUL = "Думул (Знакомый)"

LC_EN.repLevel.FRIEND = "Friend"
LC_DE.repLevel.FRIEND = ""
LC_FR.repLevel.FRIEND = ""
LC_RU.repLevel.FRIEND = "Друг"

LC_EN.repLevel.KINDRED = "Kindred"
LC_DE.repLevel.KINDRED = ""
LC_FR.repLevel.KINDRED = ""
LC_RU.repLevel.KINDRED = "Родич"

LC_EN.repLevel.RESPECTED = "Respected"
LC_DE.repLevel.RESPECTED = ""
LC_FR.repLevel.RESPECTED = ""
LC_RU.repLevel.RESPECTED = "Уважаемый"

-- Add repuation names
LC_EN.rep = {}
LC_DE.rep = {}
LC_FR.rep = {}
LC_RU.rep = {}

LC_EN.rep.THORINS_HALL = "Thorin's Hall"
LC_DE.rep.THORINS_HALL = ""
LC_FR.rep.THORINS_HALL = ""
LC_RU.rep.THORINS_HALL = "Чертоги Торина"

LC_EN.rep.MEN_OF_BREE = "Men of Bree"
LC_DE.rep.MEN_OF_BREE = ""
LC_FR.rep.MEN_OF_BREE = ""
LC_RU.rep.MEN_OF_BREE = "Люди Бри"

LC_EN.rep.DUNEDAIN_OF_CARDOLAN = "Dúnedain of Cardolan"
LC_DE.rep.DUNEDAIN_OF_CARDOLAN = ""
LC_FR.rep.DUNEDAIN_OF_CARDOLAN = ""
LC_RU.rep.DUNEDAIN_OF_CARDOLAN = "Дунаданы Кардолана"

LC_EN.rep.YONDER_WATCH = "Yonder-watch"
LC_DE.rep.YONDER_WATCH = ""
LC_FR.rep.YONDER_WATCH = ""
LC_RU.rep.YONDER_WATCH = "Дозор Дальнего Шира"

LC_EN.rep.EGLAIN = "Eglain"
LC_DE.rep.EGLAIN = ""
LC_FR.rep.EGLAIN = ""
LC_RU.rep.EGLAIN = "Эгланы"

LC_EN.rep.DEFENDERS_OF_ANGLE = "Defenders of the Angle"
LC_DE.rep.DEFENDERS_OF_ANGLE = ""
LC_FR.rep.DEFENDERS_OF_ANGLE = ""
LC_RU.rep.DEFENDERS_OF_ANGLE = "Защитники Стрелки"

LC_EN.rep.ELVES_OF_RIVENDELL = "Elves of Rivendell"
LC_DE.rep.ELVES_OF_RIVENDELL = ""
LC_FR.rep.ELVES_OF_RIVENDELL = ""
LC_RU.rep.ELVES_OF_RIVENDELL = "Эльфы Ривенделла"

LC_EN.rep.WOODCUTTERS_BROTHERHOOD = "Woodcutter's Brotherhood"
LC_DE.rep.WOODCUTTERS_BROTHERHOOD = ""
LC_FR.rep.WOODCUTTERS_BROTHERHOOD = ""
LC_RU.rep.WOODCUTTERS_BROTHERHOOD = "Братство дровосеков"

LC_EN.rep.LEAGUE_OF_AXE = "The League of the Axe"
LC_DE.rep.LEAGUE_OF_AXE = ""
LC_FR.rep.LEAGUE_OF_AXE = ""
LC_RU.rep.LEAGUE_OF_AXE = "Лига топора"

LC_EN.rep.LOSSOTH_OF_FOROCHEL = "Lossoth of Forochel"
LC_DE.rep.LOSSOTH_OF_FOROCHEL = ""
LC_FR.rep.LOSSOTH_OF_FOROCHEL = ""
LC_RU.rep.LOSSOTH_OF_FOROCHEL = "Лоссоты Форохеля"

LC_EN.rep.IRON_GARRISON_MINERS = "Iron Garrison Miners"
LC_DE.rep.IRON_GARRISON_MINERS = ""
LC_FR.rep.IRON_GARRISON_MINERS = ""
LC_RU.rep.IRON_GARRISON_MINERS = "Рудокопы Железного Гарнизона"

LC_EN.rep.GALADHRIM = "Galadhrim"
LC_DE.rep.GALADHRIM = ""
LC_FR.rep.GALADHRIM = ""
LC_RU.rep.GALADHRIM = "Галадрим"

LC_EN.rep.MALLEDHRIM = "Malledhrim"
LC_DE.rep.MALLEDHRIM = ""
LC_FR.rep.MALLEDHRIM = ""
LC_RU.rep.MALLEDHRIM = "Малледрим"

LC_EN.rep.ALGRAIG = "Algraig, Men of Enedwaith"
LC_DE.rep.ALGRAIG = ""
LC_FR.rep.ALGRAIG = ""
LC_RU.rep.ALGRAIG = "Алграги, люди Энедвайта"

LC_EN.rep.GREY_COMPANY = "The Grey Company"
LC_DE.rep.GREY_COMPANY = ""
LC_FR.rep.GREY_COMPANY = ""
LC_RU.rep.GREY_COMPANY = "Серые плащи"

LC_EN.rep.MEN_OF_DUNLAND = "Men of Dunland"
LC_DE.rep.MEN_OF_DUNLAND = ""
LC_FR.rep.MEN_OF_DUNLAND = ""
LC_RU.rep.MEN_OF_DUNLAND = "Люди Дунланда"

LC_EN.rep.RIDERS_OF_STANGARD = "The Riders of Stangard"
LC_DE.rep.RIDERS_OF_STANGARD = ""
LC_FR.rep.RIDERS_OF_STANGARD = ""
LC_RU.rep.RIDERS_OF_STANGARD = "Всадники Стангарда"

LC_EN.rep.MEN_OF_SUTCROFTS = "Men of the Sutcrofts"
LC_DE.rep.MEN_OF_SUTCROFTS = ""
LC_FR.rep.MEN_OF_SUTCROFTS = ""
LC_RU.rep.MEN_OF_SUTCROFTS = "Жители Саткрофта"

LC_EN.rep.PEOPLE_OF_WILDERMORE = "People of Wildermore"
LC_DE.rep.PEOPLE_OF_WILDERMORE = ""
LC_FR.rep.PEOPLE_OF_WILDERMORE = ""
LC_RU.rep.PEOPLE_OF_WILDERMORE = "Жители Вилдермора"

LC_EN.rep.EORLINGAS = "The Eorlingas"
LC_DE.rep.EORLINGAS = ""
LC_FR.rep.EORLINGAS = ""
LC_RU.rep.EORLINGAS = "Эорлинги"

LC_EN.rep.HELMINGAS = "The Helmingas"
LC_DE.rep.HELMINGAS = ""
LC_FR.rep.HELMINGAS = ""
LC_RU.rep.HELMINGAS = "Хельминги"

LC_EN.rep.ENTS_OF_FANGORN = "The Ents of Fangorn Forest"
LC_DE.rep.ENTS_OF_FANGORN = ""
LC_FR.rep.ENTS_OF_FANGORN = ""
LC_RU.rep.ENTS_OF_FANGORN = "Энты леса Фангорн"

LC_EN.rep.DOL_AMROTH = "Dol Amroth"
LC_FR.rep.DOL_AMROTH = ""
LC_DE.rep.DOL_AMROTH = ""
LC_RU.rep.DOL_AMROTH = "Дол Амрот"

LC_EN.rep.RANGERS_OF_ITHILIEN = "Rangers of Ithilien"
LC_DE.rep.RANGERS_OF_ITHILIEN = ""
LC_FR.rep.RANGERS_OF_ITHILIEN = ""
LC_RU.rep.RANGERS_OF_ITHILIEN = "Следопыты Итилиена"

LC_EN.rep.DEFENDERS_OF_MINAS_TIRITH = "Defenders of Minas Tirith"
LC_DE.rep.DEFENDERS_OF_MINAS_TIRITH = ""
LC_FR.rep.DEFENDERS_OF_MINAS_TIRITH = ""
LC_RU.rep.DEFENDERS_OF_MINAS_TIRITH = "Защитники Минас Тирита"

LC_EN.rep.RIDERS_OF_ROHAN = "Riders of Rohan"
LC_DE.rep.RIDERS_OF_ROHAN = ""
LC_FR.rep.RIDERS_OF_ROHAN = ""
LC_RU.rep.RIDERS_OF_ROHAN = "Всадники Рохана"

LC_EN.rep.HOST_OF_WEST = "Host of the West"
LC_DE.rep.HOST_OF_WEST = ""
LC_FR.rep.HOST_OF_WEST = ""
LC_RU.rep.HOST_OF_WEST = "Воинство Запада"

LC_EN.rep.CONQUEST_OF_GORGOROTH = "Conquest of Gorgoroth"
LC_DE.rep.CONQUEST_OF_GORGOROTH = ""
LC_FR.rep.CONQUEST_OF_GORGOROTH = ""
LC_RU.rep.CONQUEST_OF_GORGOROTH = "Покорители Горгорота"

LC_EN.rep.MEN_OF_DALE = "Men of Dale"
LC_DE.rep.MEN_OF_DALE = ""
LC_FR.rep.MEN_OF_DALE = ""
LC_RU.rep.MEN_OF_DALE = "Люди Дейла"

LC_EN.rep.GREY_MOUNTAINS_EXPEDITION = "Grey Mountains Expedition"
LC_DE.rep.GREY_MOUNTAINS_EXPEDITION = ""
LC_FR.rep.GREY_MOUNTAINS_EXPEDITION = ""
LC_RU.rep.GREY_MOUNTAINS_EXPEDITION = "Экспедиция в Серые горы"

LC_EN.rep.WILDERFOLK = "Wilderfolk"
LC_DE.rep.WILDERFOLK = ""
LC_FR.rep.WILDERFOLK = ""
LC_RU.rep.WILDERFOLK = "Жители Глухоманья"

LC_EN.rep.WHITE_COMPANY = "The White Company"
LC_DE.rep.WHITE_COMPANY = ""
LC_FR.rep.WHITE_COMPANY = ""
LC_RU.rep.WHITE_COMPANY = "Белая дружина"

LC_EN.rep.PROTECTORS_OF_WILDERLAND = "Protectors of Wilderland"
LC_DE.rep.PROTECTORS_OF_WILDERLAND = ""
LC_FR.rep.PROTECTORS_OF_WILDERLAND = ""
LC_RU.rep.PROTECTORS_OF_WILDERLAND = "Защитники Глухоманья"

LC_EN.rep.KHARUM_UBNAR = "Kharum-ubnâr"
LC_DE.rep.KHARUM_UBNAR = ""
LC_FR.rep.KHARUM_UBNAR = ""
LC_RU.rep.KHARUM_UBNAR = "Кхарум-Убнар"

LC_EN.rep.HABANAKKA_OF_THRAIN = "The Haban'akkâ of Thráin"
LC_DE.rep.HABANAKKA_OF_THRAIN = ""
LC_FR.rep.HABANAKKA_OF_THRAIN = ""
LC_RU.rep.HABANAKKA_OF_THRAIN = "Хабан'акка Траина"

LC_EN.rep.RECLAIMERS_OF_MOUNTAINHOLD = "Reclaimers of the Mountain-hold"
LC_DE.rep.RECLAIMERS_OF_MOUNTAINHOLD = ""
LC_FR.rep.RECLAIMERS_OF_MOUNTAINHOLD = ""
LC_RU.rep.RECLAIMERS_OF_MOUNTAINHOLD = "Освободители Подгорной крепости"

LC_EN.rep.RENEWAL_OF_GONDOR = "The Renewal of Gondor"
LC_DE.rep.RENEWAL_OF_GONDOR = ""
LC_FR.rep.RENEWAL_OF_GONDOR = ""
LC_RU.rep.RENEWAL_OF_GONDOR = "Восстановленный Гондор"

LC_EN.rep.CITIZENS_OF_UMBAR_BAHARBEL = "Citizens of Umbar Baharbêl"
LC_DE.rep.CITIZENS_OF_UMBAR_BAHARBEL = ""
LC_FR.rep.CITIZENS_OF_UMBAR_BAHARBEL = ""
LC_RU.rep.CITIZENS_OF_UMBAR_BAHARBEL = "Жители Умбар-Бахарбеля"

-- Add token names
LC_EN.token = {}
LC_DE.token = {}
LC_FR.token = {}
LC_RU.token = {}

LC_EN.token.COPPER = "Copper"
LC_DE.token.COPPER = ""
LC_FR.token.COPPER = ""
LC_RU.token.COPPER = "Медь"

LC_EN.token.SILVER = "Silver"
LC_DE.token.SILVER = ""
LC_FR.token.SILVER = ""
LC_RU.token.SILVER = "Серебро"

LC_EN.token.GOLD = "Gold"
LC_DE.token.GOLD = ""
LC_FR.token.GOLD = ""
LC_RU.token.GOLD = "Золото"

LC_EN.token.LOTRO_POINT = "LOTRO Points"
LC_DE.token.LOTRO_POINT = ""
LC_FR.token.LOTRO_POINT = ""
LC_RU.token.LOTRO_POINT = "ВКО марки"

LC_EN.token.MITHRIL_COIN = "Mithril Coins"
LC_DE.token.MITHRIL_COIN = ""
LC_FR.token.MITHRIL_COIN = ""
LC_RU.token.MITHRIL_COIN = "Мифриловые монеты"

LC_EN.token.DELVING_WRIT = "Delving Writs"
LC_DE.token.DELVING_WRIT = ""
LC_FR.token.DELVING_WRIT = ""
LC_RU.token.DELVING_WRIT = "Письмена погружений"

LC_EN.token.COMMENDATION = "Commendations"
LC_DE.token.COMMENDATION = ""
LC_FR.token.COMMENDATION = ""
LC_RU.token.COMMENDATION = "Очки поощрения"

LC_EN.token.DOURHAND_CREST = "Dourhand Crests"
LC_DE.token.DOURHAND_CREST = ""
LC_FR.token.DOURHAND_CREST = ""
LC_RU.token.DOURHAND_CREST = "Эмблемы Крепкохватов"

LC_EN.token.BARROW_TREASURE = "Barrow-treasures"
LC_DE.token.BARROW_TREASURE = ""
LC_FR.token.BARROW_TREASURE = ""
LC_RU.token.BARROW_TREASURE = "Сокровища Могильников"

LC_EN.token.GREYFLOOD_MARK = "Greyflood Marks"
LC_DE.token.GREYFLOOD_MARK = ""
LC_FR.token.GREYFLOOD_MARK = ""
LC_RU.token.GREYFLOOD_MARK = "Марки Седой реки"

LC_EN.token.IRON_COIN_OF_CARDOLAN = "Iron Coins of Cardolan"
LC_DE.token.IRON_COIN_OF_CARDOLAN = ""
LC_FR.token.IRON_COIN_OF_CARDOLAN = ""
LC_RU.token.IRON_COIN_OF_CARDOLAN = "Железные монеты Кардолана"

LC_EN.token.COPPER_BOUNDER_COIN = "Copper Bounder's Coins"
LC_DE.token.COPPER_BOUNDER_COIN = ""
LC_FR.token.COPPER_BOUNDER_COIN = ""
LC_RU.token.COPPER_BOUNDER_COIN = "Медные монетки стражей"

LC_EN.token.MARK_OF_ANGLE = "Marks of the Angle"
LC_DE.token.MARK_OF_ANGLE = ""
LC_FR.token.MARK_OF_ANGLE = ""
LC_RU.token.MARK_OF_ANGLE = "Марки Митейтельской стрелки"

LC_EN.token.MARK_OF_WILDS = "Marks of the Wilds"
LC_DE.token.MARK_OF_WILDS = ""
LC_FR.token.MARK_OF_WILDS = ""
LC_RU.token.MARK_OF_WILDS = "Марки дебрей"

LC_EN.token.LOTHLORIEN_SILVER_BRANCH = "Lothlórien Silver Branches"
LC_DE.token.LOTHLORIEN_SILVER_BRANCH = ""
LC_FR.token.LOTHLORIEN_SILVER_BRANCH = ""
LC_RU.token.LOTHLORIEN_SILVER_BRANCH = "Лотлориэнские серебряные ветви"

LC_EN.token.MALLEDHRIM_BRONZE_FEATHER = "Malledhrim Bronze Feather"
LC_DE.token.MALLEDHRIM_BRONZE_FEATHER = ""
LC_FR.token.MALLEDHRIM_BRONZE_FEATHER = ""
LC_RU.token.MALLEDHRIM_BRONZE_FEATHER = "Малледримское бронзовое перо"
--
LC_EN.token.MALLEDHRIM_GOLD_STAR_EMBLEM = "Malledhrim Gold Star Emblems"
LC_DE.token.MALLEDHRIM_GOLD_STAR_EMBLEM = ""
LC_FR.token.MALLEDHRIM_GOLD_STAR_EMBLEM = ""
LC_RU.token.MALLEDHRIM_GOLD_STAR_EMBLEM = "Малледримские золотые звезды"

LC_EN.token.SILVER_TOKEN_OF_WILDS = "Silver Tokens of the Wilds"
LC_DE.token.SILVER_TOKEN_OF_WILDS = ""
LC_FR.token.SILVER_TOKEN_OF_WILDS = ""
LC_RU.token.SILVER_TOKEN_OF_WILDS = "Серебряные эмблемы Энедвайта"

LC_EN.token.GOLDEN_TOKEN_OF_WILDS = "Golden Tokens of the Wilds"
LC_DE.token.GOLDEN_TOKEN_OF_WILDS = ""
LC_FR.token.GOLDEN_TOKEN_OF_WILDS = ""
LC_RU.token.GOLDEN_TOKEN_OF_WILDS = "Золотые эмблемы Энедвайта"

LC_EN.token.SILVER_TOKEN_OF_ANDUIN = "Silver Tokens of the Anduin"
LC_DE.token.SILVER_TOKEN_OF_ANDUIN = ""
LC_FR.token.SILVER_TOKEN_OF_ANDUIN = ""
LC_RU.token.SILVER_TOKEN_OF_ANDUIN = "Серебряные жетоны Андуина["

LC_EN.token.GOLDEN_TOKEN_OF_ANDUIN = "Golden Tokens of the Anduin"
LC_DE.token.GOLDEN_TOKEN_OF_ANDUIN = ""
LC_FR.token.GOLDEN_TOKEN_OF_ANDUIN = ""
LC_RU.token.GOLDEN_TOKEN_OF_ANDUIN = "Золотые жетоны Андуина"

LC_EN.token.SILVER_TOKEN_OF_RIDDERMARK = "Silver Tokens of the Riddermark"
LC_DE.token.SILVER_TOKEN_OF_RIDDERMARK = ""
LC_FR.token.SILVER_TOKEN_OF_RIDDERMARK = ""
LC_RU.token.SILVER_TOKEN_OF_RIDDERMARK = "Серебряные эмблемы Риддермарка"

LC_EN.token.WILDERMORE_COIN = "Wildermore Coins"
LC_DE.token.WILDERMORE_COIN = ""
LC_FR.token.WILDERMORE_COIN = ""
LC_RU.token.WILDERMORE_COIN = "Монеты Вилдермора"

LC_EN.token.WESTEMNET_IRON_COIN = "Westemnet Iron Coins"
LC_DE.token.WESTEMNET_IRON_COIN = ""
LC_FR.token.WESTEMNET_IRON_COIN = ""
LC_RU.token.WESTEMNET_IRON_COIN = "Вестемнетские железные монеты"

LC_EN.token.FANGORN_LEAF = "Fangorn Leaves"
LC_DE.token.FANGORN_LEAF = ""
LC_FR.token.FANGORN_LEAF = ""
LC_RU.token.FANGORN_LEAF = "Фангорнские листья"

LC_EN.token.AMROTH_SILVER = "Amroth Silver Pieces"
LC_DE.token.AMROTH_SILVER = ""
LC_FR.token.AMROTH_SILVER = ""
LC_RU.token.AMROTH_SILVER = "Серебряные монеты Амрота"

LC_EN.token.EAST_GONDOR_SILVER = "East Gondor Silver Pieces"
LC_DE.token.EAST_GONDOR_SILVER = ""
LC_FR.token.EAST_GONDOR_SILVER = ""
LC_RU.token.EAST_GONDOR_SILVER = "Серебряные монеты Восточного Гондора"

LC_EN.token.MINAS_TIRITH_SILVER = "Minas Tirith Silver Pieces"
LC_DE.token.MINAS_TIRITH_SILVER = ""
LC_FR.token.MINAS_TIRITH_SILVER = ""
LC_RU.token.MINAS_TIRITH_SILVER = "Серебряные монеты Минас Тирита"

LC_EN.token.EXQUISITE_WOODCARVING = "Exquisite Wood-carvings"
LC_DE.token.EXQUISITE_WOODCARVING = ""
LC_FR.token.EXQUISITE_WOODCARVING = ""
LC_RU.token.EXQUISITE_WOODCARVING = "Изысканные резные фигурки"

LC_EN.token.POLISHED_MARBLE_TRINKET = "Polished Marble Trinkets"
LC_DE.token.POLISHED_MARBLE_TRINKET = ""
LC_FR.token.POLISHED_MARBLE_TRINKET = ""
LC_RU.token.POLISHED_MARBLE_TRINKET = "Полированная мраморная безделушка"

LC_EN.token.HOST_OF_WEST_SILVER = "Host of the West Silver Pieces"
LC_DE.token.HOST_OF_WEST_SILVER = ""
LC_FR.token.HOST_OF_WEST_SILVER = ""
LC_RU.token.HOST_OF_WEST_SILVER = "Серебряные монеты Воинства Запада"

LC_EN.token.SILVER_SIGNET_OF_THANDRIM = "Silver Signets of the Thandrim"
LC_DE.token.SILVER_SIGNET_OF_THANDRIM = ""
LC_FR.token.SILVER_SIGNET_OF_THANDRIM = ""
LC_RU.token.SILVER_SIGNET_OF_THANDRIM = "Серебряные печати тандримов"

LC_EN.token.TOKEN_OF_LAKE_AND_RIVERS = "Tokens of the Lake and Rivers"
LC_DE.token.TOKEN_OF_LAKE_AND_RIVERS = ""
LC_FR.token.TOKEN_OF_LAKE_AND_RIVERS = ""
LC_RU.token.TOKEN_OF_LAKE_AND_RIVERS = "Жетоны Озера и Рек"

LC_EN.token.MARK_OF_LONGBEARDS = "Mark of the Longbeards"
LC_DE.token.MARK_OF_LONGBEARDS = ""
LC_FR.token.MARK_OF_LONGBEARDS = ""
LC_RU.token.MARK_OF_LONGBEARDS = "Печать Длиннобородов"

LC_EN.token.GULMARK = "Gúlmark"
LC_DE.token.GULMARK = ""
LC_FR.token.GULMARK = ""
LC_RU.token.GULMARK = "Гулмарка"

LC_EN.token.VALES_BEORNING_TOKEN = "Vales - Beorning Token"
LC_DE.token.VALES_BEORNING_TOKEN = ""
LC_FR.token.VALES_BEORNING_TOKEN = ""
LC_RU.token.VALES_BEORNING_TOKEN = "Долина - жетон беорнингов"

LC_EN.token.SIGIL_IMLAD_ITHIL = "Sigil of Imlad Ithil"
LC_DE.token.SIGIL_IMLAD_ITHIL = ""
LC_FR.token.SIGIL_IMLAD_ITHIL = ""
LC_RU.token.SIGIL_IMLAD_ITHIL = "Печать Имлад Итиля"

LC_EN.token.NORTHERN_GULMARK = "Northern Gúlmark"
LC_DE.token.NORTHERN_GULMARK = ""
LC_FR.token.NORTHERN_GULMARK = ""
LC_RU.token.NORTHERN_GULMARK = "Северная гулмарка"

LC_EN.token.COPPER_COIN_OF_GUNDABAD = "Copper Coins of Gundabad"
LC_DE.token.COPPER_COIN_OF_GUNDABAD = ""
LC_FR.token.COPPER_COIN_OF_GUNDABAD = ""
LC_RU.token.COPPER_COIN_OF_GUNDABAD = "Медные монеты Гундабада"

LC_EN.token.TOKEN_OF_KHARUM_UBNAR = "Tokens of the Kharum-ubnâr"
LC_DE.token.TOKEN_OF_KHARUM_UBNAR = ""
LC_FR.token.TOKEN_OF_KHARUM_UBNAR = ""
LC_RU.token.TOKEN_OF_KHARUM_UBNAR = "Жетоны Кхарум-Убнар"

LC_EN.token.LEDGER_KEEPER_MARK = "Ledger-keeper Marks"
LC_DE.token.LEDGER_KEEPER_MARK = ""
LC_FR.token.LEDGER_KEEPER_MARK = ""
LC_RU.token.LEDGER_KEEPER_MARK = "Марки Хранителей книг"

LC_EN.token.EAGLE_BIT = "Eagle Bits"
LC_DE.token.EAGLE_BIT = ""
LC_FR.token.EAGLE_BIT = ""
LC_RU.token.EAGLE_BIT = "Орлиные монеты"

LC_EN.token.ZAKAF_BESHEK = "Zakaf-beshêk"
LC_DE.token.ZAKAF_BESHEK = ""
LC_FR.token.ZAKAF_BESHEK = ""
LC_RU.token.ZAKAF_BESHEK = "Закаф-Бешек"

LC_EN.token.SILVER_COIN_OF_GUNDABAD = "Silver Coins of Gundabad"
LC_DE.token.SILVER_COIN_OF_GUNDABAD = ""
LC_FR.token.SILVER_COIN_OF_GUNDABAD = ""
LC_RU.token.SILVER_COIN_OF_GUNDABAD = "Серебряные монеты Гундабада"

LC_EN.token.SARSKILLINAN = "Sárskilinnan"
LC_DE.token.SARSKILLINAN = ""
LC_FR.token.SARSKILLINAN = ""
LC_RU.token.SARSKILLINAN = "Сарскиллины"

LC_EN.token.MARK_OF_RENEWAL = "Marks of Renewal"
LC_DE.token.MARK_OF_RENEWAL = ""
LC_FR.token.MARK_OF_RENEWAL = ""
LC_RU.token.MARK_OF_RENEWAL = "Марки восстановления"

LC_EN.token.UMBARI_TAM = "Umbari Tâm"
LC_DE.token.UMBARI_TAM = ""
LC_FR.token.UMBARI_TAM = ""
LC_RU.token.UMBARI_TAM = "Умбарский там"
