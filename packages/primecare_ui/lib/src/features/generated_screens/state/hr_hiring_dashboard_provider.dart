import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for HrHiringDashboardScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HrHiringDashboardNotifier extends StateNotifier<AsyncValue<void>> {
  HrHiringDashboardNotifier() : super(const AsyncValue.data(null));
}
