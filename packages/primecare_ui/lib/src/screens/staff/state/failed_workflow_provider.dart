import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for FailedWorkflowScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FailedWorkflowNotifier extends StateNotifier<AsyncValue<void>> {
  FailedWorkflowNotifier() : super(const AsyncValue.data(null));
}
