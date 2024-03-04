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

function MapWindow:Constructor(map)
    Turbine.UI.Window.Constructor(self);

    --  add a check to see if we load completely
    self.loaded = false;

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
            PatchDataSave(Turbine.DataScope.Character, "TravelWindowIIDebugCoords", coordinates);
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
        self.mapLabel:SetBackground(0x41008138);
    elseif self.mapType == MapType.RHOVANION then
        self.mapLabel:SetBackground(0x411C2DE4);
    elseif self.mapType == MapType.ROHAN then
        self.mapLabel:SetBackground(0x411c2de5);
    elseif self.mapType == MapType.GONDOR then
        self.mapLabel:SetBackground(0x41154336);
    elseif self.mapType == MapType.HARADWAITH then
        self.mapLabel:SetBackground(0x4124bcd0);
    elseif self.mapType == MapType.CREEPS then
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
    end
end

function MapWindow:AddLocations(skills)
    local sType = Turbine.UI.Lotro.ShortcutType.Skill;
    for i = 1, #skills do
        local skill = skills[i];
        if skill.map ~= nil then
            for r = 1, #skill.map do
                local item = skill.map[r];
                if item ~= nil and #item == 3 and self.mapType == item[1] then
                    local id = skill.id;
                    self:AddSingleShortcut(item, Turbine.UI.Lotro.Shortcut(sType, id));
                end
            end
        end
    end
end

function MapWindow:AddClassLocations()
    if PlayerClass == Turbine.Gameplay.Class.Hunter then
        self:AddLocations(TravelInfo.hunter.skills);
    elseif PlayerClass == Turbine.Gameplay.Class.Warden then
        self:AddLocations(TravelInfo.warden.skills);
    elseif PlayerClass == Turbine.Gameplay.Class.Mariner then
        self:AddLocations(TravelInfo.mariner.skills);
    else
        -- nothing to add for other classes
        return
    end
end

function MapWindow:AddReputationLocations()
    self:AddLocations(TravelInfo.rep.skills);
end

function MapWindow:AddRacialLocation()
    local racial = TravelInfo.racial;
    if self.mapType == racial.map[1] then
        local id = racial.id
        if IsShortcutTrained(id) then
            local sType = Turbine.UI.Lotro.ShortcutType.Skill;
            local shortcut = Turbine.UI.Lotro.Shortcut(sType, id);
            self:AddSingleShortcut(racial.map, shortcut);
        end
    end
end

function MapWindow:AddCreepShortcuts()

    local sType = Turbine.UI.Lotro.ShortcutType.Skill;
    local creep = TravelInfo.creep;
    for i = 1, #creep.skills do
        local map = creep.skills[i].map
        local id = creep.skills[i].id;
        self.AddSingleShortcut(map, Turbine.UI.Lotro.Shortcut(sType, id));
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
    self.quickslots[index]:SetVisible(IsShortcutEnabled(shortcut:GetData()));

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

function MapWindow:UpdateShortcut(id, enable)
    for i = 1, #self.quickslots do
        if self.quickslots[i]:GetShortcut():GetData() == id then
            self.quickslots[i]:SetVisible(enable);
        end
    end
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
