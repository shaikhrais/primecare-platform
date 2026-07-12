import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for ClinicWorkflowScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ClinicWorkflowNotifier extends StateNotifier<AsyncValue<void>> {
  ClinicWorkflowNotifier() : super(const AsyncValue.data(null));
}
