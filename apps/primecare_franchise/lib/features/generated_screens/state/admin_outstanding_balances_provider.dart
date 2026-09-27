// Governance - Category: state | Purpose: Riverpod state notifier for Admin Outstanding Balances
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AdminOutstandingBalancesNotifier extends StateNotifier<AsyncValue<void>> {
  AdminOutstandingBalancesNotifier() : super(const AsyncValue.data(null));
}
