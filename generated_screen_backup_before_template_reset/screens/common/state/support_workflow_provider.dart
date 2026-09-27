// Governance - Category: state | Purpose: Riverpod state notifier for SupportWorkflowScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SupportWorkflowNotifier extends StateNotifier<AsyncValue<void>> {
  SupportWorkflowNotifier() : super(const AsyncValue.data(null));
}
