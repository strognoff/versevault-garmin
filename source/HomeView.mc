import Toybox.Lang;
import Toybox.WatchUi;
import Toybox.Graphics;

//! Main home view showing a random verse
class HomeView extends WatchUi.View {
    
    private var _app as VerseVaultApp;
    private var _currentVerse as Verse?;
    private var _showHint as Boolean = true;
    private var _hintTimer as Number = 0;
    
    // Warm color scheme
    const COLOR_AMBER = 0xFFBF00;
    const COLOR_SOFT_RED = 0xE57373;
    const COLOR_CREAM = 0xFFF8E1;
    const COLOR_DARK_BROWN = 0x3E2723;
    const COLOR_WARM_BG = 0x2D1F1A;
    const COLOR_CARD = 0x3E2B26;
    const COLOR_MUTED = 0xA89080;
    
    function initialize(app as VerseVaultApp) {
        WatchUi.View.initialize();
        _app = app;
        showNewVerse();
    }
    
    function onLayout(dc as Dc) as Void {
        // Set up input for swipe gestures
        WatchUi.View.setLayout(null);
    }
    
    function onUpdate(dc as Dc) as Void {
        var w = dc.getWidth();
        var h = dc.getHeight();
        
        // Warm gradient-like background
        dc.setColor(COLOR_WARM_BG, COLOR_WARM_BG);
        dc.clear();
        
        // Top accent bar
        dc.setColor(COLOR_AMBER, Graphics.COLOR_TRANSPARENT);
        dc.fillRectangle(0, 0, w, 4);
        
        // Title
        dc.setColor(COLOR_CREAM, Graphics.COLOR_TRANSPARENT);
        dc.drawText(w / 2, 20, Graphics.FONT_TINY, "VerseVault", Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER);
        
        if (_currentVerse != null) {
            drawVerse(dc, w, h);
        }
        
        // Hint text at bottom
        if (_showHint && _hintTimer < 3) {
            dc.setColor(COLOR_MUTED, Graphics.COLOR_TRANSPARENT);
            dc.drawText(w / 2, h - 60, Graphics.FONT_XTINY, "T=new | H = save", Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER);
            dc.drawText(w / 2, h - 45, Graphics.FONT_XTINY, "D=Fav", Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER);
            dc.drawText(w / 2, h - 30, Graphics.FONT_XTINY, "U=Themes", Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER);
            dc.drawText(w / 2, h - 15, Graphics.FONT_XTINY, "R=Stats", Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER);
        }
    }
    
    function drawVerse(dc as Dc, w as Number, h as Number) as Void {
        if (_currentVerse == null) {
            return;
        }
        
        var verse = _currentVerse as Verse;
        
        // Calculate positions using math
        var centerX = w / 2;
        var centerY = h / 2;
        
        // Verse card background
        var cardPadding = 15;
        var cardWidth = w - (cardPadding * 2);
        var cardX = cardPadding;
        
        // Calculate text dimensions
        var maxTextWidth = cardWidth - 20;
        
        // Choose font based on verse length - use smaller font for longer verses
        var font = Graphics.FONT_TINY;
        var lineHeight = 18;
        
        if (verse.text.length() > 200) {
            font = Graphics.FONT_XTINY;
            lineHeight = 14;
        }
        
        // Word wrap the text manually
        var words = wordWrap(verse.text, maxTextWidth, dc, font);
        
        var textHeight = words.size() * lineHeight;
        var cardHeight = textHeight + 60; // Extra space for reference
        
        // Check if card would overflow with current font
        var minY = 35;
        var maxY = h - 50;
        var availableHeight = maxY - minY;
        
        // If card is too tall, switch to smaller font
        if (cardHeight > availableHeight && font == Graphics.FONT_TINY) {
            font = Graphics.FONT_XTINY;
            lineHeight = 14;
            words = wordWrap(verse.text, maxTextWidth, dc, font);
            textHeight = words.size() * lineHeight;
            cardHeight = textHeight + 60;
        }
        
        // Center the card
        var cardY = centerY - (cardHeight / 2);
        
        // Make sure card stays in bounds
        if (cardY < minY) {
            cardY = minY;
        }
        if ((cardY + cardHeight) > maxY) {
            cardY = maxY - cardHeight;
        }
        
        // Draw card background
        dc.setColor(COLOR_CARD, Graphics.COLOR_TRANSPARENT);
        dc.fillRoundedRectangle(cardX, cardY, cardWidth, cardHeight, 8);
        
        // Draw verse text
        dc.setColor(COLOR_CREAM, Graphics.COLOR_TRANSPARENT);
        var textX = cardX + 10;
        var textY = cardY + 15;
        
        // Draw each line
        for (var i = 0; i < words.size(); i++) {
            dc.drawText(textX, textY + (i * lineHeight), font, words[i], Graphics.TEXT_JUSTIFY_LEFT | Graphics.TEXT_JUSTIFY_VCENTER);
        }
        
        // Draw reference with favorite indicator
        var refY = textY + (words.size() * lineHeight) + 10;
        
        if (_app.isFavorite(verse)) {
            // Draw "F - " in red, then reference in amber
            dc.setColor(COLOR_SOFT_RED, Graphics.COLOR_TRANSPARENT);
            var fText = "F - ";
            var fWidth = dc.getTextDimensions(fText, Graphics.FONT_XTINY)[0];
            var totalText = fText + verse.reference;
            var totalWidth = dc.getTextDimensions(totalText, Graphics.FONT_XTINY)[0];
            var startX = centerX - (totalWidth / 2);
            
            dc.drawText(startX, refY, Graphics.FONT_XTINY, fText, Graphics.TEXT_JUSTIFY_LEFT | Graphics.TEXT_JUSTIFY_VCENTER);
            
            dc.setColor(COLOR_AMBER, Graphics.COLOR_TRANSPARENT);
            dc.drawText(startX + fWidth, refY, Graphics.FONT_XTINY, verse.reference, Graphics.TEXT_JUSTIFY_LEFT | Graphics.TEXT_JUSTIFY_VCENTER);
        } else {
            // Just draw reference normally
            dc.setColor(COLOR_AMBER, Graphics.COLOR_TRANSPARENT);
            dc.drawText(centerX, refY, Graphics.FONT_XTINY, verse.reference, Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER);
        }
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
    
    function showNewVerse() as Void {
        var verses = _app.getAllVerses();
        if (verses.size() > 0) {
            _currentVerse = Verses.getRandomFrom(verses);
        }
        _hintTimer = 0;
    }
    
    function showFavoriteVerse() as Void {
        var favorites = _app.getFavorites();
        if (favorites.size() > 0) {
            _currentVerse = Verses.getRandomFrom(favorites);
        } else {
            // No favorites, show all verses
            showNewVerse();
        }
    }
    
    function setCurrentVerse(verse as Verse) as Void {
        _currentVerse = verse;
        WatchUi.requestUpdate();
    }
    
    function onTap() as Void {
        _app.onVerseRead();
        showNewVerse();
        WatchUi.requestUpdate();
    }
    
    function onHold() as Void {
        if (_currentVerse != null) {
            if (_app.isFavorite(_currentVerse)) {
                _app.removeFavorite(_currentVerse);
            } else {
                _app.addFavorite(_currentVerse);
            }
            WatchUi.requestUpdate();
        }
    }
    
    function incrementHintTimer() as Void {
        _hintTimer++;
    }
}
