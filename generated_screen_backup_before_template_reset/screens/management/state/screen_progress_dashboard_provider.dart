// Governance - Category: state | Purpose: Riverpod state notifier for ScreenProgressDashboardScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ScreenProgressDashboardNotifier extends StateNotifier<AsyncValue<void>> {
  ScreenProgressDashboardNotifier() : super(const AsyncValue.data(null));
}
