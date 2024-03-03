--[[ string constants ]] --
--[[ put all the strings that might require translation in ]] --
--[[ one location for easier access ]] --

GLocale = Turbine.Engine.GetLanguage();

local Locale = {
    [Turbine.Language.English] = {},
    [Turbine.Language.German] = {},
    [Turbine.Language.French] = {}
}
LC = Locale[Turbine.Engine.GetLanguage()]
local LC_EN = Locale[Turbine.Language.English]
local LC_DE = Locale[Turbine.Language.German]
local LC_FR = Locale[Turbine.Language.French]


LC_EN.help = "Travel\n\ntrav show: Display the Travel Window\n" ..
"trav hide: Hides the Travel Window\n" ..
"trav toggle: Toggle the Travel Window\n"
LC_DE.help = "Travel\n\ntrav show: Zeigt das Travel-Fenster an\n" ..
"trav hide: Versteckt das Travel-Fenster\n" ..
"trav toggle: Schaltet das Travel-Fenster um\n"
LC_FR.help = "Travel\n\ntrav show: Afficher Travel Window\n" ..
"trav hide: Masquer Travel Window\n" ..
"trav toggle: Toggle the Travel Window\n"

-- window title strings
LC_EN.mainTitle = "Travel"
LC_DE.mainTitle = "Travel"
LC_FR.mainTitle = "Travel"

LC_EN.mainShortTitle = "TW"
LC_DE.mainShortTitle = "TW"
LC_FR.mainShortTitle = "TW"

LC_EN.miniTitle = "Travel Window II"
LC_EN.miniTitle = "Travel Window II"
LC_EN.MiniTitle = "Travel Window II"

LC_EN.optionsTitle = "Travel Options"
LC_DE.optionsTitle = "Travel Optionen"
LC_FR.optionsTitle = "Options de Travel"

LC_EN.skillNotTrained = "Skills not trained: "
LC_DE.skillNotTrained = "Nicht erlernte Fertigkeit: "
LC_FR.skillNotTrained = "Compétence non utilisée: "

-- options window strings
LC_EN.generalTab = "General"
LC_DE.generalTab = "Allgemein"
LC_FR.generalTab = "Général"

LC_EN.selectTab = "Enable"
LC_DE.selectTab = "Auswahl"
LC_FR.selectTab = "Sélection"

LC_EN.sortTab = "Sort"
LC_DE.sortTab = "Sortierung"
LC_FR.sortTab = "Tri"

LC_EN.hide = "Hide Travel window at startup"
LC_DE.hide = "Verstecke Travel-Fenster beim Start"
LC_FR.hide = "Cacher la fenêtre au démarrage"

LC_EN.toggle = "Show Travel Button"
LC_DE.toggle = "Zeige Travel-Knopf"
LC_FR.toggle = "Montrer le bouton Travel"

LC_EN.pulldownTravel = "Travel when pulldown skill selected"
LC_DE.pulldownTravel = "Reise wenn Pulldown-Fertigkeit selektiert"
LC_FR.pulldownTravel = "Voyager lorsque la compétence déroulante est sélectionnée"

LC_EN.hideOnTravel = "Hide main window on travel"
LC_DE.hideOnTravel = "Verstecke Fenster bei Reise"
LC_FR.hideOnTravel = "Cacher la fenêtre quand une compétence de voyage est utilisée"

LC_EN.hideOnCombat = "Hide main window when entering combat"
LC_DE.hideOnCombat = "Verstecke Fenster bei Kampfbeginn"
LC_FR.hideOnCombat = "Cacher la fenêtre à l'entrée en combat"

LC_EN.genericLabel = "Generic Skills"
LC_DE.genericLabel = "Generische Fertigkeiten"
LC_FR.genericLabel = "Compétences générales"

LC_EN.racialLabel = "Racial Skills"
LC_DE.racialLabel = "Rassenfertigkeiten"
LC_FR.racialLabel = "Compétences raciales"

LC_EN.classLabel = "Class Skills"
LC_DE.classLabel = "Klassenfertigkeiten"
LC_FR.classLabel = "Compétences de classe"

