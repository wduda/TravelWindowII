-- SettingsManager.lua
-- Manages all plugin settings including persistence, migration, and configuration

-- Map type enumeration (global, used by SkillData, TravelMapTab, and other files)
MapType = {
    NONE = 1,
    CREEPS = 2,
    ERIADOR = 3,
    RHOVANION = 4,
    ROHAN = 5,
    GONDOR = 6,
    HARADWAITH = 7,
}

-- Tab/Mode type enumeration (global, used by TravelWindow, OptionsPanel, SettingsMenu)
TabId = {
    LIST = 1,
    GRID = 2,
    CARO = 3,
    PULL = 4,
    MAP = 5,
}

function SetPlayerRaceKey()
    -- map player race to racial travel skill index for insertion into available travel skills
    if (PlayerRace == Turbine.Gameplay.Race.Dwarf) then
        PlayerRaceKey = 3
    elseif (PlayerRace == Turbine.Gameplay.Race.Elf) then
        PlayerRaceKey = 4
    elseif (PlayerRace == Turbine.Gameplay.Race.Hobbit) then
        PlayerRaceKey = 2
    elseif (PlayerRace == Turbine.Gameplay.Race.Man) then
        PlayerRaceKey = 1
    elseif (PlayerRace == Turbine.Gameplay.Race.Beorning) then
        PlayerRaceKey = 5
    elseif (PlayerRace == Turbine.Gameplay.Race.HighElf) then
        PlayerRaceKey = 6
    elseif (PlayerRace == Turbine.Gameplay.Race.StoutAxe) then
        PlayerRaceKey = 7
    elseif (PlayerRace == Turbine.Gameplay.Race.RiverHobbit) then
        PlayerRaceKey = 8
    else
        PlayerRaceKey = 1 -- default to man race to prevent errors
    end
end

function InitDefaultSettings()
    -- set all settings to default values
    Settings = {}
    Settings.lastLoadedVersion = Plugins["Travel Window II"]:GetVersion()

    for k, v in pairs(SettingsConfig) do
        if v.defValue ~= nil then
            Settings[k] = v.defValue
        end
    end
end

function InitNumberSetting(strTable, name, forceDefault)
    if strTable[name] == nil or strTable[name] == "nil" then
        if forceDefault == nil then
            strTable[name] = tostring(Settings[name])
        else
            strTable[name] = tostring(forceDefault)
        end
    end
    if type(strTable[name]) == "string" then
        Settings[name] = tonumber(strTable[name])
    else
        Settings[name] = strTable[name]
    end
end

function AddSettingConfig(name, defValue)
    SettingsConfig[name] = {}
    SettingsConfig[name].defValue = defValue
    if type(defValue) == "number" then
        SettingsConfig[name].init = InitNumberSetting
        SettingsConfig[name].save = tostring
    end
end

function CreateSettingsConfig()
    SettingsConfig = {}

    AddSettingConfig("gridCols", 0)
    AddSettingConfig("gridRows", 0)
    AddSettingConfig("listWidth", 0)
    AddSettingConfig("listRows", 0)
    AddSettingConfig("pullWidth", 0)
    AddSettingConfig("positionRelativeX", 0.75)
    AddSettingConfig("positionRelativeY", 0.75)
    AddSettingConfig("mapPositionRelativeX", 0.5)  -- Default to center for MAP mode
    AddSettingConfig("mapPositionRelativeY", 0.5)  -- Default to center for MAP mode
    AddSettingConfig("buttonRelativeX", 0.95)
    AddSettingConfig("buttonRelativeY", 0.75)
    AddSettingConfig("useMinWindow", 0)
    AddSettingConfig("hideOnStart", 0)
    AddSettingConfig("hideOnCombat", 0)
    AddSettingConfig("hideOnTravel", 0)
    AddSettingConfig("pulldownTravel", 0)
    AddSettingConfig("useZoneNames", 1)
    AddSettingConfig("useSkillNames", 0)
    AddSettingConfig("useTagInListTab", 1)
    AddSettingConfig("lockUI", 0)
    AddSettingConfig("unlockKeyPress", 0)
    AddSettingConfig("escapeToClose", 1)
    AddSettingConfig("showButton", 1)
    AddSettingConfig("mode", 2)
    AddSettingConfig("mapViewRegion", 3)
    AddSettingConfig("filters", 0x0F)
    AddSettingConfig("mainMaxOpacity", 1)
    AddSettingConfig("mainMinOpacity", 0.5)
    AddSettingConfig("fadeOutSteps", 1)
    AddSettingConfig("fadeOutDelay", 0)
    AddSettingConfig("toggleMaxOpacity", 1)
    AddSettingConfig("toggleMinOpacity", 0.5)
