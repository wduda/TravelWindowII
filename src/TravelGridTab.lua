import "Turbine";
import "Turbine.Gameplay";
import "Turbine.UI";
import "Turbine.UI.Lotro";
import "TravelWindowII.src.extensions";
import "TravelWindowII.src.SettingsMenu";
import "TravelWindowII.src.utils.BitOps";

--[[ This is the window for the icon grid tab of the 	 ]] --
--[[ Travel UI.  It handles creating all UI controls on  ]] --
--[[ the tab, and updating the UI when the settings are	 ]] --
--[[ changed.											 ]] --

TravelGridTab = class(Turbine.UI.Control);

function TravelGridTab:Constructor(toplevel)
    Turbine.UI.Control.Constructor(self);

    -- set the default values
    self.quickslots = {};
    self.selected = {};
    self.numOfCols = 0;
    self.maxScroll = 0;

    if self.parent == nil then
        -- need top level window in order to close it
        self.parent = toplevel;
    end

    -- a subwindow (now a control) for containing all the quickslots
    self.SubWindow = Turbine.UI.Control();
    self.SubWindow:SetPosition(0, 0);
    self.SubWindow:SetParent(self);
    self.SubWindow:SetMouseVisible(true);

    -- set up the scrollbar for the list
    self.myScrollBar = Turbine.UI.Lotro.ScrollBar();
    self.myScrollBar:SetOrientation(Turbine.UI.Orientation.Vertical);
    self.myScrollBar:SetMinimum(0);
    self.myScrollBar:SetVisible(false);

    self.myScrollBar.MouseClick = function(sender, args)
        if (args.Button == Turbine.UI.MouseButton.Right) then
            Menu:ShowMenu();
        end
    end

    -- call the routine to update the
    -- sub window when the value of the
    -- scrollbar is changed.
    self.myScrollBar.ValueChanged = function(sender, args)
        self:UpdateSubWindow();
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

    -- handle the mouse wheel scrolls
    self.myLabel.MouseWheel = function(sender, args)
        self:DoScroll(sender, args);
    end

    self.myLabel.MouseUp = function(sender, args)
        self.parent:MouseUp(sender, args);
    end

    --[[  EVENT HANDLERS  ]] --

    -- make sure we check for updates
    self:SetWantsUpdates(true);

    -- check for a right mouse button event to open menu
    self.MouseClick = function(sender, args)
        if (args.Button == Turbine.UI.MouseButton.Right) then
            Menu:ShowMenu();
        end
    end
end

-- function to handle mouse scrollwheel events
function TravelGridTab:DoScroll(sender, args)

    -- calculate how far to move the scrollbar
    local newValue = self.myScrollBar:GetValue() - args.Direction * 20;

    -- make sure the value does not go below zero
    if newValue < 0 then
        newValue = 0;
    end
    self.myScrollBar:SetValue(newValue);

    -- hide the scrollbar if the max value is 0, we don't need it
    self.myScrollBar:SetVisible(self.maxScroll > 0);
end

-- function to force the tab to update the subwindow control
function TravelGridTab:UpdateSubWindow()

    -- loop through all the quickslots
    for i = 1, #self.quickslots, 1 do
        -- get the number of rows
        local row = math.ceil(i / self.numOfCols);

        -- set the top position of the quickslots based on row
        -- number and the value of the scrollbar
        self.quickslots[i]:SetTop((row - 1) * 38 - self.myScrollBar:GetValue());
    end
end

