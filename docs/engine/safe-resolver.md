# Safe resolver

The resolver is the part of Hoovi Music that turns playlist metadata into playable tracks.

It must be accurate, fast where possible, and honest when uncertain.

## Resolver contract

Input:

```json
{
  "title": "Track title",
  "artists": ["Artist name"],
  "album": "Album name",
  "durationMs": 184000,
  "isrc": "optional",
  "playlistSource": "metadata import"
}
```

Output:

```json
{
  "status": "matched | review | unavailable | unmatched",
  "confidence": 0.97,
  "sourceType": "local_file | licensed_catalog | public_catalog | artist_direct | unknown",
  "playbackAllowed": true,
  "offlineAllowed": true,
  "reason": "Exact local file match by title, artist, and duration.",
  "filePath": "optional",
  "sourceUrl": "optional"
}
```

## Source priority

1. Local files already on the user's device.
2. User-uploaded files.
3. Licensed catalog sources.
4. Public catalog sources that allow storage.
5. Artist-direct files that allow storage.
6. Everything else stays unavailable until reviewed or supported.

## Confidence scoring

Suggested scoring model:

```txt
title match        25
artist match       25
album match        10
duration match     15
ISRC match         20
fingerprint match  30
source trust       10

penalties:
wrong artist       -40
large duration gap -30
alternate version  -15
low source trust   -20
```

A perfect score can exceed 100 internally, then normalize to 0–100%.

## Suggested thresholds

| Confidence | State | Action |
| --- | --- | --- |
| 90–100% | Matched | Can play if source allows. |
| 75–89% | Review | Ask user to confirm. |
| 50–74% | Weak | Keep hidden behind review tools. |
| 0–49% | Unmatched | Do not use automatically. |

## Local-first rule

Local files should always win when confidence is high. They are faster, clearer, and better for offline playback.

## Background jobs

First-time matching should run in a job queue:

```txt
queued → scanning → matching → checking source → ready / review / unavailable
```

Cached results can be shown instantly. Fresh online checks should not block the interface.

## User-facing reasons

Good reasons:

- Exact local file match.
- Same title, artist, and duration.
- Possible alternate version.
- Source allows playback but not offline storage.
- No permitted source found yet.
- File was moved or deleted.

Bad reasons:

- Error 500.
- Failed.
- Unknown.
- Not possible.

The app should sound like a careful music librarian, not a broken script.
