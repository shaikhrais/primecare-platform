// Governance - Category: state | Purpose: Riverpod state notifier for GuestWorkflowScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GuestWorkflowNotifier extends StateNotifier<AsyncValue<void>> {
  GuestWorkflowNotifier() : super(const AsyncValue.data(null));
}
