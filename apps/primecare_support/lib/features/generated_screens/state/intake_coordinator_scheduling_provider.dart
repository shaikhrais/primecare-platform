// Governance - Category: state | Purpose: Riverpod state notifier for Intake Coordinator Scheduling
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class IntakeCoordinatorSchedulingNotifier extends StateNotifier<AsyncValue<void>> {
  IntakeCoordinatorSchedulingNotifier() : super(const AsyncValue.data(null));
}
