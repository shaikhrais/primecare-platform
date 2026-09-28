// Governance - Category: state | Purpose: Riverpod state notifier for Client Book Appointment
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class ClientBookAppointmentNotifier extends StateNotifier<AsyncValue<void>> {
  ClientBookAppointmentNotifier() : super(const AsyncValue.data(null));
}
