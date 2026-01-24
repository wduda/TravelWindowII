import "Turbine.Gameplay"
import "Turbine.UI"
import "Turbine.UI.Lotro"
import "TravelWindowII.src.extensions"
import "TravelWindowII.src.utils.BitOps"

OptionsWindow = class(Turbine.UI.Lotro.Window);

function OptionsWindow:Constructor()
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
        self.backColor = Turbine.UI.Color(1, 0, 0, 0)  -- Transparent
    else
        self.titleBarHeight = 0
        self.contentTopOffset = 35
        self.backColor = nil
    end

    self.width = 800;
    self.height = 840;
    self.windowWidth, self.windowHeight = Turbine.UI.Display:GetSize();
    if self.height + 40 > self.windowHeight then
        self.height = self.windowHeight - 20;
    end

    self:SetPosition(self.windowWidth / 2 - self.width / 2, self.windowHeight / 2 - self.height / 2);
    self:SetSize(self.width, self.height);
    self:SetBlendMode(Turbine.UI.BlendMode.Undefined);
    if self.backColor then
        self:SetBackColor(self.backColor)
    else
        self:SetBackColor(Turbine.UI.Color(0.0, 0, 0, 0))
    end
    self:SetText(LC.optionsTitle);
    self:SetOpacity(1);

    -- Custom title label for minimal window mode
    self.titleLabel = Turbine.UI.Label()
    self.titleLabel:SetParent(self)
    self.titleLabel:SetVisible(self.isMinWindow)
    self.titleLabel:SetPosition(0, 0)
    self.titleLabel:SetSize(self.width, self.titleBarHeight)
    self.titleLabel:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleCenter)
    self.titleLabel:SetFont(Turbine.UI.Lotro.Font.TrajanPro15)
    self.titleLabel:SetText(LC.optionsTitle)

    -- close button for minimal window mode
    self.closeButton = Turbine.UI.Label()
    self.closeButton:SetParent(self.titleLabel)
    self.closeButton:SetVisible(self.isMinWindow)
    self.closeButton:SetBackColor(Turbine.UI.Color(0.34,0,0))
    self.closeButton:SetPosition(self.width - self.titleBarHeight, 2)
    self.closeButton:SetSize(self.titleBarHeight - 2, self.titleBarHeight - 2)

    self.closeButton.MouseClick = function(_, _)
        self:SetVisible(false)
    end

    self.closeButton.MouseEnter = function(_, _)
        self.closeButton:SetBackColor(Turbine.UI.Color(0.68,0,0))
    end

    self.closeButton.MouseLeave = function(_, _)
        self.closeButton:SetBackColor(Turbine.UI.Color(0.34,0,0))
    end

    self.PositionChanged = function(_, _)
        if BlockUIChange(self) then
            if self.posLockX ~= nil then
                self:SetPosition(self.posLockX, self.posLockY)
            end
        else
            self.posLockX = nil
        end
    end

    -- Enable dragging on title label in minimal mode
    self.MouseDown = function(_, args)
        self.posLockX, self.posLockY = self:GetPosition()
        if BlockUIChange(self) then
            return
        end

        if (args.Button == Turbine.UI.MouseButton.Left) then
            local mX, mY = self:GetMousePosition()
            self.dragStartX, self.dragStartY = mX, mY
            self.isDragging = true
        end
    end
    self.MouseMove = function(_, _)
        if self.isDragging then
            local maxX, maxY = Turbine.UI.Display.GetSize()
            maxX, maxY = maxX - self:GetWidth(), maxY - self:GetHeight()
            local left, top = self:GetPosition();
            local mX, mY = self:GetMousePosition();
            local x = left + (mX - self.dragStartX);
            local y = top + (mY - self.dragStartY);
            if x < 0 then x = 0 end
            if x > maxX then x = maxX end
            if y < 0 then y = 0 end
            if y > maxY then y = maxY end
            self:SetPosition(x, y);
        end
    end
    self.MouseUp = function(_, _)
        self.isDragging = false;
    end

    self.titleLabel.MouseDown = self.MouseDown
    self.titleLabel.MouseMove = self.MouseMove
    self.titleLabel.MouseUp = self.MouseUp

    -- add the main options panel to the window
    self.Panel = TravelWindowII.src.OptionsPanel();
    self.Panel:SetParent(self);
    self.Panel:SetPosition(0, self.contentTopOffset);

    -- set the window to be visible
    self:SetVisible(false);
end

function CreatePluginOptionsPanel()
    local optionsPanel = Turbine.UI.Control()
    optionsPanel:SetSize(500, 200)

    plugin.GetOptionsPanel = function()
        return optionsPanel
    end

    local optionsButton = Turbine.UI.Lotro.Button()
    optionsButton:SetParent(optionsPanel)
    optionsButton:SetPosition(100, 100)
    optionsButton:SetSize(200,15)
    optionsButton:SetText(LC.menuOptions)
    optionsButton:SetVisible(true)
    optionsButton.Click = function()
        _G.options:SetVisible(true)
    end
end
