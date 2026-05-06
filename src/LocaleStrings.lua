--[[ string constants ]] --
--[[ put all the strings that might require translation in ]] --
--[[ one location for easier access ]] --

import "Turbine";
import "Turbine.Gameplay";
import "Turbine.UI";
import "Turbine.UI.Lotro";

Turbine.Language.Russian = 0x10000007 -- officially removed in Update 22 and again in Update 34
Turbine.Language.Spanish = 0x10000008 -- fabricated

function Turbine.Engine.GetLanguage()
    local language = ({
        ["Mushroom"] = Turbine.Language.English,
        ["Pilz"] = Turbine.Language.German,
        ["Champignon"] = Turbine.Language.French,
        ["Hongo"] = Turbine.Language.Spanish,
        ["Гриб"] = Turbine.Language.Russian,
        })[Turbine.UI.Lotro.Shortcut(Turbine.UI.Lotro.ShortcutType.Item,
            "0x0,0x700005C5"):GetItem():GetItemInfo():GetName()] or Turbine.Language.English
    return language
end

GLocale = Turbine.Engine.GetLanguage()

local Locale = {
    [Turbine.Language.English] = {},
    [Turbine.Language.German] = {},
    [Turbine.Language.French] = {},
    [Turbine.Language.Spanish] = {},
    [Turbine.Language.Russian] = {}
}
LC = Locale[GLocale]
local LC_EN = Locale[Turbine.Language.English]
local LC_DE = Locale[Turbine.Language.German]
local LC_FR = Locale[Turbine.Language.French]
local LC_ES = Locale[Turbine.Language.Spanish]
local LC_RU = Locale[Turbine.Language.Russian]


LC_EN.help = "Travel\n\ntrav show: Display the Travel Window\n" ..
"trav hide: Hides the Travel Window\n" ..
"trav toggle: Toggle the Travel Window\n" ..
"trav update: Show the update notification window\n"
LC_DE.help = "Travel\n\ntrav show: Zeigt das Travel-Fenster an\n" ..
"trav hide: Versteckt das Travel-Fenster\n" ..
"trav toggle: Schaltet das Travel-Fenster um\n" ..
"trav update: Update-Fenster anzeigen\n"
LC_FR.help = "Travel\n\ntrav show: Afficher Travel Window\n" ..
"trav hide: Masquer Travel Window\n" ..
"trav toggle: Toggle the Travel Window\n" ..
"trav update: Afficher la fenêtre de actualisation\n"
LC_ES.help = "Travel\n\ntrav show: Mostrar la Ventana de Viaje\n" ..
"trav hide: Ocultar la Ventana de Viaje\n" ..
"trav toggle: Alternar la Ventana de Viaje\n" ..
"trav update: Mostrar la ventana de notificación de actualización\n"
LC_RU.help = "Travel\n\ntrav show: Показать Travel Window\n" ..
"trav hide: Спрятать Travel Window\n" ..
"trav toggle: Переключить показ Travel Window\n" ..
"trav update: Показать окно Обновление\n"

-- window title strings
LC_EN.mainTitle = "Travel"
LC_DE.mainTitle = "Travel"
LC_FR.mainTitle = "Travel"
LC_ES.mainTitle = "Travel"
LC_RU.mainTitle = "Travel"

LC_EN.mainShortTitle = "TW"
LC_DE.mainShortTitle = "TW"
LC_FR.mainShortTitle = "TW"
LC_ES.mainShortTitle = "TW"
LC_RU.mainShortTitle = "TW"

LC_EN.miniTitle = "Travel Window II"
LC_DE.miniTitle = "Travel Window II"
LC_FR.miniTitle = "Travel Window II"
LC_ES.miniTitle = "Travel Window II"
LC_RU.miniTitle = "Travel Window II"

LC_EN.optionsTitle = "Travel Options"
LC_DE.optionsTitle = "Travel Einstellungen"
LC_FR.optionsTitle = "Options de Travel"
LC_ES.optionsTitle = "Opciones de Viaje"
LC_RU.optionsTitle = "Настройки Travel"

