import "Turbine";
import "Turbine.Debug";
import "Turbine.Gameplay";
import "Turbine.UI";
import "Turbine.UI.Lotro";
import "TravelWindowII.src.extensions";
import "TravelWindowII.src.utils.BitOps";

RhovanionMapWindow = class(Turbine.UI.Lotro.Window);

function RhovanionMapWindow:Constructor(parent, class, race, shortcuts)
    Turbine.UI.Lotro.Window.Constructor(self);

    --  add a check to see if we load completely
    self.loaded = false;

    -- set size of window
    self.width = 1044;
    self.height = 817;
    self.windowWidth, self.windowHeight = Turbine.UI.Display:GetSize();

    self.mainWindow = parent;
    self.PlayerClass = class;
    self.PlayerRace = race;
    self.shortcuts = shortcuts;

    -- table of shortcuts
    self.quickslots = {};

    -- set the default window settings
    self:SetPosition(self.windowWidth / 2 - self.width / 2,
                     self.windowHeight / 2 - self.height / 2);
    self:SetSize(self.width, self.height);
    self:SetBlendMode(Turbine.UI.BlendMode.Undefined);
    self:SetBackColor(Turbine.UI.Color(0.0, 0, 0, 0));
    self:SetText(rhovanionMapTitleString);
    self:SetOpacity(1);

    self.mapLabel = Turbine.UI.Label();
    self.mapLabel:SetPosition(10, 40);
    self.mapLabel:SetSize(1024, 768);

    self.mapLabel:SetBackground(0x411C2DE4);
    self.mapLabel:SetParent(self);
    self.mapLabel:SetVisible(true);

    self.mapLocations = {
        -- Hunter skills
        {-1, -1}, -- Camp
        {-1, -1}, -- Bree
        {-1, -1}, -- Thorin's Hall
        {-1, -1}, -- Michel Delving
        {-1, -1}, -- Esteldin
        {-1, -1}, -- Evendim
        {-1, -1}, -- Ost Guruth
        {-1, -1}, -- Rivendell
        {-1, -1}, -- Suri-Kyla
        {-1, -1}, -- West Angmar
        {-1, -1}, -- East Angmar
        {-1, -1}, -- Echad Dunann
        {285, 325}, -- 21st Hall
        {460, 360}, -- Mirkwood
        {-1, -1}, -- Enedwaith Harndirion
        {-1, -1}, -- Galtrev
        {400, 360}, -- Stangard
        {360, 345}, -- Caras Galadhon
        {-1, -1}, -- Misty Mountains
        {420, 650}, -- Snowbourn
        {380, 460}, -- Forlaw
        {320, 715}, -- Aldburg
        {235, 700}, -- Helm's Deep
        {-1, -1}, -- Dol Amroth
        {-1, -1}, -- Arnach
        {-1, -1}, -- Minas Tirith
        {-1, -1}, -- War-stead
        {-1, -1}, -- After-Battle Minas Tirith
        {-1, -1}, -- Osgiliath
        {-1, -1}, -- Henneth Annûn
        {-1, -1}, -- Camp of the Host
        {-1, -1}, -- Haerondir
        {-1, -1}, -- Udûn Foothold
        {-1, -1}, -- Dale
        {-1, -1}, -- Jarnafst
        {-1, -1}, -- Skarhald
        {-1, -1}, -- Beorningus
        {-1, -1}, -- Hultvis
        {-1, -1}, -- Estolad Lân
        {-1, -1}, -- Limlók
        {-1, -1}, -- Annâk-khurfu
        {-1, -1}, -- Trader's Wharf
        {-1, -1}, -- Trestlebridge
        {-1, -1}, -- U30 A
        {-1, -1}, -- U30 B
        {-1, -1}, -- U31 A
        {-1, -1}, -- U31 B

        -- Muster skills
        {-1, -1}, -- Ost Guruth
        {-1, -1}, -- Esteldin
        {-1, -1}, -- Evendim
        {-1, -1}, -- Rivendell
        {-1, -1}, -- Suri-Kyla
        {285, 325}, -- 21st Hall
        {460, 360}, -- Mirkwood
        {-1, -1}, -- Enedwaith Harndirion
        {-1, -1}, -- Galtrev
        {400, 360}, -- Stangard
        {360, 345}, -- Caras Galadhon
        {-1, -1}, -- Misty Mountains
        {425, 650}, -- Snowbourn
        {385, 460}, -- Forlaw
        {325, 715}, -- Aldburg
        {240, 700}, -- Helm's Deep
        {-1, -1}, -- Dol Amroth
        {-1, -1}, -- Arnach
        {-1, -1}, -- Minas Tirith
        {-1, -1}, -- War-stead
        {-1, -1}, -- After-Battle Minas Tirith
        {-1, -1}, -- Osgiliath
        {-1, -1}, -- Henneth Annûn
        {-1, -1}, -- Camp of the Host
        {-1, -1}, -- Haerondir
        {-1, -1}, -- Udûn Foothold
        {-1, -1}, -- Dale
        {-1, -1}, -- Jarnafst
        {-1, -1}, -- Skarhald
        {-1, -1}, -- Beorningus
        {-1, -1}, -- Hultvis
        {-1, -1}, -- Estolad Lân
        {-1, -1}, -- Limlók
        {-1, -1}, -- Annâk-khurfu
        {-1, -1}, -- Trader's Wharf
        {-1, -1}, -- Trestlebridge
        {-1, -1}, -- U30 A
        {-1, -1}, -- U30 B
        {-1, -1}, -- U31 A
        {-1, -1}, -- U31 B

        -- Reputation skills
        {-1, -1}, -- Thorin's Hall
        {-1, -1}, -- Bree
        {-1, -1}, -- Lalia's Market
        {-1, -1}, -- Michel Delving
        {-1, -1}, -- Rivendell
        {-1, -1}, -- Ost Guruth
        {485, 360}, -- Mirkwood
        {-1, -1}, -- Enedwaith Lhanuch
        {-1, -1}, -- Galtrev
        {425, 360}, -- Stangard
        {400, 650}, -- Snowbourn
        {360, 460}, -- Forlaw
        {300, 715}, -- Aldburg
        {280, 520}, -- Derndingle
        {215, 700}, -- Helm's Deep
        {-1, -1}, -- Dol Amroth
        {-1, -1}, -- Arnach
        {-1, -1}, -- Minas Tirith
        {-1, -1}, -- War-Stead
        {-1, -1}, -- After-Battle Minas Tirith
        {-1, -1}, -- Henneth Annûn
        {-1, -1}, -- Osgiliath
        {-1, -1}, -- Camp of the Host
        {-1, -1}, -- Haerondir
        {-1, -1}, -- Udûn Foothold
        {-1, -1}, -- Court of Lothlórien
        {-1, -1}, -- Hall of the King
        {-1, -1}, -- Hall Under the Mountain
        {-1, -1}, -- Bâr Thorenion
        {-1, -1}, -- Dale
        {-1, -1}, -- Jarnafst
        {-1, -1}, -- Skarhald
        {-1, -1}, -- Beorningus
        {-1, -1}, -- Hultvis
        {-1, -1}, -- Estolad Lân
        {-1, -1}, -- Limlók
        {-1, -1}, -- Annâk-khurfu
        {-1, -1}, -- Trader's Wharf
        {-1, -1}, -- Trestlebridge
        {-1, -1}, -- U30 A
        {-1, -1}, -- U30 B
        {-1, -1}, -- U31 A
        {-1, -1}, -- U31 B
        {-1, -1}, -- U31 C

        -- Racial skills
        {-1, -1}, -- Bree
        {-1, -1}, -- Michel Delving
        {-1, -1}, -- Thorin's Hall
        {-1, -1}, -- Rivendell
        {405, 180}, -- Grimbeorn's House
        {-1, -1}, -- Caras Galadhon
        {-1, -1} -- Thorin's Hall
    };
    self:AddShortcuts();

    self:SetVisible(true);

    -- have the main window close the options
    self.VisibleChanged = function(sender, args)
        if (self:IsVisible() == false) then
            if (parent ~= nil) then parent:CloseEriadorMap(); end
        end
    end

    self.loaded = true;
