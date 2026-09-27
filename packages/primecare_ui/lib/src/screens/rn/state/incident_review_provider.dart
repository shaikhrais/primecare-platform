import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for IncidentReviewScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class IncidentReviewNotifier extends StateNotifier<AsyncValue<void>> {
  IncidentReviewNotifier() : super(const AsyncValue.data(null));
}