LC_EN.skillNotTrained = "Skills not trained: "
LC_DE.skillNotTrained = "Nicht erlernte Fertigkeiten: "
LC_FR.skillNotTrained = "Compétences non utilisée: "
LC_ES.skillNotTrained = "Habilidades no aprendidas: "
LC_RU.skillNotTrained = "Навыки не изучены: "

-- options window strings
LC_EN.generalTab = "General"
LC_DE.generalTab = "Allgemein"
LC_FR.generalTab = "Général"
LC_ES.generalTab = "General"
LC_RU.generalTab = "Общие"

LC_EN.selectTab = "Enable"
LC_DE.selectTab = "Auswahl"
LC_FR.selectTab = "Sélection"
LC_ES.selectTab = "Habilitar"
LC_RU.selectTab = "Включение в список"

LC_EN.sortTab = "Sort"
LC_DE.sortTab = "Sortierung"
LC_FR.sortTab = "Tri"
LC_ES.sortTab = "Ordenar"
LC_RU.sortTab = "Сортировка"

LC_EN.hide = "Hide Travel Window at startup"
LC_DE.hide = "Verstecke Travel-Fenster beim Start"
LC_FR.hide = "Cacher Travel Window au démarrage"
LC_ES.hide = "Ocultar la Ventana de Viaje al inicio"
LC_RU.hide = "Убрать Travel Window при старте"

LC_EN.findTab = "Find Skills"
LC_DE.findTab = "Fertigkeiten finden"
LC_FR.findTab = "Trouver des compétences"
LC_ES.findTab = "Buscar Habilidades"
LC_RU.findTab = "Поиск навыков"

LC_EN.hideOnStart = "Hide Travel Window at startup"
LC_DE.hideOnStart = "Verstecke Travel-Fenster beim Start"
LC_FR.hideOnStart = "Masquer Travel Window au début"
LC_ES.hideOnStart = "Ocultar la Ventana de Viaje al inicio"
LC_RU.hideOnStart = "Убрать окно Travel при старте"

LC_EN.showButton = "Show Travel Button"
LC_DE.showButton = "Zeige Travel-Knopf"
LC_FR.showButton = "Montrer le bouton Travel"
LC_ES.showButton = "Mostrar el Botón de Viaje"
LC_RU.showButton = "Показать кнопку Travel"

LC_EN.buttonIcon = "Travel Button Icon"
LC_DE.buttonIcon = "Icon des Travel-Knopfs"
LC_FR.buttonIcon = "Icone du bouton Travel"
LC_ES.buttonIcon = "Icono del Botón de Viaje"
LC_RU.buttonIcon = "Travel Button icon"

LC_EN.buttonSize = "Travel Button size"
LC_DE.buttonSize = "Groesse des Travel-Knopfs"
LC_FR.buttonSize = "Taille du bouton Travel"
LC_ES.buttonSize = "Tamaño del Botón de Viaje"
LC_RU.buttonSize = "Travel Button size"

LC_EN.buttonSize100 = "100%"
LC_DE.buttonSize100 = "100%"
LC_FR.buttonSize100 = "100%"
LC_ES.buttonSize100 = "100%"
LC_RU.buttonSize100 = "100%"

LC_EN.buttonSize150 = "150%"
LC_DE.buttonSize150 = "150%"
LC_FR.buttonSize150 = "150%"
LC_ES.buttonSize150 = "150%"
LC_RU.buttonSize150 = "150%"

LC_EN.buttonSize200 = "200%"
LC_DE.buttonSize200 = "200%"
LC_FR.buttonSize200 = "200%"
LC_ES.buttonSize200 = "200%"
LC_RU.buttonSize200 = "200%"

LC_EN.buttonIconDefault = "Default"
LC_DE.buttonIconDefault = "Standard"
LC_FR.buttonIconDefault = "Defaut"
LC_ES.buttonIconDefault = "Por defecto"
LC_RU.buttonIconDefault = "По умолчанию"

