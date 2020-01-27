import "Turbine";
import "Turbine.Debug";
import "Turbine.Gameplay";
import "Turbine.UI";
import "Turbine.UI.Lotro";
import "DhorPlugins.Extensions";
import "DhorPlugins.Utils.BitOps";

GondorMapWindow = class(Turbine.UI.Lotro.Window);

function GondorMapWindow:Constructor(parent, class, race, shortcuts)
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
    self:SetText(gondorMapTitleString);
    self:SetOpacity(1);

    mapLabel = Turbine.UI.Label();
    mapLabel:SetPosition(10, 40);
    mapLabel:SetSize(1024, 768);

    mapLabel:SetBackground(0x41154336);
    mapLabel:SetParent(self);
    mapLabel:SetVisible(true);

    self.mapLocations = {
        -- Hunter skills
        { -1, -1 }, -- Camp
        { -1, -1 }, -- Bree
        { -1, -1 }, -- Thorin's Hall
        { -1, -1 }, -- Michel Delving
        { -1, -1 }, -- Esteldin
        { -1, -1 }, -- Evendim
        { -1, -1 }, -- Ost Guruth
        { -1, -1 }, -- Rivendell
        { -1, -1 }, -- Suri-Kyla
        { -1, -1 }, -- West Angmar
        { -1, -1 }, -- East Angmar
        { -1, -1 }, -- Echad Dunann
        { -1, -1 }, -- 21st Hall
        { -1, -1 }, -- Mirkwood
        { -1, -1 }, -- Enedwaith Harndirion
        { -1, -1 }, -- Galtrev
        { -1, -1 }, -- Stangard
        { -1, -1 }, -- Caras Galadhon
        { -1, -1 }, -- Misty Mountains
        { 425, 100 }, -- Snowbourn
        { -1, -1 }, -- Forlaw
        { 425, 225 }, -- Aldburg
        { 175, 150 }, -- Helm's Deep
        { 250, 500 }, -- Dol Amroth
        { 700, 525 }, -- Arnach
        { 750, 370 }, -- Minas Tirith
        { 650, 225 }, -- War-Stead
        { 750, 395 }, -- After-Battle Minas Tirith
        { 850, 250 }, -- Henneth Annûn
        { 825, 400 }, -- Osgiliath
        { 825, 200 }, -- Camp of the Host
        { 850, 150 }, -- Haerondir
        { 925, 225 }, -- Udûn Foothold
        { -1, -1 }, -- Dale
        { -1, -1 }, -- Jarnfast
        { -1, -1 }, -- Skarhald
        { -1, -1 }, -- Beorningerhus
        { -1, -1 }, -- Hultvis
        
        -- Muster skills
        { -1, -1 }, -- Ost Guruth
        { -1, -1 }, -- Esteldin
        { -1, -1 }, -- Evendim
        { -1, -1 }, -- Rivendell
        { -1, -1 }, -- Suri-Kyla
        { -1, -1 }, -- 21st Hall
        { -1, -1 }, -- Mirkwood
        { -1, -1 }, -- Enedwaith Harndirion
        { -1, -1 }, -- Galtrev
        { -1, -1 }, -- Stangard
        { -1, -1 }, -- Caras Galadhon
        { -1, -1 }, -- Misty Mountains
        { 425, 100 }, -- Snowbourn
        { -1, -1 }, -- Forlaw
        { 425, 225 }, -- Aldburg
        { 175, 150 }, -- Helm's Deep
        { 250, 500 }, -- Dol Amroth
        { 700, 525 }, -- Arnach
        { 750, 370 }, -- Minas Tirith
        { 650, 225 }, -- War-Stead
        { 750, 395 }, -- After-Battle Minas Tirith
        { 850, 250 }, -- Henneth Annûn
        { 825, 400 }, -- Osgiliath
        { 825, 200 }, -- Camp of the Host
        { 850, 150 }, -- Haerondir
        { 925, 225 }, -- Udûn Foothold
        { -1, -1 }, -- Dale
        { -1, -1 }, -- Jarnfast
        { -1, -1 }, -- Skarhald
        { -1, -1 }, -- Beorningerhus
        { -1, -1 }, -- Hultvis
        
        -- Reputation skills
        { -1, -1 }, -- Thorin's Hall
        { -1, -1 }, -- Bree
        { -1, -1 }, -- Lalia's Market
        { -1, -1 }, -- Michel Delving
        { -1, -1 }, -- Rivendell
        { -1, -1 }, -- Ost Guruth
        { -1, -1 }, -- Mirkwood
        { -1, -1 }, -- Enedwaith Lhanuch
        { -1, -1 }, -- Galtrev
        { -1, -1 }, -- Stangard
        { 450, 100 }, -- Snowbourn
        { -1, -1 }, -- Forlaw
        { 450, 225 }, -- Aldburg
        { -1, -1 }, -- Derndingle
        { 200, 150 }, -- Helm's Deep
        { 275, 500 }, -- Dol Amroth
        { 700, 500 }, -- Arnach
        { 775, 370 }, -- Minas Tirith
        { 675, 225 }, -- War-Stead
        { 775, 395 }, -- After-Battle Minas Tirith
        { 875, 250 }, -- Henneth Annûn
        { 850, 400 }, -- Osgiliath
        { 850, 200 }, -- Camp of the Host
        { 875, 150 }, -- Haerondir
        { 950, 225 }, -- Udûn Foothold
        { -1, -1 }, -- Court of Lothlórien
        { 750, 325 }, -- Hall of the King
        { -1, -1 }, -- Hall Under the Mountain
        { -1, -1 }, -- Bâr Thorenion
        { -1, -1 }, -- Dale
        { -1, -1 }, -- Jarnfast
        { -1, -1 }, -- Skarhald
        { -1, -1 }, -- Beorningerhus
        { -1, -1 }, -- Hultvis
        
        -- Racial skills
        { -1, -1 }, -- Bree
        { -1, -1 }, -- Michel Delving
        { -1, -1 }, -- Thorin's Hall
        { -1, -1 }, -- Rivendell
        { -1, -1 }, -- Grimbeorn's House
        { -1, -1 }, -- Caras Galadhon

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

function GondorMapWindow:AddShortcuts()

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

        --Turbine.Shell.WriteLine(counter);
        counter = counter + 1;
    end
end

function GondorMapWindow:AddSingleShortcut(index, shortcut)

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

function GondorMapWindow:IsShortcutEnabled(name)

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
