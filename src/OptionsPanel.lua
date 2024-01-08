import "Turbine";
import "Turbine.Debug";
import "Turbine.Gameplay";
import "Turbine.UI";
import "Turbine.UI.Lotro";
import "TravelWindowII.src.extensions";
import "TravelWindowII.src.utils.BitOps";

OptionsPanel = class(Turbine.UI.Control);

function OptionsPanel:Constructor(parent)
    Turbine.UI.Control.Constructor(self);

    --  add a check to see if we load completely
    self.loaded = false;

    -- set size of window
    self.width = 800;
    self.height = 840;
    self.windowWidth, self.windowHeight = Turbine.UI.Display:GetSize();
    if self.height + 40 > self.windowHeight then
        self.height = self.windowHeight - 20;
    end

    -- create array of labels and check boxes
    self.labels = {};
    self.checks = {};
    self.mainWindow = parent;

    -- keep track of which item is selected on the sort tab
    self.sortSelectedIndex = 1;
    self.sortMaxItem = 0;

    -- set the default window settings
    self:SetSize(self.width, self.height);

    -- add a tabbed panel
    self.OptionTabs = TravelWindowII.src.extensions.DPanel();
    self.OptionTabs:SetOpacity(1);
    self.OptionTabs:SetSize(self.width - 20, self.height - 60);
    self.OptionTabs:SetPosition(10, 0);
    self.OptionTabs:SetParent(self);
    self.OptionTabs:SetBlendMode(Turbine.UI.BlendMode.Overlay);
    self.OptionTabs:SetBackColor(Turbine.UI.Color(DefAlpha, 0, 0, 0));
    self.OptionTabs:SetVisible(true);

    -- create the tabs
    self.GeneralTab = Turbine.UI.Control();
    self.EnabledTab = Turbine.UI.Control();
    self.SortTab = Turbine.UI.Control();

    self.EnabledTab:SetSize(self.width - 20, self.height - 60)
    self.ListBox = Turbine.UI.ListBox()
    self.ListBox:SetParent(self.EnabledTab)
    self.ListBox:SetPosition(5, 5)
    self.ListBox:SetSize(self:GetWidth() - 20, self:GetHeight() - 120)
    self.scrollBar = Turbine.UI.Lotro.ScrollBar()
    self.scrollBar:SetOrientation(Turbine.UI.Orientation.Vertical)
    self.scrollBar:SetParent(self.EnabledTab)
    self.scrollBar:SetPosition(0, 0)
    self.scrollBar:SetWidth(10)
    self.scrollBar:SetHeight(self.ListBox:GetHeight())
    self.ListBox:SetVerticalScrollBar(self.scrollBar)

    -- populate each tab
    self:AddGeneralItems();
    self:AddBoxes();
    self:AddItems();
    self:AddSortList();
    self:AddSortButtons();

    -- add the tabs
    self.OptionTabs:AddTab(self.GeneralTab);
    self.OptionTabs:AddTab(self.EnabledTab);
    self.OptionTabs:AddTab(self.SortTab);

    -- name the tabs
    self.OptionTabs:SetTabText(1, generalTabString);
    self.OptionTabs:SetTabText(2, selectTabString);
    self.OptionTabs:SetTabText(3, sortTabString);

    self:SetVisible(true);

    -- have the main window close the options
    self.VisibleChanged = function(sender, args)
        if (self:IsVisible() == false) then
            if (parent ~= nil) then
                parent:CloseOptions();
            end
        end
    end

    self.loaded = true;
end

function OptionsPanel:GetLoaded()
    return self.loaded;
end

