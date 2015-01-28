import "DhorPlugins.Travel.OldTurbineUtil.Class";
import "DhorPlugins.Travel.TravelWindow";
import "DhorPlugins.Travel.TravelListTab";
import "DhorPlugins.Travel.TravelGridTab";
import "DhorPlugins.Travel.TravelCaroTab";
import "DhorPlugins.Travel.TravelPulldownTab"
GLocale = Turbine.Engine.GetLanguage();
if GLocale == 268435459 then import "DhorPlugins.Travel.IndexedDictionaryFr";
elseif GLocale == 268435460 then import "DhorPlugins.Travel.IndexedDictionaryDe";
elseif GLocale == 268435463 then import "DhorPlugins.Travel.IndexedDictionaryRu"; --by PulseDiver
else import "DhorPlugins.Travel.IndexedDictionary";
end
-- import "DhorPlugins.Travel.IndexedDictionary";
import "DhorPlugins.Travel.TravelShortcut";
import "DhorPlugins.Travel.OptionsWindow";
import "DhorPlugins.Travel.TravelButton";
import "DhorPlugins.Travel.TravelTests";
import "DhorPlugins.Travel.MoorMapWindow";
import "DhorPlugins.Travel.EriadorMapWindow";
import "DhorPlugins.Travel.RhovanionMapWindow";
import "DhorPlugins.Travel.GondorMapWindow";
import "DhorPlugins.Travel.OptionsPanel";