-- function to set all the quickslot items to show
function TravelGridTab:SetItems()

    if self.tabId ~= self.parent.MainPanel.selectedPage then
        return
    end

    if not(self.parent.dirty) then
        local prevNumOfCols = self.numOfCols;
        self:UpdateBounds(#self.selected);
        if self.parent.MainPanel.selectedPage == 2 and self.numOfCols ~= prevNumOfCols then
            self.parent.dirty = true;
        end
    end

    self.row = 1;
    self.col = 1;
    if self.parent.dirty then
        -- clear all the old quickslots from the SubWindow
        self.controlList = self.SubWindow:GetControls();
        self.controlList:Clear();

        -- collect shortcuts for display
        self.selected = {}
        for i = 1, #TravelShortcuts, 1 do
            local shortcut = TravelShortcuts[i];
            -- make sure skill is trained and enabled
            if shortcut.found and shortcut:IsEnabled() then
                -- apply skill type filter if set in options
                if hasbit(Settings.filters, bit(shortcut:GetTravelType())) then
                    self.selected[#self.selected + 1] = shortcut;
                end
            end
        end

        -- update controls
        self:UpdateBounds(#self.selected);
        self.SubWindow:SetSize(self:GetWidth(), self:GetHeight());
        self.myScrollBar:SetParent(self.SubWindow);
        self.myScrollBar:SetSize(10, self:GetHeight());
        self.myScrollBar:SetPosition(self:GetWidth() - 10, 0);
        self.myScrollBar:SetMaximum(self.maxScroll);
        self.myScrollBar:SetVisible(self.maxScroll > 0);
        self.myLabel:SetParent(self.SubWindow);
        self.myLabel:SetSize(self:GetWidth() - 10, self:GetHeight());

        -- clear the quickslots table
        self.quickslots = {};
    else
        self.SubWindow:SetSize(self:GetWidth(), self:GetHeight());
        self.myScrollBar:SetSize(10, self:GetHeight());
        self.myScrollBar:SetPosition(self:GetWidth() - 10, 0);
        self.myScrollBar:SetMaximum(self.maxScroll);
        self.myScrollBar:SetVisible(self.maxScroll > 0);
        self.myLabel:SetSize(self:GetWidth() - 10, self:GetHeight());
    end

    local margin = self:GetMargin(#self.selected);
    for i = 1, #self.selected, 1 do
        self:AddItem(self.selected[i], margin);
    end

    self.parent.dirty = false;
end

-- function to add a single shortcut to the tab
function TravelGridTab:AddItem(shortcut, margin)

    local index = (self.row - 1) * self.numOfCols + self.col;

    if not(self.parent.dirty) then
        self.quickslots[index]:SetPosition(margin + ((self.col - 1) * 38),
                ((self.row - 1) * 38 - self.myScrollBar:GetValue()));
    else
        --	create new quickslots setting the position
        --  based on the row and column locations
        self.quickslots[index] = Turbine.UI.Lotro.Quickslot();
        self.quickslots[index]:SetSize(36, 36);
        self.quickslots[index]:SetPosition(margin + ((self.col - 1) * 38),
                ((self.row - 1) * 38 - self.myScrollBar:GetValue()));
        self.quickslots[index]:SetZOrder(90);
        self.quickslots[index]:SetUseOnRightClick(false);
        self.quickslots[index]:SetParent(self.SubWindow);

        -- attempt to create the shortcut
        pcall(function()
            self.quickslots[index]:SetShortcut(shortcut);
        end)

        -- set all quickslots to be visible and
        -- disable dropping new shortcuts onto them
        self.quickslots[index]:SetAllowDrop(false);
        self.quickslots[index]:SetVisible(true);

        -- show the menu when right clicked
        self.quickslots[index].MouseClick = function(sender, args)
            if (args.Button == Turbine.UI.MouseButton.Right) then
                Menu:ShowMenu();
            else
                if (Settings.hideOnTravel == 1) then
                    self.parent:SetVisible(false);
                end
            end
        end

        -- handle the mouse wheel scroll
        self.quickslots[index].MouseWheel = function(sender, args)
            self:DoScroll(sender, args);
        end
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

function TravelGridTab:UpdateBounds(numOfShortcuts)
    -- calculate number of columns
    local padding = 4;
    local marginOffset = 1;
    self.numOfCols = math.floor((self:GetWidth() - padding) / 38);
    local numOfRows = math.ceil(numOfShortcuts / self.numOfCols);

    -- set the maximum scroll of the scrollbar
    self.maxScroll = numOfRows * 38 - self:GetHeight();
    if self.maxScroll < 1 then
        self.maxScroll = 0;
    else
        -- include scrollbar width
        self.numOfCols = math.floor((self:GetWidth() - padding - 10) / 38);
        numOfRows = math.ceil(numOfShortcuts / self.numOfCols);
        self.maxScroll = numOfRows * 38 - self:GetHeight();
    end
end

function TravelGridTab:GetMargin(numOfShortcuts)
    -- center the grid icons by calculating start position
    local cols = self.numOfCols;
    if numOfShortcuts < cols then
        cols = numOfShortcuts;
    end
    local width = self:GetWidth();
    local marginOffset = 1;
    if self.maxScroll < 1 then
        marginOffset = 0;
    else
        width = width - 12; -- remove width of scrollbar
    end
    return math.floor((width - cols * 38) / 2.0) - marginOffset;
end

-- function to adjust the size of the tab and all items in the tab
function TravelGridTab:SetSize(width, height)

    -- set the size of the tab
    Turbine.UI.Control.SetSize(self, width, height);

    -- reset all the quickslots of the tab
    self:SetItems();
end
