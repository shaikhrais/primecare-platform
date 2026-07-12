import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for TrainingHubWorkflowScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TrainingHubWorkflowNotifier extends StateNotifier<AsyncValue<void>> {
  TrainingHubWorkflowNotifier() : super(const AsyncValue.data(null));
}
