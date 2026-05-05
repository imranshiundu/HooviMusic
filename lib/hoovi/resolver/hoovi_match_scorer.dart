import 'dart:math';

import 'hoovi_audio_candidate.dart';
import 'hoovi_track_identity.dart';

class HooviMatchScore {
  const HooviMatchScore({
    required this.value,
    required this.reason,
  });

  /// Normalized score from 0.0 to 1.0.
  final double value;
  final String reason;
}

class HooviMatchScorer {
  const HooviMatchScorer({
    this.durationToleranceMs = 4000,
  });

  final int durationToleranceMs;

  HooviMatchScore score(
    HooviTrackIdentity identity,
    HooviAudioCandidate candidate,
  ) {
    var score = 0.0;
    final reasons = <String>[];

    final sourceTitle = HooviTextNormalizer.normalize(candidate.title);
    final sourceArtist = HooviTextNormalizer.normalize(
      candidate.artists.isEmpty ? '' : candidate.artists.first,
    );
    final sourceAlbum = HooviTextNormalizer.normalize(candidate.album ?? '');
    final sourceIsrc = HooviTextNormalizer.normalize(candidate.isrc ?? '');

    if (identity.normalizedTitle.isNotEmpty &&
        sourceTitle == identity.normalizedTitle) {
      score += 0.30;
      reasons.add('exact title');
    } else if (_containsUsefulTokenOverlap(identity.normalizedTitle, sourceTitle)) {
      score += 0.16;
      reasons.add('similar title');
    }

    if (identity.normalizedPrimaryArtist.isNotEmpty &&
        sourceArtist == identity.normalizedPrimaryArtist) {
      score += 0.25;
      reasons.add('exact artist');
    } else if (_containsUsefulTokenOverlap(
      identity.normalizedPrimaryArtist,
      sourceArtist,
    )) {
      score += 0.12;
      reasons.add('similar artist');
    }

    if (identity.normalizedAlbum.isNotEmpty &&
        sourceAlbum == identity.normalizedAlbum) {
      score += 0.10;
      reasons.add('same album');
    }

    final durationScore = _durationScore(identity.durationMs, candidate.durationMs);
    if (durationScore > 0) {
      score += durationScore;
      reasons.add(durationScore >= 0.15 ? 'same duration' : 'close duration');
    }

    if (identity.normalizedIsrc.isNotEmpty &&
        sourceIsrc == identity.normalizedIsrc) {
      score += 0.25;
      reasons.add('same ISRC');
    }

    score += min(max(candidate.sourceConfidence, 0), 1) * 0.10;

    if (!candidate.hasPlayableReference) {
      score -= 0.20;
      reasons.add('no playable reference');
    }

    final normalized = min(max(score, 0), 1).toDouble();

    return HooviMatchScore(
      value: normalized,
      reason: reasons.isEmpty ? 'No strong match signals.' : reasons.join(', '),
    );
  }

  double _durationScore(int? expectedMs, int? actualMs) {
    if (expectedMs == null || actualMs == null || expectedMs <= 0 || actualMs <= 0) {
      return 0;
    }

    final difference = (expectedMs - actualMs).abs();
    if (difference <= durationToleranceMs) return 0.15;
    if (difference <= durationToleranceMs * 2) return 0.08;
    return 0;
  }

  bool _containsUsefulTokenOverlap(String left, String right) {
    if (left.isEmpty || right.isEmpty) return false;

    final leftTokens = left.split(' ').where((token) => token.length > 2).toSet();
    final rightTokens = right.split(' ').where((token) => token.length > 2).toSet();
    if (leftTokens.isEmpty || rightTokens.isEmpty) return false;

    final overlap = leftTokens.intersection(rightTokens).length;
    final smallest = min(leftTokens.length, rightTokens.length);
    return overlap / smallest >= 0.6;
  }
}
