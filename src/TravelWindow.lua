import "Turbine";
import "Turbine.Debug";
import "Turbine.Gameplay";
import "Turbine.UI";
import "Turbine.UI.Lotro";
import "TravelWindowII.src.MapWindow"
import "TravelWindowII.src.extensions";
import "TravelWindowII.src.utils.BitOps";
import "TravelWindowII.src.VindarPatch";
import "TravelWindowII.src.EuroNormalize";

--[[ This is the main window for the Travel Window UI      ]] --
--[[ It handles the loading and saving the settings,       ]] --
--[[ creating the lists of travel shortcuts, creates       ]] --
--[[ and handles the context menu.                         ]] --

TravelWindow = class(Turbine.UI.Window);

function TravelWindow:Constructor(useMinWindow)
    if useMinWindow == 1 then
        Turbine.UI.Window.Constructor(self);
    else
        Turbine.UI.Lotro.Window.Constructor(self);
    end

    self.reloadGVMap = false;
    self.options = nil;
    self.dirty = true;
    self.isMouseDown = false;
    self.isDragging = false;
    self.isResizing = false;
    self.isMinWindow = useMinWindow == 1;
    if self.isMinWindow then
        self.wPos = -1;
        self.hPos = 20;
        self.wPadding = -1;
        self.hPadding = 20;
        self.resizeLabelSize = 13;
        self.backColor = Turbine.UI.Color(1, 0, 0, 0);
    else
        self.wPos = 15;
        self.hPos = 40;
        self.wPadding = 20;
        self.hPadding = 60;
        self.resizeLabelSize = 20;
    end

    -- configure the main window
    self:SetPosition(Settings.positionX, Settings.positionY);
    self:SetText(mainTitleString);
    self:SetBackColor(self.backColor);
    if (Settings.hideOnStart == 1) then
        self:SetVisible(false);
    else
        self:SetVisible(true);
    end

    -- if the player has a PvMP map, then insert it into the list
    -- if ((.mapGlanVraig ~= nil) and (.mapGlanVraig ~= "nil")) then
    -- self.reloadGVMap = true;
    -- genLocations:InsertSkill(2, glanMapString, .mapGlanVraig, "skip");
    -- end

    -- save the player's combat states for managing hiding the window
    -- when the player enters combat
    self.previousCombatState = false;
    self.wasOpenBeforeCombat = false;

    -- create a single context menu to use on all panels
    Menu = SettingsMenu(self);
    Menu:SetSettings(Settings.mode, Settings.filters);

    -- create the tabbed panel to hold all the other panels
    self.MainPanel = TravelWindowII.src.extensions.DPanel();
    self.MainPanel:SetPosition(self.wPos, self.hPos);
    self.MainPanel:SetButtonsVisible(false) -- make sure to hide the tab buttons
    self.MainPanel:SetParent(self);

    -- create the tabs for each mode of display
    self.ListTab = TravelListTab(self);
    self.GridTab = TravelGridTab(self);
    self.CaroTab = TravelCaroTab(self);
    self.PullTab = TravelPulldownTab(self);

    -- add the tabs to the panel
    self.MainPanel:AddTab(self.ListTab);
    self.MainPanel:AddTab(self.GridTab);
    self.MainPanel:AddTab(self.CaroTab);
    self.MainPanel:AddTab(self.PullTab);
    self.ListTab.tabId = 1;
    self.GridTab.tabId = 2;
    self.CaroTab.tabId = 3;
    self.PullTab.tabId = 4;
    self.GridTab.numOfCols = Settings.gridCols;
    self.GridTab.numOfRows = Settings.gridRows;
    self.ListTab.pixelWidth = Settings.listWidth;
    self.ListTab.numOfRows = Settings.listRows;

    self.MainPanel:SetTab(Settings.mode);
    self:SetItems();
    self:UpdateMinimum();
    self:SetOpacity(Settings.mainMinOpacity);

    -- track the hidden state of the UI, manage previous states for window and
    -- the button
    self.hidden = false;
    self.currentVisState = self:IsVisible();

    self.titleLabel = Turbine.UI.Label();
    self.titleLabel:SetParent(self);
    self.titleLabel:SetVisible(self.isMinWindow);
    self.titleLabel:SetPosition(0, 0);
    self.titleLabel:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleCenter);
    self.titleLabel:SetFont(Turbine.UI.Lotro.Font.TrajanPro15);
    self.titleLabel:SetText("Travel Window II");

    self.resizeLabel = Turbine.UI.Label();
    self.resizeLabel:SetParent(self);
    self.resizeLabel:SetSize(self.resizeLabelSize, self.resizeLabelSize);
    self.resizeLabel:SetOpacity(0);
    self.resizeLabel:SetZOrder(100); -- put above the shortcuts; which are set to 90

    --[[ Event Handlers ]] --

    self:SetWantsKeyEvents(true);

    -- check if our position has changed, and save the settings if so
    self.PositionChanged = function(sender, args)
        local one, two = self:GetPosition();
        Settings.positionX = one;
        Settings.positionY = two;
        self.PullTab:ClosePulldown();
    end

    -- manage hiding the UI
    self.KeyDown = function(sender, args)
        if (args.Action == Turbine.UI.Lotro.Action.Escape) then
            if Settings.ignoreEsc == 0 then
                self:SetVisible(false);
            end
            OptionsWindow:SetVisible(false);
            self:CloseOptions();
            self:CloseMapWindow();
            if (self.hidden == true) then
                self.hidden = false;
                self:SetVisible(self.currentVisState);
                ToggleButton:SetVisible(Settings.showButton == 1);
            end
        elseif (args.Action == Turbine.UI.Lotro.Action.UI_Toggle) then
            if (self.hidden == false) then
                self.currentVisState = self:IsVisible();
                self.hidden = true;
                self:SetVisible(false);
                OptionsWindow:SetVisible(false);
                ToggleButton:SetVisible(false);
                if self.mapWindow ~= nil then
                    self.mapWindow:SetVisible(false);
                end
            else
                self.hidden = false;
                self:SetVisible(self.currentVisState);
                ToggleButton:SetVisible(Settings.showButton == 1);
                if self.mapWindow ~= nil then
                    self.mapWindow:SetVisible(true);
                end
            end
        end
    end

    -- check if the combat state of the player changed, in case we want
    -- to hide the window
    IncombatChangedHandler = function(sender, args)
        -- first check if we are going into combat
        if (self.previousCombatState == false) then

            -- then check if the window is visible already, and the player wishes
            -- to hide on combat
            if (Settings.hideOnCombat == 1 and self:IsVisible()) then

                -- make sure we know we were open previously, then hide the window
                self.wasOpenBeforeCombat = true;
                self:SetVisible(false);
            end

            -- set the previous state for the next check
            self.previousCombatState = true;

            -- handle going out of combat
        else

            -- check that we were open before combat and the player wishes
            -- to hide on combat
            if (Settings.hideOnCombat == 1 and self.wasOpenBeforeCombat == true) then

                -- clear the open status, and show the window
                self.wasOpenBeforeCombat = false;
                self:SetVisible(true);
            end

            -- set the previous state for the next check
            self.previousCombatState = false;
        end
    end
    AddCallback(player, "InCombatChanged", IncombatChangedHandler);

    self.Update = function(sender, args)
        -- handle opacity fade out
        local stepSize = (Settings.mainMaxOpacity - Settings.mainMinOpacity) / Settings.fadeOutSteps;
        local opacity = self:GetOpacity() - stepSize;
        if opacity < Settings.mainMinOpacity then
            opacity = Settings.mainMinOpacity
            self:SetWantsUpdates(false);
        end
        self:SetOpacity(opacity);
    end

    -- if the visible status of the window changes, close the pulldown tab
    self.VisibleChanged = function(sender, args)
        if (self:IsVisible() == false) then
            self.PullTab:ClosePulldown();
        end
    end

    self.MouseClick = function(sender, args)
        if args.Button == Turbine.UI.MouseButton.Right then
            Menu:ShowMenu();
        end

        if Settings.mode == 4 then
            self.PullTab:ClosePulldown();
        end
    end

    -- go to full opacity if mouse is over
    self.MouseEnter = function(sender, args)
        self:SetMaxOpacity();
    end

    -- go to low opacity when mouse is not over
    self.MouseLeave = function(sender, args)
        if not self.isMouseDown then
            self:FadeOut();
        end
    end
    self.PullTab.pulldown.dropDownWindow.MouseEnter = self.MouseEnter;
    self.PullTab.pulldown.dropDownWindow.MouseLeave = self.MouseLeave;

    self.MouseDown = function(sender, args)
        self.isMouseDown = true;
        if (args.Button == Turbine.UI.MouseButton.Left) then
            self.dragStartX, self.dragStartY = self:GetMousePosition();
            if Settings.mode == 1 or Settings.mode == 2 then
                local mX, mY = self:GetMousePosition();
                self.resizeStartX, self.resizeStartY = self:GetSize();
                if self.resizeStartX - mX < self.resizeLabelSize + 1 and
                        self.resizeStartY - mY < self.resizeLabelSize + 1 then
                    self.isResizing = true;
                end
            end

            if not self.isResizing then
                self.isDragging = true;
            end
        end
    end
    self.MouseMove = function(sender, args)
        if self.isDragging then
            local left, top = self:GetPosition();
            local mX, mY = self:GetMousePosition();
            local x = left + (mX - self.dragStartX);
            local y = top + (mY - self.dragStartY);
            self:SetPosition(x, y);
        elseif self.isResizing then
            local sX, sY = self:GetSize();
            local mX, mY = self:GetMousePosition();
            sX = self.resizeStartX + (mX - self.dragStartX);
            sY = self.resizeStartY + (mY - self.dragStartY);
            if Settings.mode == 1 then
                sX, sY = self.ListTab:FitToPixels(sX, sY);
            elseif Settings.mode == 2 then
                sX, sY = self.GridTab:FitToPixels(sX, sY);
            end
            self:SetSize(sX, sY);
        end
    end
    self.MouseUp = function(sender, args)
        local mX, mY = self:GetMousePosition();
        local winX, winY = self:GetSize();
        local outsideWindow = mX < 1 or mY < 1 or mX > winX - 1 or mY > winY - 1;
        if outsideWindow then
            self:FadeOut();
        end

        self.isMouseDown = false;
        self.isDragging = false;
        self.isResizing = false;
    end
    self.titleLabel.MouseDown = self.MouseDown;
    self.titleLabel.MouseMove = self.MouseMove;
    self.titleLabel.MouseUp = self.MouseUp;
    self.titleLabel.MouseClick = self.MouseClick;
    self.resizeLabel.MouseDown = self.MouseDown;
    self.resizeLabel.MouseMove = self.MouseMove;
    self.resizeLabel.MouseUp = self.MouseUp;
    self.resizeLabel.MouseClick = self.MouseClick;

    self.SizeChanged = function(sender, args)
        if Settings.mode == 1 then
            Settings.listWidth = self.ListTab.pixelWidth;
            Settings.listRows = self.ListTab.numOfRows;
        elseif Settings.mode == 2 then
            Settings.gridCols = self.GridTab.numOfCols;
            Settings.gridRows = self.GridTab.numOfRows;
        end
        self.MainPanel:SetSize(self:GetWidth() - self.wPadding, self:GetHeight() - self.hPadding);
        self.MainPanel:UpdateTabs();
        self.titleLabel:SetSize(self:GetWidth(), 20);
        self.resizeLabel:SetPosition(self:GetWidth() - self.resizeLabel:GetWidth(),
                                     self:GetHeight() - self.resizeLabel:GetHeight());
    end
    self:SizeChanged(); -- explicitly call to ensure correct positioning
    if Settings.mode == 1 then
        self:SetSize(self.ListTab:FitToPixels(self:GetSize()));
    elseif Settings.mode == 2 then
        self:SetSize(self.GridTab:FitToPixels(self:GetSize()));
    end
