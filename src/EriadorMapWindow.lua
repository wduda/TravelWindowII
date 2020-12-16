import "Turbine";
import "Turbine.Debug";
import "Turbine.Gameplay";
import "Turbine.UI";
import "Turbine.UI.Lotro";
import "TravelWindowII.src.extensions";
import "TravelWindowII.src.utils.BitOps";

EriadorMapWindow = class(Turbine.UI.Lotro.Window);

function EriadorMapWindow:Constructor(parent, class, race, shortcuts)
    Turbine.UI.Lotro.Window.Constructor(self);

    --  add a check to see if we load completely
    self.loaded = false;

    -- set size of window
    self.width = 1044;
    self.height = 817;
    self.windowWidth, self.windowHeight = Turbine.UI.Display:GetSize();

    self.mainWindow = parent;
    self.playerClass = class;
    self.playerRace = race;
    self.shortcuts = shortcuts;

    -- table of shortcuts
    self.quickslots = {};

    -- set the default window settings
    self:SetPosition(self.windowWidth / 2 - self.width / 2, self.windowHeight / 2 - self.height / 2);
    self:SetSize(self.width, self.height);
    self:SetBlendMode(Turbine.UI.BlendMode.Undefined);
    self:SetBackColor(Turbine.UI.Color(0.0, 0, 0, 0));
    self:SetText(eriadorMapTitleString);
    self:SetOpacity(1);

    mapLabel = Turbine.UI.Label();
    mapLabel:SetPosition(10, 40);
    mapLabel:SetSize(1024, 768);

    mapLabel:SetBackground(0x41008138);
    mapLabel:SetParent(self);
    mapLabel:SetVisible(true);

    self.mapLocations = {
        -- Hunter skills
        { -1, -1 }, -- Camp
        { 570, 400 }, -- Bree
        { 280, 330 }, -- Thorin's Hall
        { 395, 415 }, -- Michel Delving
        { 650, 280 }, -- Esteldin
        { 455, 245 }, -- Evendim
        { 725, 400 }, -- Ost Guruth
        { 845, 390 }, -- Rivendell
        { 450, 110 }, -- Suri-Kyla
        { 700, 205 }, -- West Angmar
        { 800, 150 }, -- East Angmar
        { 850, 475 }, -- Echad Dunann
        { 960, 480 }, -- 21st Hall
        { -1, -1 }, -- Mirkwood
        { 815, 635 }, -- Enedwaith Harndirion
        { 790, 715 }, -- Galtrev
        { -1, -1 }, -- Stangard
        { -1, -1 }, -- Caras Galadhon
        { 930, 270 }, -- Misty Mountains
        { -1, -1 }, -- Snowbourn
        { -1, -1 }, -- Forlaw
        { -1, -1 }, -- Aldburg
        { -1, -1 }, -- Helm's Deep
        { -1, -1 }, -- Dol Amroth
        { -1, -1 }, -- Arnach
        { -1, -1 }, -- Minas Tirith
        { -1, -1 }, -- War-Stead
        { -1, -1 }, -- After-Battle Minas Tirith
        { -1, -1 }, -- Henneth Annûn
        { -1, -1 }, -- Osgiliath
        { -1, -1 }, -- Camp of the Host
        { -1, -1 }, -- Haerondir
        { -1, -1 }, -- Udûn Foothold
        { -1, -1 }, -- Dale
        { -1, -1 }, -- Jarnafst
        { -1, -1 }, -- Skarhald
        { -1, -1 }, -- Beorningus
        { -1, -1 }, -- Hultvis
        { -1, -1 }, -- Estolad Lân
        { -1, -1 }, -- Limlók
        { -1, -1 }, -- Annâk-khurfu

        -- Warden skills
        { 725, 400 }, -- Ost Guruth
        { 650, 280 }, -- Esteldin
        { 455, 345 }, -- Evendim
        { 845, 390 }, -- Rivendell
        { 450, 110 }, -- Suri-Kyla
        { -1, -1 }, -- 21st Hall
        { -1, -1 }, -- Mirkwood
        { 815, 635 }, -- Enedwaith Harndirion
        { 790, 715 }, -- Galtrev
        { -1, -1 },   -- Stangard
        { -1, -1 },   -- Caras Galadhon
        { 930, 270 }, -- Misty Mountains
        { -1, -1 }, -- Snowbourn
        { -1, -1 }, -- Forlaw
        { -1, -1 }, -- Aldburg
        { -1, -1 }, -- Helm's Deep
        { -1, -1 }, -- Dol Amroth
        { -1, -1 }, -- Arnach
        { -1, -1 }, -- Minas Tirith
        { -1, -1 }, -- War-Stead
        { -1, -1 }, -- After-Battle Minas Tirith
        { -1, -1 }, -- Henneth Annûn
        { -1, -1 }, -- Osgiliath
        { -1, -1 }, -- Camp of the Host
        { -1, -1 }, -- Haerondir
        { -1, -1 }, -- Udûn Foothold
        { -1, -1 }, -- Dale
        { -1, -1 }, -- Jarnafst
        { -1, -1 }, -- Skarhald
        { -1, -1 }, -- Beorningus
        { -1, -1 }, -- Hultvis
        { -1, -1 }, -- Estolad Lân
        { -1, -1 }, -- Limlók
        { -1, -1 }, -- Annâk-khurfu

        -- Reputation skills
        { 305, 330 }, -- Thorin's Hall
        { 595, 400 }, -- Bree
        { 620, 400 }, -- Lalia's Market
        { 420, 415 }, -- Michel Delving
        { 870, 390 }, -- Rivendell
        { 750, 400 }, -- Ost Guruth
        { -1, -1 }, -- Mirkwood
        { 840, 645 }, -- Enedwaith Lhanuch
        { 815, 715 }, -- Galtrev
        { -1, -1 }, -- Stangard
        { -1, -1 }, -- Snowbourn
        { -1, -1 }, -- Forlaw
        { -1, -1 }, -- Aldburg
        { -1, -1 }, -- Derndingle
        { -1, -1 }, -- Helm's Deep
        { -1, -1 }, -- Dol Amroth
        { -1, -1 }, -- Arnach
        { -1, -1 }, -- Minas Tirith
        { -1, -1 }, -- War-Stead
        { -1, -1 }, -- After-Battle Minas Tirith
        { -1, -1 }, -- Henneth Annûn
        { -1, -1 }, -- Osgiliath
        { -1, -1 }, -- Camp of the Host
        { -1, -1 }, -- Haerondir
        { -1, -1 }, -- Udûn Foothold
        { -1, -1 }, -- Court of Lothlórien
        { -1, -1 }, -- Hall of the King
        { -1, -1 }, -- Hall Under the Mountain
        { -1, -1 }, -- Bâr Thorenion
        { -1, -1 }, -- Dale
        { -1, -1 }, -- Jarnafst
        { -1, -1 }, -- Skarhald
        { -1, -1 }, -- Beorningus
        { -1, -1 }, -- Hultvis
        { -1, -1 }, -- Estolad Lân
        { -1, -1 }, -- Limlók
        { -1, -1 }, -- Annâk-khurfu

        -- Racial skills
        { 620, 400 }, -- Bree
        { 445, 415 }, -- Michel Delving
        { 330, 330 }, -- Thorin's Hall
        { 895, 390 }, -- Rivendell
        { -1, -1 },   -- Grimbeorn's House
        { -1, -1 },   -- Caras Galadhon
        { 330, 330 }, -- Thorin's Gate

        -- Moors Map
        { 815, 300 }    -- Ettenmoors
    };

    self:AddShortcuts();

    self:SetVisible(true);

    -- have the main window close the options
    self.VisibleChanged = function(sender, args)
        if (self:IsVisible() == false) then
            if (parent ~= nil) then
                parent:CloseEriadorMap();
            end
        end
    end

    self.loaded = true;
