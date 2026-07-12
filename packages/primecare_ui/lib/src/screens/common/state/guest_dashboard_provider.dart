import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for GuestDashboardScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GuestDashboardNotifier extends StateNotifier<AsyncValue<void>> {
  GuestDashboardNotifier() : super(const AsyncValue.data(null));
}
