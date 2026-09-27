import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for Nurse Practitioner (NP) Compliance Workflow
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NpWorkflowNotifier extends StateNotifier<AsyncValue<void>> {
  NpWorkflowNotifier() : super(const AsyncValue.data(null));
}
