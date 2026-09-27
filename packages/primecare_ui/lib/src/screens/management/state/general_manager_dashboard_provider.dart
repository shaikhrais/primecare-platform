import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for GeneralManagerDashboardScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GeneralManagerDashboardNotifier extends StateNotifier<AsyncValue<void>> {
  GeneralManagerDashboardNotifier() : super(const AsyncValue.data(null));
}
