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

    -- create array of labels and check boxes
    self.labels = {};
    self.checks = {};

    -- keep track of which item is selected on the sort tab
    self.sortSelectedIndex = 1;

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
    self.OptionTabs:SetTabText(1, LC.generalTab);
    self.OptionTabs:SetTabText(2, LC.selectTab);
    self.OptionTabs:SetTabText(3, LC.sortTab);

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

    local labelWidth = 420;

    -- label for hide window on start option
    self.UseMinWindowLabel = Turbine.UI.Label();
    self.UseMinWindowLabel:SetSize(labelWidth, 20);
    self.UseMinWindowLabel:SetPosition(20, NextY(20));
    self.UseMinWindowLabel:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleLeft);
    self.UseMinWindowLabel:SetParent(self.GeneralTab);
    self.UseMinWindowLabel:SetText(LC.miniWindow);
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
    self.HideOnStartLabel:SetSize(labelWidth, 20);
    self.HideOnStartLabel:SetPosition(20, NextY(30));
    self.HideOnStartLabel:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleLeft);
    self.HideOnStartLabel:SetParent(self.GeneralTab);
    self.HideOnStartLabel:SetText(LC.hide);
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
    self.HideOnCombatLabel:SetSize(labelWidth, 20);
    self.HideOnCombatLabel:SetPosition(20, NextY(30));
    self.HideOnCombatLabel:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleLeft);
    self.HideOnCombatLabel:SetParent(self.GeneralTab);
    self.HideOnCombatLabel:SetText(LC.hideOnCombat);
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
    self.hideOnTravelLabel:SetSize(labelWidth, 20);
    self.hideOnTravelLabel:SetPosition(20, NextY(30));
    self.hideOnTravelLabel:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleLeft);
    self.hideOnTravelLabel:SetParent(self.GeneralTab);
    self.hideOnTravelLabel:SetText(LC.hideOnTravel);
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
    self.ignoreEscLabel:SetSize(labelWidth, 20);
    self.ignoreEscLabel:SetPosition(20, NextY(30));
    self.ignoreEscLabel:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleLeft);
    self.ignoreEscLabel:SetParent(self.GeneralTab);
    self.ignoreEscLabel:SetText(LC.ignoreEsc);
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
    self.ShowButtonLabel:SetSize(labelWidth, 20);
    self.ShowButtonLabel:SetPosition(20, NextY(30));
    self.ShowButtonLabel:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleLeft);
    self.ShowButtonLabel:SetParent(self.GeneralTab);
    self.ShowButtonLabel:SetText(LC.toggle);
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
    self.PulldownTravelLabel:SetSize(labelWidth, 20);
    self.PulldownTravelLabel:SetPosition(20, NextY(30));
    self.PulldownTravelLabel:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleLeft);
    self.PulldownTravelLabel:SetParent(self.GeneralTab);
    self.PulldownTravelLabel:SetText(LC.pulldownTravel);
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
    self.toggleSlidersLabel:SetSize(labelWidth, 20);
    self.toggleSlidersLabel:SetPosition(20, NextY(30));
    self.toggleSlidersLabel:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleLeft);
    self.toggleSlidersLabel:SetParent(self.GeneralTab);
    self.toggleSlidersLabel:SetText(LC.toggleSliders);
    self.toggleSlidersLabel:SetVisible(true);

    -- toggle button min slider label
    self.toggleMinSlidersLabel = Turbine.UI.Label();
    self.toggleMinSlidersLabel:SetSize(50, 20);
    self.toggleMinSlidersLabel:SetPosition(20, NextY(20));
    self.toggleMinSlidersLabel:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleLeft);
    self.toggleMinSlidersLabel:SetParent(self.GeneralTab);
    self.toggleMinSlidersLabel:SetText(LC.min);
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
    self.toggleMaxSlidersLabel:SetText(LC.max);
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
    self.SlidersLabel:SetSize(labelWidth, 20);
    self.SlidersLabel:SetPosition(20, NextY(25));
    self.SlidersLabel:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleLeft);
    self.SlidersLabel:SetParent(self.GeneralTab);
    self.SlidersLabel:SetText(LC.mainSliders);
    self.SlidersLabel:SetVisible(true);

    -- main window min slider label
    self.mainMinSlidersLabel = Turbine.UI.Label();
    self.mainMinSlidersLabel:SetSize(50, 20);
    self.mainMinSlidersLabel:SetPosition(20, NextY(20));
    self.mainMinSlidersLabel:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleLeft);
    self.mainMinSlidersLabel:SetParent(self.GeneralTab);
    self.mainMinSlidersLabel:SetText(LC.min);
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
    self.mainMaxSlidersLabel:SetText(LC.max);
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

    -- fade out delay slider label
    self.fadeDelaySlidersLabel = Turbine.UI.Label();
    self.fadeDelaySlidersLabel:SetSize(labelWidth, 20);
    self.fadeDelaySlidersLabel:SetPosition(20, NextY(25));
    self.fadeDelaySlidersLabel:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleLeft);
    self.fadeDelaySlidersLabel:SetParent(self.GeneralTab);
    self.fadeDelaySlidersLabel:SetText(LC.fadeDelay);
    self.fadeDelaySlidersLabel:SetVisible(true);

    -- fade out delay slider
    self.fadeDelayScrollBar = Turbine.UI.Lotro.ScrollBar();
    self.fadeDelayScrollBar:SetOrientation(Turbine.UI.Orientation.Horizontal);
    self.fadeDelayScrollBar:SetSize(450, 10);
    self.fadeDelayScrollBar:SetPosition(20, NextY(25));
    self.fadeDelayScrollBar:SetMinimum(0);
    self.fadeDelayScrollBar:SetMaximum(100);
    self.fadeDelayScrollBar:SetValue(Settings.fadeOutDelay);
    self.fadeDelayScrollBar:SetParent(self.GeneralTab);

    -- fade out slider label
    self.mainFadeSlidersLabel = Turbine.UI.Label();
    self.mainFadeSlidersLabel:SetSize(labelWidth, 20);
    self.mainFadeSlidersLabel:SetPosition(20, NextY(25));
    self.mainFadeSlidersLabel:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleLeft);
    self.mainFadeSlidersLabel:SetParent(self.GeneralTab);
    self.mainFadeSlidersLabel:SetText(LC.fadeSpeed);
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

    self:UpdateSettings();

    -- reset all setting button
    self.resetButton = Turbine.UI.Lotro.Button();
    self.resetButton:SetSize(220, 20);
    self.resetButton:SetPosition(20, 690);
    self.resetButton:SetText(LC.resetSettings);
    self.resetButton:SetParent(self.GeneralTab);
    self.resetButton:SetVisible(true);
    self.resetButton.Click = function(sender, args)
        _G.travel:ResetSettings();
    end

    if (PlayerAlignment == Turbine.Gameplay.Alignment.FreePeople) then
        self.saveGlobal = Turbine.UI.Lotro.Button();
        self.saveGlobal:SetSize(220, 20);
        self.saveGlobal:SetPosition(250, 690);
        self.saveGlobal:SetText(LC.saveGlobalDefaults);
        self.saveGlobal:SetParent(self.GeneralTab);
        self.saveGlobal:SetVisible(true);
        self.saveGlobal.Click = function(sender, args)
            SaveSettings(Turbine.DataScope.Account);
        end

        self.loadGlobal = Turbine.UI.Lotro.Button();
        self.loadGlobal:SetSize(220, 20);
        self.loadGlobal:SetPosition(480, 690);
        self.loadGlobal:SetText(LC.loadGlobalDefaults);
        self.loadGlobal:SetParent(self.GeneralTab);
        self.loadGlobal:SetVisible(true);
        self.loadGlobal.Click = function(sender, args)
            SetSettings(AccountSettingsStrings, Turbine.DataScope.Account);
            for i = 1, #TravelShortcuts do
                TravelShortcuts[i]:InitOrder();
                TravelShortcuts[i]:InitEnabled();
            end
            ClearLoaders();
            SortShortcuts();
            SyncUIFromSettings();
        end
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

    self.fadeDelayScrollBar.ValueChanged = function(sender, args)
        Settings.fadeOutDelay = self.fadeDelayScrollBar:GetValue();
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
    self.fadeDelayScrollBar:SetValue(Settings.fadeOutDelay);
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
        self:AddSkillItemForEnabling(TravelInfo.racial);
    end

    if (PlayerAlignment == Turbine.Gameplay.Alignment.MonsterPlayer) then
        -- add the creep travel skills
        self:AddSkillsForEnabling(TravelInfo.creep);
    end
