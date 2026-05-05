# Validation checklist

Use this before pushing deeper app changes.

## Documentation-only validation

For documentation and SVG-only changes:

- README links point to existing files.
- SVG assets render in GitHub preview.
- No app source files are changed.
- No dependency files are changed.
- No generated files are changed.
- No engine behavior is touched.

## Flutter app validation

When app code changes are made, run:

```bash
flutter pub get
flutter analyze
flutter test
flutter build linux --debug
```

Optional target checks:

```bash
flutter build apk --debug
flutter build web
```

## User-facing copy validation

Search for legacy terms before release:

```bash
rg "Spotube|spotify downloader|free spotify|stream ripper|download any song" .
```

Search for Hoovi language:

```bash
rg "Hoovi Music|Import your playlists|Match your music safely|Play offline" .
```

## Manual QA

- app starts
- home loads
- settings opens
- player bar renders
- local playback still works
- imported playlists still render
- offline screen opens
- source status labels are readable
- no critical route is broken

## Release note template

```txt
Hoovi Music rebrand pass

Changed:
- rebuilt product documentation
- added Hoovi visual docs assets
- defined user-facing source policy language
- documented safe resolver and offline rules

Engine status:
- no engine logic changed in this pass
- runtime validation required after user-facing code string migration
```
