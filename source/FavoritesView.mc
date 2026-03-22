import Toybox.Lang;
import Toybox.WatchUi;
import Toybox.Graphics;

//! View for displaying favorites
class FavoritesView extends WatchUi.View {
    
    private var _homeView as HomeView;
    private var _favorites as Array<Verse> = [];
    private var _selectedIndex as Number = 0;
    private var _app as VerseVaultApp;
    
    // Colors
    const COLOR_AMBER = 0xFFBF00;
    const COLOR_SOFT_RED = 0xE57373;
    const COLOR_CREAM = 0xFFF8E1;
    const COLOR_WARM_BG = 0x2D1F1A;
    const COLOR_CARD = 0x3E2B26;
    const COLOR_MUTED = 0xA89080;
    
    function initialize(homeView as HomeView) {
        WatchUi.View.initialize();
        _homeView = homeView;
        _app = Application.getApp() as VerseVaultApp;
        refreshFavorites();
    }
    
    function refreshFavorites() as Void {
        _favorites = _app.getFavorites();
        if (_selectedIndex >= _favorites.size()) {
            _selectedIndex = 0;
        }
    }
    
    function onLayout(dc as Dc) as Void {
        // Draw everything in onUpdate
    }
    
    function onUpdate(dc as Dc) as Void {
        var w = dc.getWidth();
        var h = dc.getHeight();
        
        // Background
        dc.setColor(COLOR_WARM_BG, COLOR_WARM_BG);
        dc.clear();
        
        // Header
        dc.setColor(COLOR_AMBER, Graphics.COLOR_TRANSPARENT);
        dc.fillRectangle(0, 0, w, 4);
        
        dc.setColor(COLOR_CREAM, Graphics.COLOR_TRANSPARENT);
        dc.drawText(w / 2, 25, Graphics.FONT_TINY, "Favorites", Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER);
        
        dc.setColor(COLOR_MUTED, Graphics.COLOR_TRANSPARENT);
        dc.drawText(w / 2, 42, Graphics.FONT_XTINY, _favorites.size() + " verses", Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER);
        
        if (_favorites.size() == 0) {
            // No favorites message
            dc.setColor(COLOR_MUTED, Graphics.COLOR_TRANSPARENT);
            dc.drawText(w / 2, h / 2, Graphics.FONT_TINY, "No favorites yet", Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER);
            dc.drawText(w / 2, h / 2 + 25, Graphics.FONT_XTINY, "Hold a verse to save it", Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER);
        } else {
            drawFavoriteVerse(dc, w, h);
        }
        
        // Back hint
        dc.setColor(COLOR_MUTED, Graphics.COLOR_TRANSPARENT);
        dc.drawText(w / 2, h - 20, Graphics.FONT_XTINY, "Back to go back", Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER);
    }
    
