import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for LpnDashboardScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LpnDashboardNotifier extends StateNotifier<AsyncValue<void>> {
  LpnDashboardNotifier() : super(const AsyncValue.data(null));
}
