import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for Dynamic Dashboard
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DynamicDashboardNotifier extends StateNotifier<AsyncValue<void>> {
  DynamicDashboardNotifier() : super(const AsyncValue.data(null));
}
