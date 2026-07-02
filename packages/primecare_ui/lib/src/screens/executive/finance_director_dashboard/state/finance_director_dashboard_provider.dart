// Governance - Category: state | Purpose: Riverpod state notifier for FinanceDirectorDashboardScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FinanceDirectorDashboardNotifier extends StateNotifier<AsyncValue<void>> {
  FinanceDirectorDashboardNotifier() : super(const AsyncValue.data(null));
}
