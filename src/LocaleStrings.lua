--[[ string constants ]] --
--[[ put all the strings that might require translation in ]] --
--[[ one location for easier access ]] --

import "Turbine";
import "Turbine.Gameplay";
import "Turbine.UI";
import "Turbine.UI.Lotro";

Turbine.Language.Russian = 0x10000007 -- removed in Update 22 and again in Update 34

-- Add detection for the Russian language client
Turbine.Engine._GetLanguage = Turbine.Engine.GetLanguage
function Turbine.Engine.GetLanguage()
    local language = Turbine.Engine._GetLanguage()
    if language == Turbine.Language.English then
        local russianAlphabet = "АаБбВвГгДдЕеЁёЖжЗзИиЙйКкЛлМмНнОоПпРрСсТтУуФфХхЦцЧчШшЩщЪъЫыЬьЭэЮюЯя" -- wide characters, 2 bytes each
        local skillName = Turbine.Gameplay.LocalPlayer:GetInstance():GetTrainedSkills():GetItem(1):GetSkillInfo():GetName()
        if russianAlphabet:match(skillName:sub(1, 2)) then
            return Turbine.Language.Russian
        end
    end
    return language
end

GLocale = Turbine.Engine.GetLanguage();

local Locale = {
    [Turbine.Language.English] = {},
    [Turbine.Language.German] = {},
    [Turbine.Language.French] = {},
    [Turbine.Language.Russian] = {}
}
LC = Locale[GLocale]
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
LC_FR.miniTitle = "Travel Window II"
LC_RU.miniTitle = "Travel Window II"

LC_EN.optionsTitle = "Travel Options"
LC_DE.optionsTitle = "Travel Einstellungen"
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
LC_DE.pulldownTravel = "Reisen wenn Fertigkeits-Pulldown selektiert"
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
LC_RU.repLabel = "Навыки за репутацию"

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
LC_DE.mainSliders = "Travel-Fenster Transparenz"
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

LC_EN.enableRepSkills = "Enable Overlapping"
LC_DE.enableRepSkills = "Alle Überlappenden Aktivieren"
LC_FR.enableRepSkills = "Activer le chevauchement"
LC_RU.enableRepSkills = "Разрешить дубликаты"

LC_EN.disableRepSkills = "Disable Overlapping"
LC_DE.disableRepSkills = "Alle Überlappenden Deaktivieren"
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
LC_DE.useZoneNames = "Verwenden von Zonen-Namen"
LC_FR.useZoneNames = "Utiliser les noms de zone"
LC_RU.useZoneNames = "Использовать название зон"

LC_EN.useSkillNames = "Use Skill names"
LC_DE.useSkillNames = "Verwenden von Skill-Namen"
LC_FR.useSkillNames = "Utiliser les noms de compétence"
LC_RU.useSkillNames = "Использовать названия навыков"

LC_EN.useTagInListTab = "Use Skill tag in Text layout"
LC_DE.useTagInListTab = "Verwenden von Skill-Tag im Textlayout"
LC_FR.useTagInListTab = "Utiliser la balise Skill dans la mise en page de texte"
LC_RU.useTagInListTab = "Использование тега навыка в макете текста"

LC_EN.unlockKeyPress = "Hold Shift to unlock"
LC_DE.unlockKeyPress = "Umschalttaste um zu entsperren gedrückt halten"
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
LC_DE.menuGen = "Zeige Generische Fertigkeiten"
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

LC_EN.acquired = "You have acquired the (.*) skill%."
LC_DE.acquired = "Ihr habt Euch die Fertigkeit (.*) angeeignet%."
LC_FR.acquired = "Vous avez acquis la compétence (.*)%."
LC_RU.acquired = "Вы приобрели умение <(.*)%>."

LC_EN.store = "LOTRO Store"
LC_DE.store = "LOTRO Shop"
LC_FR.store = "LOTRO Boutique"
LC_RU.store = "LOTRO Store"

LC_EN.quest = "Quest: "
LC_DE.quest = "Aufgabe: "
LC_FR.quest = "Quête: "
LC_RU.quest = "Задание: "

LC_EN.deed = "Deed: "
LC_DE.deed = "Tat: "
LC_FR.deed = "Acte: "
LC_RU.deed = "Деяние: "

LC_EN.source = "Source: "
LC_DE.source = "Quelle: "
LC_FR.source = "Source: "
LC_RU.source = "Источник: "

LC_EN.cost = "Cost: "
LC_DE.cost = "Kosten: "
LC_FR.cost = "Coût: "
LC_RU.cost = "Стоимость: "

LC_EN.requires = "Requires: "
LC_DE.requires = "Benötigt: "
LC_FR.requires = "Exige: "
LC_RU.requires = "Требуется: "

LC_EN.allegiance = "Allegiance: "
LC_DE.allegiance = "Bündnis: "
LC_FR.allegiance = "Allégeance: "
LC_RU.allegiance = "Альянс: "

LC_EN.rank = "Rank: "
LC_DE.rank = "Rang: "
LC_FR.rank = "Rang: "
LC_RU.rank = "Ранг: "

LC_EN.with = " with "
LC_DE.with = " bei "
LC_FR.with = " avec "
LC_RU.with = " с "

LC_EN.minLevel = "Minimum Level "
LC_DE.minLevel = "Mindeststufe "
LC_FR.minLevel = "Niveau minimum "
LC_RU.minLevel = "Минимальный уровень "

-- Verify matched locale keys
for lang, _ in pairs(Locale) do
    for k, _ in pairs(Locale[lang]) do
        for lang2, _ in pairs(Locale) do
            if lang2 ~= lang then
                if Locale[lang2][k] == nil then
                    Turbine.Shell.WriteLine("WARNING: Translation key missing: " .. k)
                    Locale[lang2][k] = ""
                elseif type(Locale[lang2][k]) == "table" then
                    for k2, _ in pairs(Locale[lang][k]) do
                        if Locale[lang2][k][k2] == nil then
                            Turbine.Shell.WriteLine("WARNING: Translation key missing: " .. k .. ":" .. k2)
                            Locale[lang2][k][k2] = ""
                        end
                    end
                end
            end
        end
    end
end
