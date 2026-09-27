// Governance - Category: state | Purpose: Riverpod state notifier for CisoWorkflowScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CisoWorkflowNotifier extends StateNotifier<AsyncValue<void>> {
  CisoWorkflowNotifier() : super(const AsyncValue.data(null));
}
