// Governance - Category: state | Purpose: Riverpod state notifier for AppointmentScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppointmentNotifier extends StateNotifier<AsyncValue<void>> {
  AppointmentNotifier() : super(const AsyncValue.data(null));
}
