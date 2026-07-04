// Governance - Category: state | Purpose: Riverpod state notifier for TrainingDirectorWorkflowScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TrainingDirectorWorkflowNotifier extends StateNotifier<AsyncValue<void>> {
  TrainingDirectorWorkflowNotifier() : super(const AsyncValue.data(null));
}
