// Governance - Category: state | Purpose: Riverpod state notifier for Receptionist Appointments
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ReceptionistAppointmentsNotifier extends StateNotifier<AsyncValue<void>> {
  ReceptionistAppointmentsNotifier() : super(const AsyncValue.data(null));
}
