import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for DefectTrackingScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DefectTrackingNotifier extends StateNotifier<AsyncValue<void>> {
  DefectTrackingNotifier() : super(const AsyncValue.data(null));
}
