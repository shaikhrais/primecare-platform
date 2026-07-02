// Governance - Category: state | Purpose: Riverpod state notifier for Patient Medication Adherence
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PatientMedicationAdherenceNotifier extends StateNotifier<AsyncValue<void>> {
  PatientMedicationAdherenceNotifier() : super(const AsyncValue.data(null));
}
