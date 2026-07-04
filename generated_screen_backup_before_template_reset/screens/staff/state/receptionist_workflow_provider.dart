// Governance - Category: state | Purpose: Riverpod state notifier for ReceptionistWorkflowScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ReceptionistWorkflowNotifier extends StateNotifier<AsyncValue<void>> {
  ReceptionistWorkflowNotifier() : super(const AsyncValue.data(null));
}
