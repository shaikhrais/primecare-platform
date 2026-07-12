import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for Registered Nurse (RN) Field Supervisor Analytics
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RnFieldSupervisorAnalyticsNotifier extends StateNotifier<AsyncValue<void>> {
  RnFieldSupervisorAnalyticsNotifier() : super(const AsyncValue.data(null));
}
