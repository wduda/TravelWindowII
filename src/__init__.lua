import "TravelWindowII.src.OldTurbineUtil.Class";
import "TravelWindowII.src.TravelWindow";
import "TravelWindowII.src.TravelListTab";
import "TravelWindowII.src.TravelGridTab";
import "TravelWindowII.src.TravelCaroTab";
import "TravelWindowII.src.TravelPulldownTab"
import "TravelWindowII.src.IndexedDictionary"
import "TravelWindowII.src.TravelDictionary"
import "TravelWindowII.src.SkillData"

-- get language from Turbine API to load corresponding translated strings
GLocale = Turbine.Engine.GetLanguage();
if GLocale == Turbine.Language.French then
    import "TravelWindowII.src.IndexedDictionaryFr";
elseif GLocale == Turbine.Language.German then
    import "TravelWindowII.src.IndexedDictionaryDe";
else
    import "TravelWindowII.src.IndexedDictionaryEn";
end

import "TravelWindowII.src.TravelShortcut";
import "TravelWindowII.src.OptionsWindow";
import "TravelWindowII.src.TravelButton";
-- import "TravelWindowII.src.TravelTests";
import "TravelWindowII.src.MapWindow";
import "TravelWindowII.src.OptionsPanel";
