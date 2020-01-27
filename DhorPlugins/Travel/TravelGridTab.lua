import "Turbine";
import "Turbine.Gameplay";
import "Turbine.UI";
import "Turbine.UI.Lotro";
import "DhorPlugins.Extensions";
import "DhorPlugins.Travel.SettingsMenu";
import "DhorPlugins.Utils.BitOps";

--[[ This is the window for the icon grid tab of the 	                      ]] --
--[[ Travel UI.  It handles creating all UI controls on                     ]] --
--[[ the tab, and updating the UI when the settings are	                   ]] --
--[[ changed.											                               ]] --

TravelGridTab = class(Turbine.UI.Control);

function TravelGridTab:Constructor(toplevel)
    Turbine.UI.Control.Constructor(self);

    -- set the default values
    self.quickslots = {};
    -- self.rationCount = 0;
    self.numOfCols = 0;
    self.max = 1;

    -- need top level window in order to close it
    self.parent = toplevel;

    -- a subwindow (now a control) for containing all the quickslots
    self.SubWindow = Turbine.UI.Control();
    self.SubWindow:SetZOrder(99);
    self.SubWindow:SetPosition(0, 25);
    self.SubWindow:SetSize(self:GetWidth(), self:GetHeight() - 35);
    self.SubWindow:SetBackColor(Turbine.UI.Color(0.87, 0, 0, 0));
    self.SubWindow:SetParent(self);
    self.SubWindow:SetMouseVisible(true);
    self.SubWindow:SetOpacity(1);
    self.SubWindow:SetVisible(true);

    -- set up all the quickslots
    self:SetItems();

    --[[  EVENT HANDLERS  ]] --

    -- make sure we check for updates
    self:SetWantsUpdates(true);

    -- check for a right mouse button event to open menu
    self.MouseClick = function(sender, args)
        if (args.Button == Turbine.UI.MouseButton.Right) then
            menu:ShowMenu();
        end
    end

end

-- function to handle mouse scrollwheel events
function TravelGridTab:DoScroll(sender, args)

    -- calculate how far to move the scrollbar
    newValue = self.myScrollBar:GetValue() - args.Direction * 20;

    -- make sure the value does not go below zero
    if (newValue < 0) then
        newValue = 0;
    end

    -- set the new value
    self.myScrollBar:SetValue(newValue);

    -- hide the scrollbar if the max value is 0, meaning we don't need a
    -- scrollbar
    if (self.max == 0) then
        self.myScrollBar:SetVisible(false);
    else
        self.myScrollBar:SetVisible(true);
    end
end

-- function to force the tab to update the subwindow control	
function TravelGridTab:UpdateSubWindow()

    -- loop through all the quickslots
    for i = 1, table.getn(self.quickslots), 1 do
        -- get the number of rows
        self.row = math.ceil(i / self.numOfCols);

        -- set the top position of the quickslots based on row
        -- number and the value of the scrollbar
        self.quickslots[i]:SetTop((self.row - 1) * 38 - self.myScrollBar:GetValue());
    end
end

-- function to set all the quickslot items to show
function TravelGridTab:SetItems()

    -- clear all the old quickslots from the Sub Window
    if (self.SubWindow ~= nil) then
        self.controlList = self.SubWindow:GetControls();

        if (self.controlList:GetCount() > 0) then
            for i = self.controlList:GetCount(), 1, -1 do
                self.controlList:RemoveAt(i);
            end
        end
    end

    -- create a new sub window
    self.SubWindow = Turbine.UI.Control();
    self.SubWindow:SetZOrder(99);
    self.SubWindow:SetPosition(0, 25);
    self.SubWindow:SetSize(self:GetWidth(), self:GetHeight() - 35);
    self.SubWindow:SetBackColor(Turbine.UI.Color(0.87, 0, 0, 0));
    self.SubWindow:SetParent(self);
    self.SubWindow:SetMouseVisible(true);
    self.SubWindow:SetOpacity(1);
    self.SubWindow:SetVisible(true);

    -- clear the quickslots table, and set row and column to 1
    self.quickslots = {};
    self.row = 1;
    self.col = 1;

    -- loop through all the shortcuts and add those that are enabled
    counter = 1;
    for i = 1, table.getn(travelShortcuts), 1 do
        if (travelShortcuts[i]:IsEnabled()) then
            if (hasbit(settings.filters, bit(travelShortcuts[i]:GetTravelType()))) then

                if (TravelWindow:FindSkill(travelShortcuts[i]:GetSkillName())) then
                    self:AddItem(travelShortcuts[i], counter);
                    counter = counter + 1;
                elseif (travelShortcuts[i]:GetSkillName() == "skip") then
                    self:AddItem(travelShortcuts[i], counter);
                    counter = counter + 1;
                else
                    --Turbine.Shell.WriteLine("Skill not trained: " .. travelShortcuts[i]:GetSkillName());
                end
            end
        end
    end

    -- add an invisible label to intercept mouse events
    self.myLabel = Turbine.UI.Label();
    self.myLabel:SetSize(self:GetWidth(), self:GetHeight() - 35);
    self.myLabel:SetPosition(0, 0);
    self.myLabel:SetParent(self.SubWindow);

    -- show the menu when right clicked
    self.myLabel.MouseClick = function(sender, args)
        if (args.Button == Turbine.UI.MouseButton.Right) then
            menu:ShowMenu();
        else
            self.parent:SetVisible(false);
        end
    end

    -- handle the mouse wheel scrolls
    self.myLabel.MouseWheel = function(sender, args)
        self:DoScroll(sender, args);
    end

    -- set the scrollbar up
    self:SetScrollBar();
