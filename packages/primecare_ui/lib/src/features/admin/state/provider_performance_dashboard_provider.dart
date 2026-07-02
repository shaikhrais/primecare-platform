// Governance - Category: state | Purpose: Riverpod state notifier for Provider Performance Dashboard
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProviderPerformanceDashboardNotifier extends StateNotifier<AsyncValue<void>> {
  ProviderPerformanceDashboardNotifier() : super(const AsyncValue.data(null));
}
