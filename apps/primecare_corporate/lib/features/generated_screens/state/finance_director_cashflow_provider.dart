// Governance - Category: state | Purpose: Riverpod state notifier for Finance Director Cashflow
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class FinanceDirectorCashflowNotifier extends StateNotifier<AsyncValue<void>> {
  FinanceDirectorCashflowNotifier() : super(const AsyncValue.data(null));
}
