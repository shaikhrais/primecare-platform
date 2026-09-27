// Governance - Category: state | Purpose: Riverpod state notifier for Family Billing
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FamilyBillingNotifier extends StateNotifier<AsyncValue<void>> {
  FamilyBillingNotifier() : super(const AsyncValue.data(null));
}
