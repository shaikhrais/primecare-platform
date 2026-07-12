import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for Psw Workflow
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PswWorkflowNotifier extends StateNotifier<AsyncValue<void>> {
  PswWorkflowNotifier() : super(const AsyncValue.data(null));
}
