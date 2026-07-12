import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for DynamicScreenDashboardScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DynamicScreenDashboardNotifier extends StateNotifier<AsyncValue<void>> {
  DynamicScreenDashboardNotifier() : super(const AsyncValue.data(null));
}
