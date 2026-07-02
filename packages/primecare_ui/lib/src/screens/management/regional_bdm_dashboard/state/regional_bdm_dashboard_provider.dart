// Governance - Category: state | Purpose: Riverpod state notifier for RegionalBdmDashboardScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegionalBdmDashboardNotifier extends StateNotifier<AsyncValue<void>> {
  RegionalBdmDashboardNotifier() : super(const AsyncValue.data(null));
}
