// Governance - Category: state | Purpose: Riverpod state notifier for Patient My Appointments
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PatientMyAppointmentsNotifier extends StateNotifier<AsyncValue<void>> {
  PatientMyAppointmentsNotifier() : super(const AsyncValue.data(null));
}
