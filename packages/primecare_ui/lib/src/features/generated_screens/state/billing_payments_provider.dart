import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for Billing Payments
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BillingPaymentsNotifier extends StateNotifier<AsyncValue<void>> {
  BillingPaymentsNotifier() : super(const AsyncValue.data(null));
}
