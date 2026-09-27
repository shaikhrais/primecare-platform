import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for FinancialDashboardScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FinancialDashboardNotifier extends StateNotifier<AsyncValue<void>> {
  FinancialDashboardNotifier() : super(const AsyncValue.data(null));
}
