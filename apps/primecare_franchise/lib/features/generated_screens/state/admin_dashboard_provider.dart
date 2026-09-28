// Governance - Category: state | Purpose: Riverpod state notifier for Admin Dashboard
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class AdminDashboardNotifier extends StateNotifier<AsyncValue<void>> {
  AdminDashboardNotifier() : super(const AsyncValue.data(null));
}