end

function OptionsPanel:AddSkillsForEnabling(skills)
    if skills == nil then return end
    for i = 1, skills:GetCount() do
        self:AddSkillItemForEnabling(skills:Skill(i));
    end
end

-- add a single shortcut to the enabled tab at the given location
function OptionsPanel:AddSkillItemForEnabling(skill)
    local control = Turbine.UI.Label();
    control:SetSize(self.ListBox:GetWidth() - 20, 20);

    -- create the label for the shortcut setting
    local slabel = Turbine.UI.Label();
    slabel:SetSize(control:GetWidth() - 20, 20);
    slabel:SetPosition(30, 0)
    slabel:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleLeft);
    slabel:SetParent(control);
    slabel:SetText(skill.label);
    slabel:SetVisible(true);
    table.insert(self.labels, slabel);

    -- create the checkbox for the shortcut setting
    local check = Turbine.UI.Lotro.CheckBox();
    check:SetSize(19, 19);
    check:SetPosition(10, 0);
    check:SetChecked(skill.shortcut:IsEnabled());
    check:SetParent(control);
    check:SetVisible(true);
    check.skill = skill;
    table.insert(self.checks, check);
    self.ListBox:AddItem(control)

    -- handle the event of the check box value changing
    check.CheckedChanged = function(sender, args)
        -- change the setting on the main window
        skill.shortcut:SetEnabled(sender:IsChecked());

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
        self.genLabel:SetText(LC.genericLabel);
        self.genLabel:SetParent(self.EnabledTab);
        self.genLabel:SetVisible(true);

        -- add a label and box for the reputation travel skills
        self.repLabel = Turbine.UI.Label();
        self.repLabel:SetSize(200, 20);
        self.repLabel:SetPosition(260, 0);
        self.repLabel:SetTextAlignment(Turbine.UI.ContentAlignment.BottomLeft);
        self.repLabel:SetFont(Turbine.UI.Lotro.Font.Verdana16);
        self.repLabel:SetText(LC.repLabel);
        self.repLabel:SetParent(self.EnabledTab);
        self.repLabel:SetVisible(true);

        -- if the player is a hunter or warden, add a label
        if ((PlayerClass == Turbine.Gameplay.Class.Hunter) or (PlayerClass == Turbine.Gameplay.Class.Warden)) then
            self.classLabel = Turbine.UI.Label();
            self.classLabel:SetSize(200, 20);
            self.classLabel:SetPosition(520, 0);
            self.classLabel:SetTextAlignment(Turbine.UI.ContentAlignment.BottomLeft);
            self.classLabel:SetFont(Turbine.UI.Lotro.Font.Verdana16);
            self.classLabel:SetText(LC.classLabel);
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
        self.genLabel:SetText(LC.genericLabel);
        self.genLabel:SetParent(self.EnabledTab);
        self.genLabel:SetVisible(true);

    end
    --]]

    -- add a check skills button
    self.checkSkillsButton = Turbine.UI.Lotro.Button();
    self.checkSkillsButton:SetSize(200, 20);
    self.checkSkillsButton:SetPosition(300, self.EnabledTab:GetHeight() - 50);
    self.checkSkillsButton:SetText(LC.checkSkills);
    self.checkSkillsButton:SetParent(self.EnabledTab);
    self.checkSkillsButton:SetVisible(true);

    -- do the check skills
    self.checkSkillsButton.Click = function(sender, args)
        CheckSkills(true);
    end

    if TravelInfo:GetClassSkills() ~= nil then
        -- add an enable overlapping skills button
        self.enableRepSkillsButton = Turbine.UI.Lotro.Button();
        self.enableRepSkillsButton:SetSize(200, 20);
        self.enableRepSkillsButton:SetPosition(520, 90);
        self.enableRepSkillsButton:SetText(LC.enableRepSkills);
        self.enableRepSkillsButton:SetParent(self.EnabledTab);
        self.enableRepSkillsButton:SetVisible(true);

        self.enableRepSkillsButton.Click = function(sender, args)
            self:EnableOverlapSkills(true);
        end

        -- add a disable overlapping skills button
        self.disableRepSkillsButton = Turbine.UI.Lotro.Button();
        self.disableRepSkillsButton:SetSize(200, 20);
        self.disableRepSkillsButton:SetPosition(520, 120);
        self.disableRepSkillsButton:SetText(LC.disableRepSkills);
        self.disableRepSkillsButton:SetParent(self.EnabledTab);
        self.disableRepSkillsButton:SetVisible(true);

        self.disableRepSkillsButton.Click = function(sender, args)
            self:EnableOverlapSkills(false);
        end
    end

    self.enableAllButton = Turbine.UI.Lotro.Button();
    self.enableAllButton:SetSize(200, 20);
    self.enableAllButton:SetPosition(520, 30);
    self.enableAllButton:SetText(LC.enableAll);
    self.enableAllButton:SetParent(self.EnabledTab);
    self.enableAllButton:SetVisible(true);

    self.enableAllButton.Click = function(sender, args)
        self:EnableAll(true);
    end

    self.disableAllButton = Turbine.UI.Lotro.Button();
    self.disableAllButton:SetSize(200, 20);
    self.disableAllButton:SetPosition(520, 60);
    self.disableAllButton:SetText(LC.disableAll);
    self.disableAllButton:SetParent(self.EnabledTab);
    self.disableAllButton:SetVisible(true);

    self.disableAllButton.Click = function(sender, args)
        self:EnableAll(false);
    end
