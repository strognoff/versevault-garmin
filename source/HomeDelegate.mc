import Toybox.Lang;
import Toybox.WatchUi;

//! Input delegate for HomeView
class HomeDelegate extends WatchUi.BehaviorDelegate {
    
    private var _view as HomeView;
    
    function initialize(view as HomeView) {
        BehaviorDelegate.initialize();
        _view = view;
    }
    
    function onTap(clickEvent as WatchUi.ClickEvent) as Boolean {
        _view.onTap();
        return true;
    }
    
    function onHold(clickEvent as WatchUi.ClickEvent) as Boolean {
        _view.onHold();
        return true;
    }
    
    function onSwipe(swipeEvent as WatchUi.SwipeEvent) as Boolean {
        var direction = swipeEvent.getDirection();
        
        if (direction == WatchUi.SWIPE_UP) {
            // Open Favorites view
            var favView = new FavoritesView(_view);
            WatchUi.pushView(favView, new FavoritesDelegate(favView), WatchUi.SLIDE_UP);
            return true;
        } else if (direction == WatchUi.SWIPE_DOWN) {
            // Open Themes view
            var themesView = new ThemesView(_view);
            WatchUi.pushView(themesView, new ThemesDelegate(themesView), WatchUi.SLIDE_DOWN);
            return true;
        } else if (direction == WatchUi.SWIPE_RIGHT) {
            // Open Settings/Stats view (for watches without menu button)
            var settingsView = new SettingsView();
            WatchUi.pushView(settingsView, new SettingsDelegate(), WatchUi.SLIDE_LEFT);
            return true;
        }
        
        return false;
    }
    
    function onNextPage() as Boolean {
        // Up button -> Open Favorites
        var favView = new FavoritesView(_view);
        WatchUi.pushView(favView, new FavoritesDelegate(favView), WatchUi.SLIDE_UP);
        return true;
    }
    
    function onPreviousPage() as Boolean {
        // Down button -> Open Themes
        var themesView = new ThemesView(_view);
        WatchUi.pushView(themesView, new ThemesDelegate(themesView), WatchUi.SLIDE_DOWN);
        return true;
    }
    
    function onKey(keyEvent as WatchUi.KeyEvent) as Boolean {
        var key = keyEvent.getKey();
        
        if (key == WatchUi.KEY_MENU) {
            // Open Settings view
            var settingsView = new SettingsView();
            WatchUi.pushView(settingsView, new SettingsDelegate(), WatchUi.SLIDE_LEFT);
            return true;
        }
        
        return false;
    }
    
    function onBack() as Boolean {
        // Exit app
        return false; // Return false to allow system to handle back and exit
    }
}