end

function TravelWindow:SetMaxOpacity()
    self:SetOpacity(Settings.mainMaxOpacity);
    self:SetWantsUpdates(false);
end

function TravelWindow:FadeOut()
    self:SetWantsUpdates(true);
end

function TravelWindow:SetItems()
    if Settings.mode == 1 then
        self:SetSize(self.ListTab:GetPixelSize());
        self.ListTab:SetItems();
    elseif Settings.mode == 2 then
        self:SetSize(self.GridTab:GetPixelSize());
        self.GridTab:SetItems();
    elseif Settings.mode == 3 then
        self.CaroTab:SetItems();
    elseif Settings.mode == 4 then
        self.PullTab:SetItems();
    end
end

function TravelWindow:UpdateMinimum()
    -- update the page that is showing
    if Settings.mode == 1 then
        self.minWidth = 200;
        self.minHeight = 75;
    elseif Settings.mode == 3 then
        if self.isMinWindow then
            self.minWidth = 150;
            self.minHeight = 75;
        else
            self.minWidth = 200;
            self.minHeight = 110;
        end
    elseif Settings.mode == 4 then
        if self.isMinWindow then
            self.minWidth = 360;
            self.minHeight = 65;
        else
            self.minWidth = 360;
            self.minHeight = 105;
        end
    else
        self.minWidth = 100;
        self.minHeight = 40;
    end

    self:SetMinimumSize(self.minWidth, self.minHeight);

    if Settings.mode == 3 or Settings.mode == 4 then
        self:SetSize(self.minWidth, self.minHeight);
    end
