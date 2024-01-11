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

function MapWindow:Constructor(parent, map)
    Turbine.UI.Window.Constructor(self);

    --  add a check to see if we load completely
    self.loaded = false;

    self.mainWindow = parent;
    self.mapType = map;
    self.debug = false; -- enable to position shortcuts on the map

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

    if self.debug then
        self.debugCoords = Turbine.UI.Label();
        self.debugCoords:SetParent(self);
        self.debugCoords:SetSize(75, 15);
        self.debugCoords:SetPosition(30, 30);
        self.debugCoords:SetBackColor(Turbine.UI.Color(1, 0, 0, 0));
        self.debugCoords:SetVisible(true);

        self.debugCoords.MouseClick = function(sender, args)
            self:DebugSave(self.quickslots);
        end

        self.mapLabel.MouseClick = function(sender, args)
            local mX, mY = self:GetMousePosition();
            self.debugCoords:SetText(tostring(mX) .. " x " .. tostring(mY));
        end

        self.mapLabel.DragDrop = function(sender, args)
            if self.debugMove then
                self.debugMove = false;
                -- get dropped location
                local mX, mY = self:GetMousePosition();
                mX = mX - self.debugX;
                mY = mY - self.debugY;
                -- round to nearest multiple of 5
                local adjust = mX % 5;
                if adjust > 2 then
                    adjust = 5 - adjust;
                else
                    adjust = adjust * -1;
                end
                mX = mX + adjust;
                -- round to nearest multiple of 5
                adjust = mY % 5;
                if adjust > 2 then
                    adjust = 5 - adjust;
                else
                    adjust = adjust * -1;
                end
                mY = mY + adjust;
                self.quickslots[self.debugIndex]:SetPosition(mX, mY);
                self.debugCoords:SetText(tostring(mX) .. "x" .. tostring(mY));
            end
        end

        self.DebugSave = function(quickslots)
            local coordinates = {}
            for i = 1, #self.quickslots, 1 do
                local shortcut = self.quickslots[i]:GetShortcut();
                local name = self:DebugNameLookup(shortcut:GetData());
                coordinates[i] = {name, self.quickslots[i]:GetPosition()}
            end
            pcall(function()
                PatchDataSave(Turbine.DataScope.Character, "TravelWindowIIDebugCoords", coordinates);
            end);
        end
    end

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

    self.loaded = true;
end

function MapWindow:AddShortcuts()
    if self.mapType == MapType.CREEPS then
        self:AddCreepShortcuts();
    else
        self:AddClassLocations();
        self:AddReputationLocations();
        self:AddRacialLocation();
        self:AddGlanVraigMap();
    end
end

function MapWindow:AddLocations(name)
    local sType = Turbine.UI.Lotro.ShortcutType.Skill;
    local map = self:GetLocations(name);
    for i = 1, #map do
        if #map[i] == 2 then
            local id = map[i][1];
            for r = 1, #map[i][2] do
                local item = map[i][2][r];
                if item ~= nil and #item == 3 and
                        self.mapType == item[1] and self:IsShortcutEnabled(id) then
                    self:AddSingleShortcut(item, Turbine.UI.Lotro.Shortcut(sType, id));
                end
            end
        end
    end
end

function MapWindow:AddClassLocations()
    local name = "";
    if PlayerClass == Turbine.Gameplay.Class.Hunter then
        name = "Hunter";
    elseif PlayerClass == Turbine.Gameplay.Class.Warden then
        name = "Warden";
    elseif PlayerClass == Turbine.Gameplay.Class.Mariner then
        name = "Mariner";
    else
        -- nothing to add for other classes
        return
    end

    self:AddLocations(name);
end

function MapWindow:AddReputationLocations()
    self:AddLocations("Reputation");
end

