// Governance - Category: state | Purpose: Riverpod state notifier for Patient Trial Outcomeser
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PatientTrialOutcomeserNotifier extends StateNotifier<AsyncValue<void>> {
  PatientTrialOutcomeserNotifier() : super(const AsyncValue.data(null));
}
