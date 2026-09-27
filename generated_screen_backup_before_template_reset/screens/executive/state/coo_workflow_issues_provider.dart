// Governance - Category: state | Purpose: Riverpod state notifier for CooWorkflowIssuesScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CooWorkflowIssuesNotifier extends StateNotifier<AsyncValue<void>> {
  CooWorkflowIssuesNotifier() : super(const AsyncValue.data(null));
}
