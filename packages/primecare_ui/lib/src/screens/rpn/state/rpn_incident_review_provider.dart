import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for RpnIncidentReviewScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RpnIncidentReviewNotifier extends StateNotifier<AsyncValue<void>> {
  RpnIncidentReviewNotifier() : super(const AsyncValue.data(null));
}
