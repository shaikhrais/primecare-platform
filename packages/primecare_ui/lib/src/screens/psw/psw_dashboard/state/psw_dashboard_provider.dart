// Governance - Category: state | Purpose: Riverpod state notifier for Care Dashboard
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PswDashboardNotifier extends StateNotifier<AsyncValue<void>> {
  PswDashboardNotifier() : super(const AsyncValue.data(null));
}