end

function TravelWindow:SetMapHome()

    -- also close the options window
    self:CloseOptions();

    -- create the window used to add the map
    self.MapWindow = Turbine.UI.Control();
    self.MapWindow:SetPosition(10, 35);
    self.MapWindow:SetSize(Settings.width - 20, Settings.height - 60);
    self.MapWindow:SetBackColor(Turbine.UI.Color(1, 0.1, 0.1, 0.1));
    self.MapWindow:SetParent(self);
    self.MapWindow:SetZOrder(300);

    -- add a label to the window for instructions
    self.mapLabel = Turbine.UI.Label();
    self.mapLabel:SetForeColor(Turbine.UI.Color(1, 0.2, 0.2, 0.6));
    self.mapLabel:SetPosition(0, 15);
    self.mapLabel:SetSize(Settings.width - 20, self.MapWindow:GetHeight() - 90);
    self.mapLabel:SetParent(self.MapWindow);
    self.mapLabel:SetVisible(true);
    self.mapLabel:SetFont(Turbine.UI.Lotro.Font.Verdana14);
    self.mapLabel:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleLeft);
    self.mapLabel:SetMultiline(true);
    self.mapLabel:SetText("@TODO");

    -- add an empty quickslot to the window
    self.mapQuickSlot1 = Turbine.UI.Lotro.Quickslot();
    self.mapQuickSlot1:SetPosition(self.MapWindow:GetWidth() / 2 - 18, self.MapWindow:GetHeight() - 80);
    self.mapQuickSlot1:SetSize(36, 36);
    self.mapQuickSlot1:SetParent(self.MapWindow);
    self.mapQuickSlot1:SetUseOnRightClick(false);
    self.mapQuickSlot1:SetVisible(true);

    -- add a button to the window
    self.mapButton = Turbine.UI.Lotro.Button();
    self.mapButton:SetSize(60, 50);
    self.mapButton:SetPosition(self.MapWindow:GetWidth() / 2 - self.mapButton:GetWidth() / 2,
                               self.MapWindow:GetHeight() - 35);
    self.mapButton:SetText("OK");
    self.mapButton:SetParent(self.MapWindow);
    self.mapButton:SetVisible(true);

    -- when the button is pressed, update the settings
    -- with the new skill, and reset everything
    self.mapButton.Click = function(sender, args)

        -- check if there is a shortcut in the quickslot
        if (self.mapQuickSlot1:GetShortcut():GetType() ~= Turbine.UI.Lotro.ShortcutType.Undef) then

            -- save the shortcut data to the settings
            self:SaveMapHome(self.mapQuickSlot1:GetShortcut());
        end

        -- update the shortcuts list
        self:UpdateSettings();

        -- close this window
        self.MapWindow:SetVisible(false);
        self.MapWindow = nil;
    end
