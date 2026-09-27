// Governance - Category: state | Purpose: Riverpod state notifier for PatientObservationScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PatientObservationNotifier extends StateNotifier<AsyncValue<void>> {
  PatientObservationNotifier() : super(const AsyncValue.data(null));
}
