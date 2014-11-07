if(DhorPlugins.testing) then
import "Turbine.Testing";
import "Turbine.Testing.Assert";

extTest = unittest();

function extTest:Setup()
   self.testLabel = DLabel();
   self.testMenuList = DMenuList();
   self.testPanel = DPanel();
   self.testTabButton = DTabButton();
   self.testItemControl = DItemControl();
end

function extTest:Teardown()
   self.testLabel = nil;
   self.testMenuList = nil;
   self.testPanel = nil;
   self.testTabButton = nil;
   self.testItemControl = nil;
end

function extTest:TestDLabel()
   -- the data field should only accept strings
   pcall(function()
      self.testLabel:SetData(19);    -- put in a number, it should not match
   end);
   Turbine.Testing.Assert.AreNotEqual(19,self.testLabel:GetData(),"There should not be a match");

   -- make sure the strings match
   local testString = "abcdefghijklmnopqrstuvwxyz1234567890Üáçòøÿ";   
   pcall(function()
      self.testLabel:SetData(testString);
   end);
   Turbine.Testing.Assert.AreEqual(testString,self.testLabel:GetData(),"The expected return string did not match");
   
   -- the index field should not accept a string
   pcall(function()
      self.testLabel:SetIndex("number");
   end);
   Turbine.Testing.Assert.AreNotEqual("number",self.testLabel:GetIndex(),"The index should not match");
   
   -- the index field should not accept negative numbers
   pcall(function()
      self.testLabel:SetIndex(-99);
   end);
   Turbine.Testing.Assert.AreNotEqual(-99,self.testLabel:GetIndex(),"The index should not match");
   
   -- positive numbers should work
   pcall(function()
      self.testLabel:SetIndex(99);
   end);
   Turbine.Testing.Assert.AreEqual(99,self.testLabel:GetIndex(),"The index should have matched this time");
end

function extTest:TestDMenuList()
   pcall(function()
      self.testMenuList:SetText(1);
   end);
   Turbine.Testing.Assert.AreNotEqual(1,self.testMenuList:GetText(),"Menu List text issue");
   
   Turbine.Testing.Assert.AreEqual(0,self.testMenuList:GetCount(),"There should be 0 items in the list right now");
   
   -- add an item to the list then check again
   self.Filters1 = Turbine.UI.MenuItem("test item");
   FilterItems = self.testMenuList:GetItems();
	FilterItems:Add(self.Filters1);	
   Turbine.Testing.Assert.AreEqual(1,self.testMenuList:GetCount(),"There should be 1 item in the list right now");
   
   -- check the returned item matches the created one
   Turbine.Testing.Assert.AreEqual(self.Filters1:GetText(),self.testMenuList:Get(1):GetText(),"The two items in the menu list should match");
end

function extTest:TestDPanel()
   
end

function extTest:TestDTabButton()
   pcall(function()
      self.testTabButton:SetSelected("something");
   end);
   Turbine.Testing.Assert.IsNil(self.testTabButton:IsSelected(),"Should set to nil on invalid input");
   
   pcall(function()
      self.testTabButton:SetSelected(true);
   end);
   Turbine.Testing.Assert.IsTrue(self.testTabButton:IsSelected(),"Should be true");
      
   pcall(function()
      self.testTabButton:SetSelected(false);      
   end);
   Turbine.Testing.Assert.IsFalse(self.testTabButton:IsSelected(),"Should be false");

   -- the index field should not accept a string
   pcall(function()
      self.testTabButton:SetIndex("number");
   end);
   Turbine.Testing.Assert.AreNotEqual("number",self.testTabButton:GetIndex(),"The index should not match");
   
   -- the index field should not accept negative numbers
   pcall(function()
      self.testTabButton:SetIndex(-99);
   end);
   Turbine.Testing.Assert.AreNotEqual(-99,self.testTabButton:GetIndex(),"The index should not match");
   
   -- positive numbers should work
   self.testTabButton:SetIndex(99);
   Turbine.Testing.Assert.AreEqual(99,self.testTabButton:GetIndex(),"The index should have matched this time");

   -- the data field should only accept strings
   pcall(function()
      self.testTabButton:SetText(19);    -- put in a number, it should not match
   end);
   Turbine.Testing.Assert.AreNotEqual(19,self.testTabButton:GetText(),"There should not be a match");

   -- make sure the strings match
   local testString = "abcdefghijklmnopqrstuvwxyz1234567890Üáçòøÿ";
   pcall(function()
      self.testTabButton:SetText(testString);
   end);
   Turbine.Testing.Assert.AreEqual(testString,self.testTabButton:GetText(),"The expected return string should match");  
end

function extTest:TestDItemControl()
   -- the index field should not accept a string
   pcall(function()
      self.testItemControl:SetBagIndex("number");
   end);
   Turbine.Testing.Assert.AreNotEqual("number",self.testItemControl:GetBagIndex(),"The index should not match");
   
   -- the index field should not accept negative numbers
   pcall(function()
      self.testItemControl:SetBagIndex(-99);
   end);
   Turbine.Testing.Assert.AreNotEqual(-99,self.testItemControl:GetBagIndex(),"The index should not match");
   
   -- positive numbers should work
   self.testItemControl:SetBagIndex(99);
   Turbine.Testing.Assert.AreEqual(99,self.testItemControl:GetBagIndex(),"The index should have matched this time");
end

end