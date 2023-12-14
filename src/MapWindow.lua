import "Turbine";
import "Turbine.Debug";
import "Turbine.Gameplay";
import "Turbine.UI";
import "Turbine.UI.Lotro";
import "TravelWindowII.src.extensions";
import "TravelWindowII.src.utils.BitOps";

MapWindow = class(Turbine.UI.Window);

MapType = {
    NONE = 1,
    CREEPS = 2,
    ERIADOR = 3,
    RHOVANION = 4,
    ROHAN = 5,
    GONDOR = 6,
    HARADWAITH = 7,
};

function MapWindow:Constructor(parent, map, class, race, shortcuts)
    Turbine.UI.Window.Constructor(self);

    --  add a check to see if we load completely
    self.loaded = false;

    self.mainWindow = parent;
    self.mapType = map;
    self.PlayerClass = class;
    self.PlayerRaceKey = race; -- mapped as racialMap index
    self.shortcuts = shortcuts;

    -- set size of window
    self.width = 1024;
    self.height = 768;
    self.windowWidth, self.windowHeight = Turbine.UI.Display:GetSize();

    -- table of shortcuts
    self.quickslots = {};

    -- set the default window settings
    self:SetPosition(self.windowWidth / 2 - self.width / 2, self.windowHeight / 2 - self.height / 2);
    self:SetSize(self.width, self.height);
    self:SetBlendMode(Turbine.UI.BlendMode.Undefined);
    self:SetBackColor(Turbine.UI.Color(0, 0, 0, 0));
    self:SetOpacity(1);

    self.mapLabel = Turbine.UI.Label();
    self.mapLabel:SetSize(1024, 768);

    self.mapLabel:SetParent(self);
    self.mapLabel:SetVisible(true);

    self.CloseButton=Turbine.UI.Control();
    self.CloseButton:SetParent(self);
    self.CloseButton:SetStretchMode(3);
    self.CloseButton:SetBackground("TravelWindowII/src/Resources/Close.tga");
    self.CloseButton:SetSize(16, 16);
    self.CloseButton:SetPosition(self:GetWidth() - 25, 10);
    self.CloseButton.MouseEnter = function()
        self.CloseButton:SetBackground("TravelWindowII/src/Resources/Close_hover.tga");
    end
    self.CloseButton.MouseLeave = function()
        self.CloseButton:SetBackground("TravelWindowII/src/Resources/Close.tga");
    end
    self.CloseButton.MouseClick = function()
        self:SetVisible(false);
    end

    self:SetVisible(true);

    if self.mapType == MapType.ERIADOR then
        self:SetText(eriadorMapTitleString);
        self.mapLabel:SetBackground(0x41008138);
    elseif self.mapType == MapType.RHOVANION then
        self:SetText(rhovanionMapTitleString);
        self.mapLabel:SetBackground(0x411C2DE4);
    elseif self.mapType == MapType.ROHAN then
        self.mapLabel:SetBackground(0x411c2de5);
    elseif self.mapType == MapType.GONDOR then
        self:SetText(gondorMapTitleString);
        self.mapLabel:SetBackground(0x41154336);
    elseif self.mapType == MapType.HARADWAITH then
        self.mapLabel:SetBackground(0x4124bcd0);
    elseif self.mapType == MapType.CREEPS then
        self:SetText(moorMapTitleString);
        self.mapLabel:SetBackground(0x41008133);
    end

    self:AddShortcuts();

    -- have the main window close the options
    self.VisibleChanged = function(sender, args)
        if (self:IsVisible() == false) then
            if (parent ~= nil) then
                if self.mapType == MapType.CREEPS then
                    parent:CloseMoorMap();
                else
                    parent:CloseEriadorMap();
                end
            end
        end
    end

    self.loaded = true;
end

