# VerseVault - Bible Verse Garmin Watch App

A Garmin Connect IQ app that displays random Bible verses on tap — fully offline, no phone needed.

## Features

- **Truly random verses** — tap screen to get a random verse instantly (not sequential)
- **Favorites** — save verses you love with "F - " prefix indicator, view and randomize from favorites
- **Theme search** — browse by theme (peace, strength, faith, hope, love, wisdom, comfort, courage)
- **Stats tracking** — verses read, favorites saved, streak counter
- **Beautiful warming colour scheme** — warm tones (ambers, soft reds, creams)
- **Dynamic font sizing** — automatically adjusts text size for long verses to prevent overflow
- **Smart layout** — prevents text from overlapping header/footer elements

## Screenshots

- Home: Random verse display with navigation hints
- Favorites: List of saved verses with "F - " prefix
- Themes: Compact theme selection grid
- Stats: Verses read, favorites count, streak

## Navigation

- **Tap** → Display random verse
- **Hold tap** → Save to favorites (or remove if already saved)
- **Up button** (or swipe up) → Open favorites
- **Down button** (or swipe down) → Open themes
- **Menu button** → Open stats
- **Back button** → Return to previous screen

### In Favorites View
- **Left/Right buttons** (or swipe) → Navigate between favorites
- **Tap** → View selected favorite on home screen
- **Back** → Return to home

### In Themes View
- **Up/Down/Left/Right buttons** (or swipe) → Navigate between themes
- **Tap** (or Enter) → Select theme and show random verse
- **Back** → Return to home

## Technical Details

- **API Level**: Minimum 4.2.0
- **Permissions**: Notifications (for daily devotional reminder)
- **Offline**: Fully offline — no phone required

## Supported Devices

- Forerunner: 255, 265, 955, 965
- Fenix: 7 series, 8 series
- Venu: 2, 2 Plus, 3
- Instinct: 2, 3
- Epix: Pro
- Vivoactive: 5

## Building

```bash
# Build the Connect IQ package
/home/cechinel/garmin-sdk/bin/monkeyc \
    -f project.jungle \
    -y /home/cechinel/.openclaw/workspace/coachrox-garmin/private-key.der \
    -o versevault.prg \
    -w
```

## Data

Bible verses are from the KJV (King James Version) which is in the public domain.

## License

MIT License