end

-- function to add a single shortcut to the tab
function TravelGridTab:AddItem(shortcut)
    -- figure out the column width
    self.numOfCols = math.floor((self:GetWidth() - 36) / 36);

    self.index = (self.row - 1) * self.numOfCols + self.col;

    --	create new quickslots setting the position
    --  based on the row and column locations
    self.quickslots[self.index] = Turbine.UI.Lotro.Quickslot();
    self.quickslots[self.index]:SetSize(36, 36);
    self.quickslots[self.index]:SetPosition(10 + ((self.col - 1) * 38), ((self.row - 1) * 38));
    self.quickslots[self.index]:SetZOrder(90);
    self.quickslots[self.index]:SetOpacity(1);
    self.quickslots[self.index]:SetUseOnRightClick(false);
    self.quickslots[self.index]:SetParent(self.SubWindow);

    -- attempt to create the shortcut
    pcall(function()
        self.quickslots[self.index]:SetShortcut(shortcut);
    end)

    -- set all quickslots to be visible and
    -- disable dropping new shortcuts onto them
    self.quickslots[self.index]:SetAllowDrop(false);
    self.quickslots[self.index]:SetVisible(true);

    -- show the menu when right clicked
    self.quickslots[self.index].MouseClick = function(sender, args)
        if (args.Button == Turbine.UI.MouseButton.Right) then
            menu:ShowMenu();
        else
            self.parent:SetVisible(false);
        end
    end

    -- handle the mouse wheel scroll
    self.quickslots[self.index].MouseWheel = function(sender, args)
        self:DoScroll(sender, args);
    end

    -- increase the row number when the column
    -- number is greater than the number of columns
    -- for the size of the window
    self.col = self.col + 1;
    if (self.col > self.numOfCols) then
        self.col = 1;
        self.row = self.row + 1;
    end
end

function TravelGridTab:SetScrollBar()

    -- set up the scrollbar for the list
    self.myScrollBar = Turbine.UI.Lotro.ScrollBar();
    self.myScrollBar:SetBackColor(Turbine.UI.Color(0.87, 0, 0, 0));
    self.myScrollBar:SetOrientation(Turbine.UI.Orientation.Vertical);
    self.myScrollBar:SetSize(10, self:GetHeight() - 35);
    self.myScrollBar:SetPosition(self:GetWidth() - 15, 0);
    self.myScrollBar:SetMinimum(0);

    -- set the maximum value of the scrollbar
    -- based on the number of rows in the subwindow
    numOfSlots = table.getn(self.quickslots);
    numOfRows = math.ceil(numOfSlots / self.numOfCols);

    self.max = numOfRows * 38 - self:GetHeight() + 35;
    if (self.max < 0) then
        -- the max cannot be less than one
        self.max = 0;
        self.myScrollBar:SetMaximum(self.max);
        self.myScrollBar:SetParent(self.SubWindow);
        self.myScrollBar:SetVisible(false);
    else
        self.myScrollBar:SetMaximum(self.max);
        self.myScrollBar:SetParent(self.SubWindow);
        self.myScrollBar:SetVisible(true);
    end

    -- show the menu when right clicked
    self.myScrollBar.MouseClick = function(sender, args)
        if (args.Button == Turbine.UI.MouseButton.Right) then
            menu:ShowMenu();
        end
    end

    -- call the routine to update the
    -- sub window when the value of the
    -- scrollbar is changed.
    self.myScrollBar.ValueChanged = function(sender, args)
        self:UpdateSubWindow();
    end
end

-- function to adjust the size of the tab and all items in the tab
function TravelGridTab:SetSize(width, height)

    -- set the size of the tab
    Turbine.UI.Control.SetSize(self, width, height);

    -- reset all the quickslots of the tab
    self:SetItems();

    -- update the size of the ration label
    -- self.rationLabel:SetSize(self:GetWidth(),20);

    Turbine.UI.Control.SetOpacity(self, 1);
end
