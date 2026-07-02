// Governance - Category: state | Purpose: Riverpod state notifier for BusinessDevelopmentWorkflowScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BusinessDevelopmentWorkflowNotifier extends StateNotifier<AsyncValue<void>> {
  BusinessDevelopmentWorkflowNotifier() : super(const AsyncValue.data(null));
}
