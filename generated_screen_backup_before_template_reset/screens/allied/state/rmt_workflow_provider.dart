// Governance - Category: state | Purpose: Riverpod state notifier for RmtWorkflowScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RmtWorkflowNotifier extends StateNotifier<AsyncValue<void>> {
  RmtWorkflowNotifier() : super(const AsyncValue.data(null));
}