-- function to add items to the general tab
function OptionsPanel:AddGeneralItems()
    -- label for hide window on start option
    self.HideOnStartLabel = Turbine.UI.Label();
    self.HideOnStartLabel:SetSize(300, 20);
    self.HideOnStartLabel:SetPosition(20, 20);
    self.HideOnStartLabel:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleLeft);
    self.HideOnStartLabel:SetParent(self.GeneralTab);
    self.HideOnStartLabel:SetText(hideString);
    self.HideOnStartLabel:SetVisible(true);

    -- checkbox for hide window on start option
    self.HideOnStartCheck = Turbine.UI.Lotro.CheckBox();
    self.HideOnStartCheck:SetSize(19, 19);
    self.HideOnStartCheck:SetPosition(450, 20);
    self.HideOnStartCheck:SetChecked(Settings.hideOnStart == 1);
    self.HideOnStartCheck:SetParent(self.GeneralTab);
    self.HideOnStartCheck:SetVisible(true);

    -- label for hide on combat option
    self.HideOnCombatLabel = Turbine.UI.Label();
    self.HideOnCombatLabel:SetSize(300, 20);
    self.HideOnCombatLabel:SetPosition(20, 50);
    self.HideOnCombatLabel:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleLeft);
    self.HideOnCombatLabel:SetParent(self.GeneralTab);
    self.HideOnCombatLabel:SetText(hideOnCombatString);
    self.HideOnCombatLabel:SetVisible(true);

    -- checkbox for hide on combat option
    self.HideOnCombatCheck = Turbine.UI.Lotro.CheckBox();
    self.HideOnCombatCheck:SetSize(19, 19);
    self.HideOnCombatCheck:SetPosition(450, 50);
    self.HideOnCombatCheck:SetChecked(Settings.hideOnCombat == 1);
    self.HideOnCombatCheck:SetParent(self.GeneralTab);
    self.HideOnCombatCheck:SetVisible(true);

    -- label for option to close window on travel skill use
    self.hideOnTravelLabel = Turbine.UI.Label();
    self.hideOnTravelLabel:SetSize(300, 20);
    self.hideOnTravelLabel:SetPosition(20, 80);
    self.hideOnTravelLabel:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleLeft);
    self.hideOnTravelLabel:SetParent(self.GeneralTab);
    self.hideOnTravelLabel:SetText(hideOnTravelString);
    self.hideOnTravelLabel:SetVisible(true);

    -- checkbox for option to close window on travel skill use
    self.hideOnTravelCheck = Turbine.UI.Lotro.CheckBox();
    self.hideOnTravelCheck:SetSize(19, 19);
    self.hideOnTravelCheck:SetPosition(450, 80);
    self.hideOnTravelCheck:SetChecked(Settings.hideOnTravel == 1);
    self.hideOnTravelCheck:SetParent(self.GeneralTab);
    self.hideOnTravelCheck:SetVisible(true);

    -- label for show toggle button option
    self.ShowButtonLabel = Turbine.UI.Label();
    self.ShowButtonLabel:SetSize(300, 20);
    self.ShowButtonLabel:SetPosition(20, 110);
    self.ShowButtonLabel:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleLeft);
    self.ShowButtonLabel:SetParent(self.GeneralTab);
    self.ShowButtonLabel:SetText(toggleString);
    self.ShowButtonLabel:SetVisible(true);

    -- checkbox for show toggle button option
    self.ShowButtonCheck = Turbine.UI.Lotro.CheckBox();
    self.ShowButtonCheck:SetSize(19, 19);
    self.ShowButtonCheck:SetPosition(450, 110);
    self.ShowButtonCheck:SetChecked(Settings.showButton == 1);
    self.ShowButtonCheck:SetParent(self.GeneralTab);
    self.ShowButtonCheck:SetVisible(true);

    -- label for option to fire skill on pulldown selection
    self.PulldownTravelLabel = Turbine.UI.Label();
    self.PulldownTravelLabel:SetSize(300, 20);
    self.PulldownTravelLabel:SetPosition(20, 140);
    self.PulldownTravelLabel:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleLeft);
    self.PulldownTravelLabel:SetParent(self.GeneralTab);
    self.PulldownTravelLabel:SetText(pulldownTravelString);
    self.PulldownTravelLabel:SetVisible(true);

    -- checkbox for option to fire skill on pulldown selection
    self.PulldownTravelCheck = Turbine.UI.Lotro.CheckBox();
    self.PulldownTravelCheck:SetSize(19, 19);
    self.PulldownTravelCheck:SetPosition(450, 140);
    self.PulldownTravelCheck:SetChecked(Settings.pulldownTravel == 1);
    self.PulldownTravelCheck:SetParent(self.GeneralTab);
    self.PulldownTravelCheck:SetVisible(true);

    -- label for toggle button sliders
    self.toggleSlidersLabel = Turbine.UI.Label();
    self.toggleSlidersLabel:SetSize(300, 20);
    self.toggleSlidersLabel:SetPosition(20, 170);
    self.toggleSlidersLabel:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleLeft);
    self.toggleSlidersLabel:SetParent(self.GeneralTab);
    self.toggleSlidersLabel:SetText(toggleSlidersString);
    self.toggleSlidersLabel:SetVisible(true);

    -- toggle button min slider label
    self.toggleMinSlidersLabel = Turbine.UI.Label();
    self.toggleMinSlidersLabel:SetSize(50, 20);
    self.toggleMinSlidersLabel:SetPosition(20, 190);
    self.toggleMinSlidersLabel:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleLeft);
    self.toggleMinSlidersLabel:SetParent(self.GeneralTab);
    self.toggleMinSlidersLabel:SetText(minString);
    self.toggleMinSlidersLabel:SetVisible(true);

    -- toggle button min slider
    self.toggleMinScrollBar = Turbine.UI.Lotro.ScrollBar();
    self.toggleMinScrollBar:SetOrientation(Turbine.UI.Orientation.Horizontal);
    self.toggleMinScrollBar:SetSize(400, 10);
    self.toggleMinScrollBar:SetPosition(70, 195);
    self.toggleMinScrollBar:SetMinimum(0);
    self.toggleMinScrollBar:SetMaximum(100);
    self.toggleMinScrollBar:SetValue(Settings.toggleMinOpacity * 100);
    self.toggleMinScrollBar:SetParent(self.GeneralTab);

    -- toggle button max slider
    self.toggleMaxSlidersLabel = Turbine.UI.Label();
    self.toggleMaxSlidersLabel:SetSize(50, 20);
    self.toggleMaxSlidersLabel:SetPosition(20, 210);
    self.toggleMaxSlidersLabel:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleLeft);
    self.toggleMaxSlidersLabel:SetParent(self.GeneralTab);
    self.toggleMaxSlidersLabel:SetText(maxString);
    self.toggleMaxSlidersLabel:SetVisible(true);

    -- toggle button max slider
    self.toggleMaxScrollBar = Turbine.UI.Lotro.ScrollBar();
    self.toggleMaxScrollBar:SetOrientation(Turbine.UI.Orientation.Horizontal);
    self.toggleMaxScrollBar:SetSize(400, 10);
    self.toggleMaxScrollBar:SetPosition(70, 215);
    self.toggleMaxScrollBar:SetMinimum(0);
    self.toggleMaxScrollBar:SetMaximum(100);
    self.toggleMaxScrollBar:SetValue(Settings.toggleMaxOpacity * 100);
    self.toggleMaxScrollBar:SetParent(self.GeneralTab);

    -- label for main window sliders
    self.SlidersLabel = Turbine.UI.Label();
    self.SlidersLabel:SetSize(300, 20);
    self.SlidersLabel:SetPosition(20, 240);
    self.SlidersLabel:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleLeft);
    self.SlidersLabel:SetParent(self.GeneralTab);
    self.SlidersLabel:SetText(mainSlidersString);
    self.SlidersLabel:SetVisible(true);

    -- main window min slider label
    self.mainMinSlidersLabel = Turbine.UI.Label();
    self.mainMinSlidersLabel:SetSize(50, 20);
    self.mainMinSlidersLabel:SetPosition(20, 260);
    self.mainMinSlidersLabel:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleLeft);
    self.mainMinSlidersLabel:SetParent(self.GeneralTab);
    self.mainMinSlidersLabel:SetText(minString);
    self.mainMinSlidersLabel:SetVisible(true);

    -- toggle button min slider
    self.mainMinScrollBar = Turbine.UI.Lotro.ScrollBar();
    self.mainMinScrollBar:SetOrientation(Turbine.UI.Orientation.Horizontal);
    self.mainMinScrollBar:SetSize(400, 10);
    self.mainMinScrollBar:SetPosition(70, 265);
    self.mainMinScrollBar:SetMinimum(0);
    self.mainMinScrollBar:SetMaximum(100);
    self.mainMinScrollBar:SetValue(Settings.mainMinOpacity * 100);
    self.mainMinScrollBar:SetParent(self.GeneralTab);

    -- toggle button max slider
    self.mainMaxSlidersLabel = Turbine.UI.Label();
    self.mainMaxSlidersLabel:SetSize(50, 20);
    self.mainMaxSlidersLabel:SetPosition(20, 280);
    self.mainMaxSlidersLabel:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleLeft);
    self.mainMaxSlidersLabel:SetParent(self.GeneralTab);
    self.mainMaxSlidersLabel:SetText(maxString);
    self.mainMaxSlidersLabel:SetVisible(true);

    -- toggle button max slider
    self.mainMaxScrollBar = Turbine.UI.Lotro.ScrollBar();
    self.mainMaxScrollBar:SetOrientation(Turbine.UI.Orientation.Horizontal);
    self.mainMaxScrollBar:SetSize(400, 10);
    self.mainMaxScrollBar:SetPosition(70, 285);
    self.mainMaxScrollBar:SetMinimum(0);
    self.mainMaxScrollBar:SetMaximum(100);
    self.mainMaxScrollBar:SetValue(Settings.mainMaxOpacity * 100);
    self.mainMaxScrollBar:SetParent(self.GeneralTab);

    -- reset all setting button
    self.resetButton = Turbine.UI.Lotro.Button();
    self.resetButton:SetSize(200, 20);
    self.resetButton:SetPosition(150, 690);
    self.resetButton:SetText(resetSettingsString);
    self.resetButton:SetParent(self.GeneralTab);
    self.resetButton:SetVisible(true);

    -- do the settings reset
    self.resetButton.Click = function(sender, args)
        self.mainWindow:ResetSettings();
    end

    -- set the hide on start option when changed
    self.HideOnStartCheck.CheckedChanged = function(sender, args)
        if (sender:IsChecked()) then
            Settings.hideOnStart = 1;
        else
            Settings.hideOnStart = 0;
        end
        self.mainWindow:UpdateSettings();
    end

    -- set the hide on combat option when changed
    self.HideOnCombatCheck.CheckedChanged = function(sender, args)
        if (sender:IsChecked()) then
            Settings.hideOnCombat = 1;
        else
            Settings.hideOnCombat = 0;
        end
        self.mainWindow:UpdateSettings();
    end

    -- set the close on travel option when changed
    self.hideOnTravelCheck.CheckedChanged = function(sender, args)
        if (sender:IsChecked()) then
            Settings.hideOnTravel = 1;
        else
            Settings.hideOnTravel = 0;
        end
        self.mainWindow:UpdateSettings();
    end

    -- set the show toggle button option when changed
    self.ShowButtonCheck.CheckedChanged = function(sender, args)
        if (sender:IsChecked()) then
            Settings.showButton = 1;
        else
            Settings.showButton = 0;
        end
        self.mainWindow:UpdateSettings();
        self.mainWindow.ToggleButton:SetVisible(sender:IsChecked());
    end

    -- set the fire on pulldown selection option when changed
    self.PulldownTravelCheck.CheckedChanged = function(sender, args)
        if (sender:IsChecked()) then
            Settings.pulldownTravel = 1;
        else
            Settings.pulldownTravel = 0;
        end
        self.mainWindow:UpdateSettings();
    end

    -- update settings when sliders change
    self.toggleMinScrollBar.ValueChanged = function(sender, args)

        -- check that the min opacity does not go higher than the max opacity
        if (self.toggleMinScrollBar:GetValue() > self.toggleMaxScrollBar:GetValue()) then
            self.toggleMinScrollBar:SetValue(self.toggleMaxScrollBar:GetValue());
        end

        -- do updates
        Settings.toggleMinOpacity = self.toggleMinScrollBar:GetValue() / 100;
        self.mainWindow:UpdateOpacity();
        self.mainWindow:UpdateSettings();
    end

    self.toggleMaxScrollBar.ValueChanged = function(sender, args)

        -- check that the max opacity does not go lower than the min opacity
        if (self.toggleMaxScrollBar:GetValue() < self.toggleMinScrollBar:GetValue()) then
            self.toggleMaxScrollBar:SetValue(self.toggleMinScrollBar:GetValue());
        end

        -- do updates
        Settings.toggleMaxOpacity = self.toggleMaxScrollBar:GetValue() / 100;
        self.mainWindow:UpdateOpacity();
        self.mainWindow:UpdateSettings();

    end

    -- update settings when sliders change
    self.mainMinScrollBar.ValueChanged = function(sender, args)

        -- check that the min opacity does not go higher than the max opacity
        if (self.mainMinScrollBar:GetValue() > self.mainMaxScrollBar:GetValue()) then
            self.mainMinScrollBar:SetValue(self.mainMaxScrollBar:GetValue());
        end

        -- do updates
        Settings.mainMinOpacity = self.mainMinScrollBar:GetValue() / 100;
        self.mainWindow:UpdateOpacity();
        self.mainWindow:UpdateSettings();
    end

    self.mainMaxScrollBar.ValueChanged = function(sender, args)

        -- check that the max opacity does not go lower than the min opacity
        if (self.mainMaxScrollBar:GetValue() < self.mainMinScrollBar:GetValue()) then
            self.mainMaxScrollBar:SetValue(self.mainMinScrollBar:GetValue());
        end

        -- do updates
        Settings.mainMaxOpacity = self.mainMaxScrollBar:GetValue() / 100;
        self.mainWindow:UpdateOpacity();
        self.mainWindow:UpdateSettings();
    end
