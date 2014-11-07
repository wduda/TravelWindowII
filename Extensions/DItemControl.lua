--[[
	This is an extension of the Turbine Item class.  It can store the backpack index.
]]--

import "Turbine";
import "Turbine.UI";
import "Turbine.UI.Lotro";

DItemControl = class(Turbine.UI.Lotro.ItemControl);

function DItemControl:Contstructor()
   Turbine.UI.Lotro.ItemControl(self);
   
   self.bagIndex = 0;
end

function DItemControl:SetBagIndex(index)
   -- make sure to accept only numbers
   if(type(index) ~= "number") then
      self.bagIndex = 0;
      error(string.format("Invalid input arg for DItemControl:SetBagIndex.  %q", index));
      return;
   end
   
   -- make sure the index is not negative
   if(index < 0) then
      self.bagIndex = 0;
      error(string.format("Input for DItemControl:SetBagIndex should not be negative"));
      return;
   end

   self.bagIndex = index;
end

function DItemControl:GetBagIndex()
   return self.bagIndex;
end