import "Turbine.UI"
import "Turbine.UI.Lotro"
import "TravelWindowII.src.ChangelogData"  -- For changelog data

UpdateNotificationWindow = class(Turbine.UI.Lotro.Window)

function ShowUpdateNotification(force)
    if not force and Settings.hideUpdateNotify > 0 then return end
    local currentVersion = Plugins["Travel Window II"]:GetVersion()
    local lastVersion = Settings.lastLoadedVersion or currentVersion
    local lastVersionNum = GetVersionNumber(lastVersion)
    local currentVersionNum = GetVersionNumber(currentVersion)

    if force or lastVersionNum < currentVersionNum then
        _G.update = TravelWindowII.src.UpdateNotificationWindow(currentVersion, lastVersion)
    end
end

-- Filter and format changelog data for display
function UpdateNotificationWindow:FormatChangelog(lastVersion, currentVersion)
    if not ChangelogData or #ChangelogData == 0 then
        return LC.updateDefaultMessage .. " " .. currentVersion
    end

    local lastVersionNum = GetVersionNumber(lastVersion)
    local currentVersionNum = GetVersionNumber(currentVersion)

    local relevantSections = {}

    -- Iterate through changelog entries
    for _, entry in ipairs(ChangelogData) do
        local versionNum = GetVersionNumber(entry.version)

        -- Include if the version is equal to the currentVersion or
        -- if the version is between lastVersion (exclusive) and currentVersion (inclusive)
        if (versionNum == currentVersionNum) or
                (versionNum > lastVersionNum and versionNum <= currentVersionNum) then
            -- Format this version section
            local section = "== " .. entry.version .. " ==\n"
            for _, change in ipairs(entry.changes) do
                section = section .. "- " .. change .. "\n"
            end
            table.insert(relevantSections, section)
        end
    end

    -- Combine relevant sections
    if #relevantSections > 0 then
        return table.concat(relevantSections, "\n")
    else
        return LC.updateDefaultMessage .. " " .. currentVersion
    end
end

function UpdateNotificationWindow:Constructor(currentVersion, lastVersion)
    if Settings.useMinWindow == 1 then
        Turbine.UI.Window.Constructor(self)
    else
        Turbine.UI.Lotro.Window.Constructor(self)
    end

    -- Track minimal mode and set styling properties
    self.isMinWindow = Settings.useMinWindow == 1

    if self.isMinWindow then
        self.titleBarHeight = 20
        self.contentTopOffset = 25
        self.backColor = Turbine.UI.Color(1, 0, 0, 0)
    else
        self.titleBarHeight = 0
        self.contentTopOffset = 45
        self.backColor = nil
    end

    -- Window properties
    self.width = 500
    self.height = 400
    local screenW, screenH = Turbine.UI.Display:GetSize()

    self:SetPosition(screenW / 2 - self.width / 2, screenH / 2 - self.height / 2)
    self:SetSize(self.width, self.height)
    self:SetText(LC.updateTitle .. " " .. currentVersion)
    self:SetZOrder(1000)  -- High z-order to appear on top

    -- Apply background color for minimal mode
    if self.backColor then
        self:SetBackColor(self.backColor)
    end

    -- Format changelog from data table
    local changelogText = self:FormatChangelog(lastVersion, currentVersion)

    if self.isMinWindow then
        self.titleLabel = Turbine.UI.Label()
        self.titleLabel:SetParent(self)
        self.titleLabel:SetVisible(true)
        self.titleLabel:SetPosition(0, 0)
        self.titleLabel:SetSize(self.width, self.titleBarHeight)
        self.titleLabel:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleCenter)
        self.titleLabel:SetFont(Turbine.UI.Lotro.Font.TrajanPro15)
        self.titleLabel:SetText(LC.updateTitle .. " " .. currentVersion)

        -- Enable dragging on title label in minimal mode
        self.titleLabel.MouseDown = function(_, args)
            if args.Button == Turbine.UI.MouseButton.Left then
                self.titleLabel.isDragging = true
                self.titleLabel.dragStartX, self.titleLabel.dragStartY = args.X, args.Y
            end
        end

        self.titleLabel.MouseMove = function(_, _)
            if self.titleLabel.isDragging then
                local mouseX, mouseY = Turbine.UI.Display.GetMousePosition()
                self:SetPosition(mouseX - self.titleLabel.dragStartX, mouseY - self.titleLabel.dragStartY)
            end
        end

        self.titleLabel.MouseUp = function(_, _)
            self.titleLabel.isDragging = false
        end
    end

    -- Create scrollable text area for changelog
    self.textBox = Turbine.UI.Lotro.TextBox()
    self.textBox:SetParent(self)
    self.textBox:SetPosition(10, self.contentTopOffset)
    self.textBox:SetSize(self.width - 30, self.height - self.contentTopOffset - 85)
    self.textBox:SetMultiline(true)
    self.textBox:SetReadOnly(true)
    self.textBox:SetText(changelogText)
    self.textBox:SetFont(Turbine.UI.Lotro.Font.TrajanPro14)

    -- Create vertical scrollbar for the text area
    self.scrollBar = Turbine.UI.Lotro.ScrollBar()
    self.scrollBar:SetOrientation(Turbine.UI.Orientation.Vertical)
    self.scrollBar:SetParent(self)
    self.scrollBar:SetPosition(self.width - 20, self.contentTopOffset)
    self.scrollBar:SetSize(10, self.height - self.contentTopOffset - 55)
    self.textBox:SetVerticalScrollBar(self.scrollBar)

    self.hideCheck = Turbine.UI.Lotro.CheckBox()
    self.hideCheck:SetParent(self)
    self.hideCheck:SetPosition(10, self.height - 90)
    self.hideCheck:SetWidth(300)
    self.hideCheck:SetText(" " .. LC.hideCheck)
    self.hideCheck:SetChecked(Settings.hideUpdateNotify > 0)
    self.hideCheck:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleLeft)

    -- Create "Show Again Later" button (doesn't save version) - far left
    self.remindButton = Turbine.UI.Lotro.Button()
    self.remindButton:SetParent(self)
    self.remindButton:SetPosition(10, self.height - 45)
    self.remindButton:SetSize(130, 30)
    self.remindButton:SetText(LC.updateRemindLater)
    self.remindButton.Click = function()
        self:SetVisible(false)
        self:UpdateNotifySetting()
        _G.update = nil
    end

    -- Create "Close" button (saves version) - far right
    self.closeButton = Turbine.UI.Lotro.Button()
    self.closeButton:SetParent(self)
    self.closeButton:SetPosition(self.width - 120, self.height - 45)
    self.closeButton:SetSize(110, 30)
    self.closeButton:SetText(LC.updateClose)
    self.closeButton.Click = function()
        self:SetVisible(false)
        Settings.lastLoadedVersion = currentVersion
        AccountSettingsStrings.lastLoadedVersion = Settings.lastLoadedVersion
        self:UpdateNotifySetting()
        _G.update = nil
    end

    self:SetVisible(true)
end

function UpdateNotificationWindow:UpdateNotifySetting()
    if self.hideCheck:IsChecked() then
        Settings.hideUpdateNotify = 1
    else
        Settings.hideUpdateNotify = 0
    end
    AccountSettingsStrings.hideUpdateNotify = tostring(Settings.hideUpdateNotify)
end
