// Governance - Category: state | Purpose: Riverpod state notifier for HeadOfBusDevDashboardScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HeadOfBusDevDashboardNotifier extends StateNotifier<AsyncValue<void>> {
  HeadOfBusDevDashboardNotifier() : super(const AsyncValue.data(null));
}
