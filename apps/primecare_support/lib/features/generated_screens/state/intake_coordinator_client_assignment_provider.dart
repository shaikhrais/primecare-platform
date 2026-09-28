// Governance - Category: state | Purpose: Riverpod state notifier for Intake Coordinator Client Assignment
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class IntakeCoordinatorClientAssignmentNotifier extends StateNotifier<AsyncValue<void>> {
  IntakeCoordinatorClientAssignmentNotifier() : super(const AsyncValue.data(null));
}
