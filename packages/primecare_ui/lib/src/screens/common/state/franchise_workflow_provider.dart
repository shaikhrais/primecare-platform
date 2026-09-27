import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for FranchiseWorkflowScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FranchiseWorkflowNotifier extends StateNotifier<AsyncValue<void>> {
  FranchiseWorkflowNotifier() : super(const AsyncValue.data(null));
}
