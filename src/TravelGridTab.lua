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
    self.numOfRows = 0;
    self.maxScroll = 0;
    self.colWidth = 35;
    self.scrollChunk = self.colWidth;
    self.minCols = 4;

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
    self.myScrollBar:SetLargeChange(self.scrollChunk);
    self.myScrollBar:SetSmallChange(self.scrollChunk);
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

    -- check for a right mouse button event to open menu
    self.MouseClick = function(sender, args)
        if (args.Button == Turbine.UI.MouseButton.Right) then
            Menu:ShowMenu();
        end
    end

    self.DragDrop = function(sender, args)
        if BlockUIChange(self) then
            return
        end

        local shortcut = args.DragDropInfo:GetShortcut()
        if shortcut == nil then
            return
        end
        local srcSkill = GetTravelSkill(shortcut:GetData())
        if srcSkill == nil then
            return
        end
        local x, y = self:GetMousePosition()
        local gridIndex = self:GetGridIndex(x, y)
        local quickslot = self.quickslots[gridIndex]
        if quickslot == nil then
            return
        end
        shortcut = quickslot:GetShortcut()
        if shortcut == nil then
            return
        end
        local dstSkill = GetTravelSkill(shortcut:GetData())
        if dstSkill == nil then
            return
        end

        local srcIndex = srcSkill.shortcut.Index
        local dstIndex = dstSkill.shortcut.Index
        if srcIndex == dstIndex then
            return
        end
        if srcIndex > dstIndex then
            while dstIndex - 1 >= 1 do
                if TravelShortcuts[dstIndex - 1].found then
                    break
                end
                dstIndex = dstIndex - 1
            end
            while srcIndex > dstIndex do
                SwapTravelSkill(srcIndex, srcIndex - 1)
                srcIndex = srcIndex - 1
            end
        end

        if srcIndex < dstIndex then
            local maxIndex = #TravelShortcuts
            while dstIndex + 1 <= maxIndex do
                if TravelShortcuts[dstIndex + 1].found then
                    break
                end
                dstIndex = dstIndex + 1
            end

            while srcIndex < dstIndex do
                SwapTravelSkill(srcIndex, srcIndex + 1)
                srcIndex = srcIndex + 1
            end
        end

        -- update the main window shortcuts and settings
        OptionsWindow.Panel:AddSortList();
        self.parent:UpdateSettings();
    end
end

-- function to handle mouse scrollwheel events
function TravelGridTab:DoScroll(sender, args)
    -- calculate how far to move the scrollbar
    local newValue = self.myScrollBar:GetValue() - args.Direction * self.scrollChunk;

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
        self.quickslots[i]:SetTop((row - 1) * self.colWidth - self.myScrollBar:GetValue());
    end
end

-- function to set all the quickslot items to show
function TravelGridTab:SetItems()

    if self.tabId ~= self.parent.MainPanel.selectedPage then
        return
    end

    if not(self.parent.dirty) then
        local prevNumOfCols = self.numOfCols;
        self:UpdateBounds();
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
                    table.insert(self.selected, shortcut);
                end
            end
        end

        -- update controls
        self:UpdateBounds();
        self.SubWindow:SetSize(self:GetWidth(), self:GetHeight());
        self.myScrollBar:SetParent(self.SubWindow);
        self.myScrollBar:SetSize(10, self:GetHeight() - 10);
        self.myScrollBar:SetPosition(self:GetWidth() - 10, 0);
        self.myScrollBar:SetMaximum(self.maxScroll);
        self.myScrollBar:SetVisible(self.maxScroll > 0);
        self.myLabel:SetParent(self.SubWindow);
        self.myLabel:SetSize(self:GetWidth() - 10, self:GetHeight());

        -- clear the quickslots table
        self.quickslots = {};
    else
        self.SubWindow:SetSize(self:GetWidth(), self:GetHeight());
        self.myScrollBar:SetSize(10, self:GetHeight() - 10);
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

    local x = margin + ((self.col - 1) * self.colWidth) - 1;
    local y = ((self.row - 1) * self.colWidth - self.myScrollBar:GetValue()) - 1;
    if not(self.parent.dirty) then
        self.quickslots[index]:SetPosition(x, y);
    else
        --	create new quickslots setting the position
        --  based on the row and column locations
        self.quickslots[index] = Turbine.UI.Lotro.Quickslot();
        self.quickslots[index]:SetSize(36, 36);
        self.quickslots[index]:SetPosition(x, y);
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

