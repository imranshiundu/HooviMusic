import 'hoovi_audio_candidate.dart';

enum HooviMatchStatus {
  matched,
  review,
  unavailable,
  unmatched,
}

class HooviMatchResult {
  const HooviMatchResult({
    required this.status,
    required this.confidence,
    this.candidate,
    required this.reason,
    this.alternatives = const [],
  });

  final HooviMatchStatus status;

  /// Normalized score from 0.0 to 1.0.
  final double confidence;

  final HooviAudioCandidate? candidate;
  final String reason;
  final List<HooviAudioCandidate> alternatives;

  bool get canPlay =>
      candidate != null &&
      candidate!.hasPlayableReference &&
      status != HooviMatchStatus.unmatched &&
      status != HooviMatchStatus.unavailable;

  bool get canSaveOffline =>
      canPlay && candidate!.offlinePolicy == HooviOfflinePolicy.allowed;

  Map<String, Object?> toJson() {
    return {
      'status': status.name,
      'confidence': confidence,
      'candidate': candidate?.toJson(),
      'reason': reason,
      'alternatives': alternatives.map((candidate) => candidate.toJson()).toList(),
    };
  }
}
