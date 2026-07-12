import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for TrainingManagementScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TrainingManagementNotifier extends StateNotifier<AsyncValue<void>> {
  TrainingManagementNotifier() : super(const AsyncValue.data(null));
}
