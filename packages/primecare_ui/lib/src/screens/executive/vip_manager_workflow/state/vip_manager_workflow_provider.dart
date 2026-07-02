// Governance - Category: state | Purpose: Riverpod state notifier for VIP Client Manager Compliance Workflow
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class VipManagerWorkflowNotifier extends StateNotifier<AsyncValue<void>> {
  VipManagerWorkflowNotifier() : super(const AsyncValue.data(null));
}
