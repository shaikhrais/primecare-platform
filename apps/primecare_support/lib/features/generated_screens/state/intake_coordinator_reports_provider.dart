// Governance - Category: state | Purpose: Riverpod state notifier for Intake Coordinator Reports
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class IntakeCoordinatorReportsNotifier extends StateNotifier<AsyncValue<void>> {
  IntakeCoordinatorReportsNotifier() : super(const AsyncValue.data(null));
}
