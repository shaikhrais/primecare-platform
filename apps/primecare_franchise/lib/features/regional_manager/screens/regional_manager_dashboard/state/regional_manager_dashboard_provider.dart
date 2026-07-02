// Governance - Category: state | Purpose: Riverpod state notifier for Regional Manager Dashboard
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegionalManagerDashboardNotifier extends StateNotifier<AsyncValue<void>> {
  RegionalManagerDashboardNotifier() : super(const AsyncValue.data(null));
}
