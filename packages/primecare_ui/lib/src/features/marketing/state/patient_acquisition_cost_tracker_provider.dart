import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for Patient Acquisition Cost Tracker
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PatientAcquisitionCostTrackerNotifier extends StateNotifier<AsyncValue<void>> {
  PatientAcquisitionCostTrackerNotifier() : super(const AsyncValue.data(null));
}