LC_EN.buttonIconBoots = "Boots"
LC_DE.buttonIconBoots = "Stiefel"
LC_FR.buttonIconBoots = "Bottes"
LC_ES.buttonIconBoots = "Botas"
LC_RU.buttonIconBoots = "Ботинки"

LC_EN.buttonIconBackpack = "Backpack"
LC_DE.buttonIconBackpack = "Rucksack"
LC_FR.buttonIconBackpack = "Sac"
LC_ES.buttonIconBackpack = "Mochila"
LC_RU.buttonIconBackpack = "Рюкзак"

LC_EN.buttonIconHorse = "Horse"
LC_DE.buttonIconHorse = "Pferd"
LC_FR.buttonIconHorse = "Cheval"
LC_ES.buttonIconHorse = "Caballo"
LC_RU.buttonIconHorse = "Лошадь"

LC_EN.hideSkill = "Hide skill"
LC_DE.hideSkill = "Versteck-Fähigkeit"
LC_FR.hideSkill = "Compétence de dissimulation"
LC_ES.hideSkill = "Esconder Habilidad"
LC_RU.hideSkill = "Навык скрытия"

LC_EN.pulldownTravel = "Travel when pulldown skill selected"
LC_DE.pulldownTravel = "Reisen wenn Fertigkeits-Pulldown selektiert"
LC_FR.pulldownTravel = "Voyager lorsque la compétence déroulante est sélectionnée"
LC_ES.pulldownTravel = "Viajar al seleccionar habilidad en el menú desplegable"
LC_RU.pulldownTravel = "Путешествуйте по выбранному навыку"

LC_EN.hideOnTravel = "Hide main window on travel"
LC_DE.hideOnTravel = "Verstecke Fenster bei Reise"
LC_FR.hideOnTravel = "Masquer la fenêtre quand une compétence est utilisée"
LC_ES.hideOnTravel = "Ocultar ventana principal al viajar"
LC_RU.hideOnTravel = "Убрать основное окно во время путешествия"

LC_EN.hideOnCombat = "Hide main window when entering combat"
LC_DE.hideOnCombat = "Verstecke Fenster bei Kampfbeginn"
LC_FR.hideOnCombat = "Masquer la fenêtre à l'entrée en combat"
LC_ES.hideOnCombat = "Ocultar ventana principal al entrar en combate"
LC_RU.hideOnCombat = "Убрать основное окно во время боя"

LC_EN.genericLabel = "Generic Skills"
LC_DE.genericLabel = "Allgemeine Fertigkeiten"
LC_FR.genericLabel = "Compétences générales"
LC_ES.genericLabel = "Habilidades Genéricas"
LC_RU.genericLabel = "Общие навыки"

LC_EN.racialLabel = "Racial Skills"
LC_DE.racialLabel = "Rassenfertigkeiten"
LC_FR.racialLabel = "Compétences raciales"
LC_ES.racialLabel = "Habilidades Raciales"
LC_RU.racialLabel = "Расовые навыки"

LC_EN.classLabel = "Class Skills"
LC_DE.classLabel = "Klassenfertigkeiten"
LC_FR.classLabel = "Compétences de classe"
LC_ES.classLabel = "Habilidades de Clase"
LC_RU.classLabel = "Классовые навыки"

LC_EN.repLabel = "Reputation Skills"
LC_DE.repLabel = "Ruffertigkeiten"
LC_FR.repLabel = "Compétences de réputation"
LC_ES.repLabel = "Habilidades de Reputación"
LC_RU.repLabel = "Навыки за репутацию"

LC_EN.moveUp = "Move Up"
LC_DE.moveUp = "Hoch"
LC_FR.moveUp = "Vers le haut"
LC_ES.moveUp = "Mover Arriba"
LC_RU.moveUp = "Вверх"

