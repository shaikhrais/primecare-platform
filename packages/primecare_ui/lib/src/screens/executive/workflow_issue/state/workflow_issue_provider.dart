// Governance - Category: state | Purpose: Riverpod state notifier for WorkflowIssueScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WorkflowIssueNotifier extends StateNotifier<AsyncValue<void>> {
  WorkflowIssueNotifier() : super(const AsyncValue.data(null));
}
