import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for EmployeeDashboardScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EmployeeDashboardNotifier extends StateNotifier<AsyncValue<void>> {
  EmployeeDashboardNotifier() : super(const AsyncValue.data(null));
}
