import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for BillingOverviewScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BillingOverviewNotifier extends StateNotifier<AsyncValue<void>> {
  BillingOverviewNotifier() : super(const AsyncValue.data(null));
}
