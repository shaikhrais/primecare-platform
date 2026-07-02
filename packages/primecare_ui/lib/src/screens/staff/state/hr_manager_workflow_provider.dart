// Governance - Category: state | Purpose: Riverpod state notifier for HrManagerWorkflowScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HrManagerWorkflowNotifier extends StateNotifier<AsyncValue<void>> {
  HrManagerWorkflowNotifier() : super(const AsyncValue.data(null));
}