LC_EN.moveDown = "Move Down"
LC_DE.moveDown = "Runter"
LC_FR.moveDown = "Vers le bas"
LC_ES.moveDown = "Mover Abajo"
LC_RU.moveDown = "Вниз"

LC_EN.moveUpChunk = "Move Up 10"
LC_DE.moveUpChunk = "Hoch um 10"
LC_FR.moveUpChunk = "Vers le haut 10"
LC_ES.moveUpChunk = "Mover Arriba 10"
LC_RU.moveUpChunk = "Вверх на 10"

LC_EN.moveDownChunk = "Move Down 10"
LC_DE.moveDownChunk = "Runter um 10"
LC_FR.moveDownChunk = "Vers le bas 10"
LC_ES.moveDownChunk = "Mover Abajo 10"
LC_RU.moveDownChunk = "Вниз на 10"

LC_EN.moveTop = "Move To Top"
LC_DE.moveTop = "Zum Anfang"
LC_FR.moveTop = "Tout en haut"
LC_ES.moveTop = "Mover al Principio"
LC_RU.moveTop = "В начало списка"

LC_EN.moveBottom = "Move To Bottom"
LC_DE.moveBottom = "Zum Ende"
LC_FR.moveBottom = "Tout en bas"
LC_ES.moveBottom = "Mover al Final"
LC_RU.moveBottom = "В конец списка"

LC_EN.toggleSliders = "Travel Button Opacity"
LC_DE.toggleSliders = "Travel-Knopf Transparenz"
LC_FR.toggleSliders = "Modifier l'opacité du bouton Travel"
LC_ES.toggleSliders = "Opacidad del Botón de Viaje"
LC_RU.toggleSliders = "Прозрачность кнопки"

LC_EN.mainSliders = "Travel Window Opacity"
LC_DE.mainSliders = "Travel-Fenster Transparenz"
LC_FR.mainSliders = "Modifier l'opacité de Travel Window"
LC_ES.mainSliders = "Opacidad de la Ventana de Viaje"
LC_RU.mainSliders = "Прозрачность основного Travel Window"

LC_EN.min = "Min: "
LC_DE.min = "Min: "
LC_FR.min = "Min: "
LC_ES.min = "Mín: "
LC_RU.min = "Мин: "

LC_EN.max = "Max: "
LC_DE.max = "Max: "
LC_FR.max = "Max: "
LC_ES.max = "Máx: "
LC_RU.max = "Макс: "

LC_EN.resetSettings = "Reset to Default"
LC_DE.resetSettings = "Rücksetzen auf Standard"
LC_FR.resetSettings = "Réinitialiser par défaut"
LC_ES.resetSettings = "Restablecer a por defecto"
LC_RU.resetSettings = "Сброс настроек"

LC_EN.saveGlobalDefaults = "Save Global Defaults"
LC_DE.saveGlobalDefaults = "Globale Standardwerte speichern"
LC_FR.saveGlobalDefaults = "Enregistrer par défaut globales"
LC_ES.saveGlobalDefaults = "Guardar valores por defecto globales"
LC_RU.saveGlobalDefaults = "Сохранить настройки"

LC_EN.loadGlobalDefaults = "Load Global Defaults"
LC_DE.loadGlobalDefaults = "Globale Standardwerte laden"
LC_FR.loadGlobalDefaults = "Charger par défaut globales"
LC_ES.loadGlobalDefaults = "Cargar valores por defecto globales"
LC_RU.loadGlobalDefaults = "Загрузить настройки"

LC_EN.defaultSort = "Reset to Default"
LC_DE.defaultSort = "Rücksetzen auf Standard"
LC_FR.defaultSort = "Réinitialiser par défaut"
LC_ES.defaultSort = "Restablecer a por defecto"
LC_RU.defaultSort = "Сброс"

LC_EN.sortName = "Sort by Name"
LC_DE.sortName = "Nach Namen sortieren"
LC_FR.sortName = "Trier par Nom"
LC_ES.sortName = "Ordenar por Nombre"
LC_RU.sortName = "По имени"

