// Governance - Category: state | Purpose: Riverpod state notifier for Nurse Dashboard
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NurseDashboardNotifier extends StateNotifier<AsyncValue<void>> {
  NurseDashboardNotifier() : super(const AsyncValue.data(null));
}
