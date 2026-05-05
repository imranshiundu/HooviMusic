enum HooviSourceType {
  localFile,
  userFile,
  metadataProvider,
  audioProvider,
  publicCatalog,
  licensedCatalog,
  artistDirect,
  unknown,
}

enum HooviOfflinePolicy {
  allowed,
  playbackOnly,
  reviewRequired,
  unknown,
}

/// A possible playable result returned by a source adapter.
///
/// A candidate is not automatically trusted. The resolver scores it and returns
/// a match state before any UI should treat it as selected.
class HooviAudioCandidate {
  const HooviAudioCandidate({
    required this.id,
    required this.title,
    required this.artists,
    required this.sourceName,
    required this.sourceType,
    this.album,
    this.durationMs,
    this.isrc,
    this.artworkUrl,
    this.playbackUrl,
    this.localFilePath,
    this.offlinePolicy = HooviOfflinePolicy.unknown,
    this.sourceConfidence = 0.5,
    this.reason,
  });

  final String id;
  final String title;
  final List<String> artists;
  final String? album;
  final int? durationMs;
  final String? isrc;
  final String? artworkUrl;
  final String? playbackUrl;
  final String? localFilePath;
  final String sourceName;
  final HooviSourceType sourceType;
  final HooviOfflinePolicy offlinePolicy;

  /// Adapter-provided trust hint from 0.0 to 1.0.
  ///
  /// The resolver still computes the final score.
  final double sourceConfidence;
  final String? reason;

  bool get hasPlayableReference =>
      (playbackUrl != null && playbackUrl!.trim().isNotEmpty) ||
      (localFilePath != null && localFilePath!.trim().isNotEmpty);

  bool get offlineAllowed => offlinePolicy == HooviOfflinePolicy.allowed;

  Map<String, Object?> toJson() {
    return {
      'id': id,
      'title': title,
      'artists': artists,
      'album': album,
      'durationMs': durationMs,
      'isrc': isrc,
      'artworkUrl': artworkUrl,
      'playbackUrl': playbackUrl,
      'localFilePath': localFilePath,
      'sourceName': sourceName,
      'sourceType': sourceType.name,
      'offlinePolicy': offlinePolicy.name,
      'sourceConfidence': sourceConfidence,
      'reason': reason,
    };
  }
}
