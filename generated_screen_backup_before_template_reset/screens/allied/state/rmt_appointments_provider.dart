// Governance - Category: state | Purpose: Riverpod state notifier for RmtAppointmentsScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RmtAppointmentsNotifier extends StateNotifier<AsyncValue<void>> {
  RmtAppointmentsNotifier() : super(const AsyncValue.data(null));
}
