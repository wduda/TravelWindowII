--[[ this is an extension of the Turbine MenuItem, but allows the MenuItem
     to return sub menu information  ]]--

DMenuList = class(Turbine.UI.MenuItem)

function DMenuList:Constructor(input)
	Turbine.UI.MenuItem.Constructor( self );

	self:SetText(input);
end

function DMenuList:GetCount()
	local itemList = self:GetItems();
	local number = itemList:GetCount();	
	return number;
end

function DMenuList:Get(index)
	local itemList = self:GetItems();
	local item = itemList:Get(index);
	return item;
end

