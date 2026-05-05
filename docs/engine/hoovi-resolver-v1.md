# Hoovi Resolver v1

Hoovi Resolver v1 is the first internal layer that turns imported track metadata into playable candidates.

This is not a downloader. It is a matching layer.

## Files added

```txt
lib/hoovi/resolver/
  hoovi_track_identity.dart
  hoovi_audio_candidate.dart
  hoovi_match_result.dart
  hoovi_source_adapter.dart
  hoovi_match_scorer.dart
  hoovi_resolver.dart
  resolver.dart
  adapters/hoovi_local_file_source_adapter.dart
```

## What it does

```txt
track identity
  ↓
source adapters
  ↓
audio candidates
  ↓
confidence scoring
  ↓
matched / review / unavailable / unmatched
```

## Track identity

`HooviTrackIdentity` stores imported metadata:

- title
- artists
- album
- duration
- ISRC
- playlist id
- source track id
- artwork URL

It does not store playable audio.

## Audio candidate

`HooviAudioCandidate` represents a possible playable result from a source adapter.

It can point to:

- a local file path
- a playback URL
- source name
- source type
- offline policy
- adapter confidence

## Source adapter

`HooviSourceAdapter` is the plug-in contract for sources.

Each adapter returns candidates. It does not decide the final match.

## Scoring

`HooviMatchScorer` scores candidates using:

- title match
- artist match
- album match
- duration match
- ISRC match
- source confidence
- playable reference presence

Default thresholds:

```txt
>= 0.90  matched
>= 0.75  review
<  0.75  unavailable
```

## Local file adapter

`HooviLocalFileSourceAdapter` scans provided directories and returns matches based on filename checks.

It is intentionally local-first and non-mutating:

- no download
- no move
- no delete
- no cache mutation

## Example

```dart
final resolver = HooviResolver(
  adapters: [
    HooviLocalFileSourceAdapter(
      directories: [Directory('/home/imran/Music')],
    ),
  ],
);

final result = await resolver.resolve(
  const HooviTrackIdentity(
    title: 'Song Title',
    artists: ['Artist Name'],
  ),
);
```

## Next step

Connect this layer to a small review screen:

```txt
Imported playlist track
  → Find match
  → Show candidates
  → Play preview
  → Use this match
  → Save offline when local file or allowed source
```
