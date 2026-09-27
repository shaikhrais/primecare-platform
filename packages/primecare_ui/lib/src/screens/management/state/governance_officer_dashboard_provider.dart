import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for GovernanceOfficerDashboardScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GovernanceOfficerDashboardNotifier extends StateNotifier<AsyncValue<void>> {
  GovernanceOfficerDashboardNotifier() : super(const AsyncValue.data(null));
}
