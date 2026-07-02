// Governance - Category: state | Purpose: Riverpod state notifier for PatientBillingScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PatientBillingNotifier extends StateNotifier<AsyncValue<void>> {
  PatientBillingNotifier() : super(const AsyncValue.data(null));
}
