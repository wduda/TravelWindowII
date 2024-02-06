--[[
Originally from OrendarPlugins.UI

Minor modifications from Frell
additional modifications by Dhor
--]] import "Turbine.UI";
import "TravelWindowII.src.extensions";

ComboBox = class(Turbine.UI.Control);

-- colors
ComboBox.HighlightColor = Turbine.UI.Color(232 / 255, 175 / 255, 72 / 255);
ComboBox.SelectionColor = Turbine.UI.Color(203 / 255, 195 / 255, 52 / 255);
ComboBox.ItemColor = Turbine.UI.Color(245 / 255, 222 / 255, 147 / 255);
ComboBox.DisabledColor = Turbine.UI.Color(162 / 255, 162 / 255, 162 / 255);
ComboBox.BlackColor = Turbine.UI.Color(1, 0, 0, 0);

function ComboBox:Constructor(toplevel)
    Turbine.UI.Control.Constructor(self);

    self:SetBackColor(ComboBox.DisabledColor);
    self.quickslots = {};
    self.labels = {};
    self.hoverIndex = 0;

    self.topLevelWindow = toplevel;

    -- state
    self.dropped = false;
    self.selection = -1;
    self.travelOnSelect = 0;

    -- text label
    self.label = TravelWindowII.src.extensions.DLabel();
    self.label:SetParent(self);
    self.label:SetFont(Turbine.UI.Lotro.Font.TrajanPro14);
    self.label:SetForeColor(ComboBox.ItemColor);
    self.label:SetBackColor(ComboBox.BlackColor);
    self.label:SetOutlineColor(ComboBox.HighlightColor);
    self.label:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleCenter);
    self.label:SetMouseVisible(false);

    -- arrow
    self.arrow = Turbine.UI.Control();
    self.arrow:SetParent(self);
    self.arrow:SetSize(16, 16);
    self.arrow:SetZOrder(20);
    self.arrow:SetBlendMode(Turbine.UI.BlendMode.AlphaBlend);
    self.arrow:SetBackground(
        "TravelWindowII/src/OrendarUIMods/Resources/dropdown_arrow_closed.tga");
    self.arrow:SetMouseVisible(false);

    -- drop down window
    self.dropDownWindow = Turbine.UI.Window();
    self.dropDownWindow:SetBackColor(ComboBox.DisabledColor);
    self.dropDownWindow:SetZOrder(98);
    self.dropDownWindow:SetVisible(false);

    -- list scroll bar        
    self.scrollBar = Turbine.UI.Lotro.ScrollBar();
    self.scrollBar:SetOrientation(Turbine.UI.Orientation.Vertical);
    self.scrollBar:SetParent(self.dropDownWindow);
    self.scrollBar:SetBackColor(ComboBox.BlackColor);

    -- list to contain the drop down items
    self.listBox = Turbine.UI.Control();
    self.listBox:SetZOrder(99);
    self.listBox:SetParent(self.dropDownWindow);
    self.listBox:SetMouseVisible(false);
    self.listBox:SetPosition(2, 2);
    self.listBox:SetBackColor(ComboBox.BlackColor);
    self.listBox:SetOpacity(1);
    self.listBox:SetVisible(true);
    self.listBox.MouseWheel = function(sender, args)
        self:DoScroll(sender, args);
    end

    self.FocusLost = function(sender, args)
        if self.dropped then
            if self.hoverIndex > 0 then
                local msArgs = { Button = Turbine.UI.MouseButton.None };
                self.labels[self.hoverIndex]:MouseClick(sender, args)
            else
                self:CloseDropDown()
            end
        end
    end
end

function ComboBox:SetTravelOnSelect(value) self.travelOnSelect = value; end

