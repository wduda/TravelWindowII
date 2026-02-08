import "Turbine.Gameplay"
import "Turbine.UI"
import "Turbine.UI.Lotro"
import "TravelWindowII.src.extensions"
import "TravelWindowII.src.utils.FontMetric"
import "TravelWindowII.src.utils.BitOps"

FindTreeNode = class(Turbine.UI.TreeNode)
function FindTreeNode:Constructor(width, text, top)
	Turbine.UI.TreeNode.Constructor(self)

    local height = 16
    self.expanded = false

    if top then
        self.icon = Turbine.UI.Control()
        self.icon:SetParent(self)
        self.icon:SetSize(16, 16)
        self.icon:SetBackground(0x41007E27)
        self.icon:SetMouseVisible(false)
    else
        local fm = TravelWindowII.src.utils.FontMetric()
        -- NOTE: if self.label sets a non-default Font
        -- update fm with that font
        height = fm:GetTextHeight(text, width)
    end

    self:SetSize(width, height + 8)

    self.label = Turbine.UI.Label()
    self.label:SetParent(self)
    self.label:SetTop(2)
    self.label:SetLeft(self.icon and 27 or 10)
    self.label:SetSize(width, height)
    self.label:SetMouseVisible(false)
    self.label:SetTextAlignment(Turbine.UI.ContentAlignment.TopLeft)
    self.label:SetMultiline(true)
    self.label:SetText(text)
end

function FindTreeNode:SetExpanded(expand)
    self.expanded = expand
    Turbine.UI.TreeNode.SetExpanded(self, expand)
    self.icon:SetBackground(expand and 0x41007E26 or 0x41007E27)
end

-- handles node updates when clicked by the user
function FindTreeNode:VisibleChanged(sender, args)
    local parent = self:GetParentNode()
    if parent ~= nil and parent.icon ~= nil and parent.expanded ~= parent:IsExpanded() then
        parent.expanded = parent:IsExpanded()
        parent.icon:SetBackground(parent.expanded and 0x41007E26 or 0x41007E27)
    end
end

OptionsPanel = class(Turbine.UI.Control);

function OptionsPanel:Constructor()
    Turbine.UI.Control.Constructor(self);

    --  add a check to see if we load completely
    self.disableUpdates = false;

    self.labelWidth = 420
    self.checkOffset = 450

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
    self.GeneralTab = Turbine.UI.Control()
    self.EnabledTab = Turbine.UI.Control()
    self.SortTab = Turbine.UI.Control()
    self.FindTab = Turbine.UI.Control()

    -- populate each tab
    self:SetupGeneralTab()
    self:SetupEnabledTab()
    self:SetupSortTab()
    self:SetupFindTab()

    -- add the tabs
    self.OptionTabs:AddTab(self.GeneralTab)
    self.OptionTabs:AddTab(self.EnabledTab)
    self.OptionTabs:AddTab(self.SortTab)
    self.OptionTabs:AddTab(self.FindTab)

    -- name the tabs
    self.OptionTabs:SetTabText(1, LC.generalTab)
    self.OptionTabs:SetTabText(2, LC.selectTab)
    self.OptionTabs:SetTabText(3, LC.sortTab)
    self.OptionTabs:SetTabText(4, LC.findTab)

    self:SetVisible(true);
end

function OptionsPanel:NextY(offset)
    self.optionHeight = self.optionHeight + offset;
    return self.optionHeight;
end

function OptionsPanel:AddCheckBoxOption(name, x, spacerY, changed, update)
    local nameLabel = name .. "Label"
    local y = self:NextY(spacerY)

    self[nameLabel] = Turbine.UI.Label()
    self[nameLabel]:SetSize(self.labelWidth, 20)
    self[nameLabel]:SetPosition(x, y)
    self[nameLabel]:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleLeft)
    self[nameLabel]:SetParent(self.GeneralTab)
    self[nameLabel]:SetText(LC[name])
    self[nameLabel]:SetVisible(true)

    self.options[name] = Turbine.UI.Lotro.CheckBox()
    self.options[name]:SetSize(19, 19)
    self.options[name]:SetPosition(self.checkOffset, y)
    self.options[name]:SetParent(self.GeneralTab)
    self.options[name]:SetVisible(true)
    if changed ~= nil then
        self.options[name].CheckedChangedFunc = changed
    else
        self.options[name].CheckedChangedFunc = function(sender, args)
            if sender:IsChecked() then
                Settings[name] = 1
            else
                Settings[name] = 0
            end
        end
    end
    if update ~= nil then
        self.options[name].UpdateOption = update
     else
         self.options[name].UpdateOption = function()
             self.options[name]:SetChecked(Settings[name] == 1)
         end
     end
     self.options[name]:UpdateOption()