LC_EN.sortLabel = "Sort by Label"
LC_DE.sortLabel = "Nach Label sortieren"
LC_FR.sortLabel = "Trier par étiquette"
LC_ES.sortLabel = "Ordenar por Etiqueta"
LC_RU.sortLabel = "По метке"

LC_EN.sortLevel = "Sort by Level"
LC_DE.sortLevel = "Nach Level sortieren"
LC_FR.sortLevel = "Trier par niveau"
LC_ES.sortLevel = "Ordenar por Nivel"
LC_RU.sortLevel = "По уровню"

LC_EN.enableRepSkills = "Enable Overlapping"
LC_DE.enableRepSkills = "Alle Überlappenden Aktivieren"
LC_FR.enableRepSkills = "Activer le chevauchement"
LC_ES.enableRepSkills = "Habilitar Superposición"
LC_RU.enableRepSkills = "Разрешить дубликаты"

LC_EN.disableRepSkills = "Disable Overlapping"
LC_DE.disableRepSkills = "Alle Überlappenden Deaktivieren"
LC_FR.disableRepSkills = "Désactiver le chevauchement"
LC_ES.disableRepSkills = "Deshabilitar Superposición"
LC_RU.disableRepSkills = "Убрать дубликаты"

LC_EN.enableAll = "Enable All"
LC_DE.enableAll = "Alle Aktivieren"
LC_FR.enableAll = "Activer tout"
LC_ES.enableAll = "Habilitar Todo"
LC_RU.enableAll = "Включить всё"

LC_EN.disableAll = "Disable All"
LC_DE.disableAll = "Alle Deaktivieren"
LC_FR.disableAll = "Désactiver tout"
LC_ES.disableAll = "Deshabilitar Todo"
LC_RU.disableAll = "Выключить всё"

LC_EN.lockUI = "Lock UI"
LC_DE.lockUI = "Benutzeroberfläche sperren"
LC_FR.lockUI = "Verrouiller l’interface utilisateur"
LC_ES.lockUI = "Bloquear UI"
LC_RU.lockUI = "Зафиксировать интерфейс"

LC_EN.useZoneNames = "Use Zone names"
LC_DE.useZoneNames = "Verwenden von Zonen-Namen"
LC_FR.useZoneNames = "Utiliser les noms de zone"
LC_ES.useZoneNames = "Usar nombres de Zona"
LC_RU.useZoneNames = "Использовать название зон"

LC_EN.useSkillNames = "Use Skill names"
LC_DE.useSkillNames = "Verwenden von Skill-Namen"
LC_FR.useSkillNames = "Utiliser les noms de compétence"
LC_ES.useSkillNames = "Usar nombres de Habilidad"
LC_RU.useSkillNames = "Использовать названия навыков"

LC_EN.useTagInListTab = "Use Skill tag in Text layout"
LC_DE.useTagInListTab = "Verwenden von Skill-Tag im Textlayout"
LC_FR.useTagInListTab = "Utiliser la balise Skill dans la mise en page de texte"
LC_ES.useTagInListTab = "Usar etiqueta de Habilidad en el diseño de Texto"
LC_RU.useTagInListTab = "Использование тега навыка в макете текста"

LC_EN.shortcutLabelFontSize = "Skill Label Font Size"
LC_DE.shortcutLabelFontSize = "Schriftgröße der Fertigkeitsbezeichnungen"
LC_FR.shortcutLabelFontSize = "Taille de police pour boutons de compétence"
LC_ES.shortcutLabelFontSize = "Tamaño de fuente de la etiqueta de Habilidad"
LC_RU.shortcutLabelFontSize = "Размер шрифта меток быстрого доступа"

LC_EN.fontSizeSmall = "Small"
LC_DE.fontSizeSmall = "Klein"
LC_FR.fontSizeSmall = "Petit"
LC_ES.fontSizeSmall = "Pequeño"
LC_RU.fontSizeSmall = "Малый"

