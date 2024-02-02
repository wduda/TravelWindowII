import "Turbine";
import "Turbine.Debug";
import "Turbine.Gameplay";
import "Turbine.UI";
import "Turbine.UI.Lotro";
import "TravelWindowII.src.extensions";
import "TravelWindowII.src.utils.BitOps";

OptionsWindow = class(Turbine.UI.Lotro.Window);

function OptionsWindow:Constructor()
    Turbine.UI.Lotro.Window.Constructor(self);

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
    self:SetBackColor(Turbine.UI.Color(0.0, 0, 0, 0));
    self:SetText(optionsTitleString);
    self:SetOpacity(1);

    -- add the main options panel to the window
    self.Panel = TravelWindowII.src.OptionsPanel();
    self.Panel:SetParent(self);
    self.Panel:SetPosition(0, 35);

    -- set the window to be visible
    self:SetVisible(false);

    -- have the main window close the options
    self.VisibleChanged = function(sender, args)
        if (self:IsVisible() == false) then
            if (_G.travel ~= nil) then
                _G.travel:CloseOptions();
            end
        end
    end

    self.loaded = true;
end

function OptionsWindow:GetLoaded()
    return self.loaded;
end
