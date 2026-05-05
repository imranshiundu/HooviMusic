# Offline rules

Offline playback is a core Hoovi Music feature, but it must be clean and predictable.

## What offline means

A track is offline-ready when Hoovi Music can play it without a network connection and the source allows local storage.

## Track offline states

| State | Meaning | User copy |
| --- | --- | --- |
| Offline ready | File is stored locally and playable. | Ready offline |
| Local only | The track came from the user's files. | Found in your files |
| Needs review | Hoovi Music found a possible match but confidence is not high enough. | Review match |
| Source limited | The source allows playback but not offline storage. | Streaming only |
| Missing file | A saved local file was moved or deleted. | File missing |
| Unmatched | No suitable source was found. | No safe match yet |

## Offline save requirements

Before saving a track offline, the engine should know:

- source type
- source permission state
- file format
- duration
- checksum after save
- storage path
- date saved
- source proof or reason

## User experience rules

Do not make the user guess.

If a track cannot be saved offline, explain why in one sentence:

> This source does not allow offline storage. Add a local file or choose another permitted source.

If a track needs review:

> Hoovi Music found a possible match. Check the title, artist, and duration before saving.

If a file is missing:

> The file moved or was deleted. Locate it again to restore offline playback.

## Storage view

The Offline screen should show:

- total storage used
- number of offline tracks
- broken files
- last scan time
- cleanup action

## Cleanup behavior

Cleanup should remove only Hoovi-managed cache files. It should never delete the user's original music folder unless the user explicitly selected that file inside Hoovi Music's managed cache.
