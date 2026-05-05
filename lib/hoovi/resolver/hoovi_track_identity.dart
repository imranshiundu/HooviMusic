/// Normalized identity for a track imported from a playlist, local library,
/// or metadata provider.
///
/// This model intentionally contains metadata only. It does not represent
/// playable audio, a download, or a platform-specific stream.
class HooviTrackIdentity {
  const HooviTrackIdentity({
    required this.title,
    required this.artists,
    this.album,
    this.durationMs,
    this.isrc,
    this.playlistId,
    this.sourceTrackId,
    this.artworkUrl,
  });

  final String title;
  final List<String> artists;
  final String? album;
  final int? durationMs;
  final String? isrc;
  final String? playlistId;
  final String? sourceTrackId;
  final String? artworkUrl;

  String get primaryArtist => artists.isEmpty ? '' : artists.first;

  String get normalizedTitle => HooviTextNormalizer.normalize(title);
  String get normalizedPrimaryArtist =>
      HooviTextNormalizer.normalize(primaryArtist);
  String get normalizedAlbum => HooviTextNormalizer.normalize(album ?? '');
  String get normalizedIsrc => HooviTextNormalizer.normalize(isrc ?? '');

  bool get hasDuration => durationMs != null && durationMs! > 0;

  Map<String, Object?> toJson() {
    return {
      'title': title,
      'artists': artists,
      'album': album,
      'durationMs': durationMs,
      'isrc': isrc,
      'playlistId': playlistId,
      'sourceTrackId': sourceTrackId,
      'artworkUrl': artworkUrl,
    };
  }
}

class HooviTextNormalizer {
  const HooviTextNormalizer._();

  static String normalize(String input) {
    return input
        .toLowerCase()
        .replaceAll(RegExp(r'\([^)]*\)'), ' ')
        .replaceAll(RegExp(r'\[[^\]]*\]'), ' ')
        .replaceAll(RegExp(r'[^a-z0-9]+'), ' ')
        .replaceAll(RegExp(r'\s+'), ' ')
        .trim();
  }
}
