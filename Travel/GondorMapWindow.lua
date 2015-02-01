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
    self.width = 1078;
    self.height = 680;
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
    mapLabel:SetSize(1058, 631);
    GLocale = Turbine.Engine.GetLanguage();
    if GLocale == 268435459 then mapLabel:SetBackground("DhorPlugins/Travel/Resources/gondormapfr.jpg");
    elseif GLocale == 268435460 then mapLabel:SetBackground("DhorPlugins/Travel/Resources/gondormapde.jpg");
    elseif GLocale == 268435463 then mapLabel:SetBackground("DhorPlugins/Travel/Resources/gondormapru.jpg"); -- by PulseDiver
    else mapLabel:SetBackground("DhorPlugins/Travel/Resources/gondormap.jpg");
    end
    -- mapLabel:SetBackground("DhorPlugins/Travel/Resources/gondormap.tga");
    mapLabel:SetParent(self);
    mapLabel:SetVisible(true);

    self.mapLocations = {
        { -1, -1 }, -- camp
        { -1, -1 }, -- bree
        { -1, -1 }, -- thorins
        { -1, -1 }, -- md
        { -1, -1 }, -- est
        { -1, -1 }, -- evendim
        { -1, -1 }, -- og
        { -1, -1 }, -- riv
        { -1, -1 }, -- suri
        { -1, -1 }, -- w ang
        { -1, -1 }, -- e ang
        { -1, -1 }, -- echad dunann
        { -1, -1 }, -- 21
        { -1, -1 }, -- mirk
        { -1, -1 }, -- harn
        { -1, -1 }, -- galtrev
        { -1, -1 }, -- stan
        { -1, -1 }, -- CG
        { -1, -1 }, -- MM
        { -1, -1 }, -- Snowbourn
        { -1, -1 }, -- Forlaw
        { -1, -1 }, -- Aldburg
        { -1, -1 }, --Helms Deep
        { 465, 470 }, --Dol Amroth
        { -1, -1 }, -- start of warden skills, og
        { -1, -1 }, -- est
        { -1, -1 }, -- even
        { -1, -1 }, -- riv
        { -1, -1 }, -- suri
        { -1, -1 }, -- 21
        { -1, -1 }, -- mirk
        { -1, -1 }, -- harn
        { -1, -1 }, -- galtrev
        { -1, -1 }, -- stan
        { -1, -1 }, -- CG
        { -1, -1 }, -- MM
        { -1, -1 }, -- Snowbourn
        { -1, -1 }, -- Forlaw
        { -1, -1 }, -- Aldburg
        { -1, -1 }, --Helms Deep
        { 465, 470 }, --Dol Amroth
        { -1, -1 }, -- start of rep, thorins
        { -1, -1 }, -- bree
        { -1, -1 }, -- shire
        { -1, -1 }, -- lalia
        { -1, -1 }, -- riv
        { -1, -1 }, -- og
        { -1, -1 }, -- mirk
        { -1, -1 }, -- enedwaith
        { -1, -1 }, -- galtrev
        { -1, -1 }, -- stangard
        { -1, -1 }, -- Snowbourn
        { -1, -1 }, -- Forlaw
        { -1, -1 }, -- Aldburg
        { -1, -1 }, -- Derndingle
        { -1, -1 }, --Helms Deep
        { 465, 470 }, --Dol Amroth
        { -1, -1 }, -- start of racial, bree
        { -1, -1 }, -- shire
        { -1, -1 }, -- thorins
        { -1, -1 }, -- riv
        { -1, -1 } -- beo
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
