import "Turbine";
import "Turbine.Debug";
import "Turbine.Gameplay";
import "Turbine.UI";
import "Turbine.UI.Lotro";
import "DhorPlugins.Extensions";
import "DhorPlugins.Utils.BitOps";

MoorMapWindow = class(Turbine.UI.Lotro.Window);

function MoorMapWindow:Constructor(parent)
    Turbine.UI.Lotro.Window.Constructor(self);

    -- add a check to see if we load completely
    self.loaded = false;

    -- set size of window
    self.width = 1044;
    self.height = 817
    self.windowWidth, self.windowHeight = Turbine.UI.Display:GetSize();

    self.mainWindow = parent;

    -- table of shortcuts
    self.quickslots = {};

    -- set the default window settings
    self:SetPosition(self.windowWidth / 2 - self.width / 2, self.windowHeight / 2 - self.height / 2);
    self:SetSize(self.width, self.height);
    self:SetBlendMode(Turbine.UI.BlendMode.Undefined);
    self:SetBackColor(Turbine.UI.Color(0.0, 0, 0, 0));
    self:SetText(moorMapTitleString);
    self:SetOpacity(1);

    mapLabel = Turbine.UI.Label();
    mapLabel:SetPosition(10, 40);
    mapLabel:SetSize(1024, 768);

    mapLabel:SetBackground(0x41008133);
    mapLabel:SetParent(self);
    mapLabel:SetVisible(true);

    self:AddShortcuts();

    self:SetVisible(true);

    -- have the main window close the options
    self.VisibleChanged = function(sender, args)
        if (self:IsVisible() == false) then
            if (parent ~= nil) then
                parent:CloseMoorMap();
            end
        end
    end

    self.loaded = true;
end

function MoorMapWindow:AddShortcuts()

    local mapLocations = {
        { 180, 120 }, -- Crude Map to Gramsfoot
        { 215, 120 }, -- Map to Gramsfoot

        { 700, 200 }, -- Crude Map to Isendeep
        { 350, 440 }, -- Crude Map to Tol Ascarnen
        { 180, 380 }, -- Crude Map to Lugazag
        { 500, 295 }, -- Crude Map to Tirith Rhaw
        { 340, 510 }, -- Crude Map to Grimwood

        { 610, 300 }, -- Poor Map to Isendeep
        { 435, 365 }, -- Poor Map to Tol Ascarnen
        { 180, 270 }, -- Poor Map to Lugazag
        { 625, 365 }, -- Poor Map to Tirith Rhaw
        { 380, 540 }, -- Poor Map to Grimwood

        { 310, 95 }, -- Good Map to Isendeep
        { 375, 480 }, -- Good Map to Tol Ascarnen
        { 305, 275 }, -- Good Map to Lugazag
        { 555, 470 }, -- Good Map to Tirith Rhaw
        { 445, 650 }   -- Good Map to Grimwood
    };


    for i = 1, travelCount[6], 1 do

        self.quickslots[i] = Turbine.UI.Lotro.Quickslot();
        self.quickslots[i]:SetStretchMode(2);
        self.quickslots[i]:SetSize(22, 22);
        self.quickslots[i]:SetVisible(true);
        self.quickslots[i]:SetZOrder(100);
        self.quickslots[i]:SetOpacity(1);
        self.quickslots[i]:SetParent(mapLabel);
        self.quickslots[i]:SetAllowDrop(false);
        self.quickslots[i]:SetPosition(mapLocations[i][1], mapLocations[i][2]);
        self.quickslots[i]:SetZOrder(98);
        self.quickslots[i]:SetShortcut(Turbine.UI.Lotro.Shortcut(6.0, creepLocations:DataAtIndex(i)));
        self.quickslots[i]:SetMouseVisible(true);
        self.quickslots[i]:SetUseOnRightClick(false);
        self.quickslots[i]:SetVisible(true);
        self.quickslots[i]:SetAllowDrop(false);

        self.quickslots[i].MouseClick = function(sender, args)
            self:SetVisible(false);
        end
    end
end
