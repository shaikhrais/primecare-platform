// Governance - Category: state | Purpose: Riverpod state notifier for Client My Appointments
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ClientMyAppointmentsNotifier extends StateNotifier<AsyncValue<void>> {
  ClientMyAppointmentsNotifier() : super(const AsyncValue.data(null));
}
