// Governance - Category: state | Purpose: Riverpod state notifier for Cfo Accounts Receivable
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CfoAccountsReceivableNotifier extends StateNotifier<AsyncValue<void>> {
  CfoAccountsReceivableNotifier() : super(const AsyncValue.data(null));
}
