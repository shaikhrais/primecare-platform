import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for ProgressTrackingScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProgressTrackingNotifier extends StateNotifier<AsyncValue<void>> {
  ProgressTrackingNotifier() : super(const AsyncValue.data(null));
}
