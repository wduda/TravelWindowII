--[[
	This is an extension of the Turbine Label class.  It can store it's own data,
	and index.
]]--

import "Turbine";
import "Turbine.UI";
import "Turbine.UI.Lotro";

DLabel = class(Turbine.UI.Label);

function DLabel:Constructor()
	Turbine.UI.Label.Constructor( self );
	
	self.data = "";
	self.index = 0;
	self.visible = true;
end

function DLabel:SetData(stringData)
   -- make sure to only accept actual strings
   if(type (stringData) ~= "string") then
      self.data = "Not a proper string";
      error(string.format("Invalid input arg %q for DLabel:SetData", stringData));
      return;
   end
   
	self.data = stringData;
end

function DLabel:GetData()
	return self.data;
end

function DLabel:SetIndex(value)
   -- make sure to accept only numbers
   if(type(value) ~= "number") then
      self.index = 0;
      error(string.format("Invalid input arg for DLabel:SetIndex.  %q", value));
      return;
   end
   
   -- make sure the number is greater than zero
   if(value < 0) then
      self.index = 0;
      error(string.format("Input for DLabel:SetIndex should not be negative"));
      return;
   end
   
	self.index = value;
end

function DLabel:GetIndex()
	return self.index;
end

