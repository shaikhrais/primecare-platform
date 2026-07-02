// Governance - Category: state | Purpose: Riverpod state notifier for RnDashboardScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RnDashboardNotifier extends StateNotifier<AsyncValue<void>> {
  RnDashboardNotifier() : super(const AsyncValue.data(null));
}
