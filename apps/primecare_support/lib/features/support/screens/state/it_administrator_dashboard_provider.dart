// Governance - Category: state | Purpose: Riverpod state notifier for It Administrator Dashboard
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class ItAdministratorDashboardNotifier extends StateNotifier<AsyncValue<void>> {
  ItAdministratorDashboardNotifier() : super(const AsyncValue.data(null));
}
