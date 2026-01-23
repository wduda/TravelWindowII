import "Turbine.Gameplay";
import "Turbine.UI";
import "Turbine.UI.Lotro";
import "TravelWindowII.src.extensions";
import "TravelWindowII.src.utils.BitOps";

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

    self.loaded = false;
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

    -- Enable dragging on title label in minimal mode
    if self.isMinWindow then
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

    -- add the main options panel to the window
    self.Panel = TravelWindowII.src.OptionsPanel();
    self.Panel:SetParent(self);
    self.Panel:SetPosition(0, self.contentTopOffset);

    -- set the window to be visible
    self:SetVisible(false);

    self.loaded = true;
end

function OptionsWindow:GetLoaded()
    return self.loaded;
end

function CreateOptionsWindow()
    UnlockedUI = false
    local PluginManagerOptionsPanel = Turbine.UI.Control()
    PluginManagerOptionsPanel:SetSize(500, 200)

    plugin.GetOptionsPanel = function()
        return PluginManagerOptionsPanel
    end

    local OptionsButton = Turbine.UI.Lotro.Button()
    OptionsButton:SetParent(PluginManagerOptionsPanel)
    OptionsButton:SetPosition(100, 100)
    OptionsButton:SetSize(200,15)
    OptionsButton:SetText(LC.menuOptions)
    OptionsButton:SetVisible(true)

    OptionsWindow = TravelWindowII.src.OptionsWindow()
    OptionsWindow.MouseDown = function(sender, args)
        OptionsWindow.posLockX, OptionsWindow.posLockY = OptionsWindow:GetPosition()
    end
    OptionsWindow.PositionChanged = function(sender, args)
        if BlockUIChange(OptionsWindow) then
            if OptionsWindow.posLockX ~= nil then
                OptionsWindow:SetPosition(OptionsWindow.posLockX, OptionsWindow.posLockY)
            end
        else
            OptionsWindow.posLockX = nil
        end
    end
    OptionsButton.Click = function()
        OptionsWindow:SetVisible(true)
    end
end