end

function LoadSettings()
    CreateSettingsConfig()
    InitDefaultSettings()

    -- load TWII settings file
    local settingsStrings = PatchDataLoad(Turbine.DataScope.Character, "TravelWindowIISettings")
    AccountSettingsStrings = PatchDataLoad(Turbine.DataScope.Account, "TravelWindowIISettings")

    -- save a daily backup of settings
    if (settingsStrings) then
        settingsStrings.backupTime = "#" .. Turbine.Engine.GetGameTime()
        local dateInfo = Turbine.Engine.GetDate()
        PatchDataSave(Turbine.DataScope.Character, "TravelWindowIISettings_backup" .. dateInfo.DayOfWeek,
                      settingsStrings)
    end

    -- try importing Travel Window I settings if new settings were not found
    local importOldSettings = false
    if (settingsStrings == nil) then
        local result
        importOldSettings, result = pcall(function()
            settingsStrings = PatchDataLoad(Turbine.DataScope.Character, "TravelWindowSettings")
        end)
    end

    AccountSettingsStrings = SetSettings(AccountSettingsStrings, Turbine.DataScope.Account)
    SetSettings(settingsStrings, Turbine.DataScope.Character, importOldSettings)
end

function GetVersionNumber(version)
    if type(version) ~= "string" then
        return 0
    end

    if version:sub(1, 1) == "v" then
        version = version:sub(2)
    end
    local major, minor, patch
    for num in version:gmatch("[^.]+") do
        if major == nil then
            major = tonumber(num)
        elseif minor == nil then
            minor = tonumber(num)
        elseif patch == nil then
            patch = tonumber(num:match("%d+"))
        else
            return 0 -- invalid format
        end
    end
    if major == nil then major = 0 end
    if minor == nil then minor = 0 end
    if patch == nil then patch = 0 end
    return (major * (2 ^ 16)) + (minor * (2 ^ 8)) + patch
end

function ToRelativePosSetting(settingsArg, absMax, absName, relName)
    local relative = Settings[relName]
    if settingsArg[absName] ~= nil and settingsArg[absName] ~= "nil" then
        if tonumber(settingsArg[absName]) < absMax then
            relative = tonumber(settingsArg[absName]) / absMax
            if relative > 1.0 then
                relative = Settings[relName]
            end
        end
        settingsArg[absName] = nil
    end
    SettingsConfig[relName].forceDefaultInit = relative
end