end

function EriadorMapWindow:AddShortcuts()

    local counter = 1;

    -- hunter locations
    for i = 1, travelCount[1], 1 do

        -- add hunter locations if they should be on this map
        if (self.mapLocations[counter][1] > 0 and self.playerClass == Turbine.Gameplay.Class.Hunter and self:IsShortcutEnabled(hunterLocations:KeyAtIndex(i)) == 1) then
            self:AddSingleShortcut(counter, Turbine.UI.Lotro.Shortcut(6.0, hunterLocations:DataAtIndex(i)));
        end

        counter = counter + 1;
    end

    -- warden locations
    for i = 1, travelCount[2], 1 do

        -- add warden locations if they should be on this map
        if (self.mapLocations[counter][1] > 0 and self.playerClass == 194 and self:IsShortcutEnabled(wardenLocations:KeyAtIndex(i)) == 1) then
            self:AddSingleShortcut(counter, Turbine.UI.Lotro.Shortcut(6.0, wardenLocations:DataAtIndex(i)));
        end

        counter = counter + 1;
    end

    -- reputation locations
    for i = 1, travelCount[4], 1 do

        -- add rep locations if they should be on this map
        if (self.mapLocations[counter][1] > 0 and self:IsShortcutEnabled(repLocations:KeyAtIndex(i)) == 1) then
            self:AddSingleShortcut(counter, Turbine.UI.Lotro.Shortcut(6.0, repLocations:DataAtIndex(i)));
        end

        counter = counter + 1;
    end

    -- racial locations
    for i = 1, travelCount[5], 1 do

        if (self.mapLocations[counter][1] > 0 and self:IsShortcutEnabled(racialLocations:KeyAtIndex(i)) == 1) then
            if (i == self.playerRace) then
                self:AddSingleShortcut(counter, Turbine.UI.Lotro.Shortcut(6.0, racialLocations:DataAtIndex(i)));
            end
        end

        counter = counter + 1;
    end

    -- Glan Vraig
    for i = 1, #self.shortcuts, 1 do
        if (self.shortcuts[i]:GetName() == glanMapString) then
            if (self.shortcuts[i]:IsEnabled()) then
                self:AddSingleShortcut(counter, self.shortcuts[i]);
            end
        end
    end
end

function EriadorMapWindow:AddSingleShortcut(index, shortcut)

    self.quickslots[index] = Turbine.UI.Lotro.Quickslot();

    self.quickslots[index]:SetShortcut(shortcut);

    self.quickslots[index]:SetOpacity(1);
    self.quickslots[index]:SetParent(mapLabel);
    self.quickslots[index]:SetAllowDrop(false);
    self.quickslots[index]:SetMouseVisible(true);
    self.quickslots[index]:SetUseOnRightClick(false);
    self.quickslots[index]:SetAllowDrop(false);

    self.quickslots[index]:SetStretchMode(1);
    self.quickslots[index]:SetSize(22, 22);
    self.quickslots[index]:SetPosition(self.mapLocations[index][1], self.mapLocations[index][2]);
    self.quickslots[index]:SetZOrder(98);
    self.quickslots[index]:SetVisible(true);

    self.quickslots[index].MouseClick = function(sender, args)
        self:SetVisible(false);
    end
end

function EriadorMapWindow:IsShortcutEnabled(name)

    -- loop through all the shortcuts and add those that are enabled
    for i = 1, #self.shortcuts, 1 do
        if (self.shortcuts[i]:GetName() == name) then
            if (self.shortcuts[i]:IsEnabled()) then
                return 1;
            end
        end
    end

    return 0;
end
