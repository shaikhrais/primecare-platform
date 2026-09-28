// Governance - Category: state | Purpose: Riverpod state notifier for Quality Assurance Scorecards
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class QualityAssuranceScorecardsNotifier extends StateNotifier<AsyncValue<void>> {
  QualityAssuranceScorecardsNotifier() : super(const AsyncValue.data(null));
}
