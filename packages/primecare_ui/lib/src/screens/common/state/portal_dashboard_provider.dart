import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for PortalDashboardScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PortalDashboardNotifier extends StateNotifier<AsyncValue<void>> {
  PortalDashboardNotifier() : super(const AsyncValue.data(null));
}