end

function OptionsPanel:AddMinMaxSliderOption(name, nameMin, nameMax, x, spacerY, minFunc, maxFunc)
    local nameLabel = name .. "Label"
    local nameMinLabel = nameMin .. "Label"
    local nameMaxLabel = nameMax .. "Label"

    self[nameLabel] = Turbine.UI.Label()
    self[nameLabel]:SetSize(self.labelWidth, 20)
    self[nameLabel]:SetPosition(x, self:NextY(spacerY))
    self[nameLabel]:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleLeft)
    self[nameLabel]:SetParent(self.GeneralTab)
    self[nameLabel]:SetText(LC[name])
    self[nameLabel]:SetVisible(true)

    self[nameMinLabel] = Turbine.UI.Label()
    self[nameMinLabel]:SetSize(50, 20)
    self[nameMinLabel]:SetPosition(x, self:NextY(20))
    self[nameMinLabel]:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleLeft)
    self[nameMinLabel]:SetParent(self.GeneralTab)
    self[nameMinLabel]:SetText(LC.min)
    self[nameMinLabel]:SetVisible(true)

    self.options[nameMin] = Turbine.UI.Lotro.ScrollBar()
    self.options[nameMin]:SetOrientation(Turbine.UI.Orientation.Horizontal)
    self.options[nameMin]:SetSize(400, 10)
    self.options[nameMin]:SetPosition(x + 50, self:NextY(5))
    self.options[nameMin]:SetMinimum(0)
    self.options[nameMin]:SetMaximum(100)
    self.options[nameMin]:SetParent(self.GeneralTab)
    self.options[nameMin].ValueChangedFunc = minFunc
    self.options[nameMin].UpdateOption = function()
        local value = Settings[nameMin]
        if value ~= nil then
            self.options[nameMin]:SetValue(value * 100)
        else
            self.options[nameMin]:SetValue(50)  -- Default to 50% if not set
        end
    end
    self.options[nameMin]:UpdateOption()

    self[nameMaxLabel] = Turbine.UI.Label()
    self[nameMaxLabel]:SetSize(50, 20)
    self[nameMaxLabel]:SetPosition(x, self:NextY(15))
    self[nameMaxLabel]:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleLeft)
    self[nameMaxLabel]:SetParent(self.GeneralTab)
    self[nameMaxLabel]:SetText(LC.max)
    self[nameMaxLabel]:SetVisible(true)

    self.options[nameMax] = Turbine.UI.Lotro.ScrollBar()
    self.options[nameMax]:SetOrientation(Turbine.UI.Orientation.Horizontal)
    self.options[nameMax]:SetSize(400, 10)
    self.options[nameMax]:SetPosition(x + 50, self:NextY(5))
    self.options[nameMax]:SetMinimum(0)
    self.options[nameMax]:SetMaximum(100)
    self.options[nameMax]:SetParent(self.GeneralTab)
    self.options[nameMax].ValueChangedFunc = maxFunc
    self.options[nameMax].UpdateOption = function()
        local value = Settings[nameMax]
        if value ~= nil then
            self.options[nameMax]:SetValue(value * 100)
        else
            self.options[nameMax]:SetValue(100)  -- Default to 100% if not set
        end
    end
    self.options[nameMax]:UpdateOption()
end

