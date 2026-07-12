import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for HrDirectorDashboardScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HrDirectorDashboardNotifier extends StateNotifier<AsyncValue<void>> {
  HrDirectorDashboardNotifier() : super(const AsyncValue.data(null));
}