function SetSettings(settingsArg, scope, importOldSettings)
    -- initialze any uninitialized settings strings
    if (type(settingsArg) ~= "table") then
        settingsArg = {}
    end

    local currentVersion = tostring(Plugins["Travel Window II"]:GetVersion())

    if (not settingsArg.lastLoadedVersion or settingsArg.lastLoadedVersion == "nil") then
        -- First time loading - no notification
        settingsArg.lastLoadedVersion = currentVersion
    else
        -- Check if version changed (only show notification for Account scope - account-wide behavior)
        if scope == Turbine.DataScope.Account then
            local lastVersionNum = GetVersionNumber(settingsArg.lastLoadedVersion)
            local currentVersionNum = GetVersionNumber(currentVersion)

            if lastVersionNum < currentVersionNum then
                -- Version updated - show notification window
                TravelWindowII.src.UpdateNotificationWindow(
                    currentVersion,
                    settingsArg.lastLoadedVersion,  -- Pass lastVersion for filtering
                    function()
                        -- "Close" button clicked - save new version (account-wide)
                        settingsArg.lastLoadedVersion = currentVersion
                        Settings.lastLoadedVersion = currentVersion
                        -- Settings will be saved automatically on plugin unload
                    end,
                    function()
                        -- "Show Again Later" clicked - don't save version
                        -- Do nothing, version stays as old value
                    end
                )
            else
                -- Version same or downgraded (shouldn't happen) - no notification
                settingsArg.lastLoadedVersion = currentVersion
            end
        else
            -- For Character scope, just update the version without showing notification
            settingsArg.lastLoadedVersion = currentVersion
        end
    end

    local screenW = Turbine.UI.Display.GetWidth()
    local screenH = Turbine.UI.Display.GetHeight()

    -- fixup deprecated positionX/Y and buttonPositionX/Y
    ToRelativePosSetting(settingsArg, screenW, "positionX", "positionRelativeX")
    ToRelativePosSetting(settingsArg, screenH, "positionY", "positionRelativeY")
    ToRelativePosSetting(settingsArg, screenW, "buttonPositionX", "buttonRelativeX")
    ToRelativePosSetting(settingsArg, screenH, "buttonPositionY", "buttonRelativeY")

    -- convert ignoreEsc to escapeToClose
    if settingsArg.ignoreEsc ~= nil and settingsArg.ignoreEsc ~= "nil" then
        if tonumber(settingsArg.ignoreEsc) == 0 then
            settingsArg.escapeToClose = 1
        else
            settingsArg.escapeToClose = 0
        end
        settingsArg.ignoreEsc = nil
    end

    for k, v in pairs(SettingsConfig) do
        if v.init == InitNumberSetting then
            v.init(settingsArg, k, v.forceDefaultInit)
        elseif v.init ~= nil then
            v.init(settingsArg, k)
        end
    end

    if (not settingsArg.enabled or importOldSettings) then
        settingsArg.enabled = {}
    end

    if ((not settingsArg.order) or importOldSettings) then
        settingsArg.order = {}
    end

    -- Only set Settings.lastLoadedVersion from Account scope (account-wide behavior)
    if scope == Turbine.DataScope.Account then
        Settings.lastLoadedVersion = settingsArg.lastLoadedVersion
    end

    LoadEnabled = {}
    for k, v in pairs(settingsArg.enabled) do
        if type(k) == "number" then
            k = string.format("0x%X", k)
        end
        LoadEnabled[k] = v
    end

    LoadOrder = {}
    LoadOrderNext = 1
    for loc, id in pairs(settingsArg.order) do
        LoadOrderNext = LoadOrderNext + 1
        if (type(loc) == "string") then
            loc = tonumber(loc)
        end
        LoadOrder[id] = loc
    end

    if scope == Turbine.DataScope.Account then
        -- settingsArg.enabled/order should keep the racial id tag
        settingsArg.enabled = TableCopy(LoadEnabled)
        local order = {}
        for k, v in pairs(LoadOrder) do order[v] = k end
        settingsArg.order = order

        -- replace racial id tag with current racial skill
        if LoadEnabled[TravelInfo.racialIDTag] ~= nil then
            LoadEnabled[TravelInfo.racial.id] = LoadEnabled[TravelInfo.racialIDTag]
            LoadEnabled[TravelInfo.racialIDTag] = nil
        end
        if LoadOrder[TravelInfo.racialIDTag] ~= nil then
            LoadOrder[TravelInfo.racial.id] = LoadOrder[TravelInfo.racialIDTag]
            LoadOrder[TravelInfo.racialIDTag] = nil
        end

        local ver = GetVersionNumber(settingsArg.lastLoadedVersion)
        if ver <= 0x20100 then
            -- fix broken files
            for k, racial in pairs(TravelInfo.racials.skills) do
                if k ~= PlayerRaceKey then
                    -- clear entries that are not the current race
                    if LoadEnabled[racial.id] ~= nil then
                        -- found entry to clear
                        if LoadEnabled[TravelInfo.racial.id] == nil then
                            -- set to the current race first
                            LoadEnabled[TravelInfo.racial.id] = LoadEnabled[racial.id]
                        end
                        LoadEnabled[racial.id] = nil
                    end
                    if LoadOrder[racial.id] ~= nil then
                        -- found entry to clear
                        if LoadOrder[TravelInfo.racial.id] == nil then
                            -- set to the current race first
                            LoadOrder[TravelInfo.racial.id] = LoadOrder[racial.id]
                        end
                        LoadOrder[racial.id] = nil
                    end
                end
            end
        end
    end

    return settingsArg
end

function SaveSettings(scope)
    if scope == nil then
        scope = Turbine.DataScope.Character
    end

    local settingsStrings = {}

    -- Only save lastLoadedVersion for Account scope (account-wide behavior)
    if scope == Turbine.DataScope.Account then
        -- Use the version from Settings (may be old if user clicked "Show Again Later")
        settingsStrings.lastLoadedVersion = Settings.lastLoadedVersion or Plugins["Travel Window II"]:GetVersion()
    end

    for k, v in pairs(SettingsConfig) do
        if v.save ~= nil then
            settingsStrings[k] = v.save(Settings[k])
        end
    end

    settingsStrings.enabled = GetTravelEnabled(scope)
    settingsStrings.order = GetTravelOrder(scope)

    if scope == Turbine.DataScope.Account then
        AccountSettingsStrings = settingsStrings
    end

    -- save the settings
    PatchDataSave(scope, "TravelWindowIISettings", settingsStrings)
end

function ClearLoaders()
    LoadOrder = nil
    LoadEnabled = nil
    LoadOrderNext = nil
end

function BlockUIChange(control)
    return (Settings.lockUI == 1) and
        (Settings.unlockKeyPress == 0 or not control:IsShiftKeyDown())
end