end

function RhovanionMapWindow:AddShortcuts()

    local counter = 1;

    -- hunter locations
    for i = 1, travelCount[1], 1 do

        -- add hunter locations if they should be on this map
        if (self.mapLocations[counter][1] > 0 and self.PlayerClass ==
            Turbine.Gameplay.Class.Hunter and
            self:IsShortcutEnabled(hunterLocations:IdAtIndex(i)) == 1) then
            self:AddSingleShortcut(counter, Turbine.UI.Lotro.Shortcut(6.0,
                                                                      hunterLocations:IdAtIndex(
                                                                          i)));
        end

        counter = counter + 1;
    end

    -- warden locations
    for i = 1, travelCount[2], 1 do

        -- add warden locations if they should be on this map
        if (self.mapLocations[counter][1] > 0 and self.PlayerClass ==
            Turbine.Gameplay.Class.Warden and
            self:IsShortcutEnabled(wardenLocations:IdAtIndex(i)) == 1) then
            self:AddSingleShortcut(counter, Turbine.UI.Lotro.Shortcut(6.0,
                                                                      wardenLocations:IdAtIndex(
                                                                          i)));
        end
        counter = counter + 1;
    end

    -- reputation locations
    for i = 1, travelCount[4], 1 do

        -- add rep locations if they should be on this map
        if (self.mapLocations[counter][1] > 0 and
            self:IsShortcutEnabled(repLocations:IdAtIndex(i)) == 1) then
            self:AddSingleShortcut(counter, Turbine.UI.Lotro.Shortcut(6.0,
                                                                      repLocations:IdAtIndex(
                                                                          i)));
        end

        counter = counter + 1;
    end

    -- racial locations
    for i = 1, travelCount[5], 1 do

        if (self.mapLocations[counter][1] > 0 and
            self:IsShortcutEnabled(racialLocations:IdAtIndex(i)) == 1) then
            if (i == self.PlayerRace) then
                self:AddSingleShortcut(counter, Turbine.UI.Lotro.Shortcut(6.0,
                                                                          racialLocations:IdAtIndex(
                                                                              i)));
            end
        end

        counter = counter + 1;
    end
