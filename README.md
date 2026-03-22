# VerseVault - Bible Verse Garmin Watch App

A Garmin Connect IQ app that displays random Bible verses on tap — fully offline, no phone needed.

## Features

- **Random verse on tap** — tap screen, get a random verse instantly
- **Favorites** — save verses you love, randomize only from favorites
- **Theme search** — search by theme (peace, strength, faith, hope, love, wisdom, comfort, courage)
- **Stats tracking** — verses read, favorites saved, streak counter
- **Beautiful warming colour scheme** — warm tones (ambers, soft reds, creams)

## Screenshots

- Home: Random verse display with tap hint
- Favorites: List of saved verses
- Themes: Theme selection grid
- Stats: Verses read, favorites, streak

## Navigation

- **Tap** → Display random verse
- **Hold tap** → Save to favorites (or remove if already saved)
- **Swipe up** → Open favorites
- **Swipe down** → Open themes
- **Menu button** → Open stats
- **Back button** → Return to previous screen

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
