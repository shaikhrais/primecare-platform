// Governance - Category: state | Purpose: Riverpod state notifier for Therapist Compliance Workflow
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TherapistWorkflowNotifier extends StateNotifier<AsyncValue<void>> {
  TherapistWorkflowNotifier() : super(const AsyncValue.data(null));
}
