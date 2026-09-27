// Governance - Category: state | Purpose: Riverpod state notifier for PatientComplianceScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PatientComplianceNotifier extends StateNotifier<AsyncValue<void>> {
  PatientComplianceNotifier() : super(const AsyncValue.data(null));
}
