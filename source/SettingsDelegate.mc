import Toybox.Lang;
import Toybox.WatchUi;

//! Input delegate for SettingsView
class SettingsDelegate extends WatchUi.InputDelegate {
    
    function initialize() {
        InputDelegate.initialize();
    }
    
    function onBack() as Void {
        WatchUi.popView(WatchUi.SLIDE_RIGHT);
    }
}
