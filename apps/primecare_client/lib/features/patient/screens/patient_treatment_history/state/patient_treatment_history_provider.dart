// Governance - Category: state | Purpose: Riverpod state notifier for Patient Treatment History
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PatientTreatmentHistoryNotifier extends StateNotifier<AsyncValue<void>> {
  PatientTreatmentHistoryNotifier() : super(const AsyncValue.data(null));
}
