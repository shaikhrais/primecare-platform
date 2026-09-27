// Governance - Category: state | Purpose: Riverpod state notifier for It Admin Dashboard
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ItAdminDashboardNotifier extends StateNotifier<AsyncValue<void>> {
  ItAdminDashboardNotifier() : super(const AsyncValue.data(null));
}
