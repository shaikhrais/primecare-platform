// Governance - Category: state | Purpose: Riverpod state notifier for PhysiotherapistWorkflowScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PhysiotherapistWorkflowNotifier extends StateNotifier<AsyncValue<void>> {
  PhysiotherapistWorkflowNotifier() : super(const AsyncValue.data(null));
}
