import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for ExpenseManagementScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ExpenseManagementNotifier extends StateNotifier<AsyncValue<void>> {
  ExpenseManagementNotifier() : super(const AsyncValue.data(null));
}
