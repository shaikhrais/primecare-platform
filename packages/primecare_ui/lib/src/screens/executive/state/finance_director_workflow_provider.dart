import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for FinanceDirectorWorkflowScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FinanceDirectorWorkflowNotifier extends StateNotifier<AsyncValue<void>> {
  FinanceDirectorWorkflowNotifier() : super(const AsyncValue.data(null));
}