function MapWindow:AddShortcuts()

    if self.mapType == MapType.CREEPS then
        self.addCreepShortcuts();
        return
    end

    -- Hunter skills
    local hunterMap = {
        {MapType.NONE, -1, -1}, -- Camp
        {MapType.ERIADOR, 585, 335}, -- Bree --
        {MapType.ERIADOR, 305, 270}, -- Thorin's Hall --
        {MapType.ERIADOR, 360, 390}, -- Michel Delving --
        {MapType.ERIADOR, 655, 290}, -- Esteldin --
        {MapType.ERIADOR, 490, 235}, -- Evendim --
        {MapType.ERIADOR, 755, 400}, -- Ost Guruth --
        {MapType.ERIADOR, 865, 410}, -- Rivendell --
        {MapType.ERIADOR, 430, 50}, -- Suri-Kyla --
        {MapType.ERIADOR, 825, 185}, -- West Angmar --
        {MapType.ERIADOR, 705, 180}, -- East Angmar --
        {MapType.ERIADOR, 855, 535}, -- Echad Dunann --
        {MapType.RHOVANION, 95, 585}, -- 21st Hall --
        {MapType.RHOVANION, 365, 630}, -- Mirkwood --
        {MapType.ERIADOR, 815, 635}, -- Enedwaith Harndirion --
        {MapType.ERIADOR, 810, 715}, -- Galtrev --
        {MapType.RHOVANION, 200, 720}, -- Stangard --
        {MapType.RHOVANION, 120, 660}, -- Caras Galadhon --
        {MapType.ERIADOR, 915, 265}, -- Misty Mountains --
        {MapType.ROHAN, 515, 500}, -- Snowbourn
        {MapType.ROHAN, 450, 175}, -- Forlaw
        {MapType.ROHAN, 570, 640}, -- Aldburg
        {MapType.ROHAN, 275, 565}, -- Helm's Deep
        {MapType.GONDOR, 225, 550}, -- Dol Amroth --
        {MapType.GONDOR, 715, 425}, -- Arnach --
        {MapType.GONDOR, 670, 345}, -- Minas Tirith
        {MapType.GONDOR, 665, 140}, -- War-Stead
        {MapType.GONDOR, 670, 375}, -- After-Battle Minas Tirith
        {MapType.GONDOR, 875, 385}, -- Henneth Annûn --
        {MapType.GONDOR, 855, 335}, -- Osgiliath --
        {MapType.GONDOR, 805, 170}, -- Camp of the Host --
        {MapType.GONDOR, 855, 100}, -- Haerondir --
        {MapType.GONDOR, 925, 230}, -- Udûn Foothold --
        {MapType.RHOVANION, 720, 215}, -- Dale --
        {MapType.RHOVANION, 890, 110}, -- Jarnfast --
        {MapType.RHOVANION, 430, 90}, -- Skarhald --
        {MapType.RHOVANION, 390, 300}, -- Beorningus --
        {MapType.RHOVANION, 375, 400}, -- Hultvis --
        {MapType.GONDOR, 960, 460}, -- Estolad Lân --
        {MapType.RHOVANION, 125, 720}, -- Limlók --
        {MapType.RHOVANION, 530, 90}, -- Annâk-khurfu --
        {MapType.ERIADOR, 515, 305}, -- Trader's Wharf --
        {MapType.ERIADOR, 590, 285}, -- Trestlebridge --
        {MapType.RHOVANION, 750, 115}, -- Akrâz-zahar --
        {MapType.RHOVANION, 210, 555}, -- Azanulbizar --
        {MapType.RHOVANION, 190, 130}, -- Noble Gate --
        {MapType.RHOVANION, 270, 65}, -- Leitstáth --
        {MapType.ERIADOR, 775, 435}, -- Tornhad --
        {MapType.ERIADOR, 440, 350}, -- Nobottle --
        {MapType.ERIADOR, 580, 465}, -- Andrath --
        {MapType.ERIADOR, 825, 490}, -- Swanfleet --
        {MapType.ERIADOR, 560, 495}, -- Cardolan --
        {MapType.ERIADOR, 735, 100}, -- Carn Dûm
        {MapType.ERIADOR, 755, 555}, -- Clegur --
        {MapType.GONDOR, 670, 625}, -- Pelargir
        {MapType.GONDOR, 210, 485}, -- King's Dol Amroth
        {MapType.HARADWAITH, 275, 160}, -- Halrax
        {MapType.GONDOR, 255, 420}, -- Lond Cirion
        {MapType.HARADWAITH, 510, 365}, -- Umbar
        {MapType.HARADWAITH, 305, 315}, -- Jax Phanâl
    };
    -- fixup map overlap
    if self.mapType == MapType.ERIADOR then
        hunterMap[13] = {MapType.ERIADOR, 950, 510}; -- 21st Hall
    elseif self.mapType == MapType.ROHAN then
        hunterMap[17] = {MapType.ROHAN, 545, 90}; -- Stangard
        hunterMap[40] = {MapType.ROHAN, 380, 85}; -- Limlók
    elseif self.mapType == MapType.HARADWAITH then
        hunterMap[56] = {MapType.HARADWAITH, 210, 485}; -- King's Dol Amroth
        hunterMap[58] = {MapType.HARADWAITH, 230, 20}; -- Lond Cirion
    end

    -- Warden skills
    local wardenMap = {
        {MapType.ERIADOR, 755, 400}, -- Ost Guruth --
        {MapType.ERIADOR, 655, 290}, -- Esteldin --
        {MapType.ERIADOR, 490, 235}, -- Evendim --
        {MapType.ERIADOR, 865, 410}, -- Rivendell --
        {MapType.ERIADOR, 430, 50}, -- Suri-Kyla --
        {MapType.RHOVANION, 95, 585}, -- 21st Hall --
        {MapType.RHOVANION, 365, 630}, -- Mirkwood --
        {MapType.ERIADOR, 815, 635}, -- Enedwaith Harndirion --
        {MapType.ERIADOR, 810, 715}, -- Galtrev --
        {MapType.RHOVANION, 200, 720}, -- Stangard --
        {MapType.RHOVANION, 120, 660}, -- Caras Galadhon --
        {MapType.ERIADOR, 915, 265}, -- Misty Mountains --
        {MapType.ROHAN, 515, 500}, -- Snowbourn
        {MapType.ROHAN, 450, 175}, -- Forlaw
        {MapType.ROHAN, 570, 640}, -- Aldburg
        {MapType.ROHAN, 275, 565}, -- Helm's Deep
        {MapType.GONDOR, 225, 550}, -- Dol Amroth --
        {MapType.GONDOR, 715, 425}, -- Arnach --
        {MapType.GONDOR, 670, 345}, -- Minas Tirith --
        {MapType.GONDOR, 665, 140}, -- War-Stead
        {MapType.GONDOR, 670, 375}, -- After-Battle Minas Tirith --
        {MapType.GONDOR, 875, 385}, -- Henneth Annûn
        {MapType.GONDOR, 855, 335}, -- Osgiliath --
        {MapType.GONDOR, 805, 170}, -- Camp of the Host --
        {MapType.GONDOR, 855, 100}, -- Haerondir --
        {MapType.GONDOR, 925, 230}, -- Udûn Foothold --
        {MapType.RHOVANION, 720, 215}, -- Dale --
        {MapType.RHOVANION, 890, 110}, -- Jarnfast --
        {MapType.RHOVANION, 430, 90}, -- Skarhald --
        {MapType.RHOVANION, 390, 300}, -- Beorningus --
        {MapType.RHOVANION, 375, 400}, -- Hultvis --
        {MapType.GONDOR, 960, 460}, -- Estolad Lân --
        {MapType.RHOVANION, 125, 720}, -- Limlók --
        {MapType.RHOVANION, 530, 90}, -- Annâk-khurfu --
        {MapType.ERIADOR, 515, 305}, -- Trader's Wharf --
        {MapType.ERIADOR, 590, 285}, -- Trestlebridge --
        {MapType.RHOVANION, 750, 115}, -- Akrâz-zahar --
        {MapType.RHOVANION, 210, 555}, -- Azanulbizar --
        {MapType.RHOVANION, 190, 130}, -- Noble Gate --
        {MapType.RHOVANION, 270, 65}, -- Leitstáth --
        {MapType.ERIADOR, 775, 435}, -- Tornhad --
        {MapType.ERIADOR, 440, 350}, -- Nobottle --
        {MapType.ERIADOR, 580, 465}, -- Andrath --
        {MapType.ERIADOR, 825, 490}, -- Swanfleet --
        {MapType.ERIADOR, 560, 495}, -- Cardolan --
        {MapType.ERIADOR, 735, 100}, -- Carn Dûm
        {MapType.ERIADOR, 755, 555}, -- Clegur --
        {MapType.GONDOR, 670, 625}, -- Pelargir
        {MapType.HARADWAITH, 305, 315}, -- Jax Phanâl
        {MapType.HARADWAITH, 510, 365}, -- Umbar
        {MapType.HARADWAITH, 275, 260}, -- Halrax
        {MapType.GONDOR, 210, 485}, -- King's Dol Amroth
        {MapType.GONDOR, 255, 420}, -- Lond Cirion
    };
    -- fixup map overlap
    if self.mapType == MapType.ERIADOR then
        wardenMap[6] = {MapType.ERIADOR, 950, 510}; -- 21st Hall
    elseif self.mapType == MapType.ROHAN then
        wardenMap[10] = {MapType.ROHAN, 545, 90}; -- Stangard
        wardenMap[33] = {MapType.ROHAN, 380, 85}; -- Limlók
    elseif self.mapType == MapType.HARADWAITH then
        wardenMap[52] = {MapType.HARADWAITH, 385, 70}; -- King's Dol Amroth
        wardenMap[53] = {MapType.HARADWAITH, 230, 20}; -- Lond Cirion
    end

    -- Mariner skills
    local marinerMap = {
        {MapType.ERIADOR, 310, 380}, -- Celondim --
        {MapType.ROHAN, 700, 180}, -- Brown Lands --
        {MapType.ERIADOR, 515, 305}, -- Trader's Wharf --
        {MapType.GONDOR, 855, 335}, -- after-battle Osgiliath --
        {MapType.RHOVANION, 740, 275}, -- Lake-town --
        {MapType.RHOVANION, 365, 630}, -- Mirk-eaves --
        {MapType.ERIADOR, 420, 250}, -- Tinnundir --
        {MapType.GONDOR, 225, 550}, -- Dol Amroth --
        {MapType.ERIADOR, 515, 405}, -- Buckland --
        {MapType.GONDOR, 670, 625}, -- Pelargir
        {MapType.ERIADOR, 430, 50}, -- Sûri-kylä --
        {MapType.RHOVANION, 245, 670}, -- Lothlórien --
        {MapType.ERIADOR, 650, 525}, -- Tharbad --
        {MapType.ROHAN, 515, 500}, -- Snowbourn
        {MapType.HARADWAITH, 510, 365}, -- Umbar
        {MapType.GONDOR, 255, 420}, -- Lond Cirion
        {MapType.HARADWAITH, 305, 315}, -- Jax Phanâl
        {MapType.GONDOR, 210, 485}, -- King's Dol Amroth --
        {MapType.HARADWAITH, 275, 160}, -- Halrax
    };
    -- fixup map overlap
    if self.mapType == MapType.HARADWAITH then
        marinerMap[16] = {MapType.HARADWAITH, 230, 20}; -- Lond Cirion --
        marinerMap[18] = {MapType.HARADWAITH, 385, 70}; -- King's Dol Amroth --
    end

    -- Reputation skills
    local repMap = {
        {MapType.ERIADOR, 345, 310}, -- Thorin's Hall --
        {MapType.ERIADOR, 555, 335}, -- Bree --
        {MapType.ERIADOR, 630, 360}, -- Lalia's Market --
        {MapType.ERIADOR, 375, 440}, -- Michel Delving --
        {MapType.ERIADOR, 835, 410}, -- Rivendell --
        {MapType.ERIADOR, 725, 400}, -- Ost Guruth --
        {MapType.RHOVANION, 335, 630}, -- Mirkwood --
        {MapType.ERIADOR, 765, 620}, -- Enedwaith Lhanuch --
        {MapType.ERIADOR, 780, 715}, -- Galtrev --
        {MapType.RHOVANION, 170, 720}, -- Stangard --
        {MapType.ROHAN, 485, 500}, -- Snowbourn
        {MapType.ROHAN, 480, 175}, -- Forlaw
        {MapType.ROHAN, 540, 640}, -- Aldburg
        {MapType.RHOVANION, 45, 720}, -- Derndingle --
        {MapType.ROHAN, 245, 565}, -- Helm's Deep
        {MapType.GONDOR, 195, 550}, -- Dol Amroth --
        {MapType.GONDOR, 685, 425}, -- Arnach --
        {MapType.GONDOR, 700, 345}, -- Minas Tirith --
        {MapType.GONDOR, 635, 140}, -- War-Stead
        {MapType.GONDOR, 700, 375}, -- After-Battle Minas Tirith
        {MapType.GONDOR, 845, 385}, -- Henneth Annûn
        {MapType.GONDOR, 825, 335}, -- Osgiliath
        {MapType.GONDOR, 775, 170}, -- Camp of the Host --
        {MapType.GONDOR, 825, 100}, -- Haerondir
        {MapType.GONDOR, 895, 230}, -- Udûn Foothold --
        {MapType.RHOVANION, 140, 585}, -- Court of Lothlórien --
        {MapType.GONDOR, 740, 310}, -- Hall of the King --
        {MapType.RHOVANION, 630, 115}, -- Hall Under the Mountain --
        {MapType.GONDOR, 965, 370}, -- Bâr Thorenion
        {MapType.RHOVANION, 690, 215}, -- Dale --
        {MapType.RHOVANION, 860, 110}, -- Jarnfast --
        {MapType.RHOVANION, 400, 90}, -- Skarhald --
        {MapType.RHOVANION, 360, 300}, -- Beorningus --
        {MapType.RHOVANION, 345, 400}, -- Hultvis --
        {MapType.GONDOR, 930, 460}, -- Estolad Lân --
        {MapType.RHOVANION, 95, 720}, -- Limlók --
        {MapType.RHOVANION, 500, 90}, -- Annâk-khurfu --
        {MapType.ERIADOR, 515, 275}, -- Trader's Wharf --
        {MapType.ERIADOR, 560, 285}, -- Trestlebridge --
        {MapType.RHOVANION, 720, 115}, -- Akrâz-zahar --
        {MapType.RHOVANION, 180, 555}, -- Azanulbizar --
        {MapType.RHOVANION, 155, 45}, -- Hall of Vérnozal --
        {MapType.RHOVANION, 160, 130}, -- Noble Gate --
        {MapType.RHOVANION, 240, 65}, -- Leitstáth --
        {MapType.ERIADOR, 745, 435}, -- Tornhad --
        {MapType.ERIADOR, 410, 350}, -- Nobottle --
        {MapType.ERIADOR, 550, 465}, -- Andrath --
        {MapType.ERIADOR, 795, 490}, -- Swanfleet --
        {MapType.ERIADOR, 590, 495}, -- Cardolan --
        {MapType.ERIADOR, 905, 345}, -- Tracery Archive --
        {MapType.ERIADOR, 705, 100}, -- Carn Dûm
        {MapType.ERIADOR, 725, 555}, -- Clegur --
        {MapType.ERIADOR, 835, 245}, -- Glân Vraig
        {MapType.GONDOR, 640, 625}, -- Pelargir --
        {MapType.HARADWAITH, 415, 370}, -- Order of the Eagle
        {MapType.HARADWAITH, 480, 365}, -- Umbar --
        {MapType.GONDOR, 180, 485}, -- King's Dol Amroth
        {MapType.HARADWAITH, 335, 315}, -- Jax Phanâl
        {MapType.HARADWAITH, 245, 260}, -- Halrax --
        {MapType.GONDOR, 225, 420}, -- Lond Cirion
        {MapType.HARADWAITH, 415, 340}, -- Ledger-Keepers
    };
    -- fixup map overlap
    if self.mapType == MapType.ROHAN then
        repMap[10] = {MapType.ROHAN, 515, 90}; -- Stangard
        repMap[14] = {MapType.ROHAN, 295, 275}; -- Derndingle
        repMap[36] = {MapType.ROHAN, 410, 85}; -- Limlók
    elseif self.mapType == MapType.HARADWAITH then
        repMap[57] = {MapType.HARADWAITH, 355, 70}; -- King's Dol Amroth
        repMap[60] = {MapType.HARADWAITH, 200, 20}; -- Lond Cirion
    end

    -- Racial skills
    local racialMap = {
        {MapType.ERIADOR, 525, 335}, -- Bree --
        {MapType.ERIADOR, 405, 440}, -- Michel Delving --
        {MapType.ERIADOR, 310, 270}, -- Thorin's Hall --
        {MapType.ERIADOR, 900, 375}, -- Rivendell --
        {MapType.RHOVANION, 285, 340}, -- Grimbeorn's House --
        {MapType.RHOVANION, 120, 690}, -- Caras Galadhon --
        {MapType.ERIADOR, 345, 310}, -- Thorin's Gate --
        {MapType.RHOVANION, 155, 165}, -- Lyndelby --
    };

    local moorsMap = {
        -- Moors Map
        {MapType.ERIADOR, 815, 300} -- Ettenmoors
    };

    self:AddClassLocations(Turbine.Gameplay.Class.Hunter, hunterMap, hunterLocations);
    self:AddClassLocations(Turbine.Gameplay.Class.Warden, wardenMap, wardenLocations);
    self:AddClassLocations(Turbine.Gameplay.Class.Mariner, marinerMap, marinerLocations);

    -- reputation locations
    if #repMap ~= repLocations:GetCount() then
        Turbine.Shell.WriteLine("Error: Missing Reputation locations " .. #repMap .. " " .. repLocations:GetCount());
        return
    end

    local sType = Turbine.UI.Lotro.ShortcutType.Skill;
    for i = 1, #repMap, 1 do
        local index = repLocations:IdAtIndex(i);
        if self.mapType == repMap[i][1] then
            self:AddSingleShortcut(repMap[i], Turbine.UI.Lotro.Shortcut(sType, index));
        end
    end

    -- racial locations
    if #racialMap ~= racialLocations:GetCount() then
        Turbine.Shell.WriteLine("Error: Missing Racial locations " .. #racialMap .. " " .. racialLocations:GetCount());
        return
    end

    if self.mapType == racialMap[self.PlayerRaceKey][1] then
        local index = racialLocations:IdAtIndex(self.PlayerRaceKey);
        if self.PlayerRaceKey ~= 1 or self:IsShortcutTrained(index) then
            self:AddSingleShortcut(racialMap[self.PlayerRaceKey],
                                   Turbine.UI.Lotro.Shortcut(sType, index));
        end
    end

    -- Glan Vraig
    for i = 1, #TravelShortcuts, 1 do
        if TravelShortcuts[i]:GetName() == glanMapString then
            if self:IsShortcutEnabled(index) then
                self:AddSingleShortcut(moorsMap[0], self.shortcuts[i]);
                break
            end
        end
    end
end

function MapWindow:AddClassLocations(class, map, locations)
    if class == self.PlayerClass then
        if #map ~= locations:GetCount() then
            local name = "Unknown";
            if class == Turbine.Gameplay.Class.Hunter then name = "Hunter"
            elseif class == Turbine.Gameplay.Class.Warden then name = "Warden"
            elseif class == Turbine.Gameplay.Class.Mariner then name = "Mariner"
            end
            Turbine.Shell.WriteLine("Error: Missing " .. name .. " locations " .. #map .. " " .. locations:GetCount());
            return
        end

        local sType = Turbine.UI.Lotro.ShortcutType.Skill;
        for i = 1, #map, 1 do
            local index = locations:IdAtIndex(i);
            if self.mapType == map[i][1] and self:IsShortcutEnabled(index) then
                self:AddSingleShortcut(map[i], Turbine.UI.Lotro.Shortcut(sType, index));
            end
        end
    end
end

function MapWindow:AddCreepShortcuts()

    local sType = Turbine.UI.Lotro.ShortcutType.Skill;
    local creepMap = {
        {180, 120}, -- Crude Map to Gramsfoot
        {215, 120}, -- Map to Gramsfoot
        {700, 200}, -- Crude Map to Isendeep
        {350, 440}, -- Crude Map to Tol Ascarnen
        {180, 380}, -- Crude Map to Lugazag
        {500, 295}, -- Crude Map to Tirith Rhaw
        {340, 510}, -- Crude Map to Grimwood
        {610, 300}, -- Poor Map to Isendeep
        {435, 365}, -- Poor Map to Tol Ascarnen
        {180, 270}, -- Poor Map to Lugazag
        {625, 365}, -- Poor Map to Tirith Rhaw
        {380, 540}, -- Poor Map to Grimwood
        {310, 95}, -- Good Map to Isendeep
        {375, 480}, -- Good Map to Tol Ascarnen
        {305, 275}, -- Good Map to Lugazag
        {555, 470}, -- Good Map to Tirith Rhaw
        {445, 650} -- Good Map to Grimwood
    };

    for i = 1, #creepLocations, 1 do
        self.AddSingleShortcut(creepMap[i], Turbine.UI.Lotro.Shortcut(sType, creepLocations:IdAtIndex(i)));
    end
end

function MapWindow:AddSingleShortcut(location, shortcut)

    local index = #self.quickslots + 1;
    self.quickslots[index] = Turbine.UI.Lotro.Quickslot();

    self.quickslots[index]:SetShortcut(shortcut);
    self.quickslots[index]:SetOpacity(1);
    self.quickslots[index]:SetParent(self.mapLabel);
    self.quickslots[index]:SetAllowDrop(false);
    self.quickslots[index]:SetMouseVisible(true);
    self.quickslots[index]:SetUseOnRightClick(false);
    self.quickslots[index]:SetAllowDrop(false);
    self.quickslots[index]:SetStretchMode(1);
    self.quickslots[index]:SetSize(32, 32);
    self.quickslots[index]:SetPosition(location[2], location[3]);
    self.quickslots[index]:SetZOrder(98);
    self.quickslots[index]:SetVisible(true);

    self.quickslots[index].MouseClick = function(sender, args)
        self:SetVisible(false);
    end
end

function MapWindow:IsShortcutEnabled(id)

    -- loop through all the shortcuts and add those that are enabled
    for i = 1, #TravelShortcuts, 1 do
        local shortcut = TravelShortcuts[i]
        if shortcut:GetData() == id then
            return shortcut:IsEnabled()
        end
    end

    return false;
end

function MapWindow:IsShortcutTrained(id)

    -- loop through all the shortcuts and add those that are enabled
    for i = 1, #TravelShortcuts, 1 do
        local shortcut = TravelShortcuts[i]
        if shortcut:GetData() == id then
            if shortcut:IsEnabled() and shortcut.found then
                return true;
            end
            return false;
        end
    end

    return false;
end
