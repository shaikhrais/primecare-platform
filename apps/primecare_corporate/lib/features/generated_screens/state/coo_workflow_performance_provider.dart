// Governance - Category: state | Purpose: Riverpod state notifier for Coo Workflow Performance
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CooWorkflowPerformanceNotifier extends StateNotifier<AsyncValue<void>> {
  CooWorkflowPerformanceNotifier() : super(const AsyncValue.data(null));
}
