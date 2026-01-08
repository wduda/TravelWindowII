import "Turbine.UI"
import "Turbine.UI.Lotro"
import "TravelWindowII.src.SettingsMenu"  -- For GetVersionNumber() function
import "TravelWindowII.src.ChangelogData"  -- For changelog data

UpdateNotificationWindow = class(Turbine.UI.Lotro.Window)

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

        -- Include if version is between lastVersion (exclusive) and currentVersion (inclusive)
        if versionNum > lastVersionNum and versionNum <= currentVersionNum then
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

function UpdateNotificationWindow:Constructor(currentVersion, lastVersion, onClose, onRemindLater)
    Turbine.UI.Lotro.Window.Constructor(self)

    -- Window properties
    self.width = 500
    self.height = 400
    local screenW, screenH = Turbine.UI.Display:GetSize()

    self:SetPosition(screenW / 2 - self.width / 2, screenH / 2 - self.height / 2)
    self:SetSize(self.width, self.height)
    self:SetText(LC.updateTitle .. " " .. currentVersion)
    self:SetZOrder(1000)  -- High z-order to appear on top

    -- Format changelog from data table
    local changelogText = self:FormatChangelog(lastVersion, currentVersion)

    -- Create scrollable text area for changelog
    self.textBox = Turbine.UI.Lotro.TextBox()
    self.textBox:SetParent(self)
    self.textBox:SetPosition(10, 45)
    self.textBox:SetSize(self.width - 20, self.height - 100)
    self.textBox:SetMultiline(true)
    self.textBox:SetReadOnly(true)
    self.textBox:SetText(changelogText)
    self.textBox:SetFont(Turbine.UI.Lotro.Font.TrajanPro14)

    -- Create "Show Again Later" button (doesn't save version) - far left
    self.remindButton = Turbine.UI.Lotro.Button()
    self.remindButton:SetParent(self)
    self.remindButton:SetPosition(10, self.height - 45)
    self.remindButton:SetSize(130, 30)
    self.remindButton:SetText(LC.updateRemindLater)
    self.remindButton.Click = function()
        self:SetVisible(false)
        if onRemindLater then onRemindLater() end
    end

    -- Create "Close" button (saves version) - far right
    self.closeButton = Turbine.UI.Lotro.Button()
    self.closeButton:SetParent(self)
    self.closeButton:SetPosition(self.width - 120, self.height - 45)
    self.closeButton:SetSize(110, 30)
    self.closeButton:SetText(LC.updateClose)
    self.closeButton.Click = function()
        self:SetVisible(false)
        if onClose then onClose() end
    end

    self:SetVisible(true)
end