end

-- function to add all the travel shortcuts that can be toggled
-- to the enabled tab
function OptionsPanel:AddItems()
    local counter = 1;

    -- use an offset counter to set the final position of the skill on the tab
    local offsetCounter = 0;

    -- add the generic travels skills
    if (PlayerAlignment == Turbine.Gameplay.Alignment.FreePeople) then
        for i = 1, travelCount[3], 1 do
            self:AddSkillItemForEnabling(counter, genLocations:IdAtIndex(i), genLocations:LabelAtIndex(i));
            counter = counter + 1;
            offsetCounter = offsetCounter + 1;
        end
    end

    -- add the hunter guide skills if the character is a hunter
    if (PlayerClass == Turbine.Gameplay.Class.Hunter) then
        offsetCounter = 0;
        for i = 1, travelCount[1], 1 do
            self:AddSkillItemForEnabling(counter, hunterLocations:IdAtIndex(i), hunterLocations:LabelAtIndex(i));
            counter = counter + 1;
            offsetCounter = offsetCounter + 1;
        end
    end
    -- add the warden muster skills if the character is a warden
    if (PlayerClass == Turbine.Gameplay.Class.Warden) then
        for i = 1, travelCount[2], 1 do
            self:AddSkillItemForEnabling(counter, wardenLocations:IdAtIndex(i), wardenLocations:LabelAtIndex(i));
            counter = counter + 1;
        end
    end
    -- add the mariner sailing skills if the character is a mariner
    if (PlayerClass == Turbine.Gameplay.Class.Mariner) then
        for i = 1, travelCount[7], 1 do
            self:AddSkillItemForEnabling(counter, marinerLocations:IdAtIndex(i), marinerLocations:LabelAtIndex(i));
            counter = counter + 1;
        end
    end

    -- add the reputation travel skills
    if (PlayerAlignment == Turbine.Gameplay.Alignment.FreePeople) then
        for i = 1, travelCount[4], 1 do
            self:AddSkillItemForEnabling(counter, repLocations:IdAtIndex(i), repLocations:LabelAtIndex(i));
            counter = counter + 1;
        end
    end

    -- add the race specific travel skill for the character
    if (PlayerAlignment == Turbine.Gameplay.Alignment.FreePeople) then
        self:AddSkillItemForEnabling(counter, racialLocations:IdAtIndex(PlayerRaceKey),
                                     racialLocations:LabelAtIndex(PlayerRaceKey));
        counter = counter + 1;
    end

    -- add the creep travel skills
    if (PlayerAlignment == Turbine.Gameplay.Alignment.MonsterPlayer) then
        for i = 1, travelCount[6], 1 do
            self:AddSkillItemForEnabling(counter, creepLocations:IdAtIndex(i), creepLocations:LabelAtIndex(i));
            counter = counter + 1;
        end
    end
