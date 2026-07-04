// Governance - Category: state | Purpose: Riverpod state notifier for ChiropractorDashboardScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChiropractorDashboardNotifier extends StateNotifier<AsyncValue<void>> {
  ChiropractorDashboardNotifier() : super(const AsyncValue.data(null));
}
