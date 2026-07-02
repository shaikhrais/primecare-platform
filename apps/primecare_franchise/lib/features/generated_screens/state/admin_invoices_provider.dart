// Governance - Category: state | Purpose: Riverpod state notifier for Admin Invoices
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AdminInvoicesNotifier extends StateNotifier<AsyncValue<void>> {
  AdminInvoicesNotifier() : super(const AsyncValue.data(null));
}