end

-- add a single shortcut to the enabled tab at the given location
function OptionsPanel:AddSkillItemForEnabling(index, id, label)

    control = Turbine.UI.Label();
    control:SetSize(self.ListBox:GetWidth() - 20, 20);

    -- create the label for the shortcut setting
    self.labels[index] = Turbine.UI.Label();
    self.labels[index]:SetSize(control:GetWidth() - 20, 20);
    self.labels[index]:SetPosition(30, 0)
    self.labels[index]:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleLeft);
    self.labels[index]:SetParent(control);
    self.labels[index]:SetText(label);
    self.labels[index]:SetVisible(true);

    -- create the checkbox for the shortcut setting
    self.checks[index] = Turbine.UI.Lotro.CheckBox();
    self.checks[index]:SetSize(19, 19);
    self.checks[index]:SetPosition(10, 0);
    self.checks[index]:SetChecked(Settings.enabled[id]);
    self.checks[index]:SetParent(control);
    self.checks[index]:SetWantsUpdates(true);
    self.checks[index]:SetVisible(true);
    self.ListBox:AddItem(control)

    -- handle the event of the check box value changing
    self.checks[index].CheckedChanged = function(sender, args)
        -- change the setting on the main window
        Settings.enabled[id] = sender:IsChecked();
        shortcutIndex = self.mainWindow:TableIndex(Settings.order, id);
        TravelShortcuts[shortcutIndex]:SetEnabled(sender:IsChecked());

        self.mainWindow.dirty = true;

        -- update the main window settings
        self.mainWindow:UpdateSettings();
    end
