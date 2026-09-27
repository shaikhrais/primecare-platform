import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for ComplianceManagerWorkflowScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ComplianceManagerWorkflowNotifier extends StateNotifier<AsyncValue<void>> {
  ComplianceManagerWorkflowNotifier() : super(const AsyncValue.data(null));
}