function OptionsPanel:AddSliderOption(name, min, max, x, spacerY, change)
    local nameLabel = name .. "Label"

    self[nameLabel] = Turbine.UI.Label()
    self[nameLabel]:SetSize(self.labelWidth, 20)
    self[nameLabel]:SetPosition(x, self:NextY(spacerY))
    self[nameLabel]:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleLeft)
    self[nameLabel]:SetParent(self.GeneralTab)
    self[nameLabel]:SetText(LC[name])
    self[nameLabel]:SetVisible(true)

    self.options[name] = Turbine.UI.Lotro.ScrollBar()
    self.options[name]:SetOrientation(Turbine.UI.Orientation.Horizontal)
    self.options[name]:SetSize(450, 10)
    self.options[name]:SetPosition(x, self:NextY(25))
    self.options[name]:SetMinimum(min)
    self.options[name]:SetMaximum(max)
    self.options[name]:SetParent(self.GeneralTab)
    self.options[name].ValueChangedFunc = change
    self.options[name].UpdateOption = function()
        self.options[name]:SetValue(Settings[name])
    end
    self.options[name]:UpdateOption()
end

function OptionsPanel:SetupGeneralTab()
    self.optionHeight = 0
    self.options = {}

    -- Flag to prevent recursive CheckedChanged events when programmatically updating mode radios
    self.updatingModeRadios = false

    -- Mode selection radio button group
    local modeLabel = Turbine.UI.Label()
    modeLabel:SetParent(self.GeneralTab)
    local labelY = self:NextY(30)
    modeLabel:SetPosition(20, labelY)
    modeLabel:SetSize(self.labelWidth, 20)
    modeLabel:SetText(LC.menuMode)
    modeLabel:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleLeft)
    self.modeLabel = modeLabel

    -- Array of mode configurations: {TabId, LocalizedLabel, XPosition}
    local modeConfigs = {
        {TabId.LIST, LC.menuText, 100},
        {TabId.GRID, LC.menuIcon, 190},
        {TabId.CARO, LC.menuCaro, 280},
        {TabId.PULL, LC.menuPull, 370},
        {TabId.MAP, LC.menuMap, 460}
    }

    -- Store radio buttons for later access
    self.modeRadioButtons = {}
    local radioY = labelY

    for i, config in ipairs(modeConfigs) do
        local tabId, label, xPos = config[1], config[2], config[3]

        local radio = Turbine.UI.Lotro.CheckBox()
        radio:SetParent(self.GeneralTab)
        radio:SetPosition(xPos, radioY)
        radio:SetSize(85, 20)
        radio:SetText(label)
        radio:SetCheckAlignment(Turbine.UI.ContentAlignment.MiddleLeft)

        -- Store the TabId value on the radio button for later retrieval
        radio.modeValue = tabId

        -- Set change handler (will be enabled after initialization)
        radio.CheckedChangedFunc = function(sender, args)
            -- Ignore programmatic changes to prevent infinite loops
            if self.updatingModeRadios then
                return
            end

            if sender:IsChecked() then
                -- Update Settings.mode
                Settings.mode = sender.modeValue

                -- Uncheck other radio buttons in the group (with flag to prevent recursion)
                self.updatingModeRadios = true
                for _, otherRadio in ipairs(self.modeRadioButtons) do
                    if otherRadio ~= sender then
                        otherRadio:SetChecked(false)
                    end
                end
                self.updatingModeRadios = false

                -- Update context menu checkmarks
                Menu:SetSelections()

                -- Update the travel window
                _G.travel.dirty = true
                _G.travel:UpdateSettings()
            else
                -- Prevent deselection - a radio button must always be selected
                self.updatingModeRadios = true
                sender:SetChecked(true)
                self.updatingModeRadios = false
            end
        end

        -- Set update function to read from Settings
        radio.UpdateOption = function()
            radio:SetChecked(Settings.mode == radio.modeValue)
        end
        radio:UpdateOption()

        self.modeRadioButtons[i] = radio
        self.options["mode" .. tabId] = radio
    end

    -- Increment Y position for next control
    self:NextY(10)

    self:AddCheckBoxOption("useMinWindow", 20, 20,
        function(sender, args)
            if sender:IsChecked() then
                Settings.useMinWindow = 1
            else
                Settings.useMinWindow = 0
            end
            local show = _G.travel:IsVisible()
            if _G.update ~= nil and _G.update:IsVisible() then
                _G.update:Close()
                _G.update = nil
            end
            _G.travel:Close()
            _G.travel = TravelWindow()
            _G.travel:SetVisible(show)
            _G.options:Close()
            _G.options = TravelWindowII.src.OptionsWindow()
            _G.options:SetVisible(true)
        end)
    self:AddCheckBoxOption("hideOnStart", 20, 30)
    self:AddCheckBoxOption("hideOnCombat", 20, 30)
    self:AddCheckBoxOption("hideOnTravel", 20, 30)
    self:AddCheckBoxOption("escapeToClose", 20, 30)
    self:AddCheckBoxOption("showButton", 20, 30,
        function(sender, args)
            if (sender:IsChecked()) then
                Settings.showButton = 1
            else
                Settings.showButton = 0
            end
            ToggleButton:SetVisible(sender:IsChecked())
        end)
    self:AddCheckBoxOption("pulldownTravel", 20, 30)
    self:AddCheckBoxOption("useZoneNames", 20, 30,
        function(sender, args)
            if sender:IsChecked() then
                Settings.useZoneNames = 1
            else
                Settings.useZoneNames = 0
            end
            TravelInfo:SetSkillLabels()
            _G.travel:ReloadLabels()
        end)
    self:AddCheckBoxOption("useSkillNames", 20, 30,
        function(sender, args)
            if sender:IsChecked() then
                Settings.useSkillNames = 1
            else
                Settings.useSkillNames = 0
            end
            TravelInfo:SetSkillLabels()
            _G.travel:ReloadLabels()
        end)
    self:AddCheckBoxOption("useTagInListTab", 20, 30,
        function(sender, args)
            if sender:IsChecked() then
                Settings.useTagInListTab = 1
            else
                Settings.useTagInListTab = 0
            end
            TravelInfo:SetSkillLabels()
            _G.travel.ListTab:ReloadLabels()
            _G.travel.PullTab.pulldown:ReloadLabels()
        end)
    self:AddCheckBoxOption("lockUI", 20, 30,
        function(sender, args)
            if sender:IsChecked() then
                Settings.lockUI = 1
            else
                Settings.lockUI = 0
            end
            self:UpdateOptions()
        end)
    self:AddCheckBoxOption("unlockKeyPress", 50, 30,
        function(sender, args)
            if sender:IsChecked() then
                Settings.unlockKeyPress = 1
            else
                Settings.unlockKeyPress = 0
            end
            self:UpdateOptions()
        end,
        function()
            self.options["unlockKeyPress"]:SetEnabled(Settings.lockUI == 1);
            self.options["unlockKeyPress"]:SetChecked(Settings.unlockKeyPress == 1);
        end)
    self:AddMinMaxSliderOption("toggleSliders", "toggleMinOpacity", "toggleMaxOpacity", 20, 30,
        function(sender, args)
            local minSlider = self.options["toggleMinOpacity"]
            local maxSlider = self.options["toggleMaxOpacity"]

            -- check that the min opacity does not go higher than the max opacity
            if minSlider:GetValue() > maxSlider:GetValue() then
                minSlider:SetValue(maxSlider:GetValue())
            end

            -- do updates
            Settings.toggleMinOpacity = minSlider:GetValue() / 100
            _G.travel:UpdateOpacity();
        end,
        function(sender, args)
            local minSlider = self.options["toggleMinOpacity"]
            local maxSlider = self.options["toggleMaxOpacity"]

            -- check that the max opacity does not go lower than the min opacity
            if maxSlider:GetValue() < minSlider:GetValue() then
                maxSlider:SetValue(minSlider:GetValue())
            end

            -- do updates
            Settings.toggleMaxOpacity = maxSlider:GetValue() / 100
            _G.travel:UpdateOpacity()

        end)
    self:AddMinMaxSliderOption("mainSliders", "mainMinOpacity", "mainMaxOpacity", 20, 25,
        function(sender, args)
            local minSlider = self.options["mainMinOpacity"]
            local maxSlider = self.options["mainMaxOpacity"]

            -- check that the min opacity does not go higher than the max opacity
            if minSlider:GetValue() > maxSlider:GetValue() then
                minSlider:SetValue(maxSlider:GetValue())
            end

            -- do updates
            Settings.mainMinOpacity = minSlider:GetValue() / 100
            _G.travel:UpdateOpacity()
        end,
        function(sender, args)
            local minSlider = self.options["mainMinOpacity"]
            local maxSlider = self.options["mainMaxOpacity"]

            -- check that the max opacity does not go lower than the min opacity
            if maxSlider:GetValue() < minSlider:GetValue() then
                maxSlider:SetValue(minSlider:GetValue())
            end

            -- do updates
            Settings.mainMaxOpacity = maxSlider:GetValue() / 100
            _G.travel:UpdateOpacity()
        end)
    self:AddSliderOption("fadeOutDelay", 0, 100, 20, 25,
        function(sender, args)
            Settings.fadeOutDelay = self.options["fadeOutDelay"]:GetValue()
        end)
    self:AddSliderOption("fadeOutSteps", 1, 151, 20, 25,
        function(sender, args)
            Settings.fadeOutSteps = self.options["fadeOutSteps"]:GetValue()
            _G.travel:UpdateOpacity()
        end)

    -- enable changed methods until after all options are initialized
    for _, v in pairs(self.options) do
        if v.CheckedChangedFunc ~= nil then
            v.CheckedChanged = v.CheckedChangedFunc
            v.CheckedChangedFunc = nil
        elseif v.ValueChangedFunc ~= nil then
            v.ValueChanged = v.ValueChangedFunc
            v.ValueChangedFunc = nil
        end
    end

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
        self.saveGlobal.Click = function(_, _)
            SaveSettings(Turbine.DataScope.Account);
        end

        self.loadGlobal = Turbine.UI.Lotro.Button();
        self.loadGlobal:SetSize(220, 20);
        self.loadGlobal:SetPosition(480, 690);
        self.loadGlobal:SetText(LC.loadGlobalDefaults);
        self.loadGlobal:SetParent(self.GeneralTab);
        self.loadGlobal:SetVisible(true);
        self.loadGlobal.Click = function(_, _)
            SetSettings(AccountSettingsStrings, Turbine.DataScope.Account);
            for i = 1, #TravelShortcuts do
                TravelShortcuts[i]:InitOrder();
                TravelShortcuts[i]:InitEnabled();
            end
            ClearLoaders()
            SortShortcuts(TravelShortcuts)
            SyncUIFromSettings()
        end
    end
