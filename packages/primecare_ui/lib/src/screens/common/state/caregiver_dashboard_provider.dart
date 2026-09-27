import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for CaregiverDashboardScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CaregiverDashboardNotifier extends StateNotifier<AsyncValue<void>> {
  CaregiverDashboardNotifier() : super(const AsyncValue.data(null));
}