end

function TravelWindow:SaveMapHome(shortcut)

    local mapItem = shortcut:GetItem();

    -- do this if it is the glan vraig map
    if (string.find(mapItem:GetName(), glanMapItemString)) then

        -- remove the old shortcut if it exists
        if (TravelInfo.gen:IndexByName(glanMapString) == 2) then
            TravelInfo.gen:RemoveSkillAtIndex(2);
        end

        -- set the value
        Settings.mapGlanVraig = shortcut:GetData();

        -- update the location lists
        TravelInfo.gen:InsertSkill(2, glanMapString, Settings.mapGlanVraig);

        -- else, do nothing but report the error
    else
        Turbine.Shell.WriteLine("@TODO");
    end
    -- update and save everything
    self:UpdateSettings();
end

-- simple function to open the options window
function TravelWindow:OpenOptions()
    OptionsWindow:SetVisible(true);
end

-- function to close the options window if it exists
function TravelWindow:CloseOptions()
    if (self.options ~= nil) then
        self.options:SetVisible(false);
    end
    self.options = nil;
end

function TravelWindow:OpenMapWindow(map)
    self:CloseMapWindow();
    self.mapWindow = TravelWindowII.src.MapWindow(map);
    self.mapWindow:SetVisible(true);
end

-- function to close the current map window
function TravelWindow:CloseMapWindow()
    if (self.mapWindow ~= nil) then
        self.mapWindow:SetVisible(false);
        self.mapWindow:Close();
    end
    self.mapWindow = nil;
