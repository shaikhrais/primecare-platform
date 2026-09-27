import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for SystemDashboardScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SystemDashboardNotifier extends StateNotifier<AsyncValue<void>> {
  SystemDashboardNotifier() : super(const AsyncValue.data(null));
}
