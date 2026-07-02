// Governance - Category: state | Purpose: Riverpod state notifier for Billing Claims
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BillingClaimsNotifier extends StateNotifier<AsyncValue<void>> {
  BillingClaimsNotifier() : super(const AsyncValue.data(null));
}
