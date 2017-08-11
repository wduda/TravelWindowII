import "Turbine";
import "Turbine.Gameplay";
import "Turbine.UI";
import "Turbine.UI.Lotro";
import "DhorPlugins.Extensions";
import "DhorPlugins.Travel.SettingsMenu";
import "DhorPlugins.Utils.BitOps";
import "DhorPlugins.Travel.OrendarUIMods.ComboBox"

--[[ This is the window for the pulldown list tab of the  ]] --
--[[ Travel UI.  It handles creating all UI controls on   ]] --
--[[ the tab, and updating the UI when the settings are   ]] --
--[[ changed.                                             ]] --


TravelPulldownTab = class(Turbine.UI.Control);

function TravelPulldownTab:Constructor(toplevel)
    Turbine.UI.Control.Constructor(self);

    -- need top level window in order to close it
    self.parent = toplevel;

    -- this label is used to catch wheel moves
    self.scrollLabel = Turbine.UI.Label();
    self.scrollLabel:SetSize(180, 155);
    self.scrollLabel:SetPosition(0, 20);
    self.scrollLabel:SetParent(self);

    -- the pulldown box
    self.pulldown = DhorPlugins.Travel.OrendarUIMods.ComboBox();
    self.pulldown:SetPosition(0, 20);
    self.pulldown:SetSize(200, 30);
    self.pulldown:SetParent(self);
    self.pulldown:SetVisible(true);

    -- the quickslot for the shortcut
    self.quickslot = Turbine.UI.Lotro.Quickslot();
    self.quickslot:SetSize(36, 36);
    self.quickslot:SetPosition(82, 55);
    self.quickslot:SetZOrder(98);
    self.quickslot:SetUseOnRightClick(false);
    self.quickslot:SetParent(self);
    self.quickslot:SetVisible(true);

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

    self.MouseDown = function(sender, args)
        self.pulldown:CloseDropDown();
    end

    -- check for a right mouse button event to open menu
    self.scrollLabel.MouseClick = function(sender, args)
        if (args.Button == Turbine.UI.MouseButton.Right) then
            menu:ShowMenu();
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

    -- open the option window if the quickslot is right-clicked
    self.quickslot.MouseClick = function(sender, args)
        if (args.Button == Turbine.UI.MouseButton.Right) then
            menu:ShowMenu();
        else
            self.parent:SetVisible(false);
        end
    end
end

function TravelPulldownTab:DoScroll(sender, args)
    -- nothing to do for now
end

function TravelPulldownTab:SetItems()

    -- create the combo box to use in the tab
    self.pulldown = DhorPlugins.Travel.OrendarUIMods.ComboBox(self.parent);
    self.pulldown:SetPosition(0, 20);
    self.pulldown:SetSize(200, 30);
    self.pulldown:SetParent(self);
    self.pulldown:SetVisible(true);
    self.pulldown:SetTravelOnSelect(settings.pulldownTravel);

    -- add the shortcuts to the combo box
    counter = 1;
    for i = 1, table.getn(travelShortcuts), 1 do
        if (travelShortcuts[i]:IsEnabled()) then
            if (hasbit(settings.filters, bit(travelShortcuts[i]:GetTravelType()))) then
                if (TravelWindow:FindSkill(travelShortcuts[i]:GetSkillName())) then
                    self.pulldown:AddItem(travelShortcuts[i], counter, i);
                    counter = counter + 1;
                elseif (travelShortcuts[i]:GetSkillName() == "skip") then
                    self.pulldown:AddItem(travelShortcuts[i], counter, i);
                    counter = counter + 1;
                else
                    --Turbine.Shell.WriteLine("Skill not trained: " .. travelShortcuts[i]:GetSkillName());
                end
            end
        end
    end

    -- handle the event if the selected item changes
    self.pulldown.SelectedIndexChanged = function(sender, args)
        pcall(function()
            self.quickslot:SetShortcut(travelShortcuts[sender:GetSelection()]);
        end)
    end
end

-- function to adjust the size of the tab and all items in the tab
function TravelPulldownTab:SetSize(width, height)

    -- set the size of the tab
    Turbine.UI.Control.SetSize(self, width, height);

    -- set the size of the labels
    -- self.rationLabel:SetSize(self:GetWidth(),20);
    self.scrollLabel:SetSize(self:GetWidth(), self:GetHeight());

    Turbine.UI.Control.SetOpacity(self, 1);
end

-- function to close the pulldown if necessary
function TravelPulldownTab:ClosePulldown()
    self.pulldown:CloseDropDown()
end
