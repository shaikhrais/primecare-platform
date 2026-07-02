// Governance - Category: state | Purpose: Riverpod state notifier for VolunteerCoordinatorComplianceScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class VolunteerCoordinatorComplianceNotifier extends StateNotifier<AsyncValue<void>> {
  VolunteerCoordinatorComplianceNotifier() : super(const AsyncValue.data(null));
}
