import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for ArchitecturePlanningDashboardScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ArchitecturePlanningDashboardNotifier extends StateNotifier<AsyncValue<void>> {
  ArchitecturePlanningDashboardNotifier() : super(const AsyncValue.data(null));
}
