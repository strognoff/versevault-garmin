import Toybox.Lang;

//! Represents a Bible verse
class Verse {
    var reference as String;
    var text as String;
    var themes as Array<String>;
    
    function initialize(ref as String, txt as String, thms as Array<String>) {
        reference = ref;
        text = txt;
        themes = thms;
    }
    
    function getReference() as String {
        return reference;
    }
    
    function getText() as String {
        return text;
    }
    
    function getThemes() as Array<String> {
        return themes;
    }
    
    function hasTheme(theme as String) as Boolean {
        for (var i = 0; i < themes.size(); i++) {
            if (themes[i].equals(theme)) {
                return true;
            }
        }
        return false;
    }
}

//! Collection of Bible verses (KJV - public domain)
class Verses {
    
    // All verses stored as class-level variable
    private static var allVerses as Array<Verse> = [
        // LOVE theme
        new Verse("John 3:16", "For God so loved the world, that he gave his only begotten Son, that whosoever believeth in him should not perish, but have everlasting life.", ["love", "faith", "hope"]),
        new Verse("1 Corinthians 13:4-5", "Love is patient, love is kind. It does not envy, it does not boast, it is not proud. It does not dishonor others, it is not self-seeking, it is not easily angered, it keeps no record of wrongs.", ["love"]),
        new Verse("Romans 5:8", "But God demonstrates his own love for us in this: While we were still sinners, Christ died for us.", ["love", "faith"]),
        new Verse("1 John 4:8", "Whoever does not love does not know God, because God is love.", ["love"]),
        new Verse("1 Corinthians 13:13", "And now these three remain: faith, hope and love. But the greatest of these is love.", ["love", "faith", "hope"]),
        new Verse("John 15:13", "Greater love has no one than this: to lay down one's life for one's friends.", ["love"]),
        new Verse("Ephesians 4:2", "Be completely humble and gentle; be patient, bearing with one another in love.", ["love"]),
        new Verse("1 Peter 4:8", "Above all, love each other deeply, because love covers over a multitude of sins.", ["love"]),
        new Verse("Song of Solomon 8:7", "Many waters cannot quench love; rivers cannot sweep it away. If one were to give all the wealth of one's house for love, it would be utterly scorned.", ["love"]),
        
        // FAITH theme
        new Verse("Hebrews 11:1", "Now faith is confidence in what we hope for and assurance about what we do not see.", ["faith", "hope"]),
        new Verse("Romans 10:17", "So then faith cometh by hearing, and hearing by the word of God.", ["faith"]),
        new Verse("2 Corinthians 5:7", "For we walk by faith, not by sight.", ["faith"]),
        new Verse("Mark 11:24", "Therefore I tell you, whatever you ask in prayer, believe that you have received it, and it will be yours.", ["faith", "hope", "peace"]),
        new Verse("James 1:6", "But when you ask, you must believe and not doubt, because the one who doubts is like a wave of the sea, blown and tossed by the wind.", ["faith", "hope"]),
        new Verse("Ephesians 2:8", "For it is by grace you have been saved, through faith—and this is not from yourselves, it is the gift of God.", ["faith", "love", "hope"]),
        new Verse("Matthew 17:20", "He replied, 'Because you have so little faith. Truly I tell you, if you have faith as small as a mustard seed, you can say to this mountain, Move from here to there, and it will move. Nothing will be impossible for you.'", ["faith"]),
        new Verse("Psalm 46:10", "Be still, and know that I am God; I will be exalted among the nations, I will be exalted in the earth.", ["faith", "peace", "strength"]),
        new Verse("Isaiah 40:31", "But those who hope in the Lord will renew their strength. They will soar on wings like eagles; they will run and not grow weary, they will walk and not be faint.", ["faith", "hope", "strength"]),
        
        // PEACE theme
        new Verse("Philippians 4:6-7", "Do not be anxious about anything, but in every situation, by prayer and petition, with thanksgiving, present your requests to God. And the peace of God, which transcends all understanding, will guard your hearts and your minds in Christ Jesus.", ["peace", "hope", "comfort"]),
        new Verse("John 14:27", "Peace I leave with you; my peace I give you. I do not give to you as the world gives. Do not let your hearts be troubled and do not be afraid.", ["peace", "comfort"]),
        new Verse("Isaiah 26:3", "You will keep in perfect peace those whose minds are steadfast, because they trust in you.", ["peace", "faith"]),
        new Verse("Romans 12:18", "If it is possible, as far as it depends on you, live at peace with everyone.", ["peace"]),
        new Verse("Matthew 5:9", "Blessed are the peacemakers, for they will be called children of God.", ["peace"]),
        new Verse("Psalm 29:11", "The Lord gives strength to his people; the Lord blesses his people with peace.", ["peace", "strength"]),
        new Verse("2 Thessalonians 3:16", "Now may the Lord of peace himself give you peace at all times and in every way. The Lord be with all of you.", ["peace"]),
        new Verse("Colossians 3:15", "Let the peace of Christ rule in your hearts, since as members of one body you were called to peace. And be thankful.", ["peace"]),
        new Verse("Numbers 6:26", "The Lord turn his face toward you and give you peace.", ["peace"]),
        
        // STRENGTH theme
        new Verse("Isaiah 40:31", "But those who hope in the Lord will renew their strength. They will soar on wings like eagles; they will run and not grow weary, they will walk and not be faint.", ["strength", "faith", "hope"]),
        new Verse("Joshua 1:9", "Have I not commanded you? Be strong and courageous. Do not be afraid; do not be discouraged, for the Lord your God will be with you wherever you go.", ["strength", "courage", "faith"]),
        new Verse("Psalm 46:1", "God is our refuge and strength, an ever-present help in trouble.", ["strength", "comfort", "peace"]),
        new Verse("2 Timothy 1:7", "For the Spirit God gave us does not make us timid, but gives us power, love and self-discipline.", ["strength", "courage", "faith"]),
        new Verse("Nehemiah 8:10", "Do not grieve, for the joy of the Lord is your strength.", ["strength", "hope"]),
        new Verse("Psalm 28:7", "The Lord is my strength and my shield; my heart trusts in him, and he helps me. My heart leaps for joy, and with my song I praise him.", ["strength", "hope", "comfort"]),
        new Verse("Ephesians 6:10", "Finally, be strong in the Lord and in his mighty power.", ["strength", "faith"]),
        new Verse("Psalm 73:26", "My flesh and my heart may fail, but God is the strength of my heart and my portion forever.", ["strength", "comfort", "faith"]),
        new Verse("Isaiah 41:10", "So do not fear, for I am with you; do not be dismayed, for I am your God. I will strengthen you and help you; I will uphold you with my righteous right hand.", ["strength", "courage", "comfort"]),
        
        // HOPE theme
        new Verse("Romans 15:13", "May the God of hope fill you with all joy and peace as you trust in him, so that you may overflow with hope by the power of the Holy Spirit.", ["hope", "faith", "peace"]),
        new Verse("Jeremiah 29:11", "For I know the plans I have for you, declares the Lord, plans to prosper you and not to harm you, plans to give you hope and a future.", ["hope", "comfort", "peace"]),
        new Verse("Psalm 42:11", "Why, my soul, are you downcast? Why so disturbed within me? Put your hope in God, for I will yet praise him, my Savior and my God.", ["hope"]),
        new Verse("Romans 5:5", "And hope does not put us to shame, because God's love has been poured out into our hearts through the Holy Spirit, who has been given to us.", ["hope", "love", "faith"]),
        new Verse("Lamentations 3:21-24", "Yet this I call to mind and therefore I have hope: Because of the Lord's great love we are not consumed, for his compassions never fail. They are new every morning; great is your faithfulness.", ["hope", "comfort", "faith", "love"]),
        new Verse("Psalm 71:14", "But as for me, I will always have hope; I will praise you more and more.", ["hope", "praise"]),
        new Verse("Isaiah 40:31", "But those who hope in the Lord will renew their strength. They will soar on wings like eagles; they will run and not grow weary, they will walk and not be faint.", ["hope", "strength", "faith"]),
        new Verse("Titus 2:13", "While we wait for the blessed hope—the appearing of the glory of our great God and Savior, Jesus Christ.", ["hope", "faith"]),
        new Verse("1 Peter 1:3", "Praise be to the God and Father of our Lord Jesus Christ! In his great mercy he has given us new birth into a living hope through the resurrection of Jesus Christ from the dead.", ["hope", "faith", "comfort"]),
        
        // WISDOM theme
        new Verse("Proverbs 3:5-6", "Trust in the Lord with all your heart and lean not on your own understanding; in all your ways submit to him, and he will make your paths straight.", ["wisdom", "faith", "trust"]),
        new Verse("James 1:5", "If any of you lacks wisdom, you should ask God, who gives generously to all without finding fault, and it will be given to you.", ["wisdom", "faith"]),
        new Verse("Proverbs 2:6", "For the Lord gives wisdom; from his mouth come knowledge and understanding.", ["wisdom", "faith"]),
        new Verse("Proverbs 9:10", "The fear of the Lord is the beginning of wisdom, and knowledge of the Holy One is understanding.", ["wisdom", "faith"]),
        new Verse("Colossians 2:2-3", "My goal is that they may be encouraged in heart and united in love, so that they may have the full riches of complete understanding, in order that they may know the mystery of God, namely, Christ, in whom are hidden all the treasures of wisdom and knowledge.", ["wisdom", "love", "comfort"]),
        new Verse("Psalm 111:10", "The fear of the Lord is the beginning of wisdom; all who follow his precepts have good understanding. To him belongs eternal praise.", ["wisdom", "faith"]),
        new Verse("Proverbs 16:16", "How much better to get wisdom than gold, to get insight rather than silver!", ["wisdom"]),
        new Verse("1 Corinthians 1:30", "It is because of him that you are in Christ Jesus, who has become for us wisdom from God—that is, our righteousness, holiness and redemption.", ["wisdom", "faith", "righteousness"]),
        new Verse("Ecclesiastes 7:12", "Wisdom is a shelter as money is a shelter, but the advantage of knowledge is this: Wisdom preserves those who have it.", ["wisdom"]),
        
        // COMFORT theme
        new Verse("Psalm 23:4", "Even though I walk through the darkest valley, I will fear no evil, for you are with me; your rod and your staff, they comfort me.", ["comfort", "peace", "strength", "courage"]),
        new Verse("Isaiah 41:10", "So do not fear, for I am with you; do not be dismayed, for I am your God. I will strengthen you and help you; I will uphold you with my righteous right hand.", ["comfort", "strength", "courage", "peace"]),
        new Verse("Matthew 11:28", "Come to me, all you who are weary and burdened, and I will give you rest.", ["comfort", "peace"]),
        new Verse("2 Corinthians 1:3-4", "Praise be to the God and Father of our Lord Jesus Christ, the Father of compassion and the God of all comfort, who comforts us in all our troubles, so that we can comfort those in any trouble with the comfort we ourselves receive from God.", ["comfort", "faith", "love"]),
        new Verse("Psalm 34:18", "The Lord is close to the brokenhearted and saves those who are crushed in spirit.", ["comfort", "peace"]),
        new Verse("Psalm 55:22", "Cast your cares on the Lord and he will sustain you; he will never let the righteous be shaken.", ["comfort", "faith", "hope", "peace"]),
        new Verse("John 16:33", "I have told you these things, so that in me you may have peace. In this world you will have trouble. But take heart! I have overcome the world.", ["comfort", "peace", "courage", "strength"]),
        new Verse("Romans 8:28", "And we know that in all things God works for the good of those who love him, who have been called according to his purpose.", ["comfort", "faith", "hope", "love"]),
        new Verse("Psalm 46:1", "God is our refuge and strength, an ever-present help in trouble.", ["comfort", "strength", "peace"]),
        
        // COURAGE theme
        new Verse("Joshua 1:9", "Have I not commanded you? Be strong and courageous. Do not be afraid; do not be discouraged, for the Lord your God will be with you wherever you go.", ["courage", "strength", "faith", "peace"]),
        new Verse("Deuteronomy 31:6", "Be strong and courageous. Do not be afraid or terrified because of them, for the Lord your God goes with you; he will never leave you nor forsake you.", ["courage", "strength", "faith"]),
        new Verse("Isaiah 41:13", "For I am the Lord your God who takes hold of your right hand and says to you, Do not fear; I will help you.", ["courage", "comfort", "strength", "faith"]),
        new Verse("2 Timothy 1:7", "For the Spirit God gave us does not make us timid, but gives us power, love and self-discipline.", ["courage", "strength", "faith", "love"]),
        new Verse("Psalm 27:1", "The Lord is my light and my salvation—whom shall I fear? The Lord is the stronghold of my life—of whom shall I be afraid?", ["courage", "faith", "peace", "strength"]),
        new Verse("Psalm 56:3-4", "When I am afraid, I put my trust in you. In God, whose word I praise—in God I trust and am not afraid. What can mere mortals do to me?", ["courage", "faith", "peace", "hope"]),
        new Verse("Psalm 31:24", "Be strong and take heart, all you who hope in the Lord.", ["courage", "strength", "hope", "faith"]),
        new Verse("Mark 5:36", "Don't be afraid; just believe.", ["courage", "faith", "peace"]),
        new Verse("1 Chronicles 28:20", "Be strong and courageous, and do the work. Do not be afraid or discouraged, for the Lord God, my God, is with you. He will not leave you or forsake you until all the work for the service of the temple of the Lord is finished.", ["courage", "strength", "faith"]),
        
        // General / Encouragement
        new Verse("Jeremiah 29:11", "For I know the plans I have for you, declares the Lord, plans to prosper you and not to harm you, plans to give you hope and a future.", ["hope", "comfort", "peace"]),
        new Verse("Psalm 23:1", "The Lord is my shepherd, I lack nothing.", ["comfort", "peace", "hope", "strength"]),
        new Verse("Psalm 37:4", "Take delight in the Lord, and he will give you the desires of your heart.", ["hope", "faith", "love"]),
        new Verse("Matthew 6:33", "But seek first his kingdom and his righteousness, and all these things will be given to you as well.", ["faith", "hope", "wisdom"]),
        new Verse("Psalm 91:1-2", "Whoever dwells in the shelter of the Most High will rest in the shadow of the Almighty. I will say of the Lord, 'He is my refuge and my fortress, my God, in whom I trust.'", ["faith", "comfort", "peace", "strength"]),
        new Verse("Psalm 121:1-2", "I lift up my eyes to the mountains—where does my help come from? My help comes from the Lord, the Maker of heaven and earth.", ["faith", "hope", "comfort"]),
        new Verse("Romans 8:38-39", "For I am convinced that neither death nor life, neither angels nor demons, neither the present nor the future, nor any powers, neither height nor depth, nor anything else in all creation, will be able to separate us from the love of God that is in Christ Jesus our Lord.", ["love", "faith", "hope", "comfort"]),
        new Verse("Galatians 5:22-23", "But the fruit of the Spirit is love, joy, peace, forbearance, kindness, goodness, faithfulness, gentleness and self-control. Against such things there is no law.", ["love", "peace", "faith", "wisdom"]),
        new Verse("1 Thessalonians 5:16-18", "Rejoice always, pray continually, give thanks in all circumstances; for this is God's will for you in Christ Jesus.", ["hope", "faith", "peace", "joy"]),
        new Verse("Philippians 4:13", "I can do all things through Christ who strengthens me.", ["strength", "faith", "courage", "hope"]),
        new Verse("Psalm 40:1-3", "I waited patiently for the Lord; he turned to me and heard my cry. He lifted me out of the slimy pit, out of the mud and mire; he set my feet on a rock and gave me a firm place to stand. He put a new song in my mouth, a hymn of praise to our God.", ["hope", "comfort", "faith", "strength"]),
        new Verse("Psalm 118:24", "This is the day the Lord has made; let us rejoice and be glad in it.", ["hope", "joy", "faith", "peace"]),
        new Verse("Isaiah 43:2", "When you pass through the waters, I will be with you; and when you pass through the rivers, they will not sweep over you. When you walk through the fire, you will not be burned; the flames will not set you ablaze.", ["comfort", "strength", "courage", "faith", "peace"]),
        new Verse("Romans 15:13", "May the God of hope fill you with all joy and peace as you trust in him, so that you may overflow with hope by the power of the Holy Spirit.", ["hope", "faith", "peace", "joy"]),
        new Verse("Psalm 62:5-6", "Yes, my soul, find rest in God; my hope comes from him. Truly he is my rock and my salvation; he is my fortress, I will not be shaken.", ["hope", "peace", "strength", "faith", "comfort"]),
        new Verse("2 Corinthians 4:16-18", "Therefore we do not lose heart. Though our outer self is wasting away, our inner self is being renewed day by day. For our light and momentary troubles are achieving for us an eternal glory that far outweighs them all.", ["comfort", "strength", "faith", "hope", "peace"]),
        new Verse("Psalm 30:5", "For his anger lasts only a moment, but his favor lasts a lifetime; weeping may stay for the night, but rejoicing comes in the morning.", ["comfort", "hope", "joy", "peace", "strength"]),
        new Verse("Isaiah 40:29", "He gives strength to the weary and increases the power of the weak.", ["strength", "comfort", "hope", "faith"]),
        new Verse("Psalm 143:8", "Let the morning bring me word of your unfailing love, for I have put my trust in you. Show me the way I should go, for to you I lift up my soul.", ["faith", "hope", "comfort", "peace", "love"]),
        new Verse("Matthew 28:20", "And surely I am with you always, to the very end of the age.", ["comfort", "peace", "courage", "faith", "strength"])
    ];
    
    //! Get all verses
    static function getAll() as Array<Verse> {
        return allVerses;
    }
    
    //! Get verses by theme
    static function getByTheme(theme as String) as Array<Verse> {
        var result = [] as Array<Verse>;
        for (var i = 0; i < allVerses.size(); i++) {
            if (allVerses[i].hasTheme(theme)) {
                result.add(allVerses[i]);
            }
        }
        return result;
    }
    
    private static var verseCounter as Number = 0;
    
    //! Get a random verse (cycles through based on counter)
    static function getRandom() as Verse {
        verseCounter = (verseCounter + 1) % allVerses.size();
        return allVerses[verseCounter];
    }
    
    //! Get a random verse from a subset
    static function getRandomFrom(verses as Array<Verse>) as Verse {
        if (verses.size() == 0) {
            return allVerses[0];
        }
        verseCounter = (verseCounter + 1) % verses.size();
        return verses[verseCounter];
    }
    
    //! Get themes list
    static function getThemes() as Array<String> {
        return ["love", "faith", "peace", "strength", "hope", "wisdom", "comfort", "courage"];
    }
}
