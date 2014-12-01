if(DhorPlugins.testing) then

import "Turbine.Testing";

TravelTests = unittest();

   -- create an option window and a travel shortcut to perform the tests on
   function TravelTests:Setup()
      self.optionWindow = DhorPlugins.Travel.OptionsWindow();
      self.testShortcut = DhorPlugins.Travel.TravelShortcut();
   end
   
   -- ensure the option window is closed and removed at the end of testing
   function TravelTests:TearDown()
      self.optionWindow:SetVisible(false);
      self.optionWindow = nil;
   end
   
   -- simple test to check that the travel window was created without error
   function TravelTests:TestOptionPanel()
      Turbine.Testing.Assert.IsTrue(self.optionWindow:GetLoaded(),"The option window failed to load.");
   end
   
   -- a number of tests to check the functionality of the travel shortcut
   function TravelTests:TestTravelShortcut()
      local testString = "abcdefghijklmnopqrstuvwxyz1234567890Üáçòøÿ"; 
   
      -- the travel shortcut should only accept string values, test setting
      -- the name to a number
      pcall(function()
           self.testShortcut:SetName(1);
      end);
      Turbine.Testing.Assert.AreNotEqual(1,self.testShortcut:GetName(),"Should not be equal");
      
      -- test setting the name to a string
      self.testShortcut:SetName(testString);
      Turbine.Testing.Assert.AreEqual(testString,self.testShortcut:GetName(),"The returned name should be the same");
      
      -- the enabled setting should only accept boolean values
      pcall(function()
           self.testShortcut:SetEnabled("hello");
      end);
      Turbine.Testing.Assert.IsNil(self.testShortcut:IsEnabled(),"Invalid arg for enabled should set it to nil");
      
      -- test setting the enabled value true
      self.testShortcut:SetEnabled(true);
      Turbine.Testing.Assert.IsTrue(self.testShortcut:IsEnabled(),"Should be true");
      
      -- test setting the enabled value false
      self.testShortcut:SetEnabled(false);
      Turbine.Testing.Assert.IsFalse(self.testShortcut:IsEnabled(),"Should be false");
   end
end
