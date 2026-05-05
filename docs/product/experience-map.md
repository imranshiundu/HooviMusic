# Hoovi Music experience map

This is the user-facing shape of the app.

## 1. Home

Home should answer three questions in seconds:

- What is ready to play?
- What needs attention?
- What is playing now?

Suggested sections:

```txt
Continue listening
Offline ready
Recently imported
Needs review
Local files found
```

Empty state:

> Start by importing playlist metadata or scanning a folder of music files.

## 2. Imports

Imports are metadata-first.

The user should understand that an import preserves playlist structure. It does not guarantee offline storage for every track.

Copy:

> Import names, artists, albums, artwork references, and playlist order. Hoovi Music will look for safe playable matches after import.

States:

- Not connected
- Importing
- Imported
- Needs match scan
- Import failed

## 3. Matches

Matches are where the app earns trust.

Each track should show:

- match status
- confidence
- source type
- offline permission
- reason when a source cannot be saved

Good UI makes this calm and visible.

```txt
Matched          confidence 97%   local file        offline ready
Needs review     confidence 72%   possible match    user decision needed
Not available    confidence 88%   source limited    offline not allowed
Unmatched         confidence 0%    none found        add file or retry later
```

## 4. Offline

Offline should only show tracks that can actually play without a connection.

Sections:

- Recently saved
- Playlists offline
- Albums offline
- Storage used
- Broken files

Empty state:

> Nothing is offline yet. Save allowed tracks from Matches or scan your local library.

## 5. Player

The player must feel native, not like a web demo.

Minimum player states:

- loading
- ready
- playing
- paused
- buffering
- unavailable
- file missing
- source limited

Player copy should be calm:

> This track is not available offline yet.

## 6. Settings

Settings should make the source policy visible without sounding heavy.

Recommended groups:

```txt
Library folders
Offline storage
Imports
Matching confidence
Source permissions
Playback
Privacy
About
```

## 7. Source details panel

Every matched track should be able to open source details.

Fields:

- source name
- source type
- playback allowed
- offline allowed
- confidence
- reason
- date matched

This is how Hoovi Music stays trustworthy.
