import "Turbine";
import "Turbine.Debug";
import "Turbine.Gameplay";
import "Turbine.UI";
import "Turbine.UI.Lotro";
import "TravelWindowII.src.extensions";
import "TravelWindowII.src.utils.BitOps";

OptionsPanel = class(Turbine.UI.Control);

function OptionsPanel:Constructor()
    Turbine.UI.Control.Constructor(self);

    --  add a check to see if we load completely
    self.loaded = false;
    self.disableUpdates = false;

    -- set size of window
    self.width = 800;
    self.height = 840;
    self.windowWidth, self.windowHeight = Turbine.UI.Display:GetSize();
    if self.height + 40 > self.windowHeight then
        self.height = self.windowHeight - 20;
    end

    self.overlapGroup = {};

    -- create array of labels and check boxes
    self.labels = {};
    self.checks = {};

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

    self:SetupOverlapLinks();

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

    self.loaded = true;
end

function OptionsPanel:GetLoaded()
    return self.loaded;
end

-- function to add items to the general tab
function OptionsPanel:AddGeneralItems()
    local optionHeight = 0;
    local NextY = function(offset)
        optionHeight = optionHeight + offset;
        return optionHeight;
    end

    -- label for hide window on start option
    self.UseMinWindowLabel = Turbine.UI.Label();
    self.UseMinWindowLabel:SetSize(300, 20);
    self.UseMinWindowLabel:SetPosition(20, NextY(20));
    self.UseMinWindowLabel:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleLeft);
    self.UseMinWindowLabel:SetParent(self.GeneralTab);
    self.UseMinWindowLabel:SetText(minWindowString);
    self.UseMinWindowLabel:SetVisible(true);

    -- checkbox for hide window on start option
    self.UseMinWindowCheck = Turbine.UI.Lotro.CheckBox();
    self.UseMinWindowCheck:SetSize(19, 19);
    self.UseMinWindowCheck:SetPosition(450, NextY(0));
    self.UseMinWindowCheck:SetChecked(Settings.useMinWindow == 1);
    self.UseMinWindowCheck:SetParent(self.GeneralTab);
    self.UseMinWindowCheck:SetVisible(true);

    -- label for hide window on start option
    self.HideOnStartLabel = Turbine.UI.Label();
    self.HideOnStartLabel:SetSize(300, 20);
    self.HideOnStartLabel:SetPosition(20, NextY(30));
    self.HideOnStartLabel:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleLeft);
    self.HideOnStartLabel:SetParent(self.GeneralTab);
    self.HideOnStartLabel:SetText(hideString);
    self.HideOnStartLabel:SetVisible(true);

    -- checkbox for hide window on start option
    self.HideOnStartCheck = Turbine.UI.Lotro.CheckBox();
    self.HideOnStartCheck:SetSize(19, 19);
    self.HideOnStartCheck:SetPosition(450, NextY(0));
    self.HideOnStartCheck:SetChecked(Settings.hideOnStart == 1);
    self.HideOnStartCheck:SetParent(self.GeneralTab);
    self.HideOnStartCheck:SetVisible(true);

    -- label for hide on combat option
    self.HideOnCombatLabel = Turbine.UI.Label();
    self.HideOnCombatLabel:SetSize(300, 20);
    self.HideOnCombatLabel:SetPosition(20, NextY(30));
    self.HideOnCombatLabel:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleLeft);
    self.HideOnCombatLabel:SetParent(self.GeneralTab);
    self.HideOnCombatLabel:SetText(hideOnCombatString);
    self.HideOnCombatLabel:SetVisible(true);

    -- checkbox for hide on combat option
    self.HideOnCombatCheck = Turbine.UI.Lotro.CheckBox();
    self.HideOnCombatCheck:SetSize(19, 19);
    self.HideOnCombatCheck:SetPosition(450, NextY(0));
    self.HideOnCombatCheck:SetChecked(Settings.hideOnCombat == 1);
    self.HideOnCombatCheck:SetParent(self.GeneralTab);
    self.HideOnCombatCheck:SetVisible(true);

    -- label for option to close window on travel skill use
    self.hideOnTravelLabel = Turbine.UI.Label();
    self.hideOnTravelLabel:SetSize(300, 20);
    self.hideOnTravelLabel:SetPosition(20, NextY(30));
    self.hideOnTravelLabel:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleLeft);
    self.hideOnTravelLabel:SetParent(self.GeneralTab);
    self.hideOnTravelLabel:SetText(hideOnTravelString);
    self.hideOnTravelLabel:SetVisible(true);

    -- checkbox for option to close window on travel skill use
    self.hideOnTravelCheck = Turbine.UI.Lotro.CheckBox();
    self.hideOnTravelCheck:SetSize(19, 19);
    self.hideOnTravelCheck:SetPosition(450, NextY(0));
    self.hideOnTravelCheck:SetChecked(Settings.hideOnTravel == 1);
    self.hideOnTravelCheck:SetParent(self.GeneralTab);
    self.hideOnTravelCheck:SetVisible(true);

    -- label for ignore escape to close option
    self.ignoreEscLabel = Turbine.UI.Label();
    self.ignoreEscLabel:SetSize(300, 20);
    self.ignoreEscLabel:SetPosition(20, NextY(30));
    self.ignoreEscLabel:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleLeft);
    self.ignoreEscLabel:SetParent(self.GeneralTab);
    self.ignoreEscLabel:SetText(ignoreEscString);
    self.ignoreEscLabel:SetVisible(true);

    -- checkbox for ignore escape to close option
    self.ignoreEscCheck = Turbine.UI.Lotro.CheckBox();
    self.ignoreEscCheck:SetSize(19, 19);
    self.ignoreEscCheck:SetPosition(450, NextY(0));
    self.ignoreEscCheck:SetChecked(Settings.ignoreEsc == 1);
    self.ignoreEscCheck:SetParent(self.GeneralTab);
    self.ignoreEscCheck:SetVisible(true);

    -- label for show toggle button option
    self.ShowButtonLabel = Turbine.UI.Label();
    self.ShowButtonLabel:SetSize(300, 20);
    self.ShowButtonLabel:SetPosition(20, NextY(30));
    self.ShowButtonLabel:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleLeft);
    self.ShowButtonLabel:SetParent(self.GeneralTab);
    self.ShowButtonLabel:SetText(toggleString);
    self.ShowButtonLabel:SetVisible(true);

    -- checkbox for show toggle button option
    self.ShowButtonCheck = Turbine.UI.Lotro.CheckBox();
    self.ShowButtonCheck:SetSize(19, 19);
    self.ShowButtonCheck:SetPosition(450, NextY(0));
    self.ShowButtonCheck:SetChecked(Settings.showButton == 1);
    self.ShowButtonCheck:SetParent(self.GeneralTab);
    self.ShowButtonCheck:SetVisible(true);

    -- label for option to fire skill on pulldown selection
    self.PulldownTravelLabel = Turbine.UI.Label();
    self.PulldownTravelLabel:SetSize(300, 20);
    self.PulldownTravelLabel:SetPosition(20, NextY(30));
    self.PulldownTravelLabel:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleLeft);
    self.PulldownTravelLabel:SetParent(self.GeneralTab);
    self.PulldownTravelLabel:SetText(pulldownTravelString);
    self.PulldownTravelLabel:SetVisible(true);

    -- checkbox for option to fire skill on pulldown selection
    self.PulldownTravelCheck = Turbine.UI.Lotro.CheckBox();
    self.PulldownTravelCheck:SetSize(19, 19);
    self.PulldownTravelCheck:SetPosition(450, NextY(0));
    self.PulldownTravelCheck:SetChecked(Settings.pulldownTravel == 1);
    self.PulldownTravelCheck:SetParent(self.GeneralTab);
    self.PulldownTravelCheck:SetVisible(true);

    -- label for toggle button sliders
    self.toggleSlidersLabel = Turbine.UI.Label();
    self.toggleSlidersLabel:SetSize(300, 20);
    self.toggleSlidersLabel:SetPosition(20, NextY(30));
    self.toggleSlidersLabel:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleLeft);
    self.toggleSlidersLabel:SetParent(self.GeneralTab);
    self.toggleSlidersLabel:SetText(toggleSlidersString);
    self.toggleSlidersLabel:SetVisible(true);

    -- toggle button min slider label
    self.toggleMinSlidersLabel = Turbine.UI.Label();
    self.toggleMinSlidersLabel:SetSize(50, 20);
    self.toggleMinSlidersLabel:SetPosition(20, NextY(20));
    self.toggleMinSlidersLabel:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleLeft);
    self.toggleMinSlidersLabel:SetParent(self.GeneralTab);
    self.toggleMinSlidersLabel:SetText(minString);
    self.toggleMinSlidersLabel:SetVisible(true);

    -- toggle button min slider
    self.toggleMinScrollBar = Turbine.UI.Lotro.ScrollBar();
    self.toggleMinScrollBar:SetOrientation(Turbine.UI.Orientation.Horizontal);
    self.toggleMinScrollBar:SetSize(400, 10);
    self.toggleMinScrollBar:SetPosition(70, NextY(5));
    self.toggleMinScrollBar:SetMinimum(0);
    self.toggleMinScrollBar:SetMaximum(100);
    self.toggleMinScrollBar:SetValue(Settings.toggleMinOpacity * 100);
    self.toggleMinScrollBar:SetParent(self.GeneralTab);

    -- toggle button max slider
    self.toggleMaxSlidersLabel = Turbine.UI.Label();
    self.toggleMaxSlidersLabel:SetSize(50, 20);
    self.toggleMaxSlidersLabel:SetPosition(20, NextY(15));
    self.toggleMaxSlidersLabel:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleLeft);
    self.toggleMaxSlidersLabel:SetParent(self.GeneralTab);
    self.toggleMaxSlidersLabel:SetText(maxString);
    self.toggleMaxSlidersLabel:SetVisible(true);

    -- toggle button max slider
    self.toggleMaxScrollBar = Turbine.UI.Lotro.ScrollBar();
    self.toggleMaxScrollBar:SetOrientation(Turbine.UI.Orientation.Horizontal);
    self.toggleMaxScrollBar:SetSize(400, 10);
    self.toggleMaxScrollBar:SetPosition(70, NextY(5));
    self.toggleMaxScrollBar:SetMinimum(0);
    self.toggleMaxScrollBar:SetMaximum(100);
    self.toggleMaxScrollBar:SetValue(Settings.toggleMaxOpacity * 100);
    self.toggleMaxScrollBar:SetParent(self.GeneralTab);

    -- label for main window sliders
    self.SlidersLabel = Turbine.UI.Label();
    self.SlidersLabel:SetSize(300, 20);
    self.SlidersLabel:SetPosition(20, NextY(25));
    self.SlidersLabel:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleLeft);
    self.SlidersLabel:SetParent(self.GeneralTab);
    self.SlidersLabel:SetText(mainSlidersString);
    self.SlidersLabel:SetVisible(true);

    -- main window min slider label
    self.mainMinSlidersLabel = Turbine.UI.Label();
    self.mainMinSlidersLabel:SetSize(50, 20);
    self.mainMinSlidersLabel:SetPosition(20, NextY(20));
    self.mainMinSlidersLabel:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleLeft);
    self.mainMinSlidersLabel:SetParent(self.GeneralTab);
    self.mainMinSlidersLabel:SetText(minString);
    self.mainMinSlidersLabel:SetVisible(true);

    -- main window min slider
    self.mainMinScrollBar = Turbine.UI.Lotro.ScrollBar();
    self.mainMinScrollBar:SetOrientation(Turbine.UI.Orientation.Horizontal);
    self.mainMinScrollBar:SetSize(400, 10);
    self.mainMinScrollBar:SetPosition(70, NextY(5));
    self.mainMinScrollBar:SetMinimum(0);
    self.mainMinScrollBar:SetMaximum(100);
    self.mainMinScrollBar:SetValue(Settings.mainMinOpacity * 100);
    self.mainMinScrollBar:SetParent(self.GeneralTab);

    -- main window max slider label
    self.mainMaxSlidersLabel = Turbine.UI.Label();
    self.mainMaxSlidersLabel:SetSize(50, 20);
    self.mainMaxSlidersLabel:SetPosition(20, NextY(15));
    self.mainMaxSlidersLabel:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleLeft);
    self.mainMaxSlidersLabel:SetParent(self.GeneralTab);
    self.mainMaxSlidersLabel:SetText(maxString);
    self.mainMaxSlidersLabel:SetVisible(true);

    -- main window max slider
    self.mainMaxScrollBar = Turbine.UI.Lotro.ScrollBar();
    self.mainMaxScrollBar:SetOrientation(Turbine.UI.Orientation.Horizontal);
    self.mainMaxScrollBar:SetSize(400, 10);
    self.mainMaxScrollBar:SetPosition(70, NextY(5));
    self.mainMaxScrollBar:SetMinimum(0);
    self.mainMaxScrollBar:SetMaximum(100);
    self.mainMaxScrollBar:SetValue(Settings.mainMaxOpacity * 100);
    self.mainMaxScrollBar:SetParent(self.GeneralTab);

    -- fade out slider label
    self.mainFadeSlidersLabel = Turbine.UI.Label();
    self.mainFadeSlidersLabel:SetSize(300, 20);
    self.mainFadeSlidersLabel:SetPosition(20, NextY(25));
    self.mainFadeSlidersLabel:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleLeft);
    self.mainFadeSlidersLabel:SetParent(self.GeneralTab);
    self.mainFadeSlidersLabel:SetText(fadeWindowString);
    self.mainFadeSlidersLabel:SetVisible(true);

    -- fade out slider
    self.mainFadeScrollBar = Turbine.UI.Lotro.ScrollBar();
    self.mainFadeScrollBar:SetOrientation(Turbine.UI.Orientation.Horizontal);
    self.mainFadeScrollBar:SetSize(450, 10);
    self.mainFadeScrollBar:SetPosition(20, NextY(25));
    self.mainFadeScrollBar:SetMinimum(1);
    self.mainFadeScrollBar:SetMaximum(151);
    self.mainFadeScrollBar:SetValue(Settings.fadeOutSteps);
    self.mainFadeScrollBar:SetParent(self.GeneralTab);

    -- reset all setting button
    self.resetButton = Turbine.UI.Lotro.Button();
    self.resetButton:SetSize(220, 20);
    self.resetButton:SetPosition(20, 690);
    self.resetButton:SetText(resetSettingsString);
    self.resetButton:SetParent(self.GeneralTab);
    self.resetButton:SetVisible(true);

    self.saveGlobal = Turbine.UI.Lotro.Button();
    self.saveGlobal:SetSize(220, 20);
    self.saveGlobal:SetPosition(250, 690);
    self.saveGlobal:SetText(saveGlobalDefaultsString);
    self.saveGlobal:SetParent(self.GeneralTab);
    self.saveGlobal:SetVisible(true);

    self.loadGlobal = Turbine.UI.Lotro.Button();
    self.loadGlobal:SetSize(220, 20);
    self.loadGlobal:SetPosition(480, 690);
    self.loadGlobal:SetText(loadGlobalDefaultsString);
    self.loadGlobal:SetParent(self.GeneralTab);
    self.loadGlobal:SetVisible(true);

    self:UpdateSettings();

    -- do the settings reset
    self.resetButton.Click = function(sender, args)
        _G.travel:ResetSettings();
    end

    self.saveGlobal.Click = function(sender, args)
        SaveSettings(Turbine.DataScope.Account);
    end

    self.loadGlobal.Click = function(sender, args)
        SetSettings(AccountSettingsStrings);
        SyncUIFromSettings();
    end

    self.UseMinWindowCheck.CheckedChanged = function(sender, args)
        if (sender:IsChecked()) then
            Settings.useMinWindow = 1;
        else
            Settings.useMinWindow = 0;
        end
        _G.travel:Close();
        _G.travel = nil;
        _G.travel = TravelWindow(Settings.useMinWindow);
    end

    -- set the hide on start option when changed
    self.HideOnStartCheck.CheckedChanged = function(sender, args)
        if (sender:IsChecked()) then
            Settings.hideOnStart = 1;
        else
            Settings.hideOnStart = 0;
        end
        _G.travel:UpdateSettings();
    end

    -- set the hide on combat option when changed
    self.HideOnCombatCheck.CheckedChanged = function(sender, args)
        if (sender:IsChecked()) then
            Settings.hideOnCombat = 1;
        else
            Settings.hideOnCombat = 0;
        end
        _G.travel:UpdateSettings();
    end

    -- set the close on travel option when changed
    self.hideOnTravelCheck.CheckedChanged = function(sender, args)
        if (sender:IsChecked()) then
            Settings.hideOnTravel = 1;
        else
            Settings.hideOnTravel = 0;
        end
        _G.travel:UpdateSettings();
    end

    -- set the ignore escape to close option when changed
    self.ignoreEscCheck.CheckedChanged = function(sender, args)
        if (sender:IsChecked()) then
            Settings.ignoreEsc = 1;
        else
            Settings.ignoreEsc = 0;
        end
        _G.travel:UpdateSettings();
    end

    -- set the show toggle button option when changed
    self.ShowButtonCheck.CheckedChanged = function(sender, args)
        if (sender:IsChecked()) then
            Settings.showButton = 1;
        else
            Settings.showButton = 0;
        end
        _G.travel:UpdateSettings();
        ToggleButton:SetVisible(sender:IsChecked());
    end

    -- set the fire on pulldown selection option when changed
    self.PulldownTravelCheck.CheckedChanged = function(sender, args)
        if (sender:IsChecked()) then
            Settings.pulldownTravel = 1;
        else
            Settings.pulldownTravel = 0;
        end
        _G.travel:UpdateSettings();
    end

    -- update settings when sliders change
    self.toggleMinScrollBar.ValueChanged = function(sender, args)

        -- check that the min opacity does not go higher than the max opacity
        if (self.toggleMinScrollBar:GetValue() > self.toggleMaxScrollBar:GetValue()) then
            self.toggleMinScrollBar:SetValue(self.toggleMaxScrollBar:GetValue());
        end

        -- do updates
        Settings.toggleMinOpacity = self.toggleMinScrollBar:GetValue() / 100;
        _G.travel:UpdateOpacity();
        _G.travel:UpdateSettings();
    end

    self.toggleMaxScrollBar.ValueChanged = function(sender, args)

        -- check that the max opacity does not go lower than the min opacity
        if (self.toggleMaxScrollBar:GetValue() < self.toggleMinScrollBar:GetValue()) then
            self.toggleMaxScrollBar:SetValue(self.toggleMinScrollBar:GetValue());
        end

        -- do updates
        Settings.toggleMaxOpacity = self.toggleMaxScrollBar:GetValue() / 100;
        _G.travel:UpdateOpacity();
        _G.travel:UpdateSettings();

    end

    -- update settings when sliders change
    self.mainMinScrollBar.ValueChanged = function(sender, args)

        -- check that the min opacity does not go higher than the max opacity
        if (self.mainMinScrollBar:GetValue() > self.mainMaxScrollBar:GetValue()) then
            self.mainMinScrollBar:SetValue(self.mainMaxScrollBar:GetValue());
        end

        -- do updates
        Settings.mainMinOpacity = self.mainMinScrollBar:GetValue() / 100;
        _G.travel:UpdateOpacity();
        _G.travel:UpdateSettings();
    end

    self.mainMaxScrollBar.ValueChanged = function(sender, args)

        -- check that the max opacity does not go lower than the min opacity
        if (self.mainMaxScrollBar:GetValue() < self.mainMinScrollBar:GetValue()) then
            self.mainMaxScrollBar:SetValue(self.mainMinScrollBar:GetValue());
        end

        -- do updates
        Settings.mainMaxOpacity = self.mainMaxScrollBar:GetValue() / 100;
        _G.travel:UpdateOpacity();
        _G.travel:UpdateSettings();
    end

    self.mainFadeScrollBar.ValueChanged = function(sender, args)
        Settings.fadeOutSteps = self.mainFadeScrollBar:GetValue();
        _G.travel:UpdateOpacity();
        _G.travel:UpdateSettings();
    end
