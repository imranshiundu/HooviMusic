import 'hoovi_audio_candidate.dart';
import 'hoovi_track_identity.dart';

abstract class HooviSourceAdapter {
  const HooviSourceAdapter();

  String get id;
  String get displayName;
  HooviSourceType get sourceType;

  /// Return possible playable candidates for the track identity.
  ///
  /// Adapters should not auto-select results. Selection belongs to the resolver
  /// and, when confidence is uncertain, to the review UI.
  Future<List<HooviAudioCandidate>> findCandidates(
    HooviTrackIdentity identity,
  );
}

class HooviResolverException implements Exception {
  HooviResolverException(this.message, {this.adapterId, this.cause});

  final String message;
  final String? adapterId;
  final Object? cause;

  @override
  String toString() {
    final source = adapterId == null ? '' : ' [$adapterId]';
    final suffix = cause == null ? '' : ': $cause';
    return 'HooviResolverException$source: $message$suffix';
  }
}
