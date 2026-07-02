// Governance - Category: state | Purpose: Riverpod state notifier for CtoWorkflowScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CtoWorkflowNotifier extends StateNotifier<AsyncValue<void>> {
  CtoWorkflowNotifier() : super(const AsyncValue.data(null));
}