end

function OptionsPanel:UpdateSettings()
    self.UseMinWindowCheck:SetChecked(Settings.useMinWindow == 1);
    self.HideOnStartCheck:SetChecked(Settings.hideOnStart == 1);
    self.HideOnCombatCheck:SetChecked(Settings.hideOnCombat == 1);
    self.hideOnTravelCheck:SetChecked(Settings.hideOnTravel == 1);
    self.ignoreEscCheck:SetChecked(Settings.ignoreEsc == 1);
    self.ShowButtonCheck:SetChecked(Settings.showButton == 1);
    self.PulldownTravelCheck:SetChecked(Settings.pulldownTravel == 1);
    self.toggleMinScrollBar:SetValue(Settings.toggleMinOpacity * 100);
    self.toggleMaxScrollBar:SetValue(Settings.toggleMaxOpacity * 100);
    self.mainMinScrollBar:SetValue(Settings.mainMinOpacity * 100);
    self.mainMaxScrollBar:SetValue(Settings.mainMaxOpacity * 100);
    self.mainFadeScrollBar:SetValue(Settings.fadeOutSteps);
end

-- function to add all the travel shortcuts that can be toggled
-- to the enabled tab
function OptionsPanel:AddItems()
    if (PlayerAlignment == Turbine.Gameplay.Alignment.FreePeople) then
        -- add the generic travels skills
        self:AddSkillsForEnabling(TravelInfo.gen);

        -- add class specific travel skills
        self:AddSkillsForEnabling(TravelInfo:GetClassSkills());

        -- add the reputation travel skills
        self:AddSkillsForEnabling(TravelInfo.rep);

        -- add the race specific travel skill for the character
        self:AddSkillItemForEnabling(TravelInfo.racial.id, TravelInfo.racial.label);
    end

    if (PlayerAlignment == Turbine.Gameplay.Alignment.MonsterPlayer) then
        -- add the creep travel skills
        self:AddSkillsItemForEnabling(TravelInfo.creep);
    end
