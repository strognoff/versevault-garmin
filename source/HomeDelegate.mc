import Toybox.Lang;
import Toybox.WatchUi;

//! Input delegate for HomeView
class HomeDelegate extends WatchUi.InputDelegate {
    
    private var _view as HomeView;
    
    function initialize(view as HomeView) {
        InputDelegate.initialize();
        _view = view;
    }
    
    function onSwipeUp() as Void {
        // Open Favorites view
        var favView = new FavoritesView(_view);
        WatchUi.pushView(favView, new FavoritesDelegate(favView), WatchUi.SLIDE_UP);
    }
    
    function onSwipeDown() as Void {
        // Open Themes view
        var themesView = new ThemesView(_view);
        WatchUi.pushView(themesView, new ThemesDelegate(themesView), WatchUi.SLIDE_DOWN);
    }
    
    function onMenu() as Void {
        // Open Settings view
        var settingsView = new SettingsView();
        WatchUi.pushView(settingsView, new SettingsDelegate(), WatchUi.SLIDE_LEFT);
    }
    
    function onBack() as Void {
        // Exit app
        WatchUi.popView(WatchUi.SLIDE_RIGHT);
    }
}
