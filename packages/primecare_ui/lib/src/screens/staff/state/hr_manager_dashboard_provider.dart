import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for HrManagerDashboardScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HrManagerDashboardNotifier extends StateNotifier<AsyncValue<void>> {
  HrManagerDashboardNotifier() : super(const AsyncValue.data(null));
}
