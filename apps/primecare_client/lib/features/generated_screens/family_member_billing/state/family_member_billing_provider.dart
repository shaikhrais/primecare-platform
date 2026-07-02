// Governance - Category: state | Purpose: Riverpod state notifier for Family Member Billing
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FamilyMemberBillingNotifier extends StateNotifier<AsyncValue<void>> {
  FamilyMemberBillingNotifier() : super(const AsyncValue.data(null));
}