end

function TravelWindow:UpdateOpacity()
    self:SetOpacity(Settings.mainMinOpacity);
    ToggleButton:UpdateOpacity();
end

function TravelWindow:SetOpacity(value)
    Turbine.UI.Window.SetOpacity(self, value);
    self.CaroTab:SetOpacityItems(value);
    self.PullTab:SetOpacity(value);
end

function TravelWindow:UpdateSettings()

    -- get some settings from the menu
    local prevMode = Settings.mode;
    Settings.mode, Settings.filters = Menu:GetSettings();
    if prevMode ~= Settings.mode then
        self.dirty = true;
    end

    -- set which page of the tab panel to show
    self.MainPanel:SetTab(Settings.mode);
    self:UpdateMinimum();
    self:SetItems();
    if Settings.mode == 1 then
        self:SetSize(self.ListTab:FitToPixels(self:GetSize()));
    elseif Settings.mode == 2 then
        self:SetSize(self.GridTab:FitToPixels(self:GetSize()));
    end

    self.MainPanel:SetSize(self:GetWidth() - self.wPadding, self:GetHeight() - self.hPadding);
    self.MainPanel:UpdateTabs();
end

function TravelWindow:ResetSettings()
    -- close the option window
    self:CloseOptions()

    -- set all saved settings to default values
    Settings = {};
    Settings.lastLoadedVersion = Plugins["Travel Window II"]:GetVersion();
    Settings.gridCols = 0;
    Settings.gridRows = 0;
    Settings.listWidth = 0;
    Settings.listRows = 0;
    Settings.positionX = Turbine.UI.Display.GetWidth() - self:GetWidth() - 50;
    Settings.positionY = Turbine.UI.Display.GetHeight() - self:GetHeight() - 50 * 1.5;
    Settings.buttonRelativeX = 0.95;
    Settings.buttonRelativeY = 0.75;
    Settings.hideOnStart = 0;
    Settings.hideOnCombat = 0;
    Settings.pulldownTravel = 0;
    Settings.hideOnTravel = 0;
    Settings.ignoreEsc = 0;
    Settings.showButton = 1;
    Settings.mode = 2;
    Settings.filters = 0x0F;
    Settings.enabled = {};
    Settings.order = {};
    Settings.mainMaxOpacity = 1;
    Settings.mainMinOpacity = 0.5;
    Settings.fadeOutSteps = 1;
    Settings.toggleMaxOpacity = 1;
    Settings.toggleMinOpacity = 0.5;

    -- clear the maps
    Settings.mapGlanVraig = nil;

    -- move the toggle button and main window
    local buttonPositionX = Turbine.UI.Display.GetWidth() * SettingsStrings.buttonRelativeX;
    local buttonPositionY = Turbine.UI.Display.GetHeight() * SettingsStrings.buttonRelativeY;
    ToggleButton:SetPosition(buttonPositionX, buttonPositionY);
    self:SetPosition(Settings.positionX, Settings.positionY);

    -- update everything
    SetShortcuts();
    self:UpdateSettings();
end

function TravelWindow:AddGVMap()
    -- if the player has a PvMP map, then insert it into the list
    if ((Settings.mapGlanVraig ~= nil) and (Settings.mapGlanVraig ~= "nil")) then
        self.reloadGVMap = false;
        TravelInfo.gen:InsertSkill(2, glanMapString, Settings.mapGlanVraig, "Glan Vraig");
    end
end

-- for debug purposes
function TravelWindow:DoDump()
    Turbine.Debug.Table.Dump(TravelWindowII.src);
end

function AddCallback(object, event, callback)
    if (object[event] == nil) then
        object[event] = callback;
    else
        if (type(object[event]) == "table") then
            table.insert(object[event], callback);
        else
            object[event] = {object[event], callback};
        end
    end
    return callback;