function ComboBox:MouseEnter(args)
    if (not self:IsEnabled()) then return; end

    self.label:SetFontStyle(Turbine.UI.FontStyle.Outline);
    self.label:SetForeColor(ComboBox.ItemColor);
    self.label:SetText(self.label:GetText());

    self.arrow:SetBackground(
        "TravelWindowII/src/OrendarUIMods/Resources/dropdown_arrow_" ..
            (self.dropped and "open_rollover" or "closed_rollover") .. ".tga");
end

function ComboBox:MouseLeave(args)
    if (not self:IsEnabled()) then return; end

    self.label:SetFontStyle(Turbine.UI.FontStyle.None);
    if (self.dropped) then self.label:SetForeColor(ComboBox.SelectionColor); end
    self.label:SetText(self.label:GetText());

    self.arrow:SetBackground(
        "TravelWindowII/src/OrendarUIMods/Resources/dropdown_arrow_" ..
            (self.dropped and "open" or "closed") .. ".tga");
end

function ComboBox:MouseClick(args)
    if (not self:IsEnabled()) then return; end

    if (args.Button == Turbine.UI.MouseButton.Left) then
        if (self.dropped) then
            self:CloseDropDown();
        else
            self:ShowDropDown();
        end
    end
end

function ComboBox:FireEvent()
    if (type(self.SelectedIndexChanged) == "function") then
        self:SelectedIndexChanged({selection = self:GetSelection()});
    end
end

function ComboBox:ItemSelected(index)
    if (self.selection ~= -1) then
        local old = self.labels[self.selection];
        old:SetForeColor(ComboBox.ItemColor);
    end

    -- local item = self.listBox:GetItem(index);
    local item = self.labels[index];
    self.selection = index;
    item:SetForeColor(ComboBox.SelectionColor);
    self.label:SetText(item:GetText());

    self:CloseDropDown();
end

function ComboBox:ClearItems()
    self.labels = {};
    self.quickslots = {};
    self.label:SetText("");
end

function ComboBox:AddItem(shortcut, index, value)
    local width, height = self:GetSize();

    self.quickslots[index] = Turbine.UI.Lotro.Quickslot();
    self.quickslots[index]:SetSize(width, 20);
    self.quickslots[index]:SetPosition(0, ((index - 1) * (20)));
    self.quickslots[index]:SetZOrder(90);
    self.quickslots[index]:SetOpacity(1);
    self.quickslots[index]:SetUseOnRightClick(false);
    self.quickslots[index]:SetParent(self.listBox);
    self.quickslots[index]:SetShortcut(shortcut);

    -- self.labels[index] = Turbine.UI.Label();
    self.labels[index] = TravelWindowII.src.extensions.DLabel();
    self.labels[index]:SetSize(width, 20);
    self.labels[index]:SetPosition(0, ((index - 1) * (20)));
    self.labels[index]:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleCenter);
    self.labels[index]:SetForeColor(ComboBox.ItemColor);
    self.labels[index]:SetFont(Turbine.UI.Lotro.Font.TrajanPro14);
    self.labels[index]:SetOutlineColor(ComboBox.HighlightColor);
    self.labels[index]:SetBackColor(Turbine.UI.Color(0.87, 0, 0, 0));
    self.labels[index]:SetText(shortcut:GetSkillLabel());
    self.labels[index]:SetZOrder(100);
    self.labels[index]:SetMouseVisible(self.travelOnSelect == 0);
    self.labels[index]:SetParent(self.listBox);

    self.quickslots[index]:SetAllowDrop(false);
    self.quickslots[index]:SetVisible(true);

    self.labels[index].MouseEnter = function(sender, args)
        sender:SetFontStyle(Turbine.UI.FontStyle.Outline);
        sender:SetForeColor(ComboBox.ItemColor);
        sender:SetText(sender:GetText());
        self.hoverIndex = index;
    end

    self.labels[index].MouseLeave = function(sender, args)
        sender:SetFontStyle(Turbine.UI.FontStyle.None);
        if (index == self.selection) then
            sender:SetForeColor(ComboBox.SelectionColor);
        end
        sender:SetText(sender:GetText());
        self.hoverIndex = 0;
    end

    self.labels[index].MouseClick = function(sender, args)
        if (args.Button == Turbine.UI.MouseButton.Left) then
            self:ItemSelected(index);
            self:FireEvent();
            if (self.travelOnSelect == 1 and Settings.hideOnTravel == 1) then
                self.topLevelWindow:SetVisible(false);
            end
        end
    end

    self.labels[index].MouseWheel = function(sender, args)
        self:DoScroll(sender, args);
    end
    self.quickslots[index].MouseWheel = function(sender, args)
        self:DoScroll(sender, args);
    end

    self.quickslots[index].MouseEnter = function(sender, args)
        self.labels[index]:SetFontStyle(Turbine.UI.FontStyle.Outline);
        self.labels[index]:SetForeColor(ComboBox.ItemColor);
        self.labels[index]:SetText(self.labels[index]:GetText());
    end
    self.quickslots[index].MouseLeave = function(sender, args)
        self.labels[index]:SetFontStyle(Turbine.UI.FontStyle.None);
        if (index == self.selection) then
            self.labels[index]:SetForeColor(ComboBox.SelectionColor);
        end
        self.labels[index]:SetText(self.labels[index]:GetText());
    end

    self.quickslots[index].MouseClick = function(sender, args)
        if (args.Button == Turbine.UI.MouseButton.Left) then
            self:ItemSelected(index);
            self:FireEvent();
            self.topLevelWindow:SetVisible(false);
        end
    end

    self.labels[index]:SetIndex(value);
