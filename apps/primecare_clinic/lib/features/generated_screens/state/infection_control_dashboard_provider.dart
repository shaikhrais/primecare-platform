// Governance - Category: state | Purpose: Riverpod state notifier for Infection Control Dashboard
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class InfectionControlDashboardNotifier extends StateNotifier<AsyncValue<void>> {
  InfectionControlDashboardNotifier() : super(const AsyncValue.data(null));
}
