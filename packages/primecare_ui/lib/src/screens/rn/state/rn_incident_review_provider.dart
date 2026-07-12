import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for RnIncidentReviewScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RnIncidentReviewNotifier extends StateNotifier<AsyncValue<void>> {
  RnIncidentReviewNotifier() : super(const AsyncValue.data(null));
}