end

-- this function adds the labels to the enabled tab for cosmetic purpose
function OptionsPanel:AddBoxes()
    --[[
    if (PlayerAlignment == Turbine.Gameplay.Alignment.FreePeople) then
        -- add a label and box for the generic travel skills
        self.genLabel = Turbine.UI.Label();
        self.genLabel:SetSize(200, 20);
        self.genLabel:SetPosition(0, 0);
        self.genLabel:SetTextAlignment(Turbine.UI.ContentAlignment.BottomLeft);
        self.genLabel:SetFont(Turbine.UI.Lotro.Font.Verdana16);
        self.genLabel:SetText(genericLabelString);
        self.genLabel:SetParent(self.EnabledTab);
        self.genLabel:SetVisible(true);

        -- add a label and box for the reputation travel skills
        self.repLabel = Turbine.UI.Label();
        self.repLabel:SetSize(200, 20);
        self.repLabel:SetPosition(260, 0);
        self.repLabel:SetTextAlignment(Turbine.UI.ContentAlignment.BottomLeft);
        self.repLabel:SetFont(Turbine.UI.Lotro.Font.Verdana16);
        self.repLabel:SetText(repLabelString);
        self.repLabel:SetParent(self.EnabledTab);
        self.repLabel:SetVisible(true);

        -- if the player is a hunter or warden, add a label
        if ((PlayerClass == Turbine.Gameplay.Class.Hunter) or (PlayerClass == Turbine.Gameplay.Class.Warden)) then
            self.classLabel = Turbine.UI.Label();
            self.classLabel:SetSize(200, 20);
            self.classLabel:SetPosition(520, 0);
            self.classLabel:SetTextAlignment(Turbine.UI.ContentAlignment.BottomLeft);
            self.classLabel:SetFont(Turbine.UI.Lotro.Font.Verdana16);
            self.classLabel:SetText(classLabelString);
            self.classLabel:SetParent(self.EnabledTab);
            self.classLabel:SetVisible(true);
        end
    else
        -- add a label and box for the Monster Maps settings
        self.genLabel = Turbine.UI.Label();
        self.genLabel:SetSize(200, 20);
        self.genLabel:SetPosition(0, 0);
        self.genLabel:SetTextAlignment(Turbine.UI.ContentAlignment.BottomLeft);
        self.genLabel:SetFont(Turbine.UI.Lotro.Font.Verdana16);
        self.genLabel:SetText(genericLabelString);
        self.genLabel:SetParent(self.EnabledTab);
        self.genLabel:SetVisible(true);

    end
    --]]

    -- add a check skills button
    self.checkSkillsButton = Turbine.UI.Lotro.Button();
    self.checkSkillsButton:SetSize(200, 20);
    self.checkSkillsButton:SetPosition(300, self.EnabledTab:GetHeight() - 50);
    self.checkSkillsButton:SetText(checkSkillsString);
    self.checkSkillsButton:SetParent(self.EnabledTab);
    self.checkSkillsButton:SetVisible(true);

    -- do the check skills
    self.checkSkillsButton.Click = function(sender, args)
        TravelWindow:CheckSkills(true);
    end
