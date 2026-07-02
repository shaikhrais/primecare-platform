// Governance - Category: state | Purpose: Riverpod state notifier for Patient Book Appointment
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PatientBookAppointmentNotifier extends StateNotifier<AsyncValue<void>> {
  PatientBookAppointmentNotifier() : super(const AsyncValue.data(null));
}