end

function OptionsPanel:UpdateOptions()
    for _, v in pairs(self.options) do
        v:UpdateOption()
    end
end

function OptionsPanel:AddEnabledSection(skills)
    if skills == nil then return end

    -- add a title label
    local label = Turbine.UI.Label()
    label:SetSize(self.ListBox:GetWidth() - 20, 20)
    label:SetTextAlignment(Turbine.UI.ContentAlignment.LeftCenter)
    label:SetFont(Turbine.UI.Lotro.Font.VerdanaBold16)
    label:SetText(skills.title)
    label:SetVisible(true)
    self.ListBox:AddItem(label)
    self:AddSkillsForEnabling(skills)
end

function OptionsPanel:AddSkillsForEnabling(skills)
    if skills == TravelInfo.racials then
        self:AddSkillItemForEnabling(TravelInfo.racial);
    else
        for i = 1, skills:GetCount() do
            self:AddSkillItemForEnabling(skills:Skill(i));
        end
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
    slabel:SetText(skill.shortcut:GetLabel());
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
            _G.travel.mapWindow:UpdateShortcut(skill.id, sender:IsChecked());
        end
    end
end

function OptionsPanel:SetupEnabledTab()
    self.EnabledTab:SetSize(self.width - 20, self.height - 60)
    self.ListBox = Turbine.UI.ListBox()
    self.ListBox:SetParent(self.EnabledTab)
    self.ListBox:SetPosition(10, 5)
    self.ListBox:SetSize(500, self:GetHeight() - 120)
    self.scrollBar = Turbine.UI.Lotro.ScrollBar()
    self.scrollBar:SetOrientation(Turbine.UI.Orientation.Vertical)
    self.scrollBar:SetParent(self.EnabledTab)
    self.scrollBar:SetPosition(self.ListBox:GetWidth() - 10, 5)
    self.scrollBar:SetWidth(10)
    self.scrollBar:SetHeight(self.ListBox:GetHeight())
    self.ListBox:SetVerticalScrollBar(self.scrollBar)

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

    if (PlayerAlignment == Turbine.Gameplay.Alignment.FreePeople) then
        -- add the generic travels skills
        self:AddEnabledSection(TravelInfo.gen)

        -- add the race specific travel skill for the character
        self:AddEnabledSection(TravelInfo.racials)

        -- add class specific travel skills
        self:AddEnabledSection(TravelInfo:GetClassSkills())

        -- add the reputation travel skills
        self:AddEnabledSection(TravelInfo.rep)

    elseif (PlayerAlignment == Turbine.Gameplay.Alignment.MonsterPlayer) then
        -- add the creep travel skills
        self:AddSkillsForEnabling(TravelInfo.creep);
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
                    if self.checks[j].skill.shortcut:GetData() == group[k] then
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
    local sortListWidth = 370

    -- create a listbox for all the shortcuts to be sorted
    self.sortListBox = Turbine.UI.ListBox();
    self.sortListBox:SetSize(sortListWidth, self.height - 120);
    self.sortListBox:SetPosition(200, 5);
    self.sortListBox:SetParent(self.SortTab);
    self.sortListBox:SetVisible(true);

    -- create a label to add to the listbox for each shortcut
    for _, shortcut in pairs(TravelShortcuts) do
        local tempLabel = Turbine.UI.Label();
        tempLabel:SetText(shortcut:GetLabel());
        tempLabel:SetSize(sortListWidth, 20);
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
    self.listBoxScrollBar:SetPosition(sortListWidth - 10, 0);
    self.listBoxScrollBar:SetZOrder(100);
    self.listBoxScrollBar:SetVisible(true);
    self.listBoxScrollBar:SetParent(self.sortListBox);

    -- set the listbox scrollbar
    self.sortListBox:SetVerticalScrollBar(self.listBoxScrollBar);