LC_EN.fontSizeMedium = "Medium"
LC_DE.fontSizeMedium = "Mittel"
LC_FR.fontSizeMedium = "Moyen"
LC_ES.fontSizeMedium = "Mediano"
LC_RU.fontSizeMedium = "Средний"

LC_EN.fontSizeLarge = "Large"
LC_DE.fontSizeLarge = "Groß"
LC_FR.fontSizeLarge = "Grand"
LC_ES.fontSizeLarge = "Grande"
LC_RU.fontSizeLarge = "Большой"

LC_EN.unlockKeyPress = "Hold Shift to unlock"
LC_DE.unlockKeyPress = "Umschalttaste um zu entsperren gedrückt halten"
LC_FR.unlockKeyPress = "Maintenez la touche Maj enfoncée pour déverrouiller"
LC_ES.unlockKeyPress = "Mantener Shift para desbloquear"
LC_RU.unlockKeyPress = "Передвигать с нажатым Shift"

LC_EN.escapeToClose = "Escape closes Travel Window"
LC_DE.escapeToClose = "Escape schliesst Travel-Fenster"
LC_FR.escapeToClose = "Escape fermer Travel Window"
LC_ES.escapeToClose = "ESC cierra la Ventana de Viaje"
LC_RU.escapeToClose = "ESC закрывает главное окно"

LC_EN.useMinWindow = "Use minimal UI"
LC_DE.useMinWindow = "Minimale UI verwenden"
LC_FR.useMinWindow = "Utiliser la mini-UI"
LC_ES.useMinWindow = "Usar UI mínima"
LC_RU.useMinWindow = "Использовать мини-окно"

LC_EN.fadeOutSteps = "Fade Window speed"
LC_DE.fadeOutSteps = "Geschwindigkeit des Fenster-Fadeouts"
LC_FR.fadeOutSteps = "Fondu de la vitesse de Travel Window"
LC_ES.fadeOutSteps = "Velocidad de desvanecimiento de ventana"
LC_RU.fadeOutSteps = "Fade Window Speed"

LC_EN.fadeOutDelay = "Fade Window delay"
LC_DE.fadeOutDelay = "Verzögerung des Fenster-Fadeouts"
LC_FR.fadeOutDelay = "Délai de la fenêtre de fondu"
LC_ES.fadeOutDelay = "Retraso de desvanecimiento de ventana"
LC_RU.fadeOutDelay = "Fade Window Delay"

-- menu strings
LC_EN.menuFilters = "Filters"
LC_DE.menuFilters = "Filter"
LC_FR.menuFilters = "Filtres"
LC_ES.menuFilters = "Filtros"
LC_RU.menuFilters = "Фильтры"

LC_EN.menuGen = "Show Generic Travels"
LC_DE.menuGen = "Zeige Generische Fertigkeiten"
LC_FR.menuGen = "Voir les voyages génériques"
LC_ES.menuGen = "Mostrar Viajes Genéricos"
LC_RU.menuGen = "Показать общие путешествия"

LC_EN.menuRace = "Show Racial Travels"
LC_DE.menuRace = "Zeige Rassenfertigkeiten"
LC_FR.menuRace = "Voir les voyages raciaux"
LC_ES.menuRace = "Mostrar Viajes Raciales"
LC_RU.menuRace = "Показать расовые путешествия"

LC_EN.menuRep = "Show Reputation Travels"
LC_DE.menuRep = "Zeige Ruffertigkeiten"
LC_FR.menuRep = "Voir les voyages de réputation"
LC_ES.menuRep = "Mostrar Viajes de Reputación"
LC_RU.menuRep = "Показать путешествия за репутацию"

LC_EN.menuClass = "Show Class Travels"
LC_DE.menuClass = "Zeige Klassenfertigkeiten"
LC_FR.menuClass = "Voir les voyages de classe"
LC_ES.menuClass = "Mostrar Viajes de Clase"
LC_RU.menuClass = "Показать классовые путешествия"

