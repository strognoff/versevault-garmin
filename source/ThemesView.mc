import Toybox.Lang;
import Toybox.WatchUi;
import Toybox.Graphics;

//! View for displaying theme selection
class ThemesView extends WatchUi.View {
    
    private var _homeView as HomeView;
    private var _app as VerseVaultApp;
    private var _themes as Array<String> = [];
    private var _selectedIndex as Number = 0;
    
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
        _themes = Verses.getThemes();
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
        dc.drawText(w / 2, 25, Graphics.FONT_TINY, "Themes", Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER);
        
        dc.setColor(COLOR_MUTED, Graphics.COLOR_TRANSPARENT);
        dc.drawText(w / 2, 42, Graphics.FONT_XTINY, "Choose a theme", Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER);
        
        // Draw themes as a grid
        drawThemesGrid(dc, w, h);
        
        // Back hint
        dc.setColor(COLOR_MUTED, Graphics.COLOR_TRANSPARENT);
        dc.drawText(w / 2, h - 20, Graphics.FONT_XTINY, "Back to go back", Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER);
    }
    
    function drawThemesGrid(dc as Dc, w as Number, h as Number) as Void {
        var padding = 15;
        var gap = 10;
        var cols = 2;
        var cardWidth = (w - (padding * 2) - gap) / cols;
        var cardHeight = 45;
        
        var startY = 65;
        
        for (var i = 0; i < _themes.size(); i++) {
            var col = i % cols;
            var row = i / cols;
            
            var x = padding + (col * (cardWidth + gap));
            var y = startY + (row * (cardHeight + gap));
            
            var isSelected = (i == _selectedIndex);
            
            // Card background
            if (isSelected) {
                dc.setColor(COLOR_CARD, Graphics.COLOR_TRANSPARENT);
                dc.fillRoundedRectangle(x, y, cardWidth, cardHeight, 6);
                
                // Selected accent
                dc.setColor(COLOR_AMBER, Graphics.COLOR_TRANSPARENT);
                dc.fillRoundedRectangle(x, y, 4, cardHeight, 6);
            } else {
                dc.setColor(0x2A201C, Graphics.COLOR_TRANSPARENT);
                dc.fillRoundedRectangle(x, y, cardWidth, cardHeight, 6);
            }
            
            // Theme name
            var textColor = isSelected ? COLOR_CREAM : COLOR_MUTED;
            dc.setColor(textColor, Graphics.COLOR_TRANSPARENT);
            
            var themeLabel = _themes[i].toUpper();
            dc.drawText(x + cardWidth / 2, y + cardHeight / 2, Graphics.FONT_TINY, themeLabel, Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER);
        }
    }
    
    function selectNext() as Void {
        _selectedIndex = (_selectedIndex + 1) % _themes.size();
        WatchUi.requestUpdate();
    }
    
    function selectPrevious() as Void {
        _selectedIndex = (_selectedIndex - 1 + _themes.size()) % _themes.size();
        WatchUi.requestUpdate();
    }
    
    function selectTheme() as Void {
        var theme = _themes[_selectedIndex];
        // Get verses by theme and show a random one
        var verses = _app.getVersesByTheme(theme);
        if (verses.size() > 0) {
            var randomVerse = Verses.getRandomFrom(verses);
            _homeView.setCurrentVerse(randomVerse);
        }
        WatchUi.popView(WatchUi.SLIDE_UP);
    }
}
