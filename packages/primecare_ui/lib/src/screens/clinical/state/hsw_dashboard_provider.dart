// Governance - Category: state | Purpose: Riverpod state notifier for HswDashboardScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HswDashboardNotifier extends StateNotifier<AsyncValue<void>> {
  HswDashboardNotifier() : super(const AsyncValue.data(null));
}
