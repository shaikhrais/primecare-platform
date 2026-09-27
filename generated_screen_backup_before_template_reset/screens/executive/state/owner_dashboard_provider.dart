// Governance - Category: state | Purpose: Riverpod state notifier for OwnerDashboardScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OwnerDashboardNotifier extends StateNotifier<AsyncValue<void>> {
  OwnerDashboardNotifier() : super(const AsyncValue.data(null));
}