end

function RhovanionMapWindow:AddSingleShortcut(index, shortcut)

    self.quickslots[index] = Turbine.UI.Lotro.Quickslot();

    self.quickslots[index]:SetShortcut(shortcut);

    self.quickslots[index]:SetOpacity(1);
    self.quickslots[index]:SetParent(self.mapLabel);
    self.quickslots[index]:SetAllowDrop(false);
    self.quickslots[index]:SetMouseVisible(true);
    self.quickslots[index]:SetUseOnRightClick(false);
    self.quickslots[index]:SetAllowDrop(false);

    self.quickslots[index]:SetStretchMode(1);
    self.quickslots[index]:SetSize(22, 22);
    self.quickslots[index]:SetPosition(self.mapLocations[index][1],
                                       self.mapLocations[index][2]);
    self.quickslots[index]:SetZOrder(98);
    self.quickslots[index]:SetVisible(true);

    self.quickslots[index].MouseClick = function(sender, args)
        self:SetVisible(false);
    end
end

function RhovanionMapWindow:IsShortcutEnabled(id)

    -- loop through all the shortcuts and add those that are enabled
    for i = 1, #self.shortcuts, 1 do
        if (self.shortcuts[i]:GetData() == id) then
            if (self.shortcuts[i]:IsEnabled()) then return 1; end
        end
    end

    return 0;
end
