# Frontend rebrand log

This log tracks the safe Hoovi Music frontend rebrand work.

## Completed

### Web manifest

- App name changed to `Hoovi Music`.
- Short name changed to `Hoovi Music`.
- Theme color changed to lavender purple.
- Background changed to deep violet-black.

### Brand assets

- Added square Hoovi Music logo SVG.
- Added wordmark SVG.
- Added maskable icon SVG source.
- Added branding asset usage guide.

### Native labels

- Added Android `app_name` string: `Hoovi Music`.
- Updated macOS product name: `Hoovi Music`.
- Added iOS display-name branding reference.

### Flutter brand constants

- Added `lib/branding/hoovi_music_brand.dart`.
- Added Flutter brand layer documentation.

## Not changed yet

These are intentionally deferred until a full local build/regeneration pass:

- Dart package name in `pubspec.yaml`.
- `package:spotube/...` imports.
- Generated asset registry.
- Generated localization files.
- Native PNG launcher icons.
- Windows runner resources.
- iOS `Info.plist` direct mutation.

## Why deferred

Those files can break builds if changed blindly. The correct process is:

```bash
flutter pub get
flutter analyze
flutter test
flutter pub run build_runner build --delete-conflicting-outputs
flutter build linux --debug
```

Then patch the next frontend surface with compiler feedback.

## Engine status

No player, resolver, matching, download, source, or database logic has been changed in the frontend rebrand passes so far.
