// Governance - Category: state | Purpose: Riverpod state notifier for Franchise Owner Dashboard
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FranchiseOwnerDashboardNotifier extends StateNotifier<AsyncValue<void>> {
  FranchiseOwnerDashboardNotifier() : super(const AsyncValue.data(null));
}
