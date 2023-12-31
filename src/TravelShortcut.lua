--[[ This is an extension of the Turbine Shortcut item 	]] --
--[[ that will maintain some extra data, such as name, type, index ]] --
--[[ and enabled status	]] --
TravelShortcut = class(Turbine.UI.Lotro.Shortcut);

function TravelShortcut:Constructor(sType, data, name, tType, index, enabled, skillLabel, desc)
    Turbine.UI.Lotro.Shortcut.Constructor(self);

    -- the data to keep track of
    self.Name = name;
    self.desc = desc;
    self.travelType = tType;
    self.Index = index;
    self.Enabled = enabled;
    self.skillLabel = skillLabel;

    self:SetType(sType);
    self:SetData(data);
end

-- function to set the enabled status
function TravelShortcut:SetEnabled(value)
    -- if the value type is not boolean, set an error
    if (type(value) ~= "boolean") then
        self.Enabled = nil;
        error(string.format("Invalid input arg for TravelShortcut:SetEnabled: %q", value));
        return;
    end

    -- else, set the value
    self.Enabled = value;
end

-- function to check the enabled status of the shortcut
function TravelShortcut:IsEnabled()
    return self.Enabled;
end

-- function to set the name of the shortcut
function TravelShortcut:SetName(text)
    -- if the value is not a string, set an error
    if (type(text) ~= "string") then
        self.Name = "not a string";
        error(string.format("Invalid input arg for TravelShortcut:SetName"));
        return;
    end

    self.Name = text;
end

-- function to return the ingame skill name of the shortcut
function TravelShortcut:GetName()
    return self.Name;
end

-- function to return an optional skill description to disambiguate identical skill names
function TravelShortcut:GetDescription()
    return self.desc;
end

-- function to return the plugin specific skill label of the shortcut
function TravelShortcut:GetSkillLabel()
    return self.skillLabel;
end

-- function to set the index of the shortcut
function TravelShortcut:SetIndex(value)
    self.Index = value;
end

-- function to return the index of the shortcut
function TravelShortcut:GetIndex()
    return self.Index;
end

-- function to set the type of the shortcut
function TravelShortcut:SetTravelType(type)
    -- for future use
end

-- function to get the type of shortcut
function TravelShortcut:GetTravelType()
    return self.travelType;
end