function TravelGridTab:GetPixelSize()
    local width = self.numOfCols * self.colWidth + self.parent.wPadding + 10;
    local height = self.numOfRows * self.colWidth + self.parent.hPadding;
    return width, height;
end

function TravelGridTab:FitToPixels(width, height)
    local wPadding = self.parent.wPadding;
    local hPadding = self.parent.hPadding;
    local cols, rows, maxScroll = self:GetGridDims(width - wPadding, height - hPadding);
    if not self.parent.isMinWindow or maxScroll > 0 then
        wPadding = wPadding + 10;
    end
    self.numOfCols = cols;
    self.numOfRows = rows;
    local sX = cols * self.colWidth + wPadding;
    local sY = rows * self.colWidth + hPadding;
    return sX, sY;
end

function TravelGridTab:GetGridDims(width, height)
    if width < self.minCols * self.colWidth then
        width = self.minCols * self.colWidth
    end
    if height < self.colWidth then
        height = self.colWidth
    end

    local scrollHeight = height
    width = width + self.colWidth / 2
    height = height + self.colWidth / 2
    local numOfShortcuts =  #self.selected;
    local numOfCols = math.floor(width / self.colWidth);
    local numOfRows = math.ceil(numOfShortcuts / numOfCols);

    -- set the maximum scroll of the scrollbar
    local maxScroll = numOfRows * self.colWidth - scrollHeight
    if maxScroll < self.colWidth then
        maxScroll = 0;
    elseif self.parent.isMinWindow and maxScroll > 0 then
        -- include scrollbar width
        numOfCols = math.floor((width - 10) / self.colWidth);
        numOfRows = math.ceil(numOfShortcuts / numOfCols);
        maxScroll = numOfRows * self.colWidth - scrollHeight
    end

    -- set min/max bounds
    if maxScroll < 0 then
        maxScroll = 0;
    elseif maxScroll > 0 then
        numOfRows = math.floor(height / self.colWidth);
    end
    if numOfRows < 1 then
        numOfRows = 1;
    end
    if numOfCols > #self.selected then
        numOfCols = #self.selected
    end
    if numOfCols < self.minCols then
        numOfCols = self.minCols;
    end
    return numOfCols, numOfRows, maxScroll;
end

function TravelGridTab:UpdateBounds()
    local width = self.parent:GetWidth() - self.parent.wPadding;
    local height = self.parent:GetHeight() - self.parent.hPadding;
    local c, r, m = self:GetGridDims(width, height);
    self.numOfCols = c;
    self.numOfRows = r;
    self.maxScroll = m;
    if not self.parent.isMinWindow then
        if c == self.minCols then
            self.parent:SetText(LC.mainShortTitle);
        else
            self.parent:SetText(LC.mainTitle);
        end
    end
end

function TravelGridTab:GetMargin(numOfShortcuts)
    -- center the grid icons by calculating start position
    local cols = self.numOfCols;
    if numOfShortcuts < cols then
        cols = numOfShortcuts;
    end
    local width = self:GetWidth();
    if not self.parent.isMinWindow or self.maxScroll > 0 then
        width = width - 10; -- remove width of scrollbar
    end
    return math.floor((width - cols * self.colWidth) / 2.0);
end

function TravelGridTab:GetGridIndex(x, y)
    local col = math.floor(x / self.colWidth) + 1
    local scrollRow = self.myScrollBar:GetValue() / self.colWidth
    local row = math.floor(scrollRow + y / self.colWidth)
    if row < 0 then row = 0 end
    return row * self.numOfCols + col
end

-- function to adjust the size of the tab and all items in the tab
function TravelGridTab:SetSize(width, height)

    -- set the size of the tab
    Turbine.UI.Control.SetSize(self, width, height);

    -- reset all the quickslots of the tab
    self:SetItems();
end