end

-- for debug purposes
function TravelWindow:ManualSkillScan()
    local last = 0;
    skillWindow=Turbine.UI.Lotro.Window()
    skillWindow.cols=math.floor((Turbine.UI.Display:GetWidth()-10)/100)
    skillWindow.rows=math.floor((Turbine.UI.Display:GetHeight()-105)/62)
    skillWindow:SetSize(Turbine.UI.Display:GetWidth(),Turbine.UI.Display:GetHeight())
    skillWindow:SetText("Skill Explorer")
    skillWindow.StartCaption=Turbine.UI.Label()
    skillWindow.StartCaption:SetParent(skillWindow)
    skillWindow.StartCaption:SetText("Start:")
    skillWindow.StartCaption:SetPosition(10,45)
    skillWindow.StartCaption:SetSize(50,20)
    skillWindow.Start=Turbine.UI.Lotro.TextBox()
    skillWindow.Start:SetParent(skillWindow)
    skillWindow.Start:SetPosition(65,45)
    skillWindow.Start:SetSize(100,20)
    skillWindow.Start:SetFont(Turbine.UI.Lotro.Font.Verdana16)
    skillWindow.Prev=Turbine.UI.Lotro.Button()
    skillWindow.Prev:SetParent(skillWindow)
    skillWindow.Prev:SetSize(100,20)
    skillWindow.Prev:SetPosition(170,45)
    skillWindow.Prev:SetText("Previous")
    skillWindow.Prev.Click=function()
        local start=tonumber(skillWindow.Start:GetText())
        if start==nil then start=0 end
        start=start-skillWindow.rows*skillWindow.cols
        if start<0 then start=0 end
        skillWindow.Start:SetText(string.format("0x%x",start))
        skillWindow.refresh()
    end
    skillWindow.Show=Turbine.UI.Lotro.Button()
    skillWindow.Show:SetParent(skillWindow)
    skillWindow.Show:SetSize(100,20)
    skillWindow.Show:SetPosition(275,45)
    skillWindow.Show:SetText("Refresh")
    skillWindow.Show.Click=function()
        skillWindow.refresh()
    end
    skillWindow.Next=Turbine.UI.Lotro.Button()
    skillWindow.Next:SetParent(skillWindow)
    skillWindow.Next:SetSize(100,20)
    skillWindow.Next:SetPosition(380,45)
    skillWindow.Next:SetText("Next")
    skillWindow.Next.Click=function()
        local start=tonumber(skillWindow.Start:GetText())
        if start==nil then start=0 end
        if last == 0 then
            start=start+skillWindow.rows*skillWindow.cols
        else
            start = last
        end
        skillWindow.Start:SetText(string.format("0x%x",start))
        skillWindow.refresh()
    end
    skillWindow:SetVisible(true)
    skillWindow.QS={}
    for row=1,skillWindow.rows do
        skillWindow.QS[row]={}
        for col=1,skillWindow.cols do
            skillWindow.QS[row][col]=Turbine.UI.Lotro.Quickslot()
            local qs=skillWindow.QS[row][col]
            qs:SetParent(skillWindow)
            qs:SetSize(34,34)
            qs:SetPosition(col*100-32, row*62+23)
            qs.label=Turbine.UI.Label()
            qs.label:SetParent(skillWindow)
            qs.label:SetSize(100,20)
            qs.label:SetPosition(col*100-32, row*62+57)
        end
    end
    skillWindow.refresh=function()
        local start=tonumber(skillWindow.Start:GetText())
        if start==nil then start=0 end

        for row=1,skillWindow.rows do
            local err = 0;
            for col=1,skillWindow.cols do
                repeat
                    local qs=skillWindow.QS[row][col]
                    local sc=Turbine.UI.Lotro.Shortcut();
                    sc:SetType(Turbine.UI.Lotro.ShortcutType.Skill)
                    local val=string.format("0x%x",start);
                    start = start + 1;
                    sc:SetData(val)
                    local success, result=pcall(Turbine.UI.Lotro.Quickslot.SetShortcut,qs,sc)
                    qs:SetVisible(success)
                    qs.label:SetText(val)
                    if not success then err = err + 1 end
                until success or err > 10000
            end
        end
        last = start;
    end
    skillWindow.Start:SetText("0x700697F2")
end
