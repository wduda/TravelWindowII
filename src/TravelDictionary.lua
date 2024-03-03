TravelDictionary = class()

function TravelDictionary:Constructor()
    self.skillCount = 0;

    -- create the indexed tables that store all the data
    if (PlayerAlignment == Turbine.Gameplay.Alignment.FreePeople) then
        self.gen = IndexedDictionary(self);
        self.rep = IndexedDictionary(self);
        self.hunter = IndexedDictionary(self);
        self.warden = IndexedDictionary(self);
        self.mariner = IndexedDictionary(self);

        self.racials = IndexedDictionary(self);
        self.racial = {}

        self:CreateDictionaries();
        self.racialIDTag = "RACIAL_SKILL";
        self.racial = self.racials.skills[PlayerRaceKey];
        for i = 1, #self.racials.skills do
            self.racials.skills[i].isRacial = true;
        end
    else
        self.creep = IndexedDictionary(self);
        self:CreateCreepDictionary();
    end
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
