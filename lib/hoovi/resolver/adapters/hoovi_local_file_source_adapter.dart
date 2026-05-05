import 'dart:io';

import 'package:path/path.dart' as p;

import '../hoovi_audio_candidate.dart';
import '../hoovi_source_adapter.dart';
import '../hoovi_track_identity.dart';

/// Local-file-first adapter for Hoovi Resolver v1.
///
/// This adapter scans provided music directories and returns candidates whose
/// filenames appear to match the imported track identity. It does not mutate,
/// download, or move files.
class HooviLocalFileSourceAdapter extends HooviSourceAdapter {
  const HooviLocalFileSourceAdapter({
    required this.directories,
    this.allowedExtensions = const {
      '.mp3',
      '.m4a',
      '.aac',
      '.flac',
      '.wav',
      '.ogg',
      '.opus',
    },
    this.recursive = true,
  });

  final List<Directory> directories;
  final Set<String> allowedExtensions;
  final bool recursive;

  @override
  String get id => 'hoovi.local-files';

  @override
  String get displayName => 'Local files';

  @override
  HooviSourceType get sourceType => HooviSourceType.localFile;

  @override
  Future<List<HooviAudioCandidate>> findCandidates(
    HooviTrackIdentity identity,
  ) async {
    final results = <HooviAudioCandidate>[];
    final title = identity.normalizedTitle;
    final artist = identity.normalizedPrimaryArtist;

    if (title.isEmpty) return results;

    for (final directory in directories) {
      if (!directory.existsSync()) continue;

      await for (final entity in directory.list(recursive: recursive)) {
        if (entity is! File) continue;

        final extension = p.extension(entity.path).toLowerCase();
        if (!allowedExtensions.contains(extension)) continue;

        final basename = HooviTextNormalizer.normalize(
          p.basenameWithoutExtension(entity.path),
        );

        final titleLooksPresent = basename.contains(title) || title.contains(basename);
        final artistLooksPresent = artist.isEmpty || basename.contains(artist);

        if (!titleLooksPresent || !artistLooksPresent) continue;

        results.add(
          HooviAudioCandidate(
            id: entity.path,
            title: identity.title,
            artists: identity.artists,
            album: identity.album,
            durationMs: identity.durationMs,
            isrc: identity.isrc,
            artworkUrl: identity.artworkUrl,
            localFilePath: entity.path,
            sourceName: displayName,
            sourceType: sourceType,
            offlinePolicy: HooviOfflinePolicy.allowed,
            sourceConfidence: artistLooksPresent ? 0.85 : 0.65,
            reason: 'Matched by local filename.',
          ),
        );
      }
    }

    return results;
  }
}