function MapWindow:GetLocations(name)
    if name == "Hunter" then
        return {
            {"0x7000A2C1", {{MapType.NONE, -1, -1}}}, -- Camp
            {"0x70003F42", {{MapType.ERIADOR, 585, 335}}}, -- Bree
            {"0x70003F41", {{MapType.ERIADOR, 305, 270}}}, -- Thorin's Hall
            {"0x7000A2C3", {{MapType.ERIADOR, 360, 390}}}, -- Michel Delving
            {"0x70003F43", {{MapType.ERIADOR, 655, 290}}}, -- Esteldin
            {"0x7000A2C4", {{MapType.ERIADOR, 490, 235}}}, -- Evendim
            {"0x7000A2C2", {{MapType.ERIADOR, 755, 400}}}, -- Ost Guruth
            {"0x70003F44", {{MapType.ERIADOR, 865, 410}}}, -- Rivendell
            {"0x70017C82", {{MapType.ERIADOR, 430, 50}}}, -- Suri-Kyla
            {"0x7000A2C5", {{MapType.ERIADOR, 825, 185}}}, -- West Angmar
            {"0x7000A2C6", {{MapType.ERIADOR, 705, 180}}}, -- East Angmar
            {"0x70017C81", {{MapType.ERIADOR, 855, 535}}}, -- Echad Dunann
            {"0x70017C7A", {{MapType.RHOVANION, 95, 585},
                            {MapType.ERIADOR, 950, 510}}}, -- 21st Hall
            {"0x7001F459", {{MapType.RHOVANION, 365, 630}}}, -- Mirkwood
            {"0x700235EF", {{MapType.ERIADOR, 815, 635}}}, -- Enedwaith Harndirion
            {"0x7002A93F", {{MapType.ERIADOR, 810, 715}}}, -- Galtrev
            {"0x7002C62C", {{MapType.RHOVANION, 200, 720},
                            {MapType.ROHAN, 545, 90}}}, -- Stangard
            {"0x7002E754", {{MapType.RHOVANION, 120, 660}}}, -- Caras Galadhon
            {"0x7002E756", {{MapType.ERIADOR, 915, 265}}}, -- Misty Mountains
            {"0x7003198E", {{MapType.ROHAN, 515, 500}}}, -- Snowbourn
            {"0x70036B5D", {{MapType.ROHAN, 450, 175}}}, -- Forlaw
            {"0x7003DC71", {{MapType.ROHAN, 570, 640}}}, -- Aldburg
            {"0x7003DC72", {{MapType.ROHAN, 275, 565}}}, -- Helm's Deep
            {"0x70041197", {{MapType.GONDOR, 225, 550}}}, -- Dol Amroth
            {"0x70043A63", {{MapType.GONDOR, 715, 425}}}, -- Arnach
            {"0x70044985", {{MapType.GONDOR, 670, 345}}}, -- Minas Tirith
            {"0x700459AF", {{MapType.GONDOR, 665, 140}}}, -- War-Stead
            {"0x70046CBB", {{MapType.GONDOR, 670, 375}}}, -- After-Battle Minas Tirith
            {"0x70047077", {{MapType.GONDOR, 875, 385}}}, -- Henneth Annûn
            {"0x70047074", {{MapType.GONDOR, 855, 335}}}, -- Osgiliath
            {"0x70047BFA", {{MapType.GONDOR, 805, 170}}}, -- Camp of the Host
            {"0x70047C1D", {{MapType.GONDOR, 855, 100}}}, -- Haerondir
            {"0x7004AE1E", {{MapType.GONDOR, 925, 230}}}, -- Udûn Foothold
            {"0x7004D73B", {{MapType.RHOVANION, 720, 215}}}, -- Dale
            {"0x7004FACC", {{MapType.RHOVANION, 890, 110}}}, -- Jarnfast
            {"0x7004FACB", {{MapType.RHOVANION, 430, 90}}}, -- Skarhald
            {"0x70052F07", {{MapType.RHOVANION, 390, 300}}}, -- Beorningus
            {"0x70052F08", {{MapType.RHOVANION, 375, 400}}}, -- Hultvis
            {"0x700551F4", {{MapType.GONDOR, 960, 460}}}, -- Estolad Lân
            {"0x7005762D", {{MapType.RHOVANION, 125, 720},
                            {MapType.ROHAN, 380, 85}}}, -- Limlók
            {"0x70058571", {{MapType.RHOVANION, 530, 90}}}, -- Annâk-khurfu
            {"0x70059D0C", {{MapType.ERIADOR, 515, 305}}}, -- Trader's Wharf
            {"0x70059D16", {{MapType.ERIADOR, 590, 285}}}, -- Trestlebridge
            {"0x7005AA91", {{MapType.RHOVANION, 750, 115}}}, -- Akrâz-zahar
            {"0x7005AA95", {{MapType.RHOVANION, 210, 555}}}, -- Azanulbizar
            {"0x7005D487", {{MapType.RHOVANION, 190, 130}}}, -- Noble Gate
            {"0x7005D47D", {{MapType.RHOVANION, 270, 65}}}, -- Leitstáth
            {"0x70060EA6", {{MapType.ERIADOR, 775, 435}}}, -- Tornhad
            {"0x7006133F", {{MapType.ERIADOR, 440, 350}}}, -- Nobottle
            {"0x7006323C", {{MapType.ERIADOR, 580, 465}}}, -- Andrath
            {"0x700634AA", {{MapType.ERIADOR, 825, 490}}}, -- Swanfleet
            {"0x700634A7", {{MapType.ERIADOR, 560, 495}}}, -- Cardolan
            {"0x70064AC8", {{MapType.ERIADOR, 735, 100}}}, -- Carn Dûm
            {"0x70064F4C", {{MapType.ERIADOR, 755, 555}}}, -- Clegur
            {"0x700658EA", {{MapType.GONDOR, 670, 625}}}, -- Pelargir
            {"0x70068711", {{MapType.GONDOR, 210, 485},
                            {MapType.HARADWAITH, 210, 485}}}, -- King's Dol Amroth
            {"0x70068713", {{MapType.HARADWAITH, 275, 160}}}, -- Halrax
            {"0x70068717", {{MapType.GONDOR, 255, 420},
                            {MapType.HARADWAITH, 230, 20}}}, -- Lond Cirion
            {"0x70068718", {{MapType.HARADWAITH, 505, 370}}}, -- Umbar
            {"0x70068719", {{MapType.HARADWAITH, 305, 315}}}, -- Jax Phanâl
            {"0x700697EF", {{MapType.HARADWAITH, 475, 400}}}, -- Bloody Eagle Tavern
        };
    end
    if name == "Warden" then
        return {
            {"0x70014786", {{MapType.ERIADOR, 755, 400}}}, -- Ost Guruth
            {"0x70014798", {{MapType.ERIADOR, 655, 290}}}, -- Esteldin
            {"0x7001478E", {{MapType.ERIADOR, 490, 235}}}, -- Evendim
            {"0x70014791", {{MapType.ERIADOR, 865, 410}}}, -- Rivendell
            {"0x700237D4", {{MapType.ERIADOR, 430, 50}}}, -- Suri-Kyla
            {"0x7001819E", {{MapType.RHOVANION, 95, 585},
                            {MapType.ERIADOR, 950, 510}}}, -- 21st Hall
            {"0x7001F45C", {{MapType.RHOVANION, 365, 630}}}, -- Mirkwood
            {"0x700235EB", {{MapType.ERIADOR, 815, 635}}}, -- Enedwaith Harndirion
            {"0x7002A90A", {{MapType.ERIADOR, 810, 715}}}, -- Galtrev
            {"0x7002C646", {{MapType.RHOVANION, 200, 720},
                            {MapType.ROHAN, 545, 90}}}, -- Stangard
            {"0x700303DF", {{MapType.RHOVANION, 120, 660}}}, -- Caras Galadhon
            {"0x700303DD", {{MapType.ERIADOR, 915, 265}}}, -- Misty Mountains
            {"0x7003198D", {{MapType.ROHAN, 515, 500}}}, -- Snowbourn
            {"0x70036B5B", {{MapType.ROHAN, 450, 175}}}, -- Forlaw
            {"0x7003DC7A", {{MapType.ROHAN, 570, 640}}}, -- Aldburg
            {"0x7003DC79", {{MapType.ROHAN, 275, 565}}}, -- Helm's Deep
            {"0x70041198", {{MapType.GONDOR, 225, 550}}}, -- Dol Amroth
            {"0x70043A66", {{MapType.GONDOR, 715, 425}}}, -- Arnach
            {"0x70044982", {{MapType.GONDOR, 670, 345}}}, -- Minas Tirith
            {"0x700459AA", {{MapType.GONDOR, 665, 140}}}, -- War-Stead
            {"0x70046CBF", {{MapType.GONDOR, 670, 375}}}, -- After-Battle Minas Tirith
            {"0x70047075", {{MapType.GONDOR, 875, 385}}}, -- Henneth Annûn
            {"0x70047076", {{MapType.GONDOR, 855, 335}}}, -- Osgiliath
            {"0x70047BFC", {{MapType.GONDOR, 805, 170}}}, -- Camp of the Host
            {"0x70047C23", {{MapType.GONDOR, 855, 100}}}, -- Haerondir
            {"0x7004AE1F", {{MapType.GONDOR, 925, 230}}}, -- Udûn Foothold
            {"0x7004D73A", {{MapType.RHOVANION, 720, 215}}}, -- Dale
            {"0x7004FACA", {{MapType.RHOVANION, 890, 110}}}, -- Jarnfast
            {"0x7004FACD", {{MapType.RHOVANION, 430, 90}}}, -- Skarhald
            {"0x70052F0A", {{MapType.RHOVANION, 390, 300}}}, -- Beorningus
            {"0x70052F06", {{MapType.RHOVANION, 375, 400}}}, -- Hultvis
            {"0x700551F2", {{MapType.GONDOR, 960, 460}}}, -- Estolad Lân
            {"0x70057635", {{MapType.RHOVANION, 125, 720},
                            {MapType.ROHAN, 380, 85}}}, -- Limlók
            {"0x70058572", {{MapType.RHOVANION, 530, 90}}}, -- Annâk-khurfu
            {"0x70059D09", {{MapType.ERIADOR, 515, 305}}}, -- Trader's Wharf
            {"0x70059D10", {{MapType.ERIADOR, 590, 285}}}, -- Trestlebridge
            {"0x7005AA8F", {{MapType.RHOVANION, 750, 115}}}, -- Akrâz-zahar
            {"0x7005AA8C", {{MapType.RHOVANION, 210, 555}}}, -- Azanulbizar
            {"0x7005D48A", {{MapType.RHOVANION, 190, 130}}}, -- Noble Gate
            {"0x7005D488", {{MapType.RHOVANION, 270, 65}}}, -- Leitstáth
            {"0x70060EA5", {{MapType.ERIADOR, 775, 435}}}, -- Tornhad
            {"0x7006133E", {{MapType.ERIADOR, 440, 350}}}, -- Nobottle
            {"0x70063242", {{MapType.ERIADOR, 580, 465}}}, -- Andrath
            {"0x700634B6", {{MapType.ERIADOR, 825, 490}}}, -- Swanfleet
            {"0x700634AD", {{MapType.ERIADOR, 560, 495}}}, -- Cardolan
            {"0x70064ACB", {{MapType.ERIADOR, 735, 100}}}, -- Carn Dûm
            {"0x70064F4D", {{MapType.ERIADOR, 755, 555}}}, -- Clegur
            {"0x700658E8", {{MapType.GONDOR, 670, 625}}}, -- Pelargir
            {"0x7006870C", {{MapType.HARADWAITH, 305, 315}}}, -- Jax Phanâl
            {"0x7006870F", {{MapType.HARADWAITH, 505, 370}}}, -- Umbar
            {"0x70068710", {{MapType.HARADWAITH, 275, 260}}}, -- Halrax
            {"0x70068712", {{MapType.GONDOR, 210, 485},
                            {MapType.HARADWAITH, 385, 70}}}, -- King's Dol Amroth
            {"0x70068715", {{MapType.GONDOR, 255, 420},
                            {MapType.HARADWAITH, 230, 20}}}, -- Lond Cirion
            {"0x700697F3", {{MapType.HARADWAITH, 475, 400}}}, -- Bloody Eagle Tavern
        };
    end
    if name == "Mariner" then
        return {
            {"0x70066100", {{MapType.ERIADOR, 310, 380}}}, -- Celondim
            {"0x70066101", {{MapType.ROHAN, 700, 180}}}, -- Brown Lands
            {"0x70066105", {{MapType.ERIADOR, 515, 305}}}, -- Trader's Wharf
            {"0x70066109", {{MapType.GONDOR, 855, 335}}}, -- after-battle Osgiliath
            {"0x7006610C", {{MapType.RHOVANION, 740, 275}}}, -- Lake-town
            {"0x7006610E", {{MapType.RHOVANION, 365, 630}}}, -- Mirk-eaves
            {"0x7006610F", {{MapType.ERIADOR, 420, 250}}}, -- Tinnundir
            {"0x70066117", {{MapType.GONDOR, 225, 550}}}, -- Dol Amroth
            {"0x7006611A", {{MapType.ERIADOR, 515, 405}}}, -- Buckland
            {"0x7006611B", {{MapType.GONDOR, 670, 625}}}, -- Pelargir
            {"0x7006611C", {{MapType.ERIADOR, 430, 50}}}, -- Sûri-kylä
            {"0x7006611E", {{MapType.RHOVANION, 245, 670}}}, -- Lothlórien
            {"0x70066120", {{MapType.ERIADOR, 650, 525}}}, -- Tharbad
            {"0x70066121", {{MapType.ROHAN, 515, 500}}}, -- Snowbourn
            {"0x700687BB", {{MapType.HARADWAITH, 505, 370}}}, -- Umbar
            {"0x700687BD", {{MapType.GONDOR, 255, 420},
                            {MapType.HARADWAITH, 230, 20}}}, -- Lond Cirion
            {"0x700687C0", {{MapType.HARADWAITH, 305, 315}}}, -- Jax Phanâl
            {"0x700687C1", {{MapType.GONDOR, 210, 485},
                            {MapType.HARADWAITH, 385, 70}}}, -- King's Dol Amroth
            {"0x700687C3", {{MapType.HARADWAITH, 275, 160}}}, -- Halrax
        };
    end
    if name == "Reputation" then
        return {
            {"0x7001BF91", {{MapType.ERIADOR, 345, 310}}}, -- Thorin's Hall
            {"0x7001BF90", {{MapType.ERIADOR, 555, 335}}}, -- Bree
            {"0x700364B1", {{MapType.ERIADOR, 630, 360}}}, -- Lalia's Market
            {"0x70023262", {{MapType.ERIADOR, 375, 440}}}, -- Michel Delving
            {"0x70023263", {{MapType.ERIADOR, 835, 410}}}, -- Rivendell
            {"0x70020441", {{MapType.ERIADOR, 725, 400}}}, -- Ost Guruth
            {"0x7001F374", {{MapType.RHOVANION, 335, 630}}}, -- Mirkwood
            {"0x70021FA2", {{MapType.ERIADOR, 765, 620}}}, -- Enedwaith Lhanuch
            {"0x7002C647", {{MapType.ERIADOR, 780, 715}}}, -- Galtrev
            {"0x7002C65D", {{MapType.RHOVANION, 170, 720},
                            {MapType.ROHAN, 515, 90}}}, -- Stangard
            {"0x70031A46", {{MapType.ROHAN, 485, 500}}}, -- Snowbourn
            {"0x70036B5E", {{MapType.ROHAN, 480, 175}}}, -- Forlaw
            {"0x7003DC81", {{MapType.ROHAN, 540, 640}}}, -- Aldburg
            {"0x7004128F", {{MapType.RHOVANION, 45, 720},
                            {MapType.ROHAN, 295, 275}}}, -- Derndingle
            {"0x7003DC82", {{MapType.ROHAN, 245, 565}}}, -- Helm's Deep
            {"0x700411AC", {{MapType.GONDOR, 195, 550}}}, -- Dol Amroth
            {"0x70043A6A", {{MapType.GONDOR, 685, 425}}}, -- Arnach
            {"0x7004497E", {{MapType.GONDOR, 700, 345}}}, -- Minas Tirith
            {"0x700459A9", {{MapType.GONDOR, 635, 140}}}, -- War-Stead
            {"0x70046CC0", {{MapType.GONDOR, 700, 375}}}, -- After-Battle Minas Tirith
            {"0x70047080", {{MapType.GONDOR, 845, 385}}}, -- Henneth Annûn
            {"0x7004707D", {{MapType.GONDOR, 825, 335}}}, -- Osgiliath
            {"0x70047BF4", {{MapType.GONDOR, 775, 170}}}, -- Camp of the Host
            {"0x70047C1B", {{MapType.GONDOR, 825, 100}}}, -- Haerondir
            {"0x7004AE1D", {{MapType.GONDOR, 895, 230}}}, -- Udûn Foothold
            {"0x7004B8C2", {{MapType.RHOVANION, 140, 585}}}, -- Court of Lothlórien
            {"0x7004B8C3", {{MapType.GONDOR, 740, 310}}}, -- Hall of the King
            {"0x7004B8C4", {{MapType.RHOVANION, 630, 115}}}, -- Hall Under the Mountain
            {"0x7004B8C5", {{MapType.GONDOR, 965, 370}}}, -- Bâr Thorenion
            {"0x7004D738", {{MapType.RHOVANION, 690, 215}}}, -- Dale
            {"0x7004FAC3", {{MapType.RHOVANION, 860, 110}}}, -- Jarnfast
            {"0x7004FAC5", {{MapType.RHOVANION, 400, 90}}}, -- Skarhald
            {"0x70052F12", {{MapType.RHOVANION, 360, 300}}}, -- Beorningus
            {"0x70052F04", {{MapType.RHOVANION, 345, 400}}}, -- Hultvis
            {"0x700551F8", {{MapType.GONDOR, 930, 460}}}, -- Estolad Lân
            {"0x70057629", {{MapType.RHOVANION, 95, 720},
                            {MapType.ROHAN, 410, 85}}}, -- Limlók
            {"0x7005856F", {{MapType.RHOVANION, 500, 90}}}, -- Annâk-khurfu
            {"0x70059D0E", {{MapType.ERIADOR, 515, 275}}}, -- Trader's Wharf
            {"0x70059D12", {{MapType.ERIADOR, 560, 285}}}, -- Trestlebridge
            {"0x7005AA90", {{MapType.RHOVANION, 720, 115}}}, -- Akrâz-zahar
            {"0x7005AA92", {{MapType.RHOVANION, 180, 555}}}, -- Azanulbizar
            {"0x7005A596", {{MapType.RHOVANION, 155, 45}}}, -- Hall of Vérnozal
            {"0x7005D47C", {{MapType.RHOVANION, 160, 130}}}, -- Noble Gate
            {"0x7005D484", {{MapType.RHOVANION, 240, 65}}}, -- Leitstáth
            {"0x70060EA8", {{MapType.ERIADOR, 745, 435}}}, -- Tornhad
            {"0x70061340", {{MapType.ERIADOR, 410, 350}}}, -- Nobottle
            {"0x7006323D", {{MapType.ERIADOR, 550, 465}}}, -- Andrath
            {"0x700634A4", {{MapType.ERIADOR, 795, 490}}}, -- Swanfleet
            {"0x700634AE", {{MapType.ERIADOR, 590, 495}}}, -- Cardolan
            {"0x700634A5", {{MapType.ERIADOR, 905, 345}}}, -- Tracery Archive
            {"0x70064ACA", {{MapType.ERIADOR, 705, 100}}}, -- Carn Dûm
            {"0x70064F47", {{MapType.ERIADOR, 725, 555}}}, -- Clegur
            {"0x7005B38E", {{MapType.ERIADOR, 835, 245}}}, -- Glân Vraig
            {"0x700658EB", {{MapType.GONDOR, 640, 625}}}, -- Pelargir
            {"0x700686FE", {{MapType.HARADWAITH, 415, 370}}}, -- Order of the Eagle
            {"0x700686FF", {{MapType.HARADWAITH, 475, 370}}}, -- Umbar
            {"0x70068700", {{MapType.GONDOR, 180, 485},
                            {MapType.HARADWAITH, 355, 70}}}, -- King's Dol Amroth
            {"0x70068701", {{MapType.HARADWAITH, 335, 315}}}, -- Jax Phanâl
            {"0x70068702", {{MapType.HARADWAITH, 245, 260}}}, -- Halrax
            {"0x70068703", {{MapType.GONDOR, 225, 420},
                            {MapType.HARADWAITH, 200, 20}}}, -- Lond Cirion
            {"0x70068704", {{MapType.HARADWAITH, 415, 340}}}, -- Ledger-Keepers
            {"0x700697F2", {{MapType.HARADWAITH, 445, 400}}}, -- Bloody Eagle Tavern
        };
    end
    return nil;
