import "Turbine";
import "Turbine.Gameplay";
import "Turbine.UI";
import "Turbine.UI.Extensions";
import "Turbine.UI.Lotro";
import "DhorPlugins.Extensions";

--[[
	This is an extension of the scrollable control
	It will allow the creation of a panel that can
	contain its own controls
]]--

DPanel = class(Turbine.UI.Control);

function DPanel:Constructor()
	Turbine.UI.Control.Constructor( self );

	--[[ initial settings ]]--
	self:SetOpacity( 1 );
	self:SetWantsUpdates(true);
		
	--[[ instance variables ]]--
	self.tabButtons = { };
	self.tabPages = { };	
	self.pageCount = 0;
	self.selectedPage = 0;
	self.lastPage = 0;
	self.showButtons = true;
	
	self.lastTime = 0;	
end

-- handle updating the panel
function DPanel:Update( sender, args )

	-- only update if the selected tab has changed
	if(self.lastPage ~= self.selectedPage) then
		
		-- if the last selected tab is valid, disable it
		if(self.pageCount > 0) then					
			if(self.lastPage > 0) then			
				self.tabButtons[self.lastPage]:SetSelected(false);
				self.tabPages[self.lastPage]:SetVisible(false);
				self.tabPages[self.lastPage]:SetOpacity(0);
			end
			
			-- enable the selected tab
			self.tabButtons[self.selectedPage]:SetSelected(true);
			self.tabPages[self.selectedPage]:SetVisible(true);
			self.tabPages[self.selectedPage]:SetOpacity(1);
			
			-- set the currect tab as the last tab			
			self.lastPage = self.selectedPage;
		end			
	end	         
end

--[[ 
	This is the function that is called when
	when a DTabButton registers a Mouse
	Click Event
]]--
function DPanel:TabMouseClick(sender)
	self.selectedPage = sender:GetIndex();
end

-- function to programmatically change which tab is visible
function DPanel:SetTab(value)
	self.selectedPage = value;
end

--[[
	Call this function to add a page to
	the tab panel. Use a TextBox as a panel
]]--
function DPanel:AddTab(Tab)
	self.pageCount = self.pageCount + 1;
	
	-- set the standard page settings
	Tab:SetVisible( true );
	Tab:SetZOrder(10);
	Tab:SetParent(self);
	Tab:SetPosition(0,25);
	Tab:SetSize(self:GetWidth(),self:GetHeight() - 25);
	
	-- set the standard button settings
	myButton = DhorPlugins.Extensions.DTabButton();
	myButton:SetParent(self);	
	myButton:SetZOrder(10);
	myButton:SetIndex(self.pageCount);
	
	-- insert the text box and buttons into the tables
	table.insert(self.tabButtons,myButton);
	table.insert(self.tabPages,Tab);
	
	-- update
	self.selectedPage=1;
	self:UpdateTabs();	
end

--[[
	This function will go through each button
	in the list and adjust them based on how
	wide the panel is, and on how many panels
	are in the tabbed panel
]]--
function DPanel:UpdateTabs()

	-- loop through each tab
	for i = 1,self.pageCount,1 do
		-- check if the buttons are showing	
		if(self.showButtons) then		
			self.tabPages[i]:SetSize(self:GetWidth(),self:GetHeight() - 25);
			self.tabPages[i]:SetPosition(0,25);		
			self.tabButtons[i]:SetPosition((i-1) * (self:GetWidth() / self.pageCount),0);
			self.tabButtons[i]:SetWidth(self:GetWidth() / self.pageCount);
			self.tabButtons[i]:SetHeight(25);
			self.tabButtons[i]:SetVisible(true);
		else	
			self.tabPages[i]:SetSize(self:GetSize());
			self.tabPages[i]:SetPosition(0,0);
			self.tabButtons[i]:SetVisible(false);
		end
			
			
		self.tabButtons[i]:SetSelected(false);
		self.tabPages[i]:SetVisible(false);
	end
	
	if(self.selectedPage ~= 0) then
		self.tabPages[self.selectedPage]:SetVisible(true);
		self.tabButtons[self.selectedPage]:SetSelected(true);
		self:SetVisible(false);
		self:SetVisible(true);
	end
end


--	Function for changing the button visibility
function DPanel:SetButtonsVisible(value)
	self.showButtons=value;
	self:UpdateTabs();
end

-- function to set the text on a tab button
function DPanel:SetTabText(index,value)
	self.tabButtons[index]:SetText(value);
	self:UpdateTabs();
end

-- function to handle drag drop event
function DPanel:DragDrop(sender,args)
	pcall(function()
		self.tabPages[sender:GetIndex()]:DragDrop(self,args);
		end)
end

-- function to handle drag enter events
function DPanel:DragEnter(sender,args)
	pcall(function()
		self.tabPages[sender:GetIndex()]:DragEnter(self,args);
		end)
end
