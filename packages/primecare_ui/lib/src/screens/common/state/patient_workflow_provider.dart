import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for PatientWorkflowScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PatientWorkflowNotifier extends StateNotifier<AsyncValue<void>> {
  PatientWorkflowNotifier() : super(const AsyncValue.data(null));
}
