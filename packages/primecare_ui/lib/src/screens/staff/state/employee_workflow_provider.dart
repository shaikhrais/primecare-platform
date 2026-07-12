import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for Employee Compliance Workflow
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EmployeeWorkflowNotifier extends StateNotifier<AsyncValue<void>> {
  EmployeeWorkflowNotifier() : super(const AsyncValue.data(null));
}
