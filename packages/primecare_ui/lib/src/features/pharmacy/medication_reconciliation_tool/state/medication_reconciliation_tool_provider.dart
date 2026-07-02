// Governance - Category: state | Purpose: Riverpod state notifier for Medication Reconciliation Tool
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MedicationReconciliationToolNotifier extends StateNotifier<AsyncValue<void>> {
  MedicationReconciliationToolNotifier() : super(const AsyncValue.data(null));
}
