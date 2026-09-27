// Governance - Category: state | Purpose: Riverpod state notifier for PatientCommandCenterScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PatientCommandCenterNotifier extends StateNotifier<AsyncValue<void>> {
  PatientCommandCenterNotifier() : super(const AsyncValue.data(null));
}
