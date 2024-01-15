TravelDictionary = class()

function TravelDictionary:Constructor()
    -- create the indexed tables that store all the data
    self.gen = IndexedDictionary(self);
    self.rep = IndexedDictionary(self);
    self.hunter = IndexedDictionary(self);
    self.warden = IndexedDictionary(self);
    self.mariner = IndexedDictionary(self);

    self.allRaces = IndexedDictionary(self);
    self.racial = {}
    if (PlayerAlignment == Turbine.Gameplay.Alignment.FreePeople) then
        self.creep = IndexedDictionary(self);
    end

    self.skillCount = 0;

    self:CreateDictionaries();
    self.racial.id = self.allRaces:IdAtIndex(PlayerRaceKey);
    self.racial.name = self.allRaces:NameAtIndex(PlayerRaceKey);
    self.racial.desc = self.allRaces:DescAtIndex(PlayerRaceKey);
    self.racial.label = self.allRaces:LabelAtIndex(PlayerRaceKey);
end

-- function to return the count of a specific type of travel
function TravelDictionary:GetCount()
    return self.skillCount;
end

function TravelDictionary:GetClassSkills()
    if PlayerClass == Turbine.Gameplay.Class.Hunter then
        return TravelInfo.hunter;
    elseif PlayerClass == Turbine.Gameplay.Class.Warden then
        return TravelInfo.warden;
    elseif PlayerClass == Turbine.Gameplay.Class.Mariner then
        return TravelInfo.mariner;
    end
    return nil;
end
