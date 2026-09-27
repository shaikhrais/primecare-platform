import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for AppointmentOverviewScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppointmentOverviewNotifier extends StateNotifier<AsyncValue<void>> {
  AppointmentOverviewNotifier() : super(const AsyncValue.data(null));
}
