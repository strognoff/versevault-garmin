import Toybox.Lang;
import Toybox.WatchUi;

//! Input delegate for ThemesView
class ThemesDelegate extends WatchUi.BehaviorDelegate {
    
    private var _view as ThemesView;
    
    function initialize(view as ThemesView) {
        BehaviorDelegate.initialize();
        _view = view;
    }
    
    function onSwipe(swipeEvent as WatchUi.SwipeEvent) as Boolean {
        var direction = swipeEvent.getDirection();
        
        if (direction == WatchUi.SWIPE_LEFT || direction == WatchUi.SWIPE_DOWN) {
            _view.selectNext();
            return true;
        } else if (direction == WatchUi.SWIPE_RIGHT || direction == WatchUi.SWIPE_UP) {
            _view.selectPrevious();
            return true;
        }
        
        return false;
    }
    
    function onTap(clickEvent as WatchUi.ClickEvent) as Boolean {
        _view.selectTheme();
        return true;
    }
    
    function onNextPage() as Boolean {
        _view.selectNext();
        return true;
    }
    
    function onPreviousPage() as Boolean {
        _view.selectPrevious();
        return true;
    }
    
    function onKey(keyEvent as WatchUi.KeyEvent) as Boolean {
        var key = keyEvent.getKey();
        
        if (key == WatchUi.KEY_ENTER) {
            _view.selectTheme();
            return true;
        } else if (key == WatchUi.KEY_UP) {
            _view.selectPrevious();
            return true;
        } else if (key == WatchUi.KEY_DOWN) {
            _view.selectNext();
            return true;
        }
        return false;
    }
    
    function onBack() as Boolean {
        WatchUi.popView(WatchUi.SLIDE_UP);
        return true;
    }
}
