import "Turbine.Gameplay";
import "Turbine.UI";
import "Turbine.UI.Lotro";
import "TravelWindowII.src.extensions";
import "TravelWindowII.src.SettingsMenu";
import "TravelWindowII.src.utils.BitOps";

--[[ This is the window for the map view tab of the 	 ]] --
--[[ Travel UI.  It handles creating all UI controls on  ]] --
--[[ the tab, and updating the UI when the settings are	 ]] --
--[[ changed.											 ]] --

TravelMapsTab = class(Turbine.UI.Control);

function TravelMapsTab:Constructor(toplevel)
    Turbine.UI.Control.Constructor(self);

    --  add a check to see if we load completely
    self.loaded = false;

    -- set size of window
    self.width = 1024;
    self.height = 768;
    self.windowWidth, self.windowHeight = Turbine.UI.Display:GetSize();

    -- set the default values
    self.quickslots = {};
    self.debug = false;

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

    --[[ if self.mapType == MapType.ERIADOR then
        self.mapLabel:SetBackground(0x41008138);
    elseif self.mapType == MapType.RHOVANION then
        self.mapLabel:SetBackground(0x411C2DE4);
    elseif self.mapType == MapType.ROHAN then
        self.mapLabel:SetBackground(0x411c2de5);
    elseif self.mapType == MapType.GONDOR then
        self.mapLabel:SetBackground(0x41154336);
    elseif self.mapType == MapType.HARADWAthen
        self.mapLabel:SetBackground(0x4124bcd0);
    elseif self.mapType == MapType.CREEPS then
        self.mapLabel:SetBackground(0x41008133);
    end ]]--

    self.mapType = MapType.ERIADOR
    self.mapLabel:SetBackground(0x41008138)

    self.loaded = true;

    if self.parent == nil then
        -- need top level window in order to close it
        self.parent = toplevel;
    end

    -- add an invisible label to intercept mouse events
    self.myLabel = Turbine.UI.Label();
    self.myLabel:SetSize(self:GetWidth() - 10, self:GetHeight());
    self.myLabel:SetPosition(0, 0);

    -- show the menu when right clicked
    self.myLabel.MouseClick = function(sender, args)
        if (args.Button == Turbine.UI.MouseButton.Right) then
            Menu:ShowMenu();
        end
    end

    self.myLabel.MouseUp = function(sender, args)
        self.parent:MouseUp(sender, args);
    end

    --[[  EVENT HANDLERS  ]] --

    -- check for a right mouse button event to open menu
    self.MouseClick = function(sender, args)
        if (args.Button == Turbine.UI.MouseButton.Right) then
            Menu:ShowMenu();
        end
    end
end

-- function to set all the quickslot items to show
function TravelMapsTab:SetItems()
    if self.mapType == MapType.CREEPS then
        self:AddCreepShortcuts();
    else
        self:AddClassLocations();
        self:AddReputationLocations();
        self:AddRacialLocation();
    end
end

function TravelMapsTab:ClearItems()
    self.quickslots = {}
end

function TravelMapsTab:AddLocations(skills)
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

function TravelMapsTab:AddClassLocations()
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

function TravelMapsTab:AddReputationLocations()
    self:AddLocations(TravelInfo.rep.skills);
end

function TravelMapsTab:AddRacialLocation()
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

function TravelMapsTab:AddCreepShortcuts()

    local sType = Turbine.UI.Lotro.ShortcutType.Skill;
    local creep = TravelInfo.creep;
    for i = 1, #creep.skills do
        local map = creep.skills[i].map
        local id = creep.skills[i].id;
        self.AddSingleShortcut(map, Turbine.UI.Lotro.Shortcut(sType, id));
    end
end

function TravelMapsTab:AddSingleShortcut(location, shortcut)

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

function TravelMapsTab:UpdateShortcut(id, enable)
    for i = 1, #self.quickslots do
        if self.quickslots[i]:GetShortcut():GetData() == id then
            self.quickslots[i]:SetVisible(enable);
        end
    end
end
