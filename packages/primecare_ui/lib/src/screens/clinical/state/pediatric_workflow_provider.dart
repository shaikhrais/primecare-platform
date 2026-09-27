import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for Pediatric Specialist Compliance Workflow
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PediatricWorkflowNotifier extends StateNotifier<AsyncValue<void>> {
  PediatricWorkflowNotifier() : super(const AsyncValue.data(null));
}