LC_EN.menuMode = "Mode"
LC_DE.menuMode = "Modus"
LC_FR.menuMode = "Mode"
LC_ES.menuMode = "Modo"
LC_RU.menuMode = "Режим"

LC_EN.menuText = "Text List"
LC_DE.menuText = "Liste"
LC_FR.menuText = "Liste de texte"
LC_ES.menuText = "Lista de Texto"
LC_RU.menuText = "Список текстом"

LC_EN.menuIcon = "Icon Grid"
LC_DE.menuIcon = "Icons"
LC_FR.menuIcon = "Grille d'icône"
LC_ES.menuIcon = "Cuadrícula de Iconos"
LC_RU.menuIcon = "Сетка иконок"

LC_EN.menuCaro = "Carousel"
LC_DE.menuCaro = "Karussell"
LC_FR.menuCaro = "Caroussel"
LC_ES.menuCaro = "Carrusel"
LC_RU.menuCaro = "Карусель"

LC_EN.menuPull = "Pulldown"
LC_DE.menuPull = "Pulldown"
LC_FR.menuPull = "Déroulant"
LC_ES.menuPull = "Desplegar"
LC_RU.menuPull = "Выпадающий"

LC_EN.menuMap = "Map View"
LC_DE.menuMap = "Kartenansicht"
LC_FR.menuMap = "Vue de carte"
LC_ES.menuMap = "Vista de Mapa"
LC_RU.menuMap = "Вид карты"

LC_EN.menuOptions = "Options"
LC_DE.menuOptions = "Optionen"
LC_FR.menuOptions = "Options"
LC_ES.menuOptions = "Opciones"
LC_RU.menuOptions = "Настройки"

LC_EN.menuButton = "Button"
LC_DE.menuButton = "Knopf"
LC_FR.menuButton = "Bouton"
LC_ES.menuButton = "Botón"
LC_RU.menuButton = "Button"

LC_EN.menuButtonIcon = "Icon"
LC_DE.menuButtonIcon = "Symbol"
LC_FR.menuButtonIcon = "Icone"
LC_ES.menuButtonIcon = "Icono"
LC_RU.menuButtonIcon = "Icon"

LC_EN.menuButtonSize = "Button Size"
LC_DE.menuButtonSize = "Knopfgroesse"
LC_FR.menuButtonSize = "Taille du bouton"
LC_ES.menuButtonSize = "Tamaño del Botón"
LC_RU.menuButtonSize = "Button size"

LC_EN.moorMapName = "Ettenmoors"
LC_DE.moorMapName = "Die Ettenöden"
LC_FR.moorMapName = "Les Landes d'Etten"
LC_ES.moorMapName = "Ettenmoors"
LC_RU.moorMapName = "Эттенские высоты"

LC_EN.eriadorMapName = "Eriador"
LC_DE.eriadorMapName = "Eriador"
LC_FR.eriadorMapName = "Eriador"
LC_ES.eriadorMapName = "Eriador"
LC_RU.eriadorMapName = "Эриадора"

LC_EN.rhovanionMapName = "Rhovanion"
LC_DE.rhovanionMapName = "Rhovanion"
LC_FR.rhovanionMapName = "Rhovanion"
LC_ES.rhovanionMapName = "Rhovanion"
LC_RU.rhovanionMapName = "Рованиона"

LC_EN.rohanMapName = "Rohan"
LC_DE.rohanMapName = "Rohan"
LC_FR.rohanMapName = "Rohan"
LC_ES.rohanMapName = "Rohan"
LC_RU.rohanMapName = "Рохана"

LC_EN.gondorMapName = "Gondor/Mordor"
LC_DE.gondorMapName = "Gondor/Mordor"
LC_FR.gondorMapName = "Gondor/Mordor"
LC_ES.gondorMapName = "Gondor/Mordor"
LC_RU.gondorMapName = "Гондора/Мордор"

