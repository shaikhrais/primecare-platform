// Governance - Category: state | Purpose: Riverpod state notifier for Licensed Practical Nurse (LPN) Compliance Workflow
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LpnWorkflowNotifier extends StateNotifier<AsyncValue<void>> {
  LpnWorkflowNotifier() : super(const AsyncValue.data(null));
}
