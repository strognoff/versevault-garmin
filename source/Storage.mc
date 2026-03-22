import Toybox.Lang;
import Toybox.Application.Storage;

//! Simple storage for favorites and settings
class Storage {
    
    private var _favorites as Array<Verse> = [];
    private var _favoritesKey as String = "versevault_favorites";
    
    function initialize() {
        load();
    }
    
    //! Get a value from storage
    function getValue(key as String) as Object? {
        return Storage.getValue(key);
    }
    
    //! Set a value in storage
    function setValue(key as String, value as Object) as Void {
        Storage.setValue(key, value);
    }
    
    //! Get all favorites
    function getFavorites() as Array<Verse> {
        return _favorites;
    }
    
    //! Check if verse is in favorites
    function isFavorite(verse as Verse) as Boolean {
        for (var i = 0; i < _favorites.size(); i++) {
            if (_favorites[i].reference.equals(verse.reference)) {
                return true;
            }
        }
        return false;
    }
    
    //! Add verse to favorites
    function addFavorite(verse as Verse) as Boolean {
        if (isFavorite(verse)) {
            return false;
        }
        _favorites.add(verse);
        save();
        return true;
    }
    
    //! Remove verse from favorites
    function removeFavorite(verse as Verse) as Boolean {
        for (var i = 0; i < _favorites.size(); i++) {
            if (_favorites[i].reference.equals(verse.reference)) {
                _favorites.remove(verse);
                save();
                return true;
            }
        }
        return false;
    }
    
    //! Save favorites to storage
    function save() as Void {
        // Save as JSON-like string in storage
        var refs = [] as Array<String>;
        for (var i = 0; i < _favorites.size(); i++) {
            refs.add(_favorites[i].reference);
        }
        Storage.setValue(_favoritesKey, refs);
    }
    
    //! Load favorites from storage
    function load() as Void {
        var refs = Storage.getValue(_favoritesKey) as Array<String>?;
        if (refs != null) {
            _favorites = [];
            for (var i = 0; i < refs.size(); i++) {
                var v = findVerseByReference(refs[i]);
                if (v != null) {
                    _favorites.add(v);
                }
            }
        }
    }
    
    //! Find verse by reference
    private function findVerseByReference(ref as String) as Verse? {
        var all = Verses.getAll();
        for (var i = 0; i < all.size(); i++) {
            if (all[i].reference.equals(ref)) {
                return all[i];
            }
        }
        return null;
    }
}
