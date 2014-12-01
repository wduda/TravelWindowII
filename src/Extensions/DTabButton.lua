--[[
	This is an extension of the Turbine Control class used to create
	a button composed of 3 images that can be used on a tab panel.
]]--

import "Turbine";
import "Turbine.UI";
import "Turbine.UI.Lotro";

DTabButton = class(Turbine.UI.Control);

function DTabButton:Constructor()
	Turbine.UI.Control.Constructor( self );

	--[[ instance variables ]]--
	self.selected = false;
	self.mouseOver = false;
	self.index = 0;
	self.lastTime = 0;
		
	-- Set the window to recieve update messages
	self:SetWantsUpdates(true);
	self:SetAllowDrop(true);
	
	-- Create the 3 buttons that will be used to hold
	-- the images
	self.left = Turbine.UI.Button();
	self.left:SetBlendMode(Turbine.UI.BlendMode.AlphaBlend);
	self.left:SetSize(12,29);
	self.left:SetPosition(0,0);
	self.left:SetZOrder(1);
	self.left:SetParent(self);

	self.center = Turbine.UI.Button();
	self.center:SetBlendMode(Turbine.UI.BlendMode.AlphaBlend);
	self.center:SetSize(self:GetWidth() - 28,29);
	self.center:SetPosition(12,0);
	self.center:SetZOrder(2);
	self.center:SetParent(self);
	self.center:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleCenter);

	self.right = Turbine.UI.Button();
	self.right:SetBlendMode(Turbine.UI.BlendMode.AlphaBlend);
	self.right:SetPosition(self:GetWidth() - 18,0);
	self.right:SetSize(16,29);
	self.right:SetZOrder(3);
	self.right:SetParent(self);
	
	--[[ Mouse Click Event Handlers ]]--
	self.left.MouseClick = function(sender,args)
		myParent = self:GetParent();
		myParent:TabMouseClick(self);	
	end
	self.center.MouseClick = function(sender,args)
		myParent = self:GetParent();
		myParent:TabMouseClick(self);	
	end
	self.right.MouseClick = function(sender,args)
		myParent = self:GetParent();
		myParent:TabMouseClick(self);	
	end
	
	--[[ Mouse Over Event Handlers ]]--
	self.left.MouseEnter = function(sender,args)
		self.mouseOver = true;
	end
	self.center.MouseEnter = function(sender,args)	
		self.mouseOver = true;
	end
	self.right.MouseEnter = function(sender,args)	
		self.mouseOver = true;
	end
	
	--[[ Mouse Leave Event Handlers ]]--
	self.left.MouseLeave = function(sender,args)	
		self.mouseOver = false;	
	end
	self.center.MouseLeave = function(sender,args)		
		self.mouseOver = false;	
	end
	self.right.MouseLeave = function(sender,args)	
		self.mouseOver = false;	
	end
	
	--[[ Drag Events ]]--
	self.DragEnter = function(sender,args)
		pcall(function ()
			myParent = self:GetParent();
			myParent:DragEnter(self,args);
			end)
	end

	self.DragDrop = function(sender,args)
		pcall(function ()
			myParent = self:GetParent();
			myParent:DragDrop(self,args);
			end)
	end
end

function DTabButton:SetSelected(value)
   if(type(value) ~= "boolean") then
      self.selected = nil;
      error(string.format("Invalid input %q for DTabButton:SetSelected" , value));
      return;
   end   
   
	self.selected = value;
end

function DTabButton:IsSelected()
   return self.selected;
end

function DTabButton:SetIndex(value)
   -- make sure to accept only numbers
   if(type(value) ~= "number") then
      self.index = 0;
      error(string.format("Invalid input arg for DTabButton:SetIndex.  %q", value));
      return;
   end

   -- make sure the index is not negative
   if(value < 0) then
      self.index = 0;
      error(string.format("Input for DTabButton:SetIndex should not be negative"));
      return;
   end

	self.index = value;
end

function DTabButton:GetIndex()
	return self.index;
end

function DTabButton:SetText(value)
   if(type(value) ~= "string") then
      self.center:SetText("Error");
      error(string.format("Invalid arguement for DTabButton:SetText.  %q",value));
      return;
   end
      
	self.center:SetText(value);
end

function DTabButton:GetText()
   return self.center:GetText();
end

function DTabButton:Update(sender,args)

   -- exit if the button is not visible
	if(not self:IsVisible()) then
		return;
	elseif(Turbine.Engine.GetGameTime() - self.lastTime > 0.1) then
		self.lastTime = Turbine.Engine.GetGameTime();	

      -- set the size and position of the button
		self.center:SetSize(self:GetWidth() - 28,29);
		self.right:SetPosition(self:GetWidth() - 18,0);
		
		-- set the image of the button depending if the mouse is over or the
		-- button is the selected tab.
		if(self.selected or self.mouseOver) then	
			self.left:SetBackground("DhorPlugins/Extensions/Resources/tab_tier1_middle_front_w.tga");
			self.center:SetBackground("DhorPlugins/Extensions/Resources/tab_tier1_middle_front_n.tga");
			self.right:SetBackground("DhorPlugins/Extensions/Resources/tab_tier1_middle_front_e.tga");		
		else
			self.left:SetBackground("DhorPlugins/Extensions/Resources/tab_tier1_middle_back_w.tga");
			self.center:SetBackground("DhorPlugins/Extensions/Resources/tab_tier1_middle_back_n.tga");
			self.right:SetBackground("DhorPlugins/Extensions/Resources/tab_tier1_middle_back_e.tga");	
		end	
	end
end


