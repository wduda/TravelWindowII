import "Turbine";
import "Turbine.Debug";
import "Turbine.Gameplay";
import "Turbine.UI";
import "Turbine.UI.Lotro";
import "DhorPlugins.Extensions";
import "DhorPlugins.Utils.BitOps";

--[[ This is the simple window that can be used to toggle 	]]--
--[[ the main Travel Window visible.]]--

TravelButton = class( Turbine.UI.Extensions.SimpleWindow );

function TravelButton:Constructor(parent)
	Turbine.UI.Extensions.SimpleWindow.Constructor( self );
	
   -- keep track of our parent window
	self.mainWindow = parent;
	
	-- set defaults
	self:SetSize(32,32);
	self:SetPosition(350,350);
	self:SetBackground("DhorPlugins/Travel/Resources/travel.tga");
	self:SetBackColorBlendMode(Turbine.UI.BlendMode.Multiply);
	self:SetBackColor(Turbine.UI.Color(0,0.5,0.5,0.5));
	self:SetWantsUpdates(true);
	self:SetOpacity(0.2);
	self:SetZOrder(1);	
	
	--[[ EVENT HANDLERS ]]-- 
	
	-- variables for tracking if the button is
	-- being moved around the window
   local isMoving = false;
   local hasMoved = false;
   local isHighlighted = false;
   local buttonDownTime = 0;
	local x = 0;
	local y = 0;
	
	function TravelButton:Update(sender, args)
	
	   if(isMoving) then
        if(not isHighlighted) then
          if(Turbine.Engine.GetGameTime() - buttonDownTime > 0.4) then
            self:SetBackColor(Turbine.UI.Color(1.0,0.5,0.5,0.95));
            isHighlighted = true;
            hasMoved = true;
          else  
            self:SetWantsUpdates(true);
          end          
        end
      else  
        Turbine.UI.Extensions.SimpleWindow.Update(self,args);
      end      
	end
   
   -- go to full opacity if mouse is over	
   self.MouseEnter = function(sender, args)
      self:SetOpacity(settings.toggleMaxOpacity);
   end
   
   -- go to low opacity when mosue is not over
   self.MouseLeave = function(sender, args)
      self:SetOpacity(settings.toggleMinOpacity);
   end

   -- if the mouse button is press, prepare to maybe move the button
	self.MouseDown = function(sender, args )
		if (args.Button == Turbine.UI.MouseButton.Left) then
			buttonDownTime = Turbine.Engine.GetGameTime();
			self:SetWantsUpdates(true);
         isMoving = true;
			x = args.X;
			y = args.Y;			
		end
	end

   -- mouse button released, handle a potential move
	self.MouseUp = function(sender, args )
		if (args.Button == Turbine.UI.MouseButton.Left) then
			isMoving = false;
			isHighlighted = false;
			self:SetWantsUpdates(false);
			
			-- if the window moved, update the settings, but do not toggle
			-- the visibility of the button
			if(hasMoved) then
			   local one,two = self:GetPosition();
			   settings.buttonPositionX = one;
			   settings.buttonPositionY = two;			
			   self.mainWindow:UpdateSettings();
			   hasMoved = false;
			   self:SetBackColor(Turbine.UI.Color(0,0.5,0.5,0.5));
			   
			else
			   self.mainWindow:SetVisible(not self.mainWindow:IsVisible());
			end
		else
		   menu:ShowMenu();
		end
	end

   -- handle moving the button
	self.MouseMove = function(sender, args )
		if (isMoving and Turbine.Engine.GetGameTime() - buttonDownTime > 0.4) then
		   self:SetBackColor(Turbine.UI.Color(1.0,0.5,0.5,0.95));
			hasMoved = true;
			local oldX,oldY = self:GetPosition();
			self:SetPosition(oldX + args.X - x,oldY + args.Y - y);	
		end
	end   	
end

function TravelButton:UpdateOpacity()
   self:SetOpacity(settings.toggleMinOpacity);
end



	