// Governance - Category: state | Purpose: Riverpod state notifier for RpnDashboardScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RpnDashboardNotifier extends StateNotifier<AsyncValue<void>> {
  RpnDashboardNotifier() : super(const AsyncValue.data(null));
}
