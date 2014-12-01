import "Turbine.UI";

Label = class(Turbine.UI.Label);

-- colors
Label.ItemColor = Turbine.UI.Color(245/255, 222/255, 147/255);
Label.DisabledColor = Turbine.UI.Color(162/255, 162/255, 162/255);

function Label:Constructor()
    Turbine.UI.Label.Constructor(self);

    self:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleCenter);
    self:SetForeColor(Label.ItemColor);
    self:SetFont(Turbine.UI.Lotro.Font.TrajanPro14);
end

function Label:SetEnabled(enabled)
    Turbine.UI.Control.SetEnabled(self, enabled);
    self:SetForeColor(enabled and Label.ItemColor or Label.DisabledColor);
end
