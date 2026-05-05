import 'package:flutter/material.dart';

/// Central user-facing brand constants for Hoovi Music.
///
/// Keep this file limited to presentation metadata: names, copy, and colors.
/// Do not place playback, resolver, download, database, or engine behavior here.
class HooviMusicBrand {
  const HooviMusicBrand._();

  static const String appName = 'Hoovi Music';
  static const String shortName = 'Hoovi';
  static const String tagline = 'Import. Match. Keep. Play offline.';
  static const String productLine =
      'A personal music vault for playlists, local files, safe matching, and offline listening.';

  static const String importPromise =
      'Import your playlists. Match your music safely. Play offline.';

  static const String offlineEmptyState =
      'No offline tracks yet. Saved tracks will appear here when their source allows offline storage.';

  static const String matchEmptyState =
      'No matches yet. Start a safe match scan to compare your playlists with local files and permitted sources.';

  static const String sourceLimitedMessage =
      'This source allows playback but not offline storage.';

  static const String fileMissingMessage =
      'The file moved or was deleted. Locate it again to restore playback.';

  static const Color ink = Color(0xFF08050E);
  static const Color surface = Color(0xFF140C22);
  static const Color lavender = Color(0xFF7C3AED);
  static const Color lavenderSoft = Color(0xFFB989FF);
  static const Color text = Color(0xFFF8F5FF);
  static const Color muted = Color(0xFFCDB7FF);
}