end

function OptionsPanel:AddSkillsForEnabling(skills)
    if skills == nil then return end
    for i = 1, skills:GetCount() do
        self:AddSkillItemForEnabling(skills:IdAtIndex(i), skills:LabelAtIndex(i));
    end
end

-- add a single shortcut to the enabled tab at the given location
function OptionsPanel:AddSkillItemForEnabling(id, label)
    local control = Turbine.UI.Label();
    control:SetSize(self.ListBox:GetWidth() - 20, 20);

    -- create the label for the shortcut setting
    local slabel = Turbine.UI.Label();
    slabel:SetSize(control:GetWidth() - 20, 20);
    slabel:SetPosition(30, 0)
    slabel:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleLeft);
    slabel:SetParent(control);
    slabel:SetText(label);
    slabel:SetVisible(true);
    table.insert(self.labels, slabel);

    -- create the checkbox for the shortcut setting
    local check = Turbine.UI.Lotro.CheckBox();
    check:SetSize(19, 19);
    check:SetPosition(10, 0);
    check:SetChecked(Settings.enabled[id]);
    check:SetParent(control);
    check:SetVisible(true);
    check.skillId = id;
    table.insert(self.checks, check);
    self.ListBox:AddItem(control)

    -- handle the event of the check box value changing
    check.CheckedChanged = function(sender, args)
        -- change the setting on the main window
        Settings.enabled[id] = sender:IsChecked();
        shortcutIndex = TableIndex(Settings.order, id);
        TravelShortcuts[shortcutIndex]:SetEnabled(sender:IsChecked());

        _G.travel.dirty = true;
        if not self.disableUpdates then
            _G.travel:UpdateSettings();
        end
        if _G.travel.mapWindow ~= nil then
            _G.travel.mapWindow:UpdateShortcut(id, sender:IsChecked());
        end
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
        CheckSkills(true);
    end

    local next = next; -- optimization
    if next(self.overlapGroup) ~= nil then
        -- add an enable overlapping skills button
        self.enableRepSkillsButton = Turbine.UI.Lotro.Button();
        self.enableRepSkillsButton:SetSize(200, 20);
        self.enableRepSkillsButton:SetPosition(520, 90);
        self.enableRepSkillsButton:SetText(enableRepSkillsString);
        self.enableRepSkillsButton:SetParent(self.EnabledTab);
        self.enableRepSkillsButton:SetVisible(true);

        self.enableRepSkillsButton.Click = function(sender, args)
            self:EnableOverlapSkills(true);
        end

        -- add a disable overlapping skills button
        self.disableRepSkillsButton = Turbine.UI.Lotro.Button();
        self.disableRepSkillsButton:SetSize(200, 20);
        self.disableRepSkillsButton:SetPosition(520, 120);
        self.disableRepSkillsButton:SetText(disableRepSkillsString);
        self.disableRepSkillsButton:SetParent(self.EnabledTab);
        self.disableRepSkillsButton:SetVisible(true);

        self.disableRepSkillsButton.Click = function(sender, args)
            self:EnableOverlapSkills(false);
        end
    end

    self.enableAllButton = Turbine.UI.Lotro.Button();
    self.enableAllButton:SetSize(200, 20);
    self.enableAllButton:SetPosition(520, 30);
    self.enableAllButton:SetText(enableAllString);
    self.enableAllButton:SetParent(self.EnabledTab);
    self.enableAllButton:SetVisible(true);

    self.enableAllButton.Click = function(sender, args)
        self:EnableAll(true);
    end

    self.disableAllButton = Turbine.UI.Lotro.Button();
    self.disableAllButton:SetSize(200, 20);
    self.disableAllButton:SetPosition(520, 60);
    self.disableAllButton:SetText(disableAllString);
    self.disableAllButton:SetParent(self.EnabledTab);
    self.disableAllButton:SetVisible(true);

    self.disableAllButton.Click = function(sender, args)
        self:EnableAll(false);
    end
