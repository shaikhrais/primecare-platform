import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for Remote Patient Monitoring Dashboard
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RemotePatientMonitoringDashboardNotifier extends StateNotifier<AsyncValue<void>> {
  RemotePatientMonitoringDashboardNotifier() : super(const AsyncValue.data(null));
}
