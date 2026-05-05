import 'hoovi_audio_candidate.dart';
import 'hoovi_match_result.dart';
import 'hoovi_match_scorer.dart';
import 'hoovi_source_adapter.dart';
import 'hoovi_track_identity.dart';

class HooviResolver {
  HooviResolver({
    required List<HooviSourceAdapter> adapters,
    HooviMatchScorer scorer = const HooviMatchScorer(),
    this.autoMatchThreshold = 0.90,
    this.reviewThreshold = 0.75,
  })  : _adapters = List.unmodifiable(adapters),
        _scorer = scorer;

  final List<HooviSourceAdapter> _adapters;
  final HooviMatchScorer _scorer;

  /// Score required before Hoovi can select a match without manual review.
  final double autoMatchThreshold;

  /// Score required before Hoovi shows a candidate as worth reviewing.
  final double reviewThreshold;

  List<HooviSourceAdapter> get adapters => _adapters;

  Future<HooviMatchResult> resolve(HooviTrackIdentity identity) async {
    final candidates = <HooviAudioCandidate>[];

    for (final adapter in _adapters) {
      try {
        final results = await adapter.findCandidates(identity);
        candidates.addAll(results);
      } catch (_) {
        // Resolver v1 keeps adapter failures isolated so one bad source does not
        // break the whole matching pass. Logging can be wired in once this is
        // integrated with the existing app logger.
      }
    }

    if (candidates.isEmpty) {
      return const HooviMatchResult(
        status: HooviMatchStatus.unmatched,
        confidence: 0,
        reason: 'No candidates found.',
      );
    }

    final scored = candidates.map((candidate) {
      return MapEntry(candidate, _scorer.score(identity, candidate));
    }).toList()
      ..sort((a, b) => b.value.value.compareTo(a.value.value));

    final best = scored.first;
    final confidence = best.value.value;
    final alternatives = scored.skip(1).map((entry) => entry.key).toList();

    if (confidence >= autoMatchThreshold && best.key.hasPlayableReference) {
      return HooviMatchResult(
        status: HooviMatchStatus.matched,
        confidence: confidence,
        candidate: best.key,
        reason: best.value.reason,
        alternatives: alternatives,
      );
    }

    if (confidence >= reviewThreshold && best.key.hasPlayableReference) {
      return HooviMatchResult(
        status: HooviMatchStatus.review,
        confidence: confidence,
        candidate: best.key,
        reason: best.value.reason,
        alternatives: alternatives,
      );
    }

    return HooviMatchResult(
      status: HooviMatchStatus.unavailable,
      confidence: confidence,
      candidate: best.key,
      reason: 'Best candidate is below the review threshold. ${best.value.reason}',
      alternatives: alternatives,
    );
  }
}
