-- Перевод: PulseDiver (содружество «Эсельсиор», Мирквуд)
-- http://theringunion.ru
-- http://eselsior.com


--[[ string constants ]] --
--[[ put all the strings that might require translation in ]] --
--[[ one location for easier access ]] --
helpString = "Travel. Translated by PulseDiver.\n" ..
"\n Команды:\n" ..
"ntrav show: Показать окно путешествий\n" ..
"trav hide: Срыть окно путешествий\n" ..
"trav toggle: Вызвать\скрыть окно путешествий\n";

-- window title strings
mainTitleString = "Travel";
optionsTitleString = "Настройки Travel";
moorMapTitleString = "Карта Эттен";
eriadorMapTitleString = "Карта Эриадора";
rhovanionMapTitleString = "Карта Рованиона";
gondorMapTitleString = "Карта Гондора"

-- strings for maps
mapHomeString = "Дорога домой";
glanMapString = "Точная карта дороги в Глан Врайг";
glanMapItemString = "Точная карта дороги в Глан Врайг";

-- adding map strings
mapInstructionString = "Перетащите карту из сумки в слот ниже " ..
"для добавления новой карты.";
mapErrorString = "Новых карт не обнаружено, никаких обновлений не сделано.";

-- error messages
resetOrderString = "Your order settings have been reset due to a change in " ..
"the number of items saved.  This should only occur once.\n" ..
"Sorry for the inconvenience.";

resetEnabledString = "Your selected skills have been reset due to an error " ..
"in the number of items previously saved.\n";

skillNotTrainedString = "Умение не получено: ";

-- options window strings
generalTabString = "Основные";
selectTabString = "Выбор";
sortTabString = "Порядок";
hideString = "Скрыть окно путешествий при запуске";
toggleString = "Показывать кнопку вызова Travel";
pulldownTravelString = "Отправиться сразу при выборе из \"Выпадающего меню\"";
hideOnCombatString = "Скрывать окно путешествий в бою";
genericLabelString = "Основные умения";
racialLabelString = "Расовые умения";
classLabelString = "Классовые умения";
repLabelString = "Репутационные умения";
moveUpString = "Выше";
moveDownString = "Ниже";
moveTopString = "Наверх";
moveBottomString = "Вниз";
toggleSlidersString = "Прозрачность иконки вызова Travel";
mainSlidersString = "Прозрачность главного окна Travel";
minString = "Миним.: ";
maxString = "Макс.: ";
resetSettingsString = "По умолчанию";
checkSkillsString = "Проверить умения";

