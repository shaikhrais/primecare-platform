// Governance - Category: state | Purpose: Riverpod state notifier for HrHiringWorkflowScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HrHiringWorkflowNotifier extends StateNotifier<AsyncValue<void>> {
  HrHiringWorkflowNotifier() : super(const AsyncValue.data(null));
}
