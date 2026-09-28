// Governance - Category: state | Purpose: Riverpod state notifier for Cfo Accounts Payable
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class CfoAccountsPayableNotifier extends StateNotifier<AsyncValue<void>> {
  CfoAccountsPayableNotifier() : super(const AsyncValue.data(null));
}
