import Toybox.Lang;
import Toybox.WatchUi;

//! Input delegate for ThemesView
class ThemesDelegate extends WatchUi.InputDelegate {
    
    private var _view as ThemesView;
    
    function initialize(view as ThemesView) {
        InputDelegate.initialize();
        _view = view;
    }
    
    function onKeyPressed(key as WatchUi.KeyEvent) as Boolean {
        if (key.getKey() == WatchUi.KEY_ENTER) {
            _view.selectTheme();
            return true;
        } else if (key.getKey() == WatchUi.KEY_UP) {
            _view.selectPrevious();
            return true;
        } else if (key.getKey() == WatchUi.KEY_DOWN) {
            _view.selectNext();
            return true;
        }
        return false;
    }
    
    function onBack() as Void {
        WatchUi.popView(WatchUi.SLIDE_UP);
    }
}
