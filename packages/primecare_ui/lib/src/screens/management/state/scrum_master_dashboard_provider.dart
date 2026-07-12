import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for ScrumMasterDashboardScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ScrumMasterDashboardNotifier extends StateNotifier<AsyncValue<void>> {
  ScrumMasterDashboardNotifier() : super(const AsyncValue.data(null));
}
