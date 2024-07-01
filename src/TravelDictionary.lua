import "TravelWindowII.src.IndexedDictionary"

TravelDictionary = class()

function TravelDictionary:Constructor()
    self.skillCount = 0;

    -- create the indexed tables that store all the data
    if (PlayerAlignment == Turbine.Gameplay.Alignment.FreePeople) then
        self.gen = IndexedDictionary(self, LC.genericLabel);
        self.rep = IndexedDictionary(self, LC.repLabel);
        self.hunter = IndexedDictionary(self, LC.classLabel);
        self.warden = IndexedDictionary(self, LC.classLabel);
        self.mariner = IndexedDictionary(self, LC.classLabel);

        self.racials = IndexedDictionary(self, LC.racialLabel);
        self.racial = {}

        self:CreateDictionaries();
        self.racialIDTag = "RACIAL_SKILL";
        self.racial = self.racials.skills[PlayerRaceKey];
        for i = 1, #self.racials.skills do
            self.racials.skills[i].isRacial = true;
        end
    else
        self.creep = IndexedDictionary(self, LC.genericLabel);
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

function TravelDictionary:SetSkillLabels()
    if (PlayerAlignment == Turbine.Gameplay.Alignment.FreePeople) then
        self.gen:SetSkillLabels()
        self.rep:SetSkillLabels()
        self.hunter:SetSkillLabels()
        self.warden:SetSkillLabels()
        self.mariner:SetSkillLabels()
        self.racials:SetSkillLabels()
    else
        self.creep:SetSkillLabels()
    end
end
