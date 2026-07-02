// Governance - Category: state | Purpose: Riverpod state notifier for CfoExpensesScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CfoExpensesNotifier extends StateNotifier<AsyncValue<void>> {
  CfoExpensesNotifier() : super(const AsyncValue.data(null));
}
