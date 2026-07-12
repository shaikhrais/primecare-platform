import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for OwnerWorkflowScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OwnerWorkflowNotifier extends StateNotifier<AsyncValue<void>> {
  OwnerWorkflowNotifier() : super(const AsyncValue.data(null));
}
