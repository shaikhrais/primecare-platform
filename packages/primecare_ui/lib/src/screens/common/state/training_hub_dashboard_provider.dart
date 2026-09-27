import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for TrainingHubDashboardScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TrainingHubDashboardNotifier extends StateNotifier<AsyncValue<void>> {
  TrainingHubDashboardNotifier() : super(const AsyncValue.data(null));
}
