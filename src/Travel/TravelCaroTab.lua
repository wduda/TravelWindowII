import "Turbine";
import "Turbine.Gameplay";
import "Turbine.UI";
import "Turbine.UI.Lotro";
import "DhorPlugins.Extensions";
import "DhorPlugins.Travel.SettingsMenu";
import "DhorPlugins.Utils.BitOps";

--[[ This is the window for the carousel tab of the 	]] --
--[[ Travel UI.  It handles creating all UI controls on ]] --
--[[ the tab, and updating the UI when the settings are	]] --
--[[ changed.											]] --

TravelCaroTab = class(Turbine.UI.Control);

function TravelCaroTab:Constructor(toplevel)
    Turbine.UI.Control.Constructor(self);

    -- set initial values
    self.quickslots = {};
    self.shortcuts = {};
    self.selectedIndex = 1;
    -- self.rationCount = 0;

    -- need top level window in order to close it
    self.parent = toplevel;

    -- this label is used to catch wheel moves
    self.scrollLabel = Turbine.UI.Label();
    self.scrollLabel:SetSize(180, 155);
    self.scrollLabel:SetPosition(0, 20);
    self.scrollLabel:SetParent(self);

    -- create the quickslots, then set up the shortcuts
    self:CreateQuickslots();
    self:SetItems();

    --[[  EVENT HANDLERS  ]] --

    -- make sure we listen for key presses
    self:SetWantsUpdates(true);

    -- check for a right mouse button event to open menu
    self.MouseClick = function(sender, args)
        if (args.Button == Turbine.UI.MouseButton.Right) then
            menu:ShowMenu();
        end
    end

    -- check for a right mouse button event to open menu
    self.scrollLabel.MouseClick = function(sender, args)
        if (args.Button == Turbine.UI.MouseButton.Right) then
            menu:ShowMenu();
        end
    end

    -- check for mouse wheel movements
    self.scrollLabel.MouseWheel = function(sender, args)
        self:DoScroll(sender, args);
    end
end

function TravelCaroTab:DoScroll(sender, args)

    -- if there is only one item, then do nothing
    if (table.getn(self.shortcuts) == 1) then
        return;
    else
        -- adjust the shortcuts table based on which way the
        -- mouse wheel was moved.
        if (args.Direction == -1) then
            -- move the first item in the table
            -- to the end
            self.shortcut1 = self.shortcuts[1];
            table.remove(self.shortcuts, 1);
            table.insert(self.shortcuts, self.shortcut1);
        else
            -- move the last item in the table
            -- to the start
            self.shortcut2 = self.shortcuts[table.getn(self.shortcuts)];
            table.remove(self.shortcuts, table.getn(self.shortcuts));
            table.insert(self.shortcuts, 1, self.shortcut2);
        end
    end

    -- update the quickslots
    self:SetShortcuts()
end


function TravelCaroTab:SetItems()

    -- clear the shortcut table and set the selected
    -- item to 1
    self.shortcuts = {};
    self.selectedIndex = 1;

    -- loop through all the shortcuts and add those that are enabled
    for i = 1, table.getn(travelShortcuts), 1 do
        if (travelShortcuts[i]:IsEnabled()) then
            if (hasbit(settings.filters, bit(travelShortcuts[i]:GetTravelType()))) then

                if (TravelWindow:FindSkill(travelShortcuts[i]:GetSkillName())) then
                    table.insert(self.shortcuts, travelShortcuts[i]);
                elseif (travelShortcuts[i]:GetSkillName() == "skip") then
                    table.insert(self.shortcuts, travelShortcuts[i]);
                else
                    --Turbine.Shell.WriteLine("Skill not trained: " .. travelShortcuts[i]:GetSkillName());
                end
            end
        end
    end

    -- update the quickslots
    self:SetShortcuts();
end


