import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for CooWorkflowScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CooWorkflowNotifier extends StateNotifier<AsyncValue<void>> {
  CooWorkflowNotifier() : super(const AsyncValue.data(null));
}
