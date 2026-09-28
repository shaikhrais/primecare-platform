// Governance - Category: state | Purpose: Riverpod state notifier for Intake Coordinator Eligibility
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class IntakeCoordinatorEligibilityNotifier extends StateNotifier<AsyncValue<void>> {
  IntakeCoordinatorEligibilityNotifier() : super(const AsyncValue.data(null));
}
