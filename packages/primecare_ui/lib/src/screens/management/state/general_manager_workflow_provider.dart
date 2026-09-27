import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for GeneralManagerWorkflowScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GeneralManagerWorkflowNotifier extends StateNotifier<AsyncValue<void>> {
  GeneralManagerWorkflowNotifier() : super(const AsyncValue.data(null));
}
