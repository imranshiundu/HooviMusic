# Start here

Hoovi Music is a personal music vault.

It should feel fast, familiar, and clean, but the promise is not unlimited music. The promise is ownership, clarity, and offline playback for tracks the user can legitimately keep.

## The product in one sentence

Hoovi Music imports playlist metadata, matches tracks from safe sources, and keeps the user's allowed library playable offline.

## The first version should do five things well

1. Import playlist metadata.
2. Scan local files.
3. Match songs with visible confidence.
4. Explain blocked or uncertain sources clearly.
5. Play offline files beautifully.

## The interface should feel like this

```txt
quiet luxury
fast local search
clear source states
no legal weirdness
no fake promises
no clutter
```

## The first-run experience

```txt
Welcome
  ↓
Choose import method
  ↓
Scan local files
  ↓
Review matches
  ↓
Save allowed tracks offline
  ↓
Start listening
```

## User-facing promise

Use this line in onboarding, marketing, and empty states:

> Import your playlists. Match your music safely. Play offline.

## Product boundary

Hoovi Music may import names, artists, albums, playlist order, and artwork references from supported metadata services.

Hoovi Music should not claim that every imported track can be stored offline. Some tracks will need local files. Some will need a licensed source. Some will be blocked. The UI must be honest about that.

## Design direction

- dark surfaces
- lavender highlights
- soft glass cards
- smooth motion
- large cover artwork
- clear state badges
- polished empty states
- small stickers that explain source status without childish language

## First build milestone

```txt
M1: Branded shell
├─ Home
├─ Library
├─ Imports
├─ Matches
├─ Offline
├─ Player bar
├─ Settings
└─ Source-status copy
```

Do not begin complex source automation until the local player, metadata model, and source policy states are clean.