end

function MapWindow:AddRacialLocation()
    local racialMap = {
        {"0x700062F6", {MapType.ERIADOR, 525, 335}}, -- Bree
        {"0x700062C8", {MapType.ERIADOR, 405, 440}}, -- Michel Delving
        {"0x70006346", {MapType.ERIADOR, 310, 270}}, -- Thorin's Hall
        {"0x7000631F", {MapType.ERIADOR, 900, 375}}, -- Rivendell
        {"0x70041A22", {MapType.RHOVANION, 285, 340}}, -- Grimbeorn's House
        {"0x70048C8C", {MapType.RHOVANION, 120, 690}}, -- Caras Galadhon
        {"0x70053C0F", {MapType.ERIADOR, 345, 310}}, -- Thorin's Gate
        {"0x70066D31", {MapType.RHOVANION, 155, 165}}, -- Lyndelby
    };

    if #racialMap > PlayerRaceKey then
        if #racialMap ~= racialLocations:GetCount() then
            Turbine.Shell.WriteLine("Error: Missing other Racial locations " .. (racialLocations:GetCount() - #racialMap));
        end
        local item = racialMap[PlayerRaceKey];
        if self.mapType == item[2][1] then
            local id = item[1]
            if self:IsShortcutTrained(id) then
                local sType = Turbine.UI.Lotro.ShortcutType.Skill;
                local shortcut = Turbine.UI.Lotro.Shortcut(sType, id);
                self:AddSingleShortcut(item[2], shortcut);
            end
        end
    else
        Turbine.Shell.WriteLine("Error: Missing Racial locations " .. (racialLocations:GetCount() - #racialMap));
    end
end

function MapWindow:AddGlanVraigMap()
    local moorsMap = {
        -- Moors Map
        {MapType.ERIADOR, 865, 245} -- Ettenmoors
    };

    if self.mapType == moorsMap[1][1] then
        for i = 1, #TravelShortcuts, 1 do
            if TravelShortcuts[i]:GetName() == glanMapString then
                if self:IsShortcutEnabled(TravelShortcuts[i]:GetData()) then
                    self:AddSingleShortcut(moorsMap[1], TravelShortcuts[i]);
                    break
                end
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

    if self.debug then
    self.debugMove = false;
        self.quickslots[index].MouseDown = function(sender, args)
            self.debugMove = true;
            self.debugIndex = index;
            self.debugX = args.X;
            self.debugY = args.Y;
        end
    end
end

function MapWindow:IsShortcutEnabled(id)

    for i = 1, #TravelShortcuts, 1 do
        local shortcut = TravelShortcuts[i]
        if shortcut:GetData() == id then
            -- must be user enabled
            return shortcut:IsEnabled()
        end
    end

    return false;
end

function MapWindow:IsShortcutTrained(id)

    for i = 1, #TravelShortcuts, 1 do
        local shortcut = TravelShortcuts[i]
        if shortcut:GetData() == id then
            if shortcut:IsEnabled() and shortcut.found then
                -- must be user enabled and trained
                return true;
            end
            return false;
        end
    end

    return false;
end

function MapWindow:DebugNameLookup(id)
    for i = 1, #TravelShortcuts, 1 do
        local shortcut = TravelShortcuts[i]
        if shortcut:GetData() == id then
            return shortcut.Name;
        end
    end

    return "ERROR " .. id;
end

function MapWindow:VerifyMapSkillIds(name)
    local skills;
    if name == "Hunter" then
        skills = hunterLocations;
    elseif name == "Warden" then
        skills = wardenLocations;
    elseif name == "Mariner" then
        skills = marinerLocations;
    elseif name == "Reputation" then
        skills = repLocations;
    else
        return; -- invalid option
    end

    local map = self:GetLocations(name);
    if map == nil then return end

    local skillKeys = {};
    for i = 1, skills:GetCount() do
        skillKeys[skills:IdAtIndex(i)] = 0;
    end
    for i = 1, #map do
        local id = map[i][1]
        local uses = skillKeys[id];
        if uses == nil then
            Turbine.Shell.WriteLine(name .. " coords " .. id ..  " not in dictionary");
        elseif uses == 1 then
            Turbine.Shell.WriteLine(name .. " coords " .. id .. " used more than once");
        else
            skillKeys[id] = 1;
        end
    end
    for k, v in pairs(skillKeys) do
        if v == 0 then
            Turbine.Shell.WriteLine(name .. " dictionary coords " .. k .. " not configured");
        end
    end
end
