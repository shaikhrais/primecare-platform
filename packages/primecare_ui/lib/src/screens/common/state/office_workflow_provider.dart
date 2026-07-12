import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for OfficeWorkflowScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OfficeWorkflowNotifier extends StateNotifier<AsyncValue<void>> {
  OfficeWorkflowNotifier() : super(const AsyncValue.data(null));
}
