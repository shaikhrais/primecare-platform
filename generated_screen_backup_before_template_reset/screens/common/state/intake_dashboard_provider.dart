// Governance - Category: state | Purpose: Riverpod state notifier for IntakeDashboardScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class IntakeDashboardNotifier extends StateNotifier<AsyncValue<void>> {
  IntakeDashboardNotifier() : super(const AsyncValue.data(null));
}
