import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for OperationsManagerDashboardScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OperationsManagerDashboardNotifier extends StateNotifier<AsyncValue<void>> {
  OperationsManagerDashboardNotifier() : super(const AsyncValue.data(null));
}
