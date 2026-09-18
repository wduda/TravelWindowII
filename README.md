# 🧳 Travel Window II

Interface LOTRO complète pour regrouper, organiser et utiliser les compétences de voyage d’un personnage depuis une seule fenêtre.

**🌍 Languages / Sprachen / Langues / Idiomas / Языки:** 🇬🇧 English · 🇩🇪 Deutsch · 🇫🇷 Français · 🇪🇸 Español · 🇷🇺 Русский

---

## 🇬🇧 English

### 📖 Overview

**Travel Window II** gathers the travel skills available to your character into one configurable interface, including generic, racial, class, reputation and housing-related travel skills.

It is a further development of the original **Travel Window** plugin.

### ✨ Features

- Multiple display modes: **Text List, Icon Grid, Carousel, Pulldown and Map View**.
- Automatic detection of newly learned travel skills.
- Sorting and enable/disable controls.
- Hide selected travel skills from the interface.
- **Find Skills** view with acquisition information for learnable travel skills.
- Map View with travel locations and regional navigation.
- Support for racial, class, reputation and other travel categories.
- Configurable Travel Button with several icon and size options.
- Mini UI, opacity, fade and window behavior options.
- Per-character settings plus reusable global defaults.
- Dedicated plugin data apartment for isolated saved settings.

### 📦 Installation

Copy the **TravelWindowII** folder from the release into:

```text
Documents\The Lord of the Rings Online\Plugins\
```

Keep the release structure intact so the plugin manifest and `src` folder remain together.

Then in game:

```text
/plugins refresh
```

Load **Travel Window II** from LOTRO's Plugin Manager.

### 🎮 Usage

Open the Travel Window and choose the layout that best fits your setup. Right-click menus and the options window provide filters, display modes, sorting, button appearance and other interface settings.

The **Find Skills** tab helps identify travel skills your character can still obtain.

### ⌨️ Commands

The main aliases are `/trav` and `/travel`.

- `/trav show` — show the Travel Window.
- `/trav hide` — hide the Travel Window.
- `/trav toggle` — toggle the Travel Window.
- `/trav scan` — manually scan learned travel skills.
- `/trav update` — show the update/changelog notification.
- `/trav debug on` / `off` — enable or disable debug mode.

### ⚙️ Saved data & settings

Travel Window II stores character settings in its own `TravelWindowII` Lua data apartment. Global defaults can also be saved and reused across characters.

### 🌍 Languages

The plugin contains localization support for **English, German, French, Spanish and Russian**.

Translation coverage can vary for recently added skills or acquisition data, especially when LOTRO changes names between updates.

### ⚠️ Limitations / notes

Travel skill names and availability depend on the active LOTRO client and on data maintained by the plugin. When Standing Stone Games renames a skill or adds a new destination, the corresponding localization or acquisition data may need an update.

### 🐛 Bugs & suggestions