end

function ComboBox:RemoveItem(value)
    for i = 1, self.listBox:GetItemCount() do
        local item = self.listBox:GetItem(i);
        if (item.value == value) then
            item:SetVisible(false);
            self.listBox:RemoveItemAt(i);

            -- if the removed item is the selection update it
            if (self.selection == i) then
                self.selection = -1;
                if (self.listBox:GetItemCount() > 0) then
                    self:ItemSelected(1);
                    self:FireEvent();
                else
                    self.label:SetText("");
                end
            end
            break
        end
    end
end

function ComboBox:SetSelection(value)
    for i = 1, self.listBox:GetItemCount() do
        local item = self.listBox:GetItem(i);
        if (item.value == value) then
            self:ItemSelected(i);
            self:FireEvent();
            break
        end
    end
end

function ComboBox:GetSelection()
    if (self.selection == -1) then
        Turbine.Shell.WriteLine("Return NIL selection from combobox")
        return nil;
    else
        local item = self.labels[self.selection];
        return item:GetIndex();
    end
end

function ComboBox:GetSelectedIndex()
    if (self.selection == -1) then
        return nil;
    else
        return self.selection;
    end
end

function ComboBox:UpdateSelectionText(text)
    if (self.selection ~= -1) then
        local item = self.labels[self.selection];
        item:SetText(text);
        self.label:SetText(text);
    end
end

function ComboBox:GetItemCount() return self.listBox:GetItemCount(); end

function ComboBox:GetItem(index)
    local item = self.listBox:GetItem(index);
    return item.value;
end

function ComboBox:SetSize(width, height)
    Turbine.UI.Control.SetSize(self, width, height);
    self:Layout();
end

function ComboBox:SetEnabled(enabled)
    Turbine.UI.Control.SetEnabled(self, enabled);
    if (enabled) then
        self.label:SetForeColor(ComboBox.ItemColor);
        self.arrow:SetBackground(
            "TravelWindowII/src/OrendarUIMods/Resources/dropdown_arrow_closed.tga");
    else
        self:CloseDropDown();
        self.label:SetForeColor(ComboBox.DisabledColor);
        self.arrow:SetBackground(
            "TravelWindowII/src/OrendarUIMods/Resources/dropdown_arrow_closed_ghosted.tga");
    end
end

