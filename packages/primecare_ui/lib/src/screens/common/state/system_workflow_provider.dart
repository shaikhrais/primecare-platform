import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for SystemWorkflowScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SystemWorkflowNotifier extends StateNotifier<AsyncValue<void>> {
  SystemWorkflowNotifier() : super(const AsyncValue.data(null));
}
