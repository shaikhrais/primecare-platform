// Governance - Category: state | Purpose: Riverpod state notifier for PatientAppointmentsScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PatientAppointmentsNotifier extends StateNotifier<AsyncValue<void>> {
  PatientAppointmentsNotifier() : super(const AsyncValue.data(null));
}