end

-- function to add the list of shortcuts to the sort tab
function OptionsPanel:AddSortList()

    -- create a listbox for all the shortcuts to be sorted
    self.sortListBox = Turbine.UI.ListBox();
    self.sortListBox:SetSize(480, self.height - 120);
    self.sortListBox:SetPosition(200, 5);
    self.sortListBox:SetParent(self.SortTab);
    self.sortListBox:SetVisible(true);

    local labelCounter = 1;

    -- create a label to add to the listbox for each shortcut
    for i, v in pairs(TravelShortcuts) do
        local tempLabel = Turbine.UI.Label();
        tempLabel:SetText(v:GetSkillLabel());
        tempLabel:SetSize(280, 20);
        tempLabel:SetBackColor(Turbine.UI.Color(DefAlpha, 0.1, 0.1, 0.1));
        tempLabel:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleLeft);
        tempLabel:SetZOrder(90);

        -- highlight the item that is selected by changing the colour of the
        -- the label when it is clicked
        tempLabel.MouseClick = function(sender, args)
            self.sortListBox:GetItem(self.sortSelectedIndex):SetBackColor(Turbine.UI.Color(DefAlpha, 0.1, 0.1, 0.1));
            sender:SetBackColor(Turbine.UI.Color(0.95, 0.1, 0.1, 0.6));
            self.sortSelectedIndex = self.sortListBox:IndexOfItem(sender);
        end

        -- add the item to the list box
        self.sortListBox:AddItem(tempLabel);

        -- set the maximum index value in the list
        self.sortMaxItem = labelCounter;
        labelCounter = labelCounter + 1;
    end

    -- set the first item as selected
    self.sortListBox:GetItem(self.sortSelectedIndex):SetBackColor(Turbine.UI.Color(DefAlpha, 0.1, 0.1, 0.6));

    -- set up the scrollbar for the list
    self.listBoxScrollBar = self.sortListBox:GetVerticalScrollBar();

    if (self.listBoxScrollBar == nil) then
        self.listBoxScrollBar = Turbine.UI.Lotro.ScrollBar();
    end

    self.listBoxScrollBar:SetBackColor(Turbine.UI.Color(DefAlpha, 0.1, 0.1, 0.1));
    self.listBoxScrollBar:SetOrientation(Turbine.UI.Orientation.Vertical);
    self.listBoxScrollBar:SetSize(10, self.height - 120);
    self.listBoxScrollBar:SetPosition(270, 0);
    self.listBoxScrollBar:SetZOrder(100);
    self.listBoxScrollBar:SetVisible(true);
    self.listBoxScrollBar:SetParent(self.sortListBox);

    -- set the listbox scrollbar
    self.sortListBox:SetVerticalScrollBar(self.listBoxScrollBar);
