import "TravelWindowII.src.extensions.DLabel";
import "TravelWindowII.src.extensions.DMenuList";
import "TravelWindowII.src.extensions.DPanel";
import "TravelWindowII.src.extensions.DTabButton";
import "TravelWindowII.src.extensions.DItemControl";

-- Load extension tests if test mode is enabled
if Settings and Settings.testMode == 1 then
    import "TravelWindowII.src.extensions.DExtTests"
end