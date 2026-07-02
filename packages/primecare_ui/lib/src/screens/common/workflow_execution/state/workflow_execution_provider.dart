// Governance - Category: state | Purpose: Riverpod state notifier for WorkflowExecutionScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WorkflowExecutionNotifier extends StateNotifier<AsyncValue<void>> {
  WorkflowExecutionNotifier() : super(const AsyncValue.data(null));
}
