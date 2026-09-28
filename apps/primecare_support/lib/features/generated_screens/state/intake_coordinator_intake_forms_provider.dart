// Governance - Category: state | Purpose: Riverpod state notifier for Intake Coordinator Intake Forms
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class IntakeCoordinatorIntakeFormsNotifier extends StateNotifier<AsyncValue<void>> {
  IntakeCoordinatorIntakeFormsNotifier() : super(const AsyncValue.data(null));
}
