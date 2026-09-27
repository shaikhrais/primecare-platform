import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for HrDirectorWorkflowScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HrDirectorWorkflowNotifier extends StateNotifier<AsyncValue<void>> {
  HrDirectorWorkflowNotifier() : super(const AsyncValue.data(null));
}
