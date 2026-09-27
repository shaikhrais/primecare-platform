import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for Billing Invoices
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BillingInvoicesNotifier extends StateNotifier<AsyncValue<void>> {
  BillingInvoicesNotifier() : super(const AsyncValue.data(null));
}
