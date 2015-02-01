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
    self.width = 620;
    self.height = 467;
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
    mapLabel:SetSize(600, 407);
    GLocale = Turbine.Engine.GetLanguage();
    if GLocale == 268435459 then mapLabel:SetBackground("DhorPlugins/Travel/Resources/moormapfr.jpg");
    elseif GLocale == 268435460 then mapLabel:SetBackground("DhorPlugins/Travel/Resources/moormapde.jpg");
    elseif GLocale == 268435463 then mapLabel:SetBackground("DhorPlugins/Travel/Resources/moormapru.jpg"); -- by PulseDiver
    else mapLabel:SetBackground("DhorPlugins/Travel/Resources/moormap.jpg");
    end
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
        { 120, 35 }, -- Crude Map to Gramsfoot
        { 130, 45 }, -- Map to Gramsfoot

        { 510, 93 }, -- Crude Map to Isendeep
        { 230, 230 }, -- Crude Map to Tol Ascarnen
        { 130, 185 }, -- Crude Map to Lugazag
        { 370, 135 }, -- Crude Map to Tirith Rhaw
        { 235, 275 }, -- Crude Map to Grimwood

        { 425, 115 }, -- Poor Map to Isendeep
        { 310, 185 }, -- Poor Map to Tol Ascarnen
        { 125, 135 }, -- Poor Map to Lugazag
        -- { 395,260 },	-- Poor Map to Tirith Rhaw -- by PulseDiver: it's not Poor Map to Tirith Rhaw, it's Good Map to Tirith Rhaw !!!
        { 445, 180 }, -- Poor Map to Tirith Rhaw -- by PulseDiver
        { 275, 300 }, -- Poor Map to Grimwood

        { 220, 20 }, -- Good Map to Isendeep
        { 265, 245 }, -- Good Map to Tol Ascarnen
        { 220, 140 }, -- Good Map to Lugazag
        -- { 445,180 },	-- Good Map to Tirith Rhaw -- by PulseDiver: it's not Good Map to Tirith Rhaw, it's Poor Map to Tirith Rhaw !!!
        { 395, 260 }, -- Good Map to Tirith Rhaw -- by PulseDiver
        { 325, 350 } -- Good Map to Grimwood
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
