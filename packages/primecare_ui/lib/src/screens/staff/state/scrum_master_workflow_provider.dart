import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for ScrumMasterWorkflowScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ScrumMasterWorkflowNotifier extends StateNotifier<AsyncValue<void>> {
  ScrumMasterWorkflowNotifier() : super(const AsyncValue.data(null));
}
