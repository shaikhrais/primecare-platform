// Governance - Category: state | Purpose: Riverpod state notifier for PhysicianDashboardScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PhysicianDashboardNotifier extends StateNotifier<AsyncValue<void>> {
  PhysicianDashboardNotifier() : super(const AsyncValue.data(null));
}
