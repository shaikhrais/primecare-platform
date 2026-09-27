import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for BillingScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BillingNotifier extends StateNotifier<AsyncValue<void>> {
  BillingNotifier() : super(const AsyncValue.data(null));
}
