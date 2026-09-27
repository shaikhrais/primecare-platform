import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for PatientDashboardScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PatientDashboardNotifier extends StateNotifier<AsyncValue<void>> {
  PatientDashboardNotifier() : super(const AsyncValue.data(null));
}
