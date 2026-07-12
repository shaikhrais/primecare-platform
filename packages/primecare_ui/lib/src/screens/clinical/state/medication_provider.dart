import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for MedicationScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MedicationNotifier extends StateNotifier<AsyncValue<void>> {
  MedicationNotifier() : super(const AsyncValue.data(null));
}
