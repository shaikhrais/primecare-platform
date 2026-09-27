import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for CfoWorkflowScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CfoWorkflowNotifier extends StateNotifier<AsyncValue<void>> {
  CfoWorkflowNotifier() : super(const AsyncValue.data(null));
}