    function drawFavoriteVerse(dc as Dc, w as Number, h as Number) as Void {
        var verse = _favorites[_selectedIndex];
        
        var cardPadding = 15;
        var cardWidth = w - (cardPadding * 2);
        var cardX = cardPadding;
        
        // Calculate text
        var maxTextWidth = cardWidth - 20;
        
        // Choose font based on verse length - use smaller font for longer verses
        var font = Graphics.FONT_TINY;
        var lineHeight = 18;
        
        if (verse.text.length() > 200) {
            font = Graphics.FONT_XTINY;
            lineHeight = 14;
        }
        
        // Word wrap manually
        var words = wordWrap(verse.text, maxTextWidth, dc, font);
        var textHeight = words.size() * lineHeight;
        var cardHeight = textHeight + 60;
        
        var cardY = 70;
        var minY = 70;
        var maxY = h - 40;
        var availableHeight = maxY - minY;
        
        // If card is too tall, switch to smaller font
        if (cardHeight > availableHeight && font == Graphics.FONT_TINY) {
            font = Graphics.FONT_XTINY;
            lineHeight = 14;
            words = wordWrap(verse.text, maxTextWidth, dc, font);
            textHeight = words.size() * lineHeight;
            cardHeight = textHeight + 60;
        }
        
        if ((cardY + cardHeight) > maxY) {
            cardHeight = maxY - cardY;
        }
        
        // Card background
        dc.setColor(COLOR_CARD, Graphics.COLOR_TRANSPARENT);
        dc.fillRoundedRectangle(cardX, cardY, cardWidth, cardHeight, 8);
        
        // Draw text
        dc.setColor(COLOR_CREAM, Graphics.COLOR_TRANSPARENT);
        for (var i = 0; i < words.size(); i++) {
            dc.drawText(cardX + 10, cardY + 15 + (i * lineHeight), font, words[i], Graphics.TEXT_JUSTIFY_LEFT | Graphics.TEXT_JUSTIFY_VCENTER);
        }
        
        // Draw reference with favorite indicator
        var refY = cardY + textHeight + 25;
        dc.setColor(COLOR_SOFT_RED, Graphics.COLOR_TRANSPARENT);
        var fText = "F - ";
        var fWidth = dc.getTextDimensions(fText, Graphics.FONT_XTINY)[0];
        var totalText = fText + verse.reference;
        var totalWidth = dc.getTextDimensions(totalText, Graphics.FONT_XTINY)[0];
        var startX = (w / 2) - (totalWidth / 2);
        
        dc.drawText(startX, refY, Graphics.FONT_XTINY, fText, Graphics.TEXT_JUSTIFY_LEFT | Graphics.TEXT_JUSTIFY_VCENTER);
        
        dc.setColor(COLOR_AMBER, Graphics.COLOR_TRANSPARENT);
        dc.drawText(startX + fWidth, refY, Graphics.FONT_XTINY, verse.reference, Graphics.TEXT_JUSTIFY_LEFT | Graphics.TEXT_JUSTIFY_VCENTER);
    }
    
    //! Manual word wrap function
    private function wordWrap(text as String, maxWidth as Number, dc as Dc, font as Graphics.FontDefinition) as Array<String> {
        var lines = [] as Array<String>;
        var line = "";
        var space = " ";
        
        // Simple character-by-character word wrap
        var idx = 0;
        while (idx < text.length()) {
            var c = text.substring(idx, idx + 1);
            
            if (c.equals(space)) {
                // Check if adding this word would exceed width
                var testLine = line.equals("") ? line + c : line + space;
                var testDims = dc.getTextDimensions(testLine, font);
                
                if (testDims[0] > maxWidth && !line.equals("")) {
                    lines.add(line);
                    line = "";
                } else {
                    line = testLine;
                }
                idx++;
            } else {
                // Add character to line
                var testLine = line + c;
                var testDims = dc.getTextDimensions(testLine, font);
                
                if (testDims[0] > maxWidth && !line.equals("")) {
                    lines.add(line);
                    line = c;
                } else {
                    line = testLine;
                }
                idx++;
            }
        }
        
        if (!line.equals("")) {
            lines.add(line);
        }
        
        return lines;
    }
    
    function selectNext() as Void {
        if (_favorites.size() > 0) {
            _selectedIndex = (_selectedIndex + 1) % _favorites.size();
            WatchUi.requestUpdate();
        }
    }
    
    function selectPrevious() as Void {
        if (_favorites.size() > 0) {
            _selectedIndex = (_selectedIndex - 1 + _favorites.size()) % _favorites.size();
            WatchUi.requestUpdate();
        }
    }
    
    function removeSelected() as Void {
        if (_favorites.size() > 0) {
            var verse = _favorites[_selectedIndex];
            _app.removeFavorite(verse);
            refreshFavorites();
            WatchUi.requestUpdate();
        }
    }
    
    function viewSelected() as Void {
        if (_favorites.size() > 0) {
            // Show this verse in the home view
            _homeView.showFavoriteVerse();
            WatchUi.popView(WatchUi.SLIDE_DOWN);
        }
    }
}