end

-- function to add the buttons to sort the shortcuts
function OptionsPanel:AddSortButtons()
    self.moveUpButton = Turbine.UI.Lotro.Button();
    self.moveUpButton:SetSize(185, 20);
    self.moveUpButton:SetPosition(10, 205);
    self.moveUpButton:SetText(moveUpString);
    self.moveUpButton:SetParent(self.SortTab);
    self.moveUpButton:SetVisible(true);

    self.moveDownButton = Turbine.UI.Lotro.Button();
    self.moveDownButton:SetSize(185, 20);
    self.moveDownButton:SetPosition(10, 265);
    self.moveDownButton:SetText(moveDownString);
    self.moveDownButton:SetParent(self.SortTab);
    self.moveDownButton:SetVisible(true);

    self.moveTopButton = Turbine.UI.Lotro.Button();
    self.moveTopButton:SetSize(185, 20);
    self.moveTopButton:SetPosition(10, 155);
    self.moveTopButton:SetText(moveTopString);
    self.moveTopButton:SetParent(self.SortTab);
    self.moveTopButton:SetVisible(true);

    self.moveBottomButton = Turbine.UI.Lotro.Button();
    self.moveBottomButton:SetSize(185, 20);
    self.moveBottomButton:SetPosition(10, 315);
    self.moveBottomButton:SetText(moveBottomString);
    self.moveBottomButton:SetParent(self.SortTab);
    self.moveBottomButton:SetVisible(true);

    -- handle the move to top button click
    self.moveTopButton.Click = function(sender, args)

        -- loop while selected item is not already at the top
        while (self.sortSelectedIndex > 1) do
            -- swap the selected item with the one before it
            self:SwapShortcuts(self.sortSelectedIndex, self.sortSelectedIndex - 1);

            -- resort the list
            self.sortSelectedIndex = self.sortSelectedIndex - 1;
        end

        -- update the main window shortcuts and settings
        self.mainWindow:UpdateSettings();
    end

    -- handle the move up button click
    self.moveUpButton.Click = function(sender, args)
        -- exit if the selected item is already at the top
        if (self.sortSelectedIndex == 1) then
            return;
        end

        -- swap the selected item with the previous in the list
        self:SwapShortcuts(self.sortSelectedIndex, self.sortSelectedIndex - 1);

        -- update the main window shortcuts and settings
        self.mainWindow:UpdateSettings();

        -- decrease the selected index
        self.sortSelectedIndex = self.sortSelectedIndex - 1;
    end

    -- handle the move down button click
    self.moveDownButton.Click = function(sender, args)
        -- exit if the selected item is already at the bottom
        if (self.sortSelectedIndex == self.sortMaxItem) then
            return;
        end

        -- swap the selected item with the next item in the list
        self:SwapShortcuts(self.sortSelectedIndex, self.sortSelectedIndex + 1);

        -- update the main window shortcuts and settings
        self.mainWindow:UpdateSettings();

        -- increase the selected index
        self.sortSelectedIndex = self.sortSelectedIndex + 1;
    end

    -- handle the move to bottom button
    self.moveBottomButton.Click = function(sender, args)

        -- loop while the selected item is not at the bottom of the list
        while (self.sortSelectedIndex < self.sortMaxItem) do
            -- swap the item with the next item
            self:SwapShortcuts(self.sortSelectedIndex, self.sortSelectedIndex + 1);
            -- increment the selected index
            self.sortSelectedIndex = self.sortSelectedIndex + 1;
        end

        -- update the main window shortcuts and settings
        self.mainWindow:UpdateSettings();
    end
end

-- function to perform the actual swap of shortcuts
function OptionsPanel:SwapShortcuts(first, second)
    -- only perform swap if the window is fully loaded
    if (self.loaded == true) then

        -- swap the order in the settings list by saving the first value to
        -- a temp variable, setting the value of the first index to the value of
        -- the second index, then setting the value of the second index to the
        -- temp value
        local tempValue = Settings.order[first];
        Settings.order[first] = Settings.order[second];
        Settings.order[second] = tempValue;

        -- swap the items in the listbox using the same method
        local tempItem = self.sortListBox:GetItem(first);
        self.sortListBox:RemoveItemAt(first);
        self.sortListBox:InsertItem(second, tempItem);

        TravelShortcuts[first]:SetIndex(second);
        TravelShortcuts[second]:SetIndex(first);
        local tempShortcut = TravelShortcuts[first];
        TravelShortcuts[first] = TravelShortcuts[second];
        TravelShortcuts[second] = tempShortcut;
        self.mainWindow.dirty = true;
    end
end
