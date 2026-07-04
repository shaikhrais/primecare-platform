// Governance - Category: state | Purpose: Riverpod state notifier for ReceptionistDashboardScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ReceptionistDashboardNotifier extends StateNotifier<AsyncValue<void>> {
  ReceptionistDashboardNotifier() : super(const AsyncValue.data(null));
}