LC_EN.repLabel = "Reputation Skills"
LC_DE.repLabel = "Ruffertigkeiten"
LC_FR.repLabel = "Compétences de réputation"

LC_EN.moveUp = "Move Up"
LC_DE.moveUp = "hoch"
LC_FR.moveUp = "Vers le haut"

LC_EN.moveDown = "Move Down"
LC_DE.moveDown = "runter"
LC_FR.moveDown = "Vers le bas"

LC_EN.moveUpChunk = "Move Up 10"
LC_DE.moveUpChunk = "hoch 10"
LC_FR.moveUpChunk = "Vers le haut 10"

LC_EN.moveDownChunk = "Move Down 10"
LC_DE.moveDownChunk = "runter 10"
LC_FR.moveDownChunk = "Vers le bas 10"

LC_EN.moveTop = "Move To Top"
LC_DE.moveTop = "zum Anfang"
LC_FR.moveTop = "Tout en haut"

LC_EN.moveBottom = "Move To Bottom"
LC_DE.moveBottom = "zum Ende"
LC_FR.moveBottom = "Tout en bas"

LC_EN.toggleSliders = "Toggle Button Opacity"
LC_DE.toggleSliders = "Travel-Knopf Transparenz"
LC_FR.toggleSliders = "Modifier l'opacité du bouton"

LC_EN.mainSliders = "Main Window Opacity"
LC_DE.mainSliders = "Hauptfenster Transparenz"
LC_FR.mainSliders = "Modifier l'opacité de la fenêtre"

LC_EN.min = "Min: "
LC_DE.min = "Min: "
LC_FR.min = "Min: "

LC_EN.max = "Max: "
LC_DE.max = "Max: "
LC_FR.max = "Max: "

LC_EN.resetSettings = "Reset to Defaults"
LC_DE.resetSettings = "Rücksetzen auf Standard"
LC_FR.resetSettings = "Remise a zéro"

LC_EN.saveGlobalDefaults = "Save Global Defaults"
LC_DE.saveGlobalDefaults = "Globale Standardwerte speichern"
LC_FR.saveGlobalDefaults = "Enregistrer par défaut globales"

LC_EN.loadGlobalDefaults = "Load Global Defaults"
LC_DE.loadGlobalDefaults = "Globale Standardwerte laden"
LC_FR.loadGlobalDefaults = "Charger par défaut globales"

LC_EN.defaultSort = "Reset to Default"
LC_DE.defaultSort = "Auf Standard zurücksetzen"
LC_FR.defaultSort = "Réinitialiser par défaut"

LC_EN.sortName = "Sort by Name"
LC_DE.sortName = "Nach Namen sortieren"
LC_FR.sortName = "Trier par Nom"

LC_EN.sortLabel = "Sort by Label"
LC_DE.sortLabel = "Nach Etikett sortieren"
LC_FR.sortLabel = "Trier par étiquette"

LC_EN.sortLevel = "Sort by Level"
LC_DE.sortLevel = "Nach Level sortieren"
LC_FR.sortLevel = "Trier par niveau"

LC_EN.checkSkills = "Check Untrained Skills"
LC_DE.checkSkills = "Nicht erlernte Fertigkeiten prüfen"
LC_FR.checkSkills = "Vérification des compétences non utilisées"

LC_EN.enableRepSkills = "Enable Overlapping"
LC_DE.enableRepSkills = "Überlappende Aktivieren"
LC_FR.enableRepSkills = "Activer le chevauchement"

LC_EN.disableRepSkills = "Disable Overlapping"
LC_DE.disableRepSkills = "Überlappende Deaktivieren"
LC_FR.disableRepSkills = "Désactiver le chevauchement"

LC_EN.enableAll = "Enable All"
LC_DE.enableAll = "Alle Aktivieren"
LC_FR.enableAll = "Activer tout"

LC_EN.disableAll = "Disable All"
LC_DE.disableAll = "Alle Deaktivieren"
LC_FR.disableAll = "Désactiver tout"

LC_EN.ignoreEsc = "Escape does not close main window"
LC_DE.ignoreEsc = "Escape schliesst Travel-Fenster nicht"
LC_FR.ignoreEsc = "Escape ne pas fermer la fenêtre principale"

