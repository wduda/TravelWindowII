import "Turbine";
import "Turbine.Debug";
import "Turbine.Gameplay";
import "Turbine.UI";
import "Turbine.UI.Lotro";
import "DhorPlugins.Extensions";
import "DhorPlugins.Utils.BitOps";

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
        { 575, 415 }, -- Bree
        { 305, 300 }, -- Thorin's Hall
        { 450, 415 }, -- Michel Delving
        { 640, 270 }, -- Esteldin
        { 485, 340 }, -- Evendim
        { 710, 390 }, -- Ost Guruth
        { 870, 375 }, -- Rivendell
        { 435, 180 }, -- Suri-Kyla
        { 710, 220 }, -- West Angmar
        { 750, 220 }, -- East Angmar
        { 870, 535 }, -- Echad Dunann
        { -1, -1 }, -- 21st Hall
        { -1, -1 }, -- Mirkwood
        { 815, 645 }, -- Enedwaith Harndirion
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

        -- Warden skills
        { 710, 390 }, -- Ost Guruth
        { 640, 270 }, -- Esteldin
        { 485, 340 }, -- Evendim
        { 870, 375 }, -- Rivendell
        { 435, 180 }, -- Suri-Kyla
        { -1, -1 }, -- 21st Hall
        { -1, -1 }, -- Mirkwood
        { 815, 645 }, -- Enedwaith Harndirion
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

        -- Reputation skills
        { 330, 300 }, -- Thorin's Hall
        { 600, 415 }, -- Bree
        { 650, 415 }, -- Lalia's Market
        { 475, 415 }, -- Michel Delving
        { 895, 375 }, -- Rivendell
        { 735, 390 }, -- Ost Guruth
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

        -- Racial skills
        { 625, 340 }, -- Bree
        { 500, 415 }, -- Michel Delving
        { 355, 300 }, -- Thorin's Hall
        { 920, 375 }, -- Rivendell
        { -1, -1 }, -- Grimbeorn's House
        { -1, -1 }, -- Caras Galadhon

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
    for i = 1, table.getn(self.shortcuts), 1 do
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
    for i = 1, table.getn(self.shortcuts), 1 do
        if (self.shortcuts[i]:GetName() == name) then
            if (self.shortcuts[i]:IsEnabled()) then
                return 1;
            end
        end
    end

    return 0;
end