-- menu strings
menuFiltersString = "Фильтр";
menuGenString = "Основные умения";
menuRaceString = "Расовые умения";
menuRepString = "Репутационные умения";
menuClassString = "Классовые умения";
menuModeString = "Режим";
menuTextString = "Текстовый список";
menuIconString = "Иконки";
menuCaroString = "Карусель иконок";
menuPullString = "Выпадающее меню";
menuMapString = "Добавить карту";
menuOptionsString = "Настройки";
moorMapString = "Открыть карту Эттен";
eriadorMapString = "Открыть карту Эриадора";
rhovanionMapString = "Открыть карту Рованиона";
gondorMapString = nil -- !!! will be added and translated when RU is U14
menuSkillsString = "Список неполученных умений";

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

    hunterLocations:AddData("Возвращение в лагерь", "0x7000A2C1", "Возвращение в лагерь");
    hunterLocations:AddData("Путь в Бри", "0x70003F42", "Путь в Бри");
    hunterLocations:AddData("Путь в Чертоги Торина", "0x70003F41", "Путь в Чертоги Торина");
    hunterLocations:AddData("Путь в Занорье", "0x7000A2C3", "Путь в Занорье");
    hunterLocations:AddData("Путь в Эстельдин", "0x70003F43", "Путь в Эстельдин");
    hunterLocations:AddData("Путь в Эвендим", "0x7000A2C4", "Путь в Эвендим");
    hunterLocations:AddData("Путь в Ост Гурут", "0x7000A2C2", "Путь в Ост Гурут");
    hunterLocations:AddData("Путь в Ривенделл", "0x70003F44", "Путь в Ривенделл");
    hunterLocations:AddData("Путь в Сури-кила", "0x70017C82", "Путь в Сури-кила");
    hunterLocations:AddData("Путь в западный Ангмар", "0x7000A2C5", "Путь в западный Ангмар");
    hunterLocations:AddData("Путь в восточный Ангмар", "0x7000A2C6", "Путь в восточный Ангмар");
    hunterLocations:AddData("Путь в Эхад Дунанн", "0x70017C81", "Путь в Эхад Дунанн");
    hunterLocations:AddData("Путь в Двадцать первый чертог", "0x70017C7A", "Путь в Двадцать первый чертог");
    hunterLocations:AddData("Путь в Черную рощу", "0x7001F459", "Путь в Черную рощу");
    hunterLocations:AddData("Путь в Харндирион", "0x700235EF", "Путь в Харндирион");
    hunterLocations:AddData("Путь в Галтрев", "0x7002A93F", "Путь в Галтрев");
    hunterLocations:AddData("Путь в Стангард", "0x7002C62C", "Путь в Стангард");
    hunterLocations:AddData("Путь в Карас Галадон", "0x7002E754", "Путь в Карас Галадон");
    hunterLocations:AddData("Путь в Мглистые горы", "0x7002E756", "Путь в Мглистые горы");
    hunterLocations:AddData("Путь в Сноуборн", "0x7003198E", "Путь в Сноуборн");
    hunterLocations:AddData("Путь в Форлоу", "0x70036B5D", "Путь в Форлоу");
    hunterLocations:AddData("Путь в Альдбург", "0x7003DC71", "Путь в Альдбург");
    hunterLocations:AddData("Путь в Хельмову Падь", "0x7003DC72", "Путь в Хельмову Падь");
    -- !!! will be translated when RU is past U13
    -- hunterLocations:AddData("Guide to Dol Amroth", "0x70041197", "Guide to Dol Amroth");
    -- hunterLocations:AddData("Guide to Arnach", "0x70043A63", "Guide to Arnach");
    -- hunterLocations:AddData("Guide to Minas Tirith", "0x70044985", "Guide to Minas Tirith");
    -- hunterLocations:AddData("Guide to the War-stead", "0x700459AF", "Guide to the War-stead");
    -- hunterLocations:AddData("Guide to after-battle Minas Tirith", "0x70046CBB", "Guide to after-battle Minas Tirith");
    -- hunterLocations:AddData("Guide to Henneth Annûn", "0x70047077", "Guide to Henneth Annûn");
    -- hunterLocations:AddData("Guide to after-battle Osgiliath", "0x70047074", "Guide to after-battle Osgiliath");
    -- hunterLocations:AddData("Guide to the Camp of the Host", "0x70047BFA", "Guide to the Camp of the Host");
    -- hunterLocations:AddData("Guide to Haerondir", "0x70047C1D", "Guide to Haerondir");

    wardenLocations:AddData("Сбор в Ост Гуруте", "0x70014786", "Сбор в Ост Гуруте");
    wardenLocations:AddData("Сбор в Эстельдине", "0x70014798", "Сбор в Эстельдине");
    wardenLocations:AddData("Сбор в Эвендиме", "0x7001478E", "Сбор в Эвендиме");
    wardenLocations:AddData("Сбор в Ривенделле", "0x70014791", "Сбор в Ривенделле");
    wardenLocations:AddData("Сбор в Сури-кила", "0x700237D4", "Сбор в Сури-кила");
    wardenLocations:AddData("Сбор в Двадцать первом чертоге", "0x7001819E", "Сбор в Двадцать первом чертоге");
    wardenLocations:AddData("Сбор в Лихолесье", "0x7001F45C", "Сбор в Лихолесье");
    wardenLocations:AddData("Сбор в Харндирионе", "0x700235EB", "Сбор в Харндирионе");
    wardenLocations:AddData("Сбор в Галтреве", "0x7002A90A", "Сбор в Галтреве");
    wardenLocations:AddData("Сбор в Стангарде", "0x7002C646", "Сбор в Стангарде");
    wardenLocations:AddData("Сбор в Карас Галадоне", "0x700303DF", "Сбор в Карас Галадоне");
    wardenLocations:AddData("Сбор в Мглистых горах", "0x700303DD", "Сбор в Мглистых горах");
    wardenLocations:AddData("Сбор в Сноуборне", "0x7003198D", "Сбор в Сноуборне");
    wardenLocations:AddData("Сбор в Форлоу", "0x70036B5B", "Сбор в Форлоу");
    wardenLocations:AddData("Сбор в Альбурге", "0x7003DC7A", "Сбор в Альбурге");
    wardenLocations:AddData("Сбор в Хельмовой Пади", "0x7003DC79", "Сбор в Хельмовой Пади");
    -- !!! will be translated when RU is past U13
    -- wardenLocations:AddData("Muster in Dol Amroth", "0x70041198", "Muster in Dol Amroth");
    -- wardenLocations:AddData("Muster in Arnach", "0x70043A66", "Muster in Arnach");
    -- wardenLocations:AddData("Muster in Minas Tirith", "0x70044982", "Muster in Minas Tirith");
    -- wardenLocations:AddData("Muster in the War-stead", "0x700459AA", "Muster in the War-stead");
    -- wardenLocations:AddData("Muster in after-battle Minas Tirith", "0x70046CBF", "Muster in after-battle Minas Tirith");
    -- wardenLocations:AddData("Muster in Henneth Annûn", "0x70047075", "Muster in Henneth Annûn");
    -- wardenLocations:AddData("Muster in after-battle Osgiliath", "0x70047076", "Muster in after-battle Osgiliath");
    -- wardenLocations:AddData("Muster in the Camp of the Host ", "0x70047BFC", "Muster in the Camp of the Host ");
    -- wardenLocations:AddData("Muster in Haerondir", "0x70047C23", "Muster in Haerondir");

    racialLocations:AddData("Дорога в Бри (Рас.)", "0x700062F6", "Дорога в Бри");
    racialLocations:AddData("Дорога в Шир (Рас.)", "0x700062C8", "Дорога в Шир");
    racialLocations:AddData("Дорога к Вратам Торина (Рас.)", "0x70006346", "Дорога к Вратам Торина");
    racialLocations:AddData("Дорога в Ривенделл (Рас.)", "0x7000631F", "Дорога в Ривенделл");
    -- !!! beorning travel skill, will be translated when RU is U15
    -- racialLocations:AddData("Return Home (Racial)", "0x70041a22", "Return Home");

    -- check if a function that only exists in the newest update exists,
    -- if so, add the Return Home skills
    if (Turbine.UI.Control.IsDisplayed ~= nil) then
        genLocations:AddData("Возвращение к путевому камню 1", "0x700256BA", "skip");
        genLocations:AddData("Возвращение к путевому камню 2", "0x70025792", "skip");
        genLocations:AddData("Возвращение к путевому камню 3", "0x70025793", "skip");
        genLocations:AddData("Возвращение к путевому камню 4", "0x70025794", "skip");
        genLocations:AddData("Возвращение к путевому камню 5", "0x70025795", "skip");
        genLocations:AddData("Возвращение к путевому камню 6", "0x70025796", "skip");
        genLocations:AddData("Возвращение к путевому камню 7", "0x7002FF5F", "skip");
        genLocations:AddData("Возвращение к путевому камню 8", "0x7002FF60", "skip");
        genLocations:AddData("Возвращение к путевому камню 9", "0x7002FF61", "skip");
        genLocations:AddData("Возвращение к путевому камню 10", "0x7002FF62", "skip");
        genLocations:AddData("Возвращение к путевому камню 11", "0x7002FF63", "skip");
        genLocations:AddData("Возвращение к путевому камню 12", "0x7002FF64", "skip");
    end
    genLocations:AddData("Возвращение домой", "0x7000D046", "Возвращение домой");
    genLocations:AddData("Premium House", "0x70046EE4", "Travel to Premium House");
    genLocations:AddData("Путешествие в дом содружества", "0x7000D047", "Путешествие в дом содружества");

    repLocations:AddData("Возвращение к Вратам Торина (Реп.)", "0x7001BF91", "Путь к Вратам Торина");
    repLocations:AddData("Возвращение в Бри (Реп.)", "0x7001BF90", "Возвращение в Бри");
    repLocations:AddData("Возвращение на рынок Лалии", "0x700364B1", "Возвращение на рынок Лалии");
    repLocations:AddData("Возвращение в Занорье (Реп.)", "0x70023262", "Возвращение в Занорье");
    repLocations:AddData("Возвращение в Ривенделл (Реп.)", "0x70023263", "Возвращение в Ривенделл");
    repLocations:AddData("Возвращение в Ост Гурут (Реп.)", "0x70020441", "Возвращение в Ост Гурут");
    repLocations:AddData("Возвращение в Лихолесье (Реп.)", "0x7001F374", "Возвращение в Лихолесье");
    repLocations:AddData("Возвращение в Энедвайт (Реп.)", "0x70021FA2", "Возвращение в Энедвайт");
    repLocations:AddData("Возвращение в Галтрев (Реп.)", "0x7002C647", "Возвращение в Галтрев");
    repLocations:AddData("Возвращение в Стангард (Реп.)", "0x7002C65D", "Возвращение в Стангард");
    repLocations:AddData("Возвращение в Сноуборн (Реп.)", "0x70031A46", "Возвращение в Сноуборн");
    repLocations:AddData("Возвращение в Форлоу (Реп.)", "0x70036B5E", "Возвращение в Форлоу");
    repLocations:AddData("Возвращение в Альдбург (Реп.)", "0x7003DC81", "Возвращение в Альдбург");
    repLocations:AddData("Возвращение в Хельмову Падь (Реп.)", "0x7003DC82", "Возвращение в Хельмову Падь");
    -- !!! will be translated when RU is U14
    -- repLocations:AddData("Return to Derndingle (Rep)", "0x7004128F", "Return to Derndingle");
    -- repLocations:AddData("Return to Dol Amroth (Rep)", "0x700411AC", "Return to Dol Amroth");
    -- repLocations:AddData("Return to Arnach (Rep)", "0x70043A6A", "Return to Arnach");
    -- repLocations:AddData("Return to Minas Tirith (Rep)", "0x7004497E", "Return to Minas Tirith");
    -- repLocations:AddData("Return to the War-stead (Rep)", "0x700459A9", "Return to the War-stead");
    -- repLocations:AddData("Return to after-battle Minas Tirith (Rep)", "0x70046CC0", "Return to after-battle Minas Tirith");
    -- repLocations:AddData("Return to after-battle Osgiliath (Rep)", "0x7004707D", "Return to after-battle Osgiliath");
    -- repLocations:AddData("Return to after-battle Henneth Annûn (Rep)", "0x70047080", "Return to after-battle Henneth Annûn");
    -- repLocations:AddData("Return to the Camp of the Host (Rep)", "0x70047BF4", "Return to the Camp of the Host");
    -- repLocations:AddData("Return to Haerondir (Rep)", "0x70047C1B", "Return to Haerondir");

    -- Crude Map to Gramsfoot for newb creeps
    creepLocations:AddData("Грубая карта пути к Подножию Грэм", "0x70028BBC", "Грубая карта пути к Подножию Грэм");
    creepLocations:AddData("Карта пути к Подножию Грэм", "0x70028BC1", "Карта пути к Подножию Грэм");

    creepLocations:AddData("Грубая карта пути в Изендип", "0x70028BB3", "Грубая карта пути в Изендип");
    creepLocations:AddData("Грубая карта пути на Тол Аскарнен", "0x70028BB6", "Грубая карта пути на Тол Аскарнен");
    creepLocations:AddData("Грубая карта пути в Лугазаг", "0x70028BB7", "Грубая карта пути в Лугазаг");
    creepLocations:AddData("Грубая карта пути в Тирит Роу", "0x70028BBE", "Грубая карта пути в Тирит Роу");
    creepLocations:AddData("Грубая карта пути в Мрачный лес", "0x70028BBF", "Грубая карта пути в Мрачный лес");

    creepLocations:AddData("Неважная карта пути в Изендип", "0x70028BAF", "Неважная карта пути в Изендип");
    creepLocations:AddData("Неважная карта пути на Тол Аскарнен", "0x70028BB1", "Неважная карта пути на Тол Аскарнен");
    creepLocations:AddData("Неважная карта пути в Лугазаг", "0x70028BB2", "Неважная карта пути в Лугазаг");
    creepLocations:AddData("Неважная карта пути в Тирит Роу", "0x70028BB4", "Неважная карта пути в Тирит Роу");
    creepLocations:AddData("Неважная карта пути в Мрачный лес", "0x70028BB9", "Неважная карта пути в Мрачный лес");

    creepLocations:AddData("Хорошая карта пути в Изендип", "0x70028BC0", "Хорошая карта пути в Изендип");
    creepLocations:AddData("Хорошая карта пути на Тол Аскарнен", "0x70028BC2", "Хорошая карта пути на Тол Аскарнен");
    creepLocations:AddData("Хорошая карта пути в Лугазаг", "0x70028BB5", "Хорошая карта пути в Лугазаг");
    creepLocations:AddData("Хорошая карта пути в Тирит Роу", "0x70028BB0", "Хорошая карта пути в Тирит Роу");
    creepLocations:AddData("Хорошая карта пути в Мрачный лес", "0x70028BBD", "Хорошая карта пути в Мрачный лес");
