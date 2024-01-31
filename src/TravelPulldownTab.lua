import "Turbine";
import "Turbine.Gameplay";
import "Turbine.UI";
import "Turbine.UI.Lotro";
import "TravelWindowII.src.extensions";
import "TravelWindowII.src.SettingsMenu";
import "TravelWindowII.src.utils.BitOps";
import "TravelWindowII.src.OrendarUIMods.ComboBox"

--[[ This is the window for the pulldown list tab of the  ]] --
--[[ Travel UI.  It handles creating all UI controls on   ]] --
--[[ the tab, and updating the UI when the settings are   ]] --
--[[ changed.                                             ]] --

TravelPulldownTab = class(Turbine.UI.Control);

function TravelPulldownTab:Constructor(toplevel)
    Turbine.UI.Control.Constructor(self);

    -- need top level window in order to close it
    self.parent = toplevel;

    if self.parent.isMinWindow then
        self.wPadding = 3;
    else
        self.wPadding = 0;
    end

    -- this label is used to catch wheel moves
    self.scrollLabel = Turbine.UI.Label();
    self.scrollLabel:SetPosition(0, 0);
    self.scrollLabel:SetParent(self);

    -- the pulldown box
    self.pulldown = TravelWindowII.src.OrendarUIMods.ComboBox(self);
    self.pulldown:SetPosition(43 + self.wPadding, 5);
    self.pulldown:SetParent(self);
    self.pulldown:SetVisible(true);
    self.pulldown:SetTravelOnSelect(Settings.pulldownTravel);

    -- the quickslot for the shortcut
    self.quickslot = Turbine.UI.Lotro.Quickslot();
    self.quickslot:SetSize(36, 36);
    self.quickslot:SetPosition(self.wPadding, 1);
    self.quickslot:SetZOrder(98);
    self.quickslot:SetUseOnRightClick(false);
    self.quickslot:SetParent(self);
    self.quickslot:SetVisible(true);

    --[[  EVENT HANDLERS  ]] --

    -- check for a right mouse button event to open menu
    self.MouseClick = function(sender, args)
        if (args.Button == Turbine.UI.MouseButton.Right) then
            Menu:ShowMenu();
        end
    end

    self.MouseDown = function(sender, args)
        self.pulldown:CloseDropDown();
    end

    -- check for a right mouse button event to open menu
    self.scrollLabel.MouseClick = function(sender, args)
        if (args.Button == Turbine.UI.MouseButton.Right) then
            Menu:ShowMenu();
        end
    end

    -- close the drop down window if the label is clicked
    self.scrollLabel.MouseDown = function(sender, args)
        self.pulldown:CloseDropDown();
    end

    -- check for mouse wheel movements
    self.scrollLabel.MouseWheel = function(sender, args)
        self:DoScroll(sender, args);
    end

    -- check for mouse wheel movements
    self.pulldown.MouseWheel = function(sender, args)
        self:DoScroll(sender, args);
    end

    -- handle the event if the selected item changes
    self.pulldown.SelectedIndexChanged = function(sender, args)
        pcall(function()
            self.quickslot:SetShortcut(TravelShortcuts[sender:GetSelection()]);
        end)
    end

    -- open the option window if the quickslot is right-clicked
    self.quickslot.MouseClick = function(sender, args)
        if (args.Button == Turbine.UI.MouseButton.Right) then
            Menu:ShowMenu();
        else
            if (Settings.hideOnTravel == 1) then
                self.parent:SetVisible(false);
            end
        end
    end
end

function TravelPulldownTab:DoScroll(sender, args)
    -- nothing to do for now
end

function TravelPulldownTab:SetItems()

    if self.tabId ~= self.parent.MainPanel.selectedPage or not(self.parent.dirty) then
        return
    end

    self.pulldown:ClearItems();

    -- add the shortcuts to the combo box
    local shortcutIndex = 1;
    for i = 1, #TravelShortcuts, 1 do
        if TravelShortcuts[i].found and TravelShortcuts[i]:IsEnabled() then
            if (hasbit(Settings.filters, bit(TravelShortcuts[i]:GetTravelType()))) then
                self.pulldown:AddItem(TravelShortcuts[i], shortcutIndex, i);
                shortcutIndex = shortcutIndex + 1;
            end
        end
    end

    if #self.pulldown.quickslots > 0 then
        self.pulldown:ItemSelected(1);
        self.pulldown:FireEvent();
    end
end

-- function to adjust the size of the tab and all items in the tab
function TravelPulldownTab:SetSize(width, height)

    -- set the size of the tab
    Turbine.UI.Control.SetSize(self, width, height);

    -- set the size of the labels
    self.scrollLabel:SetSize(self:GetWidth(), self:GetHeight());
    self.pulldown:SetSize(self:GetWidth() - 58 + self.wPadding * 2, 30);
end

function TravelPulldownTab:SetOpacity(value)
    Turbine.UI.Control.SetOpacity(self, value);
    self.pulldown.dropDownWindow:SetOpacity(value);
end

-- function to close the pulldown if necessary
function TravelPulldownTab:ClosePulldown()
    self.pulldown:CloseDropDown()
end
