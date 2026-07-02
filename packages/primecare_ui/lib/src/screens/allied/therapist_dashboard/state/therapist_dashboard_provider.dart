// Governance - Category: state | Purpose: Riverpod state notifier for TherapistDashboardScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TherapistDashboardNotifier extends StateNotifier<AsyncValue<void>> {
  TherapistDashboardNotifier() : super(const AsyncValue.data(null));
}
