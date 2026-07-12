import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for RoleCoverageDashboardScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RoleCoverageDashboardNotifier extends StateNotifier<AsyncValue<void>> {
  RoleCoverageDashboardNotifier() : super(const AsyncValue.data(null));
}