Use [GitHub Issues](https://github.com/Dusk-92/TravelWindowII/issues).

### 🙏 Credits

- **Dhor** and previous contributors — original Travel Window lineage.
- **Hyos / Hyoss and WhiteRabbit963** — Travel Window II development.
- **Dusk-92** — maintenance of this repository fork.

---

## 🇩🇪 Deutsch

### 📖 Übersicht

**Travel Window II** bündelt die verfügbaren Reisefertigkeiten eines Charakters in einer konfigurierbaren Oberfläche, darunter allgemeine, Rassen-, Klassen-, Ruf- und Wohnfertigkeiten.

Das Plugin ist eine Weiterentwicklung des ursprünglichen **Travel Window**.

### ✨ Funktionen

- Mehrere Ansichten: **Textliste, Symbolraster, Karussell, Dropdown und Kartenansicht**.
- Automatische Erkennung neu gelernter Reisefertigkeiten.
- Sortier- und Aktivierungsoptionen.
- Ausgewählte Reisefertigkeiten können ausgeblendet werden.
- **Fertigkeiten finden** mit Informationen zu noch erlernbaren Reisen.
- Kartenansicht mit Reisezielen und Regionsnavigation.
- Unterstützung für Rassen-, Klassen-, Ruf- und weitere Reisekategorien.
- Konfigurierbare Reiseschaltfläche mit mehreren Symbolen und Größen.
- Mini-UI sowie Einstellungen für Transparenz, Ausblenden und Fensterverhalten.
- Charakterbezogene Einstellungen und wiederverwendbare globale Standardwerte.
- Eigener Lua-Datenbereich für isolierte Speicherdaten.

### 📦 Installation

Den Ordner **TravelWindowII** aus der Release nach folgendem Pfad kopieren:

```text
Documents\The Lord of the Rings Online\Plugins\
```

Die Verzeichnisstruktur der Release beibehalten, damit Plugin-Datei und `src`-Ordner zusammenbleiben.

Danach im Spiel:

```text
/plugins refresh
```

**Travel Window II** im LOTRO-Plugin-Manager laden.

### 🎮 Verwendung

Das Reisefenster öffnen und die gewünschte Ansicht auswählen. Rechtsklick-Menüs und das Optionsfenster bieten Filter, Ansichten, Sortierung, Schaltflächen-Design und weitere Interface-Einstellungen.

Der Bereich **Fertigkeiten finden** zeigt Reisefertigkeiten, die der Charakter noch erhalten kann.

### ⌨️ Befehle

Die Hauptaliase sind `/trav` und `/travel`.

- `/trav show` — Reisefenster anzeigen.
- `/trav hide` — Reisefenster ausblenden.
- `/trav toggle` — Reisefenster umschalten.
- `/trav scan` — gelernte Reisefertigkeiten manuell prüfen.
- `/trav update` — Update-/Changelog-Fenster anzeigen.
- `/trav debug on` / `off` — Debugmodus ein-/ausschalten.

### ⚙️ Gespeicherte Daten & Einstellungen

Travel Window II speichert Charaktereinstellungen in einem eigenen Lua-Datenbereich `TravelWindowII`. Globale Standardwerte können zusätzlich gespeichert und von mehreren Charakteren verwendet werden.

### 🌍 Sprachen

Das Plugin enthält Lokalisierungen für **Deutsch, Englisch, Französisch, Spanisch und Russisch**.

Bei neu hinzugefügten Fertigkeiten oder Bezugsquellen kann der Übersetzungsumfang je nach Sprache unterschiedlich sein.

### ⚠️ Einschränkungen / Hinweise

Namen und Verfügbarkeit von Reisefertigkeiten hängen vom aktiven LOTRO-Client und den gepflegten Plugin-Daten ab. Wenn Standing Stone Games Fertigkeiten umbenennt oder neue Ziele ergänzt, können Lokalisierungs- oder Bezugsdaten aktualisiert werden müssen.

### 🐛 Fehler & Vorschläge

Bitte die [GitHub Issues](https://github.com/Dusk-92/TravelWindowII/issues) verwenden.

### 🙏 Credits

- **Dhor** und frühere Mitwirkende — Ursprung von Travel Window.
- **Hyos / Hyoss und WhiteRabbit963** — Entwicklung von Travel Window II.
- **Dusk-92** — Pflege dieses Repository-Forks.

---

## 🇫🇷 Français

### 📖 Présentation

**Travel Window II** regroupe les compétences de voyage disponibles pour ton personnage dans une seule interface configurable : voyages génériques, raciaux, de classe, de réputation, de logement et autres destinations.

Il s’agit d’une évolution du plugin original **Travel Window**.

### ✨ Fonctionnalités

- Plusieurs modes d’affichage : **Liste texte, Grille d’icônes, Carrousel, Menu déroulant et Carte**.
- Détection automatique des nouvelles compétences de voyage apprises.
- Tri et activation/désactivation des compétences.
- Possibilité de masquer certaines compétences.
- Vue **Trouver des compétences** avec les méthodes d’obtention connues.
- Vue Carte avec destinations et navigation entre régions.
- Gestion des voyages raciaux, de classe, de réputation et autres catégories.
- Bouton Travel configurable avec plusieurs icônes et tailles.
- Mini-interface, opacité, fondu et comportement des fenêtres configurables.
- Réglages par personnage et valeurs globales réutilisables.
- Espace de sauvegarde Lua dédié.

### 📦 Installation

Copie le dossier **TravelWindowII** de la release dans :

```text
Documents\The Lord of the Rings Online\Plugins\
```

Conserve l’arborescence de la release afin que le manifeste du plugin et le dossier `src` restent ensemble.

Puis en jeu :

```text
/plugins refresh
```

Charge **Travel Window II** depuis le gestionnaire de plugins LOTRO.

### 🎮 Utilisation

Ouvre Travel Window II et choisis la présentation qui te convient. Les menus au clic droit et la fenêtre d’options donnent accès aux filtres, modes d’affichage, tris, apparence du bouton et autres réglages.

L’onglet **Trouver des compétences** aide à repérer les voyages que ton personnage peut encore obtenir.

### ⌨️ Commandes

Les alias principaux sont `/trav` et `/travel`.

- `/trav show` — afficher la fenêtre.
- `/trav hide` — masquer la fenêtre.
- `/trav toggle` — afficher/masquer la fenêtre.
- `/trav scan` — relancer manuellement la détection des compétences apprises.
- `/trav update` — afficher la fenêtre de mise à jour/changelog.
- `/trav debug on` / `off` — activer/désactiver le mode debug.

### ⚙️ Sauvegardes & réglages

Travel Window II stocke les réglages des personnages dans son propre espace Lua `TravelWindowII`. Des valeurs globales peuvent aussi être enregistrées et réutilisées sur plusieurs personnages.

### 🌍 Langues

Le plugin contient des localisations en **anglais, allemand, français, espagnol et russe**.

La couverture peut varier pour les compétences ou méthodes d’obtention les plus récentes, notamment lorsque LOTRO modifie des noms entre deux mises à jour.

### ⚠️ Limites / notes

Les noms et la disponibilité des compétences dépendent du client LOTRO actif et des données maintenues par le plugin. Lorsqu’une compétence est renommée ou qu’une nouvelle destination est ajoutée par Standing Stone Games, les données de localisation ou d’obtention peuvent devoir être mises à jour.

### 🐛 Bugs & suggestions

Utilise les [Issues GitHub](https://github.com/Dusk-92/TravelWindowII/issues).

### 🙏 Crédits

- **Dhor** et les contributeurs précédents — origine de Travel Window.
- **Hyos / Hyoss et WhiteRabbit963** — développement de Travel Window II.
- **Dusk-92** — maintenance de ce fork du dépôt.

---

## 🇪🇸 Español

### 📖 Presentación

**Travel Window II** reúne las habilidades de viaje disponibles para tu personaje en una sola interfaz configurable, incluyendo viajes generales, raciales, de clase, reputación, vivienda y otras categorías.

Es una evolución del plugin original **Travel Window**.

### ✨ Funciones

- Varios modos de visualización: **Lista de texto, Cuadrícula de iconos, Carrusel, Menú desplegable y Vista de mapa**.
- Detección automática de nuevas habilidades de viaje aprendidas.
- Opciones de ordenación y activación.
- Posibilidad de ocultar habilidades seleccionadas.
- Vista **Buscar habilidades** con información sobre cómo obtener viajes pendientes.
- Vista de mapa con destinos y navegación entre regiones.
- Soporte para viajes raciales, de clase, reputación y otras categorías.
- Botón de viaje configurable con varios iconos y tamaños.
- Mini interfaz y opciones de opacidad, desvanecimiento y comportamiento de ventanas.
- Ajustes por personaje y valores globales reutilizables.
- Espacio Lua propio para los datos guardados.

### 📦 Instalación

Copia la carpeta **TravelWindowII** de la release en:

```text
Documents\The Lord of the Rings Online\Plugins\
```

Mantén intacta la estructura de la release para que el manifiesto del plugin y la carpeta `src` permanezcan juntos.

Después, dentro del juego:

```text
/plugins refresh
```

Carga **Travel Window II** desde el gestor de plugins de LOTRO.

### 🎮 Uso

Abre Travel Window II y elige la vista que prefieras. Los menús de clic derecho y la ventana de opciones permiten configurar filtros, vistas, ordenación, apariencia del botón y otros ajustes.

La pestaña **Buscar habilidades** ayuda a localizar viajes que tu personaje todavía puede conseguir.

### ⌨️ Comandos

Los alias principales son `/trav` y `/travel`.

- `/trav show` — mostrar la ventana.
- `/trav hide` — ocultar la ventana.
- `/trav toggle` — alternar la ventana.
- `/trav scan` — volver a detectar manualmente las habilidades aprendidas.
- `/trav update` — mostrar la ventana de actualización/cambios.
- `/trav debug on` / `off` — activar/desactivar el modo de depuración.

### ⚙️ Datos guardados y ajustes

Travel Window II guarda los ajustes de personaje en su propio espacio Lua `TravelWindowII`. También permite guardar valores globales para reutilizarlos entre personajes.

### 🌍 Idiomas

El plugin incluye localización en **inglés, alemán, francés, español y ruso**.

La cobertura puede variar para habilidades o métodos de obtención añadidos recientemente.

### ⚠️ Limitaciones / notas

Los nombres y la disponibilidad de las habilidades dependen del cliente LOTRO y de los datos mantenidos por el plugin. Si Standing Stone Games cambia nombres o añade destinos, puede ser necesario actualizar la localización o la información de obtención.

### 🐛 Errores y sugerencias

Usa [GitHub Issues](https://github.com/Dusk-92/TravelWindowII/issues).

### 🙏 Créditos

- **Dhor** y colaboradores anteriores — origen de Travel Window.
- **Hyos / Hyoss y WhiteRabbit963** — desarrollo de Travel Window II.
- **Dusk-92** — mantenimiento de este fork del repositorio.

---

## 🇷🇺 Русский

### 📖 Обзор

**Travel Window II** собирает доступные персонажу навыки путешествия в одном настраиваемом интерфейсе: обычные, расовые, классовые, репутационные, жилищные и другие путешествия.

Это дальнейшее развитие оригинального плагина **Travel Window**.

### ✨ Возможности

- Несколько режимов отображения: **текстовый список, сетка значков, карусель, выпадающий список и карта**.
- Автоматическое обнаружение недавно изученных навыков путешествия.
- Сортировка и включение/отключение навыков.
- Возможность скрывать выбранные навыки.
- Раздел **Поиск навыков** с информацией о получении доступных путешествий.
- Карта с точками путешествий и навигацией между регионами.
- Поддержка расовых, классовых, репутационных и других категорий.
- Настраиваемая кнопка Travel с несколькими значками и размерами.
- Мини-интерфейс, прозрачность, затухание и настройки поведения окон.
- Настройки для каждого персонажа и общие глобальные значения.
- Отдельная область Lua для сохранённых данных.

### 📦 Установка

Скопируйте папку **TravelWindowII** из релиза в:

```text
Documents\The Lord of the Rings Online\Plugins\
```

Сохраните структуру релиза, чтобы файл плагина и папка `src` оставались вместе.

Затем в игре выполните:

```text
/plugins refresh
```

Загрузите **Travel Window II** через менеджер плагинов LOTRO.

### 🎮 Использование

Откройте Travel Window II и выберите удобный режим отображения. Контекстные меню и окно настроек позволяют управлять фильтрами, режимами, сортировкой, видом кнопки и другими параметрами.

Раздел **Поиск навыков** помогает найти путешествия, которые персонаж ещё может получить.

### ⌨️ Команды

Основные команды: `/trav` и `/travel`.

- `/trav show` — показать окно.
- `/trav hide` — скрыть окно.
- `/trav toggle` — переключить видимость окна.
- `/trav scan` — вручную повторить поиск изученных навыков.
- `/trav update` — показать окно обновления/списка изменений.
- `/trav debug on` / `off` — включить/выключить режим отладки.

### ⚙️ Сохранённые данные и настройки

Travel Window II хранит настройки персонажа в собственной Lua-области `TravelWindowII`. Также можно сохранить глобальные параметры для использования несколькими персонажами.

### 🌍 Языки

Плагин содержит локализации на **английском, немецком, французском, испанском и русском** языках.

Полнота перевода может отличаться для недавно добавленных навыков и способов их получения.

### ⚠️ Ограничения / примечания

Названия и доступность навыков зависят от активного клиента LOTRO и данных плагина. Если Standing Stone Games переименовывает навык или добавляет новое направление, локализацию или данные о получении может потребоваться обновить.

### 🐛 Ошибки и предложения

Используйте [GitHub Issues](https://github.com/Dusk-92/TravelWindowII/issues).

### 🙏 Благодарности

- **Dhor** и предыдущие участники — исходная линия Travel Window.
- **Hyos / Hyoss и WhiteRabbit963** — разработка Travel Window II.
- **Dusk-92** — поддержка этого форка репозитория.
