// Governance - Category: state | Purpose: Riverpod state notifier for MedicationAdministrationScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MedicationAdministrationNotifier extends StateNotifier<AsyncValue<void>> {
  MedicationAdministrationNotifier() : super(const AsyncValue.data(null));
}
