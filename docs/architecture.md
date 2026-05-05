# Hoovi Music Architecture

Hoovi Music should be built as a personal music vault, not a piracy downloader.

## Core concept

Metadata and audio must be separate.

```txt
Playlist metadata:
  title
  artist
  album
  artwork
  duration
  ISRC when available
  playlist order
  source service ID

Playable audio:
  local file
  user-uploaded file
  licensed source
  public-domain source
  Creative Commons source
  other permitted source
```

## System map

```txt
App UI
  ↓
Local Library Database
  ↓
Metadata Importers
  ↓
Safe Resolver
  ↓
Legal Gate
  ↓
Audio Player + Offline Cache
```

## Modules

### App UI

Responsible for:

- home screen
- library
- playlists
- imports
- match results
- player
- offline downloads
- settings

The UI should never use unsafe language like “download Spotify songs.”

### Metadata Importers

Responsible for importing playlist and track data only.

Possible importers:

- Spotify metadata importer
- local file importer
- MusicBrainz importer
- manual playlist importer
- CSV/JSON importer

### Safe Resolver

Responsible for finding playable audio from allowed sources.

Priority order:

1. Existing local files
2. User-uploaded files
3. Licensed catalog sources
4. Public-domain sources
5. Creative Commons sources
6. Artist-permitted sources

### Legal Gate

Responsible for blocking unsafe saves/downloads.

Every candidate audio source needs:

- source name
- source URL or file path
- allowed playback status
- allowed offline status
- license or permission reason
- confidence score
- rejection reason when blocked

### Offline Cache

Responsible for storing files that are safe to store offline.

Should store:

- audio file path
- artwork path
- lyrics path
- license metadata
- source proof
- date saved
- checksum

## Matching engine

A match should be scored, not blindly accepted.

Suggested scoring factors:

```txt
+ exact title match
+ exact artist match
+ album match
+ duration within tolerance
+ ISRC match
+ audio fingerprint match
- remix mismatch
- live version mismatch
- cover version mismatch
- wrong artist
- low confidence source
- blocked license
```

## Performance target

Under 200ms should apply to cached/local actions only:

- open playlist from local database
- show offline track
- play cached audio
- search local indexed library
- queue next local track

First-time online resolving, fingerprinting, and legal checks should be asynchronous and visible in the UI.

## Download policy

Allowed:

- user-owned files
- user-uploaded files
- licensed files
- public-domain files
- Creative Commons files that allow download/storage
- artist/direct sources that explicitly allow download/storage

Blocked:

- Spotify protected audio
- DRM bypass
- stream ripping
- sources that forbid downloading
- uncertain source permissions
- misleading “free premium” behavior

## Suggested technical direction

Preferred stack for this repo:

```txt
Web/Desktop shell: Next.js + Tauri
Local engine: Rust or Node sidecar
Database: SQLite
Audio: native player layer or web audio for preview
Metadata: MusicBrainz + local tags
Offline files: app-managed storage folder
```

Alternative stack:

```txt
Flutter app shell
Dart audio engine
SQLite/drift
media_kit
plugin system inspired by Spotube
```

## First implementation milestone

1. Build the branded UI shell.
2. Add local database schema.
3. Add local file scanner.
4. Add playlist metadata import mock.
5. Add offline player for local files.
6. Add safe resolver interface.
7. Add blocked/allowed source states in UI.