function TravelCaroTab:SetShortcuts()

    -- set all quickslots to nil if there are no items in the shortcuts table
    if (table.getn(self.shortcuts) == 0) then
        for i = 1, 5, 1 do
            self.quickslots[i]:SetShortcut(nil);
        end
        -- set all quickslots the same if only 1 item in shortcuts table
    elseif (table.getn(self.shortcuts) == 1) then
        for i = 1, 5, 1 do
            pcall(function()
                self.quickslots[i]:SetShortcut(self.shortcuts[1]);
            end)
        end
        -- set the quickslots alternating if only 2 items in the shortcuts table
    elseif (table.getn(self.shortcuts) == 2) then
        pcall(function()
            self.quickslots[1]:SetShortcut(self.shortcuts[1]);
            self.quickslots[2]:SetShortcut(self.shortcuts[2]);
            self.quickslots[3]:SetShortcut(self.shortcuts[1]);
            self.quickslots[4]:SetShortcut(self.shortcuts[2]);
            self.quickslots[5]:SetShortcut(self.shortcuts[1]);
        end)
        -- set the quickslots for 3 or more shortcuts
    else
        pcall(function()
            self.quickslots[1]:SetShortcut(self.shortcuts[table.getn(self.shortcuts) - 1]);
            self.quickslots[2]:SetShortcut(self.shortcuts[table.getn(self.shortcuts)]);
            self.quickslots[3]:SetShortcut(self.shortcuts[1]);
            self.quickslots[4]:SetShortcut(self.shortcuts[2]);
            self.quickslots[5]:SetShortcut(self.shortcuts[3]);
        end)
    end

    -- set all but the middle shortcut to ignore
    -- mouse events and set them visible
    self.quickslots[1]:SetMouseVisible(false);
    self.quickslots[2]:SetMouseVisible(false);
    self.quickslots[4]:SetMouseVisible(false);
    self.quickslots[5]:SetMouseVisible(false);
    self.quickslots[1]:SetVisible(true);
    self.quickslots[2]:SetVisible(true);
    self.quickslots[4]:SetVisible(true);
    self.quickslots[5]:SetVisible(true);

    -- set the middle quickslot to accept mouse
    -- events, set it visible and disable drops
    self.quickslots[3]:SetMouseVisible(true);
    self.quickslots[3]:SetUseOnRightClick(false);
    self.quickslots[3]:SetVisible(true);
    self.quickslots[3]:SetAllowDrop(false);

    self:SetSize(self:GetWidth(), self:GetHeight());
end

function TravelCaroTab:CreateQuickslots()

    -- loop through the 5 quickslots to be created
    for i = 1, 5, 1 do
        -- set all the standard setting on all quickslots
        self.quickslots[i] = Turbine.UI.Lotro.Quickslot();
        self.quickslots[i]:SetVisible(true);
        self.quickslots[i]:SetZOrder(100);
        self.quickslots[i]:SetOpacity(1);
        self.quickslots[i]:SetParent(self);
        self.quickslots[i]:SetAllowDrop(false);
        self.quickslots[i]:SetStretchMode(1);
        self.quickslots[i]:SetMouseVisible(false);

        -- set the handler for mouse wheel event
        self.quickslots[i].MouseWheel = function(sender, args)
            self:DoScroll(sender, args);
        end

        -- set the handler for mouse click events, show the menu
        -- when right clicked
        self.quickslots[i].MouseClick = function(sender, args)
            if (args.Button == Turbine.UI.MouseButton.Right) then
                menu:ShowMenu();
            else
                self.parent:SetVisible(false);
            end
        end
    end

    --[[ Set the size and position for the 5 quickslots ]] --

    self.quickslots[1]:SetSize(22, 22);
    self.quickslots[1]:SetPosition(25, 81);
    self.quickslots[1]:SetZOrder(98);

    self.quickslots[2]:SetSize(36, 36);
    self.quickslots[2]:SetPosition(45, 78);
    self.quickslots[2]:SetZOrder(99);

    self.quickslots[3]:SetSize(36, 36);
    self.quickslots[3]:SetPosition(72, 75);
    self.quickslots[3]:SetMouseVisible(true);
    self.quickslots[3]:SetZOrder(100);

    self.quickslots[4]:SetSize(36, 36);
    self.quickslots[4]:SetPosition(99, 78);
    self.quickslots[4]:SetZOrder(99);

    self.quickslots[5]:SetSize(36, 36);
    self.quickslots[5]:SetPosition(119, 81);
    self.quickslots[5]:SetZOrder(98);
end

-- function to adjust the size of the tab and all items in the tab
function TravelCaroTab:SetSize(width, height)

    Turbine.UI.Control.SetSize(self, width, height);

    -- adjust the size and location of the 5 quickslots
    self.quickslots[1]:SetStretchMode(1);
    self.quickslots[1]:SetSize(22, 22);
    self.quickslots[1]:SetPosition(self:GetWidth() / 2 - 67, (self:GetHeight() - 20) / 2);

    self.quickslots[2]:SetStretchMode(1);
    self.quickslots[2]:SetSize(28, 28);
    self.quickslots[2]:SetPosition(self:GetWidth() / 2 - 45, (self:GetHeight() - 20) / 2 + 3);

    self.quickslots[3]:SetStretchMode(1);
    self.quickslots[3]:SetSize(36, 36);
    self.quickslots[3]:SetPosition(self:GetWidth() / 2 - 18, (self:GetHeight() - 20) / 2 + 5);

    self.quickslots[4]:SetStretchMode(1);
    self.quickslots[4]:SetSize(28, 28);
    self.quickslots[4]:SetPosition(self:GetWidth() / 2 + 17, (self:GetHeight() - 20) / 2 + 3);

    self.quickslots[5]:SetStretchMode(1);
    self.quickslots[5]:SetSize(22, 22);
    self.quickslots[5]:SetPosition(self:GetWidth() / 2 + 45, (self:GetHeight() - 20) / 2);

    Turbine.UI.Control.SetOpacity(self, 1);
end