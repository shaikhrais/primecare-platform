// Governance - Category: state | Purpose: Riverpod state notifier for Admin Reconciliation
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class AdminReconciliationNotifier extends StateNotifier<AsyncValue<void>> {
  AdminReconciliationNotifier() : super(const AsyncValue.data(null));
}
