import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for TrainingDirectorDashboardScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TrainingDirectorDashboardNotifier extends StateNotifier<AsyncValue<void>> {
  TrainingDirectorDashboardNotifier() : super(const AsyncValue.data(null));
}
