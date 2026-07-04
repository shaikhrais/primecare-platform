// Governance - Category: state | Purpose: Riverpod state notifier for OperationsManagerWorkflowScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OperationsManagerWorkflowNotifier extends StateNotifier<AsyncValue<void>> {
  OperationsManagerWorkflowNotifier() : super(const AsyncValue.data(null));
}