end


--[[ use a modified table that can maintain a key value for each entry ]] --
IndexedDictionary = class()

function IndexedDictionary:Constructor()

    -- set default tables
    self.listOfKeys = {};
    self.dataPairs = {};
    self.skillNames = {};
    self.numberOfPairs = 0;
end

-- function to get the total number of entries in the dictionary
function IndexedDictionary:GetCount()
    return self.numberOfPairs;
end

-- function to add a key/data pair to the end of the dictionary
function IndexedDictionary:AddData(key, data, name)
    -- increase the counter
    self.numberOfPairs = self.numberOfPairs + 1;

    -- insert the key into the list of keys
    table.insert(self.listOfKeys, key);
    -- add the key/data into the table
    self.dataPairs[key] = data;
    self.skillNames[key] = name;
end

-- function to add a key/data pair at a specific index
function IndexedDictionary:InsertData(index, key, data, name)
    -- increase the counter
    self.numberOfPairs = self.numberOfPairs + 1;

    -- add the key to the list of keys at the specified index
    table.insert(self.listOfKeys, index, key);
    -- add the key/data into the table
    self.dataPairs[key] = data;
    self.skillNames[key] = name;
end

-- function to remove a key/data pair at an index
function IndexedDictionary:RemoveAtIndex(index)

    self.location = 0;
    self.counter = 0;

    -- loop through the main table
    for k, v in pairs(self.dataPairs) do
        self.counter = self.counter + 1;

        -- if the keys match, set the location to remove from the table
        if (k == self.listOfKeys[index]) then
            self.location = self.counter;
        end
    end

    -- remove the item and the key from the tables
    table.remove(self.dataPairs, self.location);
    table.remove(self.listOfKeys, index);

    -- decrease the counters
    self.numberOfPairs = self.numberOfPairs - 1;
end

-- function to get the key at a specified index
function IndexedDictionary:KeyAtIndex(index)
    local string = self.listOfKeys[index];
    return string;
end

-- function to return the data at a specified index
function IndexedDictionary:DataAtIndex(index)
    local string = self.listOfKeys[index];
    local data = self.dataPairs[string];

    return data;
end

-- function to return the name at a specified index
function IndexedDictionary:NameAtIndex(index)
    local string = self.listOfKeys[index];
    local data = self.skillNames[string];

    return data;
end

-- function to return the data pair at an index
function IndexedDictionary:PairAtIndex(index)
    local string = self.listOfKeys[index];
    local data = self.dataPairs[string];

    return string, data;
end

-- function to get the data by a key value
function IndexedDictionary:DataByKey(key)
    return self.dataPairs[key];
end

-- function to find the index value based on a key
function IndexedDictionary:IndexByKey(key)

    -- return if the list of keys is empty
    if (self.listOfKeys == {}) then
        return -1;
    end

    -- loop through the list of keys and search for the key value
    for i = 1, table.getn(self.listOfKeys), 1 do
        -- return the index value if a match is made
        if (self.listOfKeys[i] == key) then
            return i;
        end
    end

    -- return -1 since we did not find a key
    return -1;
end