LC_EN.haradwaithMapName = "Haradwaith"
LC_DE.haradwaithMapName = "Haradwaith"
LC_FR.haradwaithMapName = "Haradwaith"
LC_ES.haradwaithMapName = "Haradwaith"
LC_RU.haradwaithMapName = "Харадвайта"

LC_EN.acquired = "You have acquired the (.*) skill%."
LC_DE.acquired = "Ihr habt Euch die Fertigkeit (.*) angeeignet%."
LC_FR.acquired = "Vous avez acquis la compétence (.*)%."
LC_ES.acquired = "Has adquirido la habilidad (.*)%."
LC_RU.acquired = "Вы приобрели умение <(.*)>%."

LC_EN.store = "LOTRO Store"
LC_DE.store = "LOTRO Shop"
LC_FR.store = "LOTRO Boutique"
LC_ES.store = "LOTRO Store"
LC_RU.store = "LOTRO Store"

LC_EN.quest = "Quest: "
LC_DE.quest = "Aufgabe: "
LC_FR.quest = "Quête: "
LC_ES.quest = "Misión: "
LC_RU.quest = "Задание: "

LC_EN.deed = "Deed: "
LC_DE.deed = "Tat: "
LC_FR.deed = "Acte: "
LC_ES.deed = "Hazaña: "
LC_RU.deed = "Деяние: "

LC_EN.source = "Source: "
LC_DE.source = "Quelle: "
LC_FR.source = "Source: "
LC_ES.source = "Fuente: "
LC_RU.source = "Источник: "

LC_EN.cost = "Cost: "
LC_DE.cost = "Kosten: "
LC_FR.cost = "Coût: "
LC_ES.cost = "Coste: "
LC_RU.cost = "Стоимость: "

LC_EN.requires = "Requires: "
LC_DE.requires = "Benötigt: "
LC_FR.requires = "Exige: "
LC_ES.requires = "Requiere: "
LC_RU.requires = "Требуется: "

LC_EN.allegiance = "Allegiance: "
LC_DE.allegiance = "Bündnis: "
LC_FR.allegiance = "Allégeance: "
LC_ES.allegiance = "Lealtad: "
LC_RU.allegiance = "Альянс: "

LC_EN.rank = "Rank: "
LC_DE.rank = "Rang: "
LC_FR.rank = "Rang: "
LC_ES.rank = "Rango: "
LC_RU.rank = "Ранг: "

LC_EN.with = " with "
LC_DE.with = " bei "
LC_FR.with = " avec "
LC_ES.with = " con "
LC_RU.with = " с "

LC_EN.minLevel = "Minimum Level "
LC_DE.minLevel = "Mindeststufe "
LC_FR.minLevel = "Niveau minimum "
LC_ES.minLevel = "Nivel Mínimo "
LC_RU.minLevel = "Минимальный уровень "

LC_EN.updateTitle = "Travel Window II Update"
LC_DE.updateTitle = "Travel Window II Update"
LC_FR.updateTitle = "Travel Window II Actualización"
LC_ES.updateTitle = "Travel Window II Update"
LC_RU.updateTitle = "Travel Window II Обновление"

LC_EN.updateClose = "Close"
LC_DE.updateClose = "Schließen"
LC_FR.updateClose = "Fermer"
LC_ES.updateClose = "Cerrar"
LC_RU.updateClose = "Закрыть"

LC_EN.updateRemindLater = "Show Again Later"
LC_DE.updateRemindLater = "Später wieder anzeigen"
LC_FR.updateRemindLater = "Rappeler plus tard"
LC_ES.updateRemindLater = "Mostrar más tarde"
LC_RU.updateRemindLater = "Показать позже"

LC_EN.updateDefaultMessage = "Travel Window II has been updated to"
LC_DE.updateDefaultMessage = "Travel Window II wurde aktualisiert auf"
LC_FR.updateDefaultMessage = "Travel Window II a été mis à jour vers"
LC_ES.updateDefaultMessage = "Travel Window II se ha actualizado a"
LC_RU.updateDefaultMessage = "Travel Window II обновлён до"

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
