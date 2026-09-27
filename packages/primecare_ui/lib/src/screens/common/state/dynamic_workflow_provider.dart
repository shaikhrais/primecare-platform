import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for DynamicScreenWorkflowScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DynamicWorkflowNotifier extends StateNotifier<AsyncValue<void>> {
  DynamicWorkflowNotifier() : super(const AsyncValue.data(null));
}
