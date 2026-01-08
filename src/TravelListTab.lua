import "Turbine.Gameplay";
import "Turbine.UI";
import "Turbine.UI.Lotro";
import "TravelWindowII.src.extensions";
import "TravelWindowII.src.TravelGridTab"
import "TravelWindowII.src.utils.FontMetric";
import "TravelWindowII.src.utils.BitOps";

--[[ This is the window for the text list tab of the 	]] --
--[[ Travel UI.  It handles creating all UI controls on ]] --
--[[ the tab, and updating the UI when the settings are	]] --
--[[ changed.											]] --
--[[ This class is actually an extension  	]] --
--[[ of the TravelGridTab	]] --

TravelListTab = class(TravelGridTab);

function TravelListTab:Constructor(toplevel)
    -- need top level window in order to close it
    self.parent = toplevel;
    TravelGridTab.Constructor(self);

    self.labels = {}
    self.itemHeight = 22;
    self.scrollChunk = self.itemHeight;

    self.minWidth = 225
    self.minHeight = 75

    self.itemAlpha = DefAlpha;
    if self.parent.isMinWindow then
        self.itemAlpha = 1;
        self.itemWidthPadding = 20
    else
        self.itemWidthPadding = 30
    end

    -- set up the scrollbar for the list
    self.myScrollBar = Turbine.UI.Lotro.ScrollBar();
    self.myScrollBar:SetOrientation(Turbine.UI.Orientation.Vertical);
    self.myScrollBar:SetMinimum(0);

    -- show the menu when right clicked
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
end

function TravelListTab:SetItems()
    if self.tabId ~= self.parent.MainPanel.selectedPage then
        return
    end

    self.itemWidth = self:GetWidth() - self.itemWidthPadding;
    TravelGridTab.SetItems(self);
end

function TravelGridTab:ClearItems()
    self.quickslots = {}
    self.labels = {}
end

function TravelListTab:AddItem(shortcut)

    -- set the index value based on the row and column
    local index = (self.row - 1) + self.col;
    local x = 10 + ((self.col - 1) * (self.itemWidth + 2));
    local y = (self.row - 1) * self.itemHeight - self.myScrollBar:GetValue();
    if not(self.parent.dirty) then
        self.quickslots[index]:SetSize(self.itemWidth, self.itemHeight);
        self.labels[index]:SetSize(self.itemWidth, self.itemHeight);
        self.quickslots[index]:SetPosition(x, y);
        self.labels[index]:SetPosition(x, y);
    else
        -- create new quickslots setting the position
        -- based on the row and column locations
        self.quickslots[index] = Turbine.UI.Lotro.Quickslot();
        self.quickslots[index]:SetSize(self.itemWidth, self.itemHeight);
        self.quickslots[index]:SetPosition(x, y);
        self.quickslots[index]:SetZOrder(90);
        self.quickslots[index]:SetOpacity(1);
        self.quickslots[index]:SetUseOnRightClick(false);
        self.quickslots[index]:SetParent(self.SubWindow);

        pcall(function()
            self.quickslots[index]:SetShortcut(shortcut);
        end)

        -- create the label that will cover the shortcut
        self.labels[index] = Turbine.UI.Label();
        self.labels[index]:SetSize(self.itemWidth, self.itemHeight);
        self.labels[index]:SetPosition(x, y);
        self.labels[index]:SetZOrder(100);
        self.labels[index]:SetMouseVisible(false);
        self.labels[index]:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleLeft);
        self.labels[index]:SetBackColor(Turbine.UI.Color(self.itemAlpha, 0, 0, 0));
        self.labels[index]:SetMultiline(false)
        self.labels[index]:SetText(shortcut:GetListLabel());
        self.labels[index]:SetParent(self.SubWindow);
        self.labels[index].shortcut = shortcut

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

        -- change the background colour of the label with the mouse enters
        self.quickslots[index].MouseEnter = function(sender, args)
            self.labels[index]:SetBackColor(Turbine.UI.Color(self.itemAlpha, 0.17, 0.17, 0.17));
        end

        -- return the background colour when the mouse leaves the label
        self.quickslots[index].MouseLeave = function(sender, args)
            self.labels[index]:SetBackColor(Turbine.UI.Color(self.itemAlpha, 0, 0, 0));
        end
    end

    -- increase the row number
    self.row = self.row + 1;
end

function TravelListTab:ReloadLabels()
    for i = 1, #self.labels do
        local label = self.labels[i]
        label:SetText(label.shortcut:GetListLabel())
    end
end

function TravelListTab:GetPixelSize()
    local height = self.numOfRows * self.itemHeight + self.parent.hPadding;
    return self.pixelWidth, height;
end

function GetMinimumHeight(labels, width)
    local minHeight = 14
    local fm = TravelWindowII.src.utils.FontMetric()
    for i = 1, #labels, 1 do
        local text = labels[i]:GetText()
        local fontHeight = fm:GetTextHeight(text, width)
        if fontHeight > minHeight then
            minHeight = fontHeight
        end
    end
    return minHeight + 8
end

function TravelListTab:FitToPixels(width, height)
    if width < self.minWidth then
        width = self.minWidth
    end
    local minWidth = width - self.itemWidthPadding - self.parent.wPadding
    self.scrollChunk = self.itemHeight
    local rowHeight = self.itemHeight;
    local minHeight = rowHeight * 6;
    local maxHeight = rowHeight * #self.selected;
    height = height - self.parent.hPadding;
    local dy = height % rowHeight;
    if dy < rowHeight / 2 then
        height = height - dy;
    else
        height = height + (rowHeight - dy);
    end
    if height < minHeight then
        height = minHeight;
    elseif height > maxHeight then
        height = maxHeight;
    end
    self.pixelWidth = width;
    self.numOfRows = math.floor(height / rowHeight);
    return width, height + self.parent.hPadding;
end

function TravelListTab:UpdateBounds()
    -- set the maximum value of the scrollbar
    -- based on the number of rows in the subwindow
    local numOfShortcuts = #self.selected;
    local height = self.parent:GetHeight() - self.parent.hPadding;
    self.maxScroll = numOfShortcuts * self.itemHeight - height;
    if self.maxScroll < 0 then
        -- the maxScroll cannot be less than one
        self.maxScroll = 0;
        self.numOfRows = #self.selected;
    elseif self.maxScroll > 0 then
        self.numOfRows = math.floor(height / self.itemHeight);
    end
    self.pixelWidth = self.parent:GetWidth();
end

function TravelListTab:GetMargin(numOfShortcuts)
    return 0;
end

function TravelListTab:UpdateSubWindow()
    -- loop through all the quickslots
    for i = 1, #self.quickslots, 1 do

        -- set the top position of the quickslots based on row
        -- number and the value of the scrollbar
        self.quickslots[i]:SetTop((i - 1) * self.itemHeight - self.myScrollBar:GetValue());
        self.labels[i]:SetTop((i - 1) * self.itemHeight - self.myScrollBar:GetValue());
    end
end

-- function to adjust the size of the tab and all items in the tab
function TravelListTab:SetSize(width, height)

    -- set the size of the tab
    Turbine.UI.Control.SetSize(self, width, height);

    self:SetItems();
end
