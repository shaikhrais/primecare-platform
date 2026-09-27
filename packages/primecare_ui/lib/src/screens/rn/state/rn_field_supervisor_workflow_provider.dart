import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for Registered Nurse (RN) Field Supervisor Compliance Workflow
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RnFieldSupervisorWorkflowNotifier extends StateNotifier<AsyncValue<void>> {
  RnFieldSupervisorWorkflowNotifier() : super(const AsyncValue.data(null));
}
