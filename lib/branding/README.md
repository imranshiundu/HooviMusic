# Flutter brand layer

This folder contains user-facing Hoovi Music brand constants for Flutter UI code.

## Current file

- `hoovi_music_brand.dart`

## Purpose

Use this layer when replacing visible names, empty states, app titles, onboarding copy, and theme colors.

This keeps the rebrand controlled instead of scattering raw strings everywhere.

## Safe usage

Use these constants in UI-only files:

```dart
HooviMusicBrand.appName
HooviMusicBrand.tagline
HooviMusicBrand.importPromise
HooviMusicBrand.lavender
```

## Do not use this file for

- playback logic
- source resolving
- downloads
- database schema
- generated localization files without regeneration
- package/import migration

## Next migration step

Replace visible UI strings file by file:

1. app shell title
2. sidebar/header brand text
3. splash/about screen logo text
4. empty states
5. source status messages
6. settings/about labels

After each group, run:

```bash
flutter analyze
flutter test
```
