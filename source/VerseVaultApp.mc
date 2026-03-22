import Toybox.Lang;
import Toybox.Application;
import Toybox.WatchUi;

//! Main application entry point for VerseVault
class VerseVaultApp extends Application.AppBase {

    //! Storage for favorites and stats
    var storage as Storage?;
    
    //! Statistics
    var versesRead as Number = 0;
    var streak as Number = 0;
    
    //! Current screen
    var currentScreen as Number = 0;
    
    //! Theme filter
    var currentTheme as String = "";
    
    function initialize() {
        AppBase.initialize();
        storage = new Storage();
        loadStats();
    }

    function getInitialView() {
        var homeView = new HomeView(self);
        return [ homeView, new HomeDelegate(homeView) ] as [WatchUi.View, WatchUi.InputDelegate];
    }

    function onStart(state) as Void {
        // App started
    }

    function onStop(state) as Void {
        // Save stats
        saveStats();
        if (storage != null) {
            storage.save();
        }
    }
    
    //! Load statistics from storage
    function loadStats() as Void {
        if (storage != null) {
            versesRead = storage.getValue("versesRead") != null ? storage.getValue("versesRead") : 0;
            streak = storage.getValue("streak") != null ? storage.getValue("streak") : 0;
        }
    }
    
    //! Save statistics
    function saveStats() as Void {
        if (storage != null) {
            storage.setValue("versesRead", versesRead);
            storage.setValue("streak", streak);
        }
    }
    
    //! Increment verses read and update streak
    function onVerseRead() as Void {
        versesRead++;
        streak++;
        saveStats();
    }
    
    //! Get all favorites
    function getFavorites() as Array<Verse> {
        if (storage != null) {
            return storage.getFavorites();
        }
        return [];
    }
    
    //! Add to favorites
    function addFavorite(verse as Verse) as Boolean {
        if (storage != null) {
            return storage.addFavorite(verse);
        }
        return false;
    }
    
    //! Remove from favorites
    function removeFavorite(verse as Verse) as Boolean {
        if (storage != null) {
            return storage.removeFavorite(verse);
        }
        return false;
    }
    
    //! Check if verse is favorite
    function isFavorite(verse as Verse) as Boolean {
        if (storage != null) {
            return storage.isFavorite(verse);
        }
        return false;
    }
    
    //! Get verses by theme
    function getVersesByTheme(theme as String) as Array<Verse> {
        return Verses.getByTheme(theme);
    }
    
    //! Get all verses
    function getAllVerses() as Array<Verse> {
        return Verses.getAll();
    }
}
