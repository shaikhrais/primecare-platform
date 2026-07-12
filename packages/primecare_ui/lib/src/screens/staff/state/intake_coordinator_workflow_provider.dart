import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for IntakeCoordinatorWorkflowScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class IntakeCoordinatorWorkflowNotifier extends StateNotifier<AsyncValue<void>> {
  IntakeCoordinatorWorkflowNotifier() : super(const AsyncValue.data(null));
}
