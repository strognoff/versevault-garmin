import Toybox.Lang;
import Toybox.WatchUi;

//! Input delegate for FavoritesView
class FavoritesDelegate extends WatchUi.InputDelegate {
    
    private var _view as FavoritesView;
    
    function initialize(view as FavoritesView) {
        InputDelegate.initialize();
        _view = view;
    }
    
    function onNextPage() as Void {
        _view.selectNext();
    }
    
    function onPreviousPage() as Void {
        _view.selectPrevious();
    }
    
    function onBack() as Void {
        WatchUi.popView(WatchUi.SLIDE_DOWN);
    }
}
