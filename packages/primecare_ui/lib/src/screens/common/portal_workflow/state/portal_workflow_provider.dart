// Governance - Category: state | Purpose: Riverpod state notifier for PortalWorkflowScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PortalWorkflowNotifier extends StateNotifier<AsyncValue<void>> {
  PortalWorkflowNotifier() : super(const AsyncValue.data(null));
}
