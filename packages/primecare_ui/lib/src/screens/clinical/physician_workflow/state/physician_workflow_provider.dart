// Governance - Category: state | Purpose: Riverpod state notifier for Physician Compliance Workflow
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PhysicianWorkflowNotifier extends StateNotifier<AsyncValue<void>> {
  PhysicianWorkflowNotifier() : super(const AsyncValue.data(null));
}
