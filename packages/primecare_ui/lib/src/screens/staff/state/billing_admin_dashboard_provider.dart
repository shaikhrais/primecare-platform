import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for BillingAdminDashboardScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BillingAdminDashboardNotifier extends StateNotifier<AsyncValue<void>> {
  BillingAdminDashboardNotifier() : super(const AsyncValue.data(null));
}
