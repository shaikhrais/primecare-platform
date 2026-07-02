// Governance - Category: state | Purpose: Riverpod state notifier for Patient Payments
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PatientPaymentsNotifier extends StateNotifier<AsyncValue<void>> {
  PatientPaymentsNotifier() : super(const AsyncValue.data(null));
}
