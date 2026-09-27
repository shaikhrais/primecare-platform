// Governance - Category: state | Purpose: Riverpod state notifier for Clinical Nurse Specialist Compliance Workflow
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CnsWorkflowNotifier extends StateNotifier<AsyncValue<void>> {
  CnsWorkflowNotifier() : super(const AsyncValue.data(null));
}
