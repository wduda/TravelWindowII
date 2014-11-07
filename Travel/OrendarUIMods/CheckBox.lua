--[[
Originally from OrendarPlugins.UI

Minor modifications from Frell
--]]

import "Turbine.UI";

CheckBox = class(Turbine.UI.Control);

-- colors
CheckBox.ItemColor = Turbine.UI.Color(245/255, 222/255, 147/255);
CheckBox.DisabledColor = Turbine.UI.Color(162/255, 162/255, 162/255);

CheckBox.LocationLeft = 1;
CheckBox.LocationRight = 2;

function CheckBox:Constructor()
    Turbine.UI.Control.Constructor(self);

    -- state
    self.checked = false;

	self.checkboxLocation = CheckBox.LocationRight;
	
    -- text label
    self.label = Turbine.UI.Label();
    self.label:SetParent(self);
    self.label:SetFont(Turbine.UI.Lotro.Font.TrajanPro14);
    self.label:SetForeColor(CheckBox.ItemColor);
    self.label:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleRight);
    self.label:SetMouseVisible(false);
    
    -- check
    self.check = Turbine.UI.Control();
    self.check:SetParent(self);
    self.check:SetSize(16, 16);
    self.check:SetBlendMode(Turbine.UI.BlendMode.AlphaBlend);
    self.check:SetBackground("DhorPlugins/Travel/OrendarUIMods/Resources/checkbox_02_empty.tga");

	self:Layout();
	
    -- listeners
    self.check.MouseClick = function(sender, args)
        if (not self:IsEnabled()) then
            return;
        end
        
        if (args.Button == Turbine.UI.MouseButton.Left) then
            self:SetChecked(not self.checked);
			if (type(self.Click) == "function") then
				self:Click({});
			end
        end
    end
end

function CheckBox:IsChecked()
    return self.checked;
end

function CheckBox:SetChecked(checked)
    self.checked = checked;
    self:UpdateState();
end

function CheckBox:SetEnabled(enabled)
    Turbine.UI.Control.SetEnabled(self, enabled);
    self:UpdateState();
end

function CheckBox:SetText(text)
    self.label:SetText(text);
end

function CheckBox:SetSize(width, height)
    self.base.SetSize(self, width, height);
    self:Layout();
end

function CheckBox:SetCheckBoxLocation(location)
	self.checkboxLocation = location;
end

function CheckBox:Layout()
    local width, height = self:GetSize();
	if (self.checkboxLocation == CheckBox.LocationRight) then
		self.label:SetPosition(0, 0);
		self.label:SetSize(width - 22, height);
		self.check:SetPosition(width - 16, ((height - 16) / 2));
	else
		self.label:SetPosition(22, 0);
		self.label:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleLeft);
		self.label:SetSize(width - 22, height);
		self.check:SetPosition(0, ((height - 16) / 2));
	end
end

function CheckBox:UpdateState()
    local enabled = self:IsEnabled();
    self.label:SetForeColor(enabled and CheckBox.ItemColor or CheckBox.DisabledColor);
    if (self.checked) then
        self.check:SetBackground("DhorPlugins/Travel/OrendarUIMods/Resources/checkbox_02"..(enabled and "" or "_ghosted")..".tga");
    else
        self.check:SetBackground("DhorPlugins/Travel/OrendarUIMods/Resources/checkbox_02_empty"..(enabled and "" or "_ghosted")..".tga");
    end
end