end

function OptionsPanel:AddOverlapLinks(id, repLinks)
    local locations = TravelInfo:GetClassSkills();
    if locations == nil then return end

    if not locations:VerifyId(id) then
        Turbine.Shell.WriteLine("Overlap Invalid ID " .. id);
        return
    end

    self.overlapGroup[id] = repLinks;
end

function OptionsPanel:SetupOverlapLinks()
    if PlayerClass == Turbine.Gameplay.Class.Hunter then
        self:AddOverlapLinks("0x70003F42", {"0x700062F6", "0x7001BF90", "0x700364B1"}); -- Bree
        self:AddOverlapLinks("0x70003F41", {"0x70006346", "0x70053C0F", "0x7001BF91"}); -- Thorin's Hall
        self:AddOverlapLinks("0x7000A2C3", {"0x700062C8", "0x70023262"}); -- Michel Delving
        self:AddOverlapLinks("0x7000A2C2", {"0x70020441"}); -- Ost Guruth
        self:AddOverlapLinks("0x70003F44", {"0x7000631F", "0x70023263"}); -- Rivendell
        self:AddOverlapLinks("0x7002A93F", {"0x7002C647"}); -- Galtrev
        self:AddOverlapLinks("0x7002C62C", {"0x7002C65D"}); -- Stangard
        self:AddOverlapLinks("0x7002E754", {"0x70048C8C"}); -- Caras Galadhon
        self:AddOverlapLinks("0x7003198E", {"0x70031A46"}); -- Snowbourn
        self:AddOverlapLinks("0x70036B5D", {"0x70036B5E"}); -- Forlaw
        self:AddOverlapLinks("0x7003DC71", {"0x7003DC81"}); -- Aldburg
        self:AddOverlapLinks("0x7003DC72", {"0x7003DC82"}); -- Helm's Deep
        self:AddOverlapLinks("0x70041197", {"0x700411AC"}); -- Dol Amroth
        self:AddOverlapLinks("0x70043A63", {"0x70043A6A"}); -- Arnach
        self:AddOverlapLinks("0x70044985", {"0x7004497E"}); -- Minas Tirith
        self:AddOverlapLinks("0x700459AF", {"0x700459A9"}); -- War-stead
        self:AddOverlapLinks("0x70046CBB", {"0x70046CC0"}); -- After-battle Minas Tirith
        self:AddOverlapLinks("0x70047077", {"0x70047080"}); -- Henneth Annûn
        self:AddOverlapLinks("0x70047074", {"0x7004707D"}); -- After-battle Osgiliath
        self:AddOverlapLinks("0x70047BFA", {"0x70047BF4"}); -- Camp of the Host
        self:AddOverlapLinks("0x70047C1D", {"0x70047C1B"}); -- Haerondir
        self:AddOverlapLinks("0x7004AE1E", {"0x7004AE1D"}); -- Udûn Foothold
        self:AddOverlapLinks("0x7004D73B", {"0x7004D738"}); -- Dale
        self:AddOverlapLinks("0x7004FACC", {"0x7004FAC3"}); -- Járnfast
        self:AddOverlapLinks("0x7004FACB", {"0x7004FAC5"}); -- Skarháld
        self:AddOverlapLinks("0x70052F07", {"0x70041A22", "0x70052F12"}); -- Beorninghús
        self:AddOverlapLinks("0x70052F08", {"0x70052F04"}); --  Hultvís
        self:AddOverlapLinks("0x700551F4", {"0x700551F8"}); -- Estolad Lân
        self:AddOverlapLinks("0x7005762D", {"0x70057629"}); -- Limlók
        self:AddOverlapLinks("0x70058571", {"0x7005856F"}); -- Annâk-khurfu
        self:AddOverlapLinks("0x70059D0C", {"0x70059D0E"}); -- Trader's Wharf
        self:AddOverlapLinks("0x70059D16", {"0x70059D12"}); -- Trestlebridge
        self:AddOverlapLinks("0x7005AA91", {"0x7005AA90"}); -- Akrâz-zahar
        self:AddOverlapLinks("0x7005AA95", {"0x7005AA92"}); -- Azanulbizar
        self:AddOverlapLinks("0x7005D487", {"0x7005D47C"}); -- Noble Gate
        self:AddOverlapLinks("0x7005D47D", {"0x7005D484"}); -- Leitstáth
        self:AddOverlapLinks("0x70060EA6", {"0x70060EA8"}); -- Tornhad
        self:AddOverlapLinks("0x7006133F", {"0x70061340"}); -- Nobottle
        self:AddOverlapLinks("0x7006323C", {"0x7006323D"}); -- Andrath
        self:AddOverlapLinks("0x700634AA", {"0x700634A4"}); -- Swanfleet
        self:AddOverlapLinks("0x700634A7", {"0x700634AE"}); -- Cardolan
        self:AddOverlapLinks("0x70064AC8", {"0x70064ACA"}); -- Carn Dûm
        self:AddOverlapLinks("0x70064F4C", {"0x70064F47"}); -- Clegur
        self:AddOverlapLinks("0x700658EA", {"0x700658EB"}); -- Pelargir
        self:AddOverlapLinks("0x70068711", {"0x70068700"}); -- King's Dol Amroth
        self:AddOverlapLinks("0x70068713", {"0x70068702"}); -- Halrax
        self:AddOverlapLinks("0x70068717", {"0x70068703"}); -- Lond Cirion
        self:AddOverlapLinks("0x70068718", {"0x700686FF"}); -- Umbar
        self:AddOverlapLinks("0x70068719", {"0x70068701"}); -- Jax Phanâl
        self:AddOverlapLinks("0x700697EF", {"0x700697F2"}); -- Bloody Eagle Tavern
    elseif PlayerClass == Turbine.Gameplay.Class.Warden then
        self:AddOverlapLinks("0x70014786", {"0x70020441"}); -- Ost Guruth
        self:AddOverlapLinks("0x70014791", {"0x7000631F", "0x70023263"}); -- Rivendell
        self:AddOverlapLinks("0x7002A90A", {"0x7002C647"}); -- Galtrev
        self:AddOverlapLinks("0x7002C646", {"0x7002C65D"}); -- Stangard
        self:AddOverlapLinks("0x700303DF", {"0x70048C8C"}); -- Caras Galadhon
        self:AddOverlapLinks("0x7003198D", {"0x70031A46"}); -- Snowbourn
        self:AddOverlapLinks("0x70036B5B", {"0x70036B5E"}); -- Forlaw
        self:AddOverlapLinks("0x7003DC7A", {"0x7003DC81"}); -- Aldburg
        self:AddOverlapLinks("0x7003DC79", {"0x7003DC82"}); -- Helm's Deep
        self:AddOverlapLinks("0x70041198", {"0x700411AC"}); -- Dol Amroth
        self:AddOverlapLinks("0x70043A66", {"0x70043A6A"}); -- Arnach
        self:AddOverlapLinks("0x70044982", {"0x7004497E"}); -- Minas Tirith
        self:AddOverlapLinks("0x700459AA", {"0x700459A9"}); -- War-stead
        self:AddOverlapLinks("0x70046CBF", {"0x70046CC0"}); -- After battle Minas Tirith
        self:AddOverlapLinks("0x70047075", {"0x70047080"}); -- Henneth Annûn
        self:AddOverlapLinks("0x70047076", {"0x7004707D"}); -- After battle Osgiliath
        self:AddOverlapLinks("0x70047BFC", {"0x70047BF4"}); -- Camp of the Host
        self:AddOverlapLinks("0x70047C23", {"0x70047C1B"}); -- Haerondir
        self:AddOverlapLinks("0x7004AE1F", {"0x7004AE1D"}); -- Udûn Foothold
        self:AddOverlapLinks("0x7004D73A", {"0x7004D738"}); -- Dale
        self:AddOverlapLinks("0x7004FACA", {"0x7004FAC3"}); -- Járnfast
        self:AddOverlapLinks("0x7004FACD", {"0x7004FAC5"}); -- Skarháld
        self:AddOverlapLinks("0x70052F0A", {"0x70041A22", "0x70052F12"}); -- Beorninghús
        self:AddOverlapLinks("0x70052F06", {"0x70052F04"}); -- Hultvís
        self:AddOverlapLinks("0x700551F2", {"0x700551F8"}); -- Estolad Lân
        self:AddOverlapLinks("0x70057635", {"0x70057629"}); -- Limlók
        self:AddOverlapLinks("0x70058572", {"0x7005856F"}); -- Annâk-khurfu
        self:AddOverlapLinks("0x70059D09", {"0x70059D0E"}); -- Trader's Wharf
        self:AddOverlapLinks("0x70059D10", {"0x70059D12"}); -- Trestlebridge
        self:AddOverlapLinks("0x7005AA8F", {"0x7005AA90"}); -- Akrâz-zahar
        self:AddOverlapLinks("0x7005AA8C", {"0x7005AA92"}); -- Azanulbizar
        self:AddOverlapLinks("0x7005D48A", {"0x7005D47C"}); -- Noble Gate
        self:AddOverlapLinks("0x7005D488", {"0x7005D484"}); -- Leitstáth
        self:AddOverlapLinks("0x70060EA5", {"0x70060EA8"}); -- Tornhad
        self:AddOverlapLinks("0x7006133E", {"0x70061340"}); -- Nobottle
        self:AddOverlapLinks("0x70063242", {"0x7006323D"}); -- Andrath
        self:AddOverlapLinks("0x700634B6", {"0x700634A4"}); -- Swanfleet
        self:AddOverlapLinks("0x700634AD", {"0x700634AE"}); -- Cardolan
        self:AddOverlapLinks("0x70064ACB", {"0x70064ACA"}); -- Carn Dûm
        self:AddOverlapLinks("0x70064F4D", {"0x70064F47"}); -- Clegur
        self:AddOverlapLinks("0x700658E8", {"0x700658EB"}); -- Pelargir
        self:AddOverlapLinks("0x7006870C", {"0x70068701"}); -- Jax Phanâl
        self:AddOverlapLinks("0x7006870F", {"0x700686FF"}); -- Umbar
        self:AddOverlapLinks("0x70068710", {"0x70068702"}); -- Halrax
        self:AddOverlapLinks("0x70068712", {"0x70068700"}); -- King's Dol Amroth
        self:AddOverlapLinks("0x70068715", {"0x70068703"}); -- Lond Cirion
        self:AddOverlapLinks("0x700697F3", {"0x700697F2"}); -- Bloody Eagle Tavern
    elseif PlayerClass == Turbine.Gameplay.Class.Mariner then
        self:AddOverlapLinks("0x70066105", {"0x70059D0E"}); -- Trader's Wharf
        self:AddOverlapLinks("0x70066109", {"0x7004707D"}); -- After-battle Osgiliath
        self:AddOverlapLinks("0x7006610C", {"0x7004D738"}); -- Lake-town
        self:AddOverlapLinks("0x70066117", {"0x700411AC"}); -- Dol Amroth
        self:AddOverlapLinks("0x7006611B", {"0x700658EB"}); -- Pelargir
        self:AddOverlapLinks("0x7006611E", {"0x70048C8C"}); -- Lothlórien
        self:AddOverlapLinks("0x70066121", {"0x70031A46"}); -- Snowbourn
        self:AddOverlapLinks("0x700687BB", {"0x700686FF"}); -- Umbar
        self:AddOverlapLinks("0x700687BD", {"0x70068703"}); -- Lond Cirion
        self:AddOverlapLinks("0x700687C0", {"0x70068701"}); -- Jax Phanâl
        self:AddOverlapLinks("0x700687C1", {"0x70068700"}); -- King's Dol Amroth
        self:AddOverlapLinks("0x700687C3", {"0x70068702"}); -- Halrax
    end
end

function OptionsPanel:EnableOverlapSkills(enable)
    self.disableUpdates = true;
    for id, group in pairs(self.overlapGroup) do
        for i = 1, #group do
            for j = 1, #self.checks do
                if self.checks[j].skillId == group[i] then
                    self.checks[j]:SetChecked(enable);
                    break
                end
            end
        end
    end
    self.disableUpdates = false;
    _G.travel:UpdateSettings(); -- force an update now
end

function OptionsPanel:EnableAll(enable)
    self.disableUpdates = true;
    for i = 1, #self.checks do
        self.checks[i]:SetChecked(enable);
    end
    self.disableUpdates = false;
    _G.travel:UpdateSettings(); -- force an update now
end

function OptionsPanel:EnableFromSettings()
    self.disableUpdates = true;
    for i = 1, #self.checks do
        local id = self.checks[i].skillId;
        self.checks[i]:SetChecked(Settings.enabled[id]);
    end
    self.disableUpdates = false;
    -- TravelWindow:UpdateSettings() will be called later
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
        _G.travel:UpdateSettings();
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
        _G.travel:UpdateSettings();

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
        _G.travel:UpdateSettings();

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
        _G.travel:UpdateSettings();
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
        _G.travel.dirty = true;
    end
end
