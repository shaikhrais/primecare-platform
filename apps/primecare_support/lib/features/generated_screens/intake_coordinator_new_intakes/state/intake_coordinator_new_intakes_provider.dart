// Governance - Category: state | Purpose: Riverpod state notifier for Intake Coordinator New Intakes
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class IntakeCoordinatorNewIntakesNotifier extends StateNotifier<AsyncValue<void>> {
  IntakeCoordinatorNewIntakesNotifier() : super(const AsyncValue.data(null));
}
