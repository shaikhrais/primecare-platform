// Governance - Category: state | Purpose: Riverpod state notifier for VolunteerDashboardScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class VolunteerDashboardNotifier extends StateNotifier<AsyncValue<void>> {
  VolunteerDashboardNotifier() : super(const AsyncValue.data(null));
}
