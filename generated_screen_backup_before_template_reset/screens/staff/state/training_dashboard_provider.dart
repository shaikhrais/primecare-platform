// Governance - Category: state | Purpose: Riverpod state notifier for TrainingDashboardScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TrainingDashboardNotifier extends StateNotifier<AsyncValue<void>> {
  TrainingDashboardNotifier() : super(const AsyncValue.data(null));
}
