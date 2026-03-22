import Toybox.Lang;
import Toybox.WatchUi;
import Toybox.Graphics;

//! View for displaying settings
class SettingsView extends WatchUi.View {
    
    private var _app as VerseVaultApp;
    
    // Colors
    const COLOR_AMBER = 0xFFBF00;
    const COLOR_SOFT_RED = 0xE57373;
    const COLOR_CREAM = 0xFFF8E1;
    const COLOR_WARM_BG = 0x2D1F1A;
    const COLOR_CARD = 0x3E2B26;
    const COLOR_MUTED = 0xA89080;
    
    function initialize() {
        WatchUi.View.initialize();
        _app = Application.getApp() as VerseVaultApp;
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
        dc.drawText(w / 2, 25, Graphics.FONT_TINY, "Stats", Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER);
        
        // Stats cards
        var cardPadding = 15;
        var cardWidth = w - (cardPadding * 2);
        var cardX = cardPadding;
        
        // Verses Read card
        var card1Y = 60;
        var card1Height = 50;
        dc.setColor(COLOR_CARD, Graphics.COLOR_TRANSPARENT);
        dc.fillRoundedRectangle(cardX, card1Y, cardWidth, card1Height, 6);
        
        dc.setColor(COLOR_MUTED, Graphics.COLOR_TRANSPARENT);
        dc.drawText(cardX + 15, card1Y + 15, Graphics.FONT_XTINY, "Verses Read", Graphics.TEXT_JUSTIFY_LEFT | Graphics.TEXT_JUSTIFY_VCENTER);
        
        dc.setColor(COLOR_CREAM, Graphics.COLOR_TRANSPARENT);
        dc.drawText(cardX + cardWidth - 15, card1Y + 15, Graphics.FONT_TINY, _app.versesRead.toString(), Graphics.TEXT_JUSTIFY_RIGHT | Graphics.TEXT_JUSTIFY_VCENTER);
        
        // Favorites card
        var card2Y = card1Y + card1Height + 10;
        dc.setColor(COLOR_CARD, Graphics.COLOR_TRANSPARENT);
        dc.fillRoundedRectangle(cardX, card2Y, cardWidth, card1Height, 6);
        
        dc.setColor(COLOR_MUTED, Graphics.COLOR_TRANSPARENT);
        dc.drawText(cardX + 15, card2Y + 15, Graphics.FONT_XTINY, "Favorites", Graphics.TEXT_JUSTIFY_LEFT | Graphics.TEXT_JUSTIFY_VCENTER);
        
        dc.setColor(COLOR_SOFT_RED, Graphics.COLOR_TRANSPARENT);
        dc.drawText(cardX + cardWidth - 15, card2Y + 15, Graphics.FONT_TINY, _app.getFavorites().size().toString(), Graphics.TEXT_JUSTIFY_RIGHT | Graphics.TEXT_JUSTIFY_VCENTER);
        
        // Streak card
        var card3Y = card2Y + card1Height + 10;
        dc.setColor(COLOR_CARD, Graphics.COLOR_TRANSPARENT);
        dc.fillRoundedRectangle(cardX, card3Y, cardWidth, card1Height, 6);
        
        dc.setColor(COLOR_MUTED, Graphics.COLOR_TRANSPARENT);
        dc.drawText(cardX + 15, card3Y + 15, Graphics.FONT_XTINY, "Streak", Graphics.TEXT_JUSTIFY_LEFT | Graphics.TEXT_JUSTIFY_VCENTER);
        
        dc.setColor(COLOR_AMBER, Graphics.COLOR_TRANSPARENT);
        dc.drawText(cardX + cardWidth - 15, card3Y + 15, Graphics.FONT_TINY, _app.streak.toString(), Graphics.TEXT_JUSTIFY_RIGHT | Graphics.TEXT_JUSTIFY_VCENTER);
        
        // App info
        dc.setColor(COLOR_MUTED, Graphics.COLOR_TRANSPARENT);
        dc.drawText(w / 2, h - 50, Graphics.FONT_XTINY, "God bless.", Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER);
        
        // Back hint
        dc.setColor(COLOR_MUTED, Graphics.COLOR_TRANSPARENT);
        dc.drawText(w / 2, h - 20, Graphics.FONT_XTINY, "Back to go back", Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER);
    }
}
