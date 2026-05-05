# Stickers and illustration system

Hoovi Music needs visual language that feels cool without becoming noisy.

The illustrations should explain product states: import, scan, match, review, offline, source limited, and file missing.

## Visual style

```txt
base: dark ink / black violet
highlight: lavender purple
secondary: soft white
shape: rounded, glass, orbit lines
mood: calm, premium, slightly futuristic
```

## Sticker set

### 1. Orbit play

Used on README, landing, splash, and about pages.

Meaning:

> Hoovi Music keeps the library moving around the player.

Asset:

- `docs/assets/hoovi-music-orbit.svg`

### 2. Safe match flow

Used in documentation and onboarding.

Meaning:

> The app moves from metadata to local files to source checks before offline playback.

Asset:

- `docs/assets/flow-safe-match.svg`

### 3. Local file found

Visual idea:

```txt
folder + small waveform + check mark
```

Use when a track is matched from the user's own files.

### 4. Needs review

Visual idea:

```txt
album tile + magnifier + soft question mark
```

Use when confidence is close but not high enough.

### 5. Offline ready

Visual idea:

```txt
music note inside a small vault
```

Use when the track is stored and playable offline.

### 6. Source limited

Visual idea:

```txt
stream line + small lock + calm explanation card
```

Use when a track can play from a source but cannot be saved offline.

### 7. File missing

Visual idea:

```txt
broken path line + folder outline
```

Use when the local file path no longer resolves.

## Animation ideas

### Import animation

Playlist cards slide into a clean stack. Artwork fades in after metadata arrives.

### Scan animation

A thin lavender line moves through folder cards.

### Match animation

Two track cards gently align, then a confidence badge appears.

### Offline animation

The player card drops into a small vault shape. The badge changes to `Offline ready`.

## Motion rules

- keep animations under 500ms
- use easing, not bounce-heavy motion
- no confetti
- no cartoon overload
- no random emojis
- use motion to explain state changes

## README visual inventory

Current assets:

- `docs/assets/hoovi-music-orbit.svg`
- `docs/assets/flow-safe-match.svg`

Future assets:

- `docs/assets/sticker-local-file.svg`
- `docs/assets/sticker-review-match.svg`
- `docs/assets/sticker-offline-ready.svg`
- `docs/assets/sticker-source-limited.svg`
- `docs/assets/sticker-file-missing.svg`