end

function OptionsPanel:EnableOverlapSkills(enable)
    local skills = TravelInfo:GetClassSkills().skills
    self.disableUpdates = true;
    for i = 1, #skills do
        local group = skills[i].overlap
        if group ~= nil then
            for k = 1, #group do
                for j = 1, #self.checks do
                    if self.checks[j].skill:GetData() == group[k] then
                        self.checks[j]:SetChecked(enable);
                        break
                    end
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
        local shortcut = self.checks[i].skill.shortcut;
        self.checks[i]:SetChecked(shortcut:IsEnabled());
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

    -- create a label to add to the listbox for each shortcut
    for _, shortcut in pairs(TravelShortcuts) do
        if shortcut:GetTravelType() ~= 8 then
            local tempLabel = Turbine.UI.Label();
            tempLabel:SetText(shortcut:GetLabel());
            tempLabel:SetSize(280, 20);
            tempLabel:SetBackColor(Turbine.UI.Color(DefAlpha, 0.1, 0.1, 0.1));
            tempLabel:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleLeft);
            tempLabel:SetZOrder(90);
            tempLabel.shortcut = shortcut;

            -- highlight the item that is selected by changing the colour of the
            -- the label when it is clicked
            tempLabel.MouseClick = function(sender, args)
                self.sortListBox:GetItem(self.sortSelectedIndex):SetBackColor(Turbine.UI.Color(DefAlpha, 0.1, 0.1, 0.1));
                sender:SetBackColor(Turbine.UI.Color(0.95, 0.1, 0.1, 0.6));
                self.sortSelectedIndex = self.sortListBox:IndexOfItem(sender);
            end

            -- add the item to the list box
            self.sortListBox:AddItem(tempLabel);
        end
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
    self.moveUpButton:SetText(LC.moveUp);
    self.moveUpButton:SetParent(self.SortTab);
    self.moveUpButton:SetVisible(true);

    self.moveDownButton = Turbine.UI.Lotro.Button();
    self.moveDownButton:SetSize(185, 20);
    self.moveDownButton:SetPosition(10, 265);
    self.moveDownButton:SetText(LC.moveDown);
    self.moveDownButton:SetParent(self.SortTab);
    self.moveDownButton:SetVisible(true);

    self.moveTopButton = Turbine.UI.Lotro.Button();
    self.moveTopButton:SetSize(185, 20);
    self.moveTopButton:SetPosition(10, 155);
    self.moveTopButton:SetText(LC.moveTop);
    self.moveTopButton:SetParent(self.SortTab);
    self.moveTopButton:SetVisible(true);

    self.moveBottomButton = Turbine.UI.Lotro.Button();
    self.moveBottomButton:SetSize(185, 20);
    self.moveBottomButton:SetPosition(10, 315);
    self.moveBottomButton:SetText(LC.moveBottom);
    self.moveBottomButton:SetParent(self.SortTab);
    self.moveBottomButton:SetVisible(true);

    self.moveUpChunkButton = Turbine.UI.Lotro.Button();
    self.moveUpChunkButton:SetSize(185, 20);
    self.moveUpChunkButton:SetPosition(10, 180);
    self.moveUpChunkButton:SetText(LC.moveUpChunk);
    self.moveUpChunkButton:SetParent(self.SortTab);
    self.moveUpChunkButton:SetVisible(true);

    self.moveDownChunkButton = Turbine.UI.Lotro.Button();
    self.moveDownChunkButton:SetSize(185, 20);
    self.moveDownChunkButton:SetPosition(10, 290);
    self.moveDownChunkButton:SetText(LC.moveDownChunk);
    self.moveDownChunkButton:SetParent(self.SortTab);
    self.moveDownChunkButton:SetVisible(true);

    self.defaultSortButton = Turbine.UI.Lotro.Button();
    self.defaultSortButton:SetSize(185, 20);
    self.defaultSortButton:SetPosition(10, 375);
    self.defaultSortButton:SetText(LC.defaultSort);
    self.defaultSortButton:SetParent(self.SortTab);
    self.defaultSortButton:SetVisible(true);

    self.nameSortButton = Turbine.UI.Lotro.Button();
    self.nameSortButton:SetSize(185, 20);
    self.nameSortButton:SetPosition(10, 405);
    self.nameSortButton:SetText(LC.sortName);
    self.nameSortButton:SetParent(self.SortTab);
    self.nameSortButton:SetVisible(true);

    self.labelSortButton = Turbine.UI.Lotro.Button();
    self.labelSortButton:SetSize(185, 20);
    self.labelSortButton:SetPosition(10, 435);
    self.labelSortButton:SetText(LC.sortLabel);
    self.labelSortButton:SetParent(self.SortTab);
    self.labelSortButton:SetVisible(true);

    self.defaultSortButton.Click = function(sender, args)
        SortByDefault();
        self:AddSortList();
        _G.travel.dirty = true;
        _G.travel:UpdateSettings();
    end

    self.nameSortButton.Click = function(sender, args)
        SortByName();
        self:AddSortList();
        _G.travel.dirty = true;
        _G.travel:UpdateSettings();
    end

    self.labelSortButton.Click = function(sender, args)
        SortByLabel();
        self:AddSortList();
        _G.travel.dirty = true;
        _G.travel:UpdateSettings();
    end

    -- handle the move to top button click
    self.moveTopButton.Click = function(sender, args)
        -- loop while selected item is not already at the top
        while (self.sortSelectedIndex > 1) do
            self:SwapShortcuts(self.sortSelectedIndex - 1);
        end

        -- update the main window shortcuts and settings
        _G.travel:UpdateSettings();
    end

    self.moveUpChunkButton.Click = function(sender, args)
        -- exit if the selected item is already at the top
        local chunks = 10
        while chunks > 0 and self.sortSelectedIndex > 1 do
            self:SwapShortcuts(self.sortSelectedIndex - 1);
            chunks = chunks - 1
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

        self:SwapShortcuts(self.sortSelectedIndex - 1);

        -- update the main window shortcuts and settings
        _G.travel:UpdateSettings();
    end

    -- handle the move down button click
    self.moveDownButton.Click = function(sender, args)
        -- exit if the selected item is already at the bottom
        local maxItems = self.sortListBox:GetItemCount()
        if (self.sortSelectedIndex == maxItems) then
            return;
        end

        self:SwapShortcuts(self.sortSelectedIndex + 1);

        -- update the main window shortcuts and settings
        _G.travel:UpdateSettings();
    end

    self.moveDownChunkButton.Click = function(sender, args)
        -- exit if the selected item is already at the bottom
        local chunks = 10
        local maxItems = self.sortListBox:GetItemCount()
        while chunks > 0 and self.sortSelectedIndex < maxItems do
            self:SwapShortcuts(self.sortSelectedIndex + 1);
            chunks = chunks - 1
        end

        -- update the main window shortcuts and settings
        _G.travel:UpdateSettings();
    end

    -- handle the move to bottom button
    self.moveBottomButton.Click = function(sender, args)
        -- loop while the selected item is not at the bottom of the list
        local maxItems = self.sortListBox:GetItemCount()
        while (self.sortSelectedIndex < maxItems) do
            self:SwapShortcuts(self.sortSelectedIndex + 1);
        end

        -- update the main window shortcuts and settings
        _G.travel:UpdateSettings();
    end
end

-- function to perform the actual swap of shortcuts
function OptionsPanel:SwapShortcuts(second)
    local first = self.sortSelectedIndex
    local item1 = self.sortListBox:GetItem(first)
    local shortcut1 = item1.shortcut
    local shortcut2 = self.sortListBox:GetItem(second).shortcut
    self.sortListBox:RemoveItemAt(first)
    self.sortListBox:InsertItem(second, item1)
    self.sortSelectedIndex = second

    first = shortcut1.Index
    second = shortcut2.Index
    shortcut1:SetIndex(second)
    shortcut2:SetIndex(first)
    TravelShortcuts[first] = shortcut2
    TravelShortcuts[second] = shortcut1

    _G.travel.dirty = true
end