function ComboBox:Layout()
    local width, height = self:GetSize();
    self.label:SetSize(width - 4, height - 4);
    self.label:SetPosition(2, 2);
    self.arrow:SetPosition(width - 2 - 16, 2 + ((height - 4 - 16) / 2));

    local scrollSize = 0;
    local itemCount = #self.labels;
    if itemCount > 10 then
        scrollSize = 10;
    end
    local listWidth, listHeight = self.listBox:GetSize();
    self.listBox:SetSize(width - 4 - scrollSize, listHeight);
    self.dropDownWindow:SetSize(width, listHeight + 4);
    self.scrollBar:SetPosition(width - 12, 2);

    for i = 1, #self.quickslots, 1 do
        self.quickslots[i]:SetSize(width, 20);
        self.labels[i]:SetSize(width, 20);
    end
end

function ComboBox:ShowDropDown()
    self:Focus();
    local itemCount = #self.labels;

    if ((itemCount > 0) and not (self.dropped)) then
        self.dropped = true;
        self.label:SetForeColor(ComboBox.SelectionColor);
        self.arrow:SetBackground(
            "TravelWindowII/src/OrendarUIMods/Resources/dropdown_arrow_open_rollover.tga");
        local width, height = self:GetSize();

        -- max size
        local maxItems = itemCount;
        local scrollSize = 0;
        if (maxItems > 10) then
            maxItems = 10;
            scrollSize = 10;
        end

        -- list item sizes
        local listHeight = 0;
        local itemHeight = self.labels[1]:GetHeight();
        for i = 1, itemCount do
            if (i <= maxItems) then
                listHeight = listHeight + itemHeight;
            end
        end

        -- window size
        self.listBox:SetSize(width - 4 - scrollSize, listHeight);
        self.dropDownWindow:SetSize(width, listHeight + 4);

        -- scrollbar
        self.scrollBar:SetSize(10, listHeight);
        self.scrollBar:SetPosition(width - 12, 2);
        self.scrollBar:SetMinimum(0);
        self.scrollBar:SetMaximum(itemCount * 20 - 200);

        -- position
        local parent = self:GetParent();
        local screenX, screenY = self:GetPosition();
        while parent ~= nil do
            local x, y = parent:GetPosition();
            screenX = screenX + x;
            screenY = screenY + y;
            if parent:GetParent() == nil then break end
            parent = parent:GetParent();
        end
        local cbWidth, cbHeight = self:GetSize();
        self.dropDownWindow:SetPosition(screenX, screenY + cbHeight + 3);

        self.dropDownWindow:SetVisible(true);

        self.scrollBar.ValueChanged = function(sender, args)
            self:UpdateSubWindow();
        end
    end
end

function ComboBox:CloseDropDown()
    if (self.dropped) then
        self.dropped = false;
        self.dropDownWindow:SetVisible(false);
        self.label:SetForeColor(ComboBox.ItemColor);
        self.arrow:SetBackground(
            "TravelWindowII/src/OrendarUIMods/Resources/dropdown_arrow_closed_rollover.tga");
    end
end

function ComboBox:DoScroll(sender, args)

    -- calculate how far to move the scrollbar
    local newValue = self.scrollBar:GetValue() - args.Direction * 20;

    -- make sure the value does not go below zero
    if (newValue < 0) then newValue = 0; end

    -- set the new value
    self.scrollBar:SetValue(newValue);

    if (self.max == 0) then
        self.scrollBar:SetVisible(false);
    else
        self.scrollBar:SetVisible(true);
    end
end

function ComboBox:UpdateSubWindow()
    -- loop through all the quickslots
    for i = 1, #self.quickslots, 1 do
        -- get the number of rows
        local row = math.ceil(i / 1);

        -- set the top position of the quickslots based on row
        -- number and the value of the scrollbar
        self.quickslots[i]:SetTop((row - 1) * 20 - self.scrollBar:GetValue());
        self.labels[i]:SetTop((row - 1) * 20 - self.scrollBar:GetValue());
    end
end
