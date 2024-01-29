import "Turbine";
import "Turbine.Debug";
import "Turbine.Gameplay";
import "Turbine.UI";
import "Turbine.UI.Lotro";
import "TravelWindowII.src.extensions";
import "TravelWindowII.src.utils.BitOps";

--[[ This is the simple window that can be used to toggle ]] --
--[[ the main Travel Window visible.]] --

TravelButton = class(Turbine.UI.Extensions.SimpleWindow);

function TravelButton:Constructor()
    Turbine.UI.Extensions.SimpleWindow.Constructor(self);

    -- set defaults
    self:SetSize(32, 32);
    self:SetBackground("TravelWindowII/src/resources/travel.tga");
    self:SetBackColorBlendMode(Turbine.UI.BlendMode.Multiply);
    self:SetBackColor(Turbine.UI.Color(0, 0.5, 0.5, 0.5));
    self:SetZOrder(1);

    local screenWidth = Turbine.UI.Display.GetWidth();
    local screenHeight = Turbine.UI.Display.GetHeight();
    local buttonPositionX = SettingsStrings.buttonRelativeX * screenWidth;
    local buttonPositionY = SettingsStrings.buttonRelativeY * screenHeight;
    if buttonPositionX + self:GetWidth() > screenWidth then
        buttonPositionX = screenWidth - self:GetWidth();
    end
    if buttonPositionY + self:GetHeight() > screenHeight then
        buttonPositionY = screenHeight - self:GetHeight();
    end
    self:SetPosition(buttonPositionX, buttonPositionY);
    self:SetVisible(Settings.showButton == 1);
    self:SetOpacity(Settings.toggleMinOpacity);

    --[[ EVENT HANDLERS ]] --

    -- variables for tracking if the button is
    -- being moved around the window
    local isMoving = false;
    local hasMoved = false;
    local isHighlighted = false;
    local buttonDownTime = 0;
    local x = 0;
    local y = 0;

    -- go to full opacity if mouse is over
    self.MouseEnter = function(sender, args)
        self:SetOpacity(Settings.toggleMaxOpacity);
    end

    -- go to low opacity when mouse is not over
    self.MouseLeave = function(sender, args)
        self:SetOpacity(Settings.toggleMinOpacity);
    end

    -- if the mouse button is pressed, prepare to maybe move the button
    self.MouseDown = function(sender, args)
        if (args.Button == Turbine.UI.MouseButton.Left) then
            buttonDownTime = Turbine.Engine.GetGameTime();
            isMoving = true;
            x = args.X;
            y = args.Y;
        end
    end

    -- mouse button released, handle a potential move
    self.MouseUp = function(sender, args)
        if (args.Button == Turbine.UI.MouseButton.Left) then
            isMoving = false;
            isHighlighted = false;

            -- if the window moved, update the settings, but do not toggle
            -- the visibility of the button
            if (hasMoved) then
                local one, two = self:GetPosition();
                local screenWidth, screenHeight = Turbine.UI.Display.GetSize();
                Settings.buttonRelativeX = one / screenWidth;
                Settings.buttonRelativeY = two / screenHeight;
                _G.travel:UpdateSettings();
                hasMoved = false;
                self:SetBackColor(Turbine.UI.Color(0, 0.5, 0.5, 0.5));

            else
                if not _G.travel:IsVisible() then
                    CheckSkills(false);
                    _G.travel:SetOpacity(Settings.mainMinOpacity);
                end
                _G.travel:SetVisible(not _G.travel:IsVisible());
            end
        else
            Menu:ShowMenu();
        end
    end

    -- handle moving the button
    self.MouseMove = function(sender, args)
        if (isMoving and Turbine.Engine.GetGameTime() - buttonDownTime > 0.4) then
            self:SetBackColor(Turbine.UI.Color(1.0, 0.5, 0.5, 0.95));
            hasMoved = true;
            local oldX, oldY = self:GetPosition();
            self:SetPosition(oldX + args.X - x, oldY + args.Y - y);
        end
    end
end

function TravelButton:UpdateOpacity()
    self:SetOpacity(Settings.toggleMinOpacity);
end
