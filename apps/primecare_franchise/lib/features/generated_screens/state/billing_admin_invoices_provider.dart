// Governance - Category: state | Purpose: Riverpod state notifier for Billing Admin Invoices
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class BillingAdminInvoicesNotifier extends StateNotifier<AsyncValue<void>> {
  BillingAdminInvoicesNotifier() : super(const AsyncValue.data(null));
}
