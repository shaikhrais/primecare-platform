// Governance - Category: state | Purpose: Riverpod state notifier for VolunteerCoordinatorDashboardScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class VolunteerCoordinatorDashboardNotifier extends StateNotifier<AsyncValue<void>> {
  VolunteerCoordinatorDashboardNotifier() : super(const AsyncValue.data(null));
}
