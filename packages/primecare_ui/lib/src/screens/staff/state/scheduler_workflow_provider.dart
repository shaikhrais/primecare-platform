import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for SchedulerWorkflowScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SchedulerWorkflowNotifier extends StateNotifier<AsyncValue<void>> {
  SchedulerWorkflowNotifier() : super(const AsyncValue.data(null));
}
