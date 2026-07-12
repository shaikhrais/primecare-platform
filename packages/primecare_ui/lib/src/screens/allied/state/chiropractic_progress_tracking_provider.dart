import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for ChiropracticProgressTrackingScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChiropracticProgressTrackingNotifier extends StateNotifier<AsyncValue<void>> {
  ChiropracticProgressTrackingNotifier() : super(const AsyncValue.data(null));
}