LC_EN.miniWindow = "Use Mini-Window"
LC_DE.miniWindow = "Mini-Fenster verwenden"
LC_FR.miniWindow = "Utiliser la mini-fenêtre"

LC_EN.fadeSpeed = "Fade Window Speed"
LC_DE.fadeSpeed = "Geschwindigkeit des Fenster-Fadeouts"
LC_FR.fadeSpeed = "Fondu de la vitesse de la fenêtre"

LC_EN.fadeDelay = "Fade Window Delay"
LC_DE.fadeDelay = "Verzögerung des Fenster-Fadeouts"
LC_FR.fadeDelay = "Délai de la fenêtre de fondu"

-- menu strings
LC_EN.menuFilters = "Filters"
LC_DE.menuFilters = "Filter"
LC_FR.menuFilters = "Filtres"

LC_EN.menuGen = "Show Generic Travels"
LC_DE.menuGen = "Zeige generische Fertigkeiten"
LC_FR.menuGen = "Voir les voyages génériques"

LC_EN.menuRace = "Show Racial Travels"
LC_DE.menuRace = "Zeige Rassenfertigkeiten"
LC_FR.menuRace = "Voir les voyages raciaux"

LC_EN.menuRep = "Show Reputation Travels"
LC_DE.menuRep = "Zeige Ruffertigkeiten"
LC_FR.menuRep = "Voir les voyages de réputation"

LC_EN.menuClass = "Show Class Travels"
LC_DE.menuClass = "Zeige Klassenfertigkeiten"
LC_FR.menuClass = "Voir les voyages de classe"

LC_EN.menuMode = "Mode"
LC_DE.menuMode = "Modus"
LC_FR.menuMode = "Mode"

LC_EN.menuText = "Text List"
LC_DE.menuText = "Liste"
LC_FR.menuText = "Liste de texte"

LC_EN.menuIcon = "Icon Grid"
LC_DE.menuIcon = "Icons"
LC_FR.menuIcon = "Grille d'icône"

LC_EN.menuCaro = "Carousel"
LC_DE.menuCaro = "Karussell"
LC_FR.menuCaro = "Caroussel"

LC_EN.menuPull = "Pulldown List"
LC_DE.menuPull = "Pulldown-Liste"
LC_FR.menuPull = "Menu déroulant"

LC_EN.mapWindow = "Maps"
LC_DE.mapWindow = "Karten"
LC_FR.mapWindow = "Destinations"

LC_EN.menuOptions = "Options"
LC_DE.menuOptions = "Optionen"
LC_FR.menuOptions = "Options"

LC_EN.moorMap = "Open Moor Map"
LC_DE.moorMap = "Öffne Etten-Karte"
LC_FR.moorMap = "Destinations aux Landes d'Etten"

LC_EN.eriadorMap = "Open Eriador Map"
LC_DE.eriadorMap = "Öffne Eriador-Karte"
LC_FR.eriadorMap = "Destinations en Eriador"

LC_EN.rhovanionMap = "Open Rhovanion Map"
LC_DE.rhovanionMap = "Öffne Rhovanion-Karte"
LC_FR.rhovanionMap = "Destination dans le Rhovanion"

LC_EN.rohanMap = "Open Rohan Map"
LC_DE.rohanMap = "Öffne Rohan-Karte"
LC_FR.rohanMap = "Destinations dans le Rohan"

LC_EN.gondorMap = "Open Gondor Map"
LC_DE.gondorMap = "Öffne Gondor-Karte"
LC_FR.gondorMap = "Destinations dans le Gondor"

LC_EN.haradwaithMap = "Open Haradwaith Map"
LC_DE.haradwaithMap = "Öffne Haradwaith-Karte"
LC_FR.haradwaithMap = "Destinations dans le Haradwaith"

LC_EN.menuSkills = "Check Untrained Skills"
LC_DE.menuSkills = "Nicht erlernte Fertigkeiten prüfen"
LC_FR.menuSkills = "Vérification des compétences non utilisées"
