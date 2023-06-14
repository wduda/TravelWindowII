import "TravelWindowII.src.OldTurbineUtil.Class";
import "TravelWindowII.src.TravelWindow";
import "TravelWindowII.src.TravelListTab";
import "TravelWindowII.src.TravelGridTab";
import "TravelWindowII.src.TravelCaroTab";
import "TravelWindowII.src.TravelPulldownTab"
import "TravelWindowII.src.IndexedDictionary"

-- get language from Turbine API to load corresponding translated strings
GLocale = Turbine.Engine.GetLanguage();
if GLocale == 268435459 then
    import "TravelWindowII.src.IndexedDictionaryFr";
elseif GLocale == 268435460 then
    import "TravelWindowII.src.IndexedDictionaryDe";
else
    import "TravelWindowII.src.IndexedDictionaryEn";
end

import "TravelWindowII.src.TravelShortcut";
import "TravelWindowII.src.OptionsWindow";
import "TravelWindowII.src.TravelButton";
-- import "TravelWindowII.src.TravelTests";
import "TravelWindowII.src.MoorMapWindow";
import "TravelWindowII.src.EriadorMapWindow";
import "TravelWindowII.src.RhovanionMapWindow";
import "TravelWindowII.src.GondorMapWindow";
import "TravelWindowII.src.OptionsPanel";
