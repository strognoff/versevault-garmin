import Toybox.Lang;
import Toybox.WatchUi;

//! Input delegate for FavoritesView
class FavoritesDelegate extends WatchUi.BehaviorDelegate {
    
    private var _view as FavoritesView;
    
    function initialize(view as FavoritesView) {
        BehaviorDelegate.initialize();
        _view = view;
    }
    
    function onSwipe(swipeEvent as WatchUi.SwipeEvent) as Boolean {
        var direction = swipeEvent.getDirection();
        
        if (direction == WatchUi.SWIPE_LEFT) {
            _view.selectNext();
            return true;
        } else if (direction == WatchUi.SWIPE_RIGHT) {
            _view.selectPrevious();
            return true;
        }
        
        return false;
    }
    
    function onTap(clickEvent as WatchUi.ClickEvent) as Boolean {
        _view.viewSelected();
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
    
    function onBack() as Boolean {
        WatchUi.popView(WatchUi.SLIDE_DOWN);
        return true;
    }
}