end

function OptionsPanel:ReloadLabels()
    for i = 1, self.sortListBox:GetItemCount() do
        local label = self.sortListBox:GetItem(i)
        label:SetText(label.shortcut:GetLabel())
    end
    for i = 1, #self.labels do
        local label = self.labels[i]
        label:SetText(self.checks[i].skill.shortcut:GetLabel())
    end
end

-- function to add the buttons to sort the shortcuts
function OptionsPanel:SetupSortTab()
    self:AddSortList()
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

    self.levelSortButton = Turbine.UI.Lotro.Button();
    self.levelSortButton:SetSize(185, 20);
    self.levelSortButton:SetPosition(10, 465);
    self.levelSortButton:SetText(LC.sortLevel);
    self.levelSortButton:SetParent(self.SortTab);
    self.levelSortButton:SetVisible(true);

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

    self.levelSortButton.Click = function(sender, args)
        SortByLevel();
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

function OptionsPanel:SetupFindTab()
    self.FindTab:SetSize(self.width - 20, self.height - 60)
    self.FindTree = Turbine.UI.TreeView()
    self.FindTree:SetParent(self.FindTab)
    self.FindTree:SetPosition(10, 5)
    self.FindTree:SetSize(500, self:GetHeight() - 120)
    self.FindScrollBar = Turbine.UI.Lotro.ScrollBar()
    self.FindScrollBar:SetOrientation(Turbine.UI.Orientation.Vertical)
    self.FindScrollBar:SetParent(self.FindTab)
    self.FindScrollBar:SetPosition(self.FindTree:GetWidth() - 10, 5)
    self.FindScrollBar:SetWidth(10)
    self.FindScrollBar:SetHeight(self.FindTree:GetHeight())
    self.FindTree:SetVerticalScrollBar(self.FindScrollBar)

    self:AddFindTreeShortcuts()
end

function OptionsPanel:AddFindTreeShortcuts()
    local root = self.FindTree:GetNodes()
    local width = self.FindTree:GetWidth()
    root:Clear()
    for i = 1, #TravelShortcuts do
        local shortcut = TravelShortcuts[i]
        if not shortcut.found then
            local hasTop = shortcut.skill.acquire ~= nil
            local node = FindTreeNode(width - 20, shortcut:GetLabel(), hasTop)
            root:Add(node)

            if hasTop then
                local text, lines = shortcut:GetAcquireText()
                local child = node:GetChildNodes()
                local infoNode = FindTreeNode(width - 20, text, false)
                child:Add(infoNode)
            end
        end
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
