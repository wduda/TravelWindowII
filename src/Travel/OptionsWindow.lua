import "Turbine";
import "Turbine.Debug";
import "Turbine.Gameplay";
import "Turbine.UI";
import "Turbine.UI.Lotro";
import "DhorPlugins.Extensions";
import "DhorPlugins.Utils.BitOps";

OptionsWindow = class(Turbine.UI.Lotro.Window);

function OptionsWindow:Constructor(parent)
    Turbine.UI.Lotro.Window.Constructor(self);

    self.loaded = false;
    self.width = 800;
    self.height = 800;
    self.windowWidth, self.windowHeight = Turbine.UI.Display:GetSize();

    self:SetPosition(self.windowWidth / 2 - self.width / 2, self.windowHeight / 2 - self.height / 2);
    self:SetSize(self.width, self.height);
    self:SetBlendMode(Turbine.UI.BlendMode.Undefined);
    self:SetBackColor(Turbine.UI.Color(0.0, 0, 0, 0));
    self:SetText(optionsTitleString);
    self:SetOpacity(1);

    -- add the main options panel to the window
    self.Panel = DhorPlugins.Travel.OptionsPanel(parent);
    self.Panel:SetParent(self);
    self.Panel:SetPosition(0, 35);

    -- set the window to be visible
    self:SetVisible(true);

    -- have the main window close the options
    self.VisibleChanged = function(sender, args)
        if (self:IsVisible() == false) then
            if (parent ~= nil) then
                parent:CloseOptions();
            end
        end
    end

    self.loaded = true;
end


function OptionsWindow:GetLoaded()
    return self.loaded;
end
