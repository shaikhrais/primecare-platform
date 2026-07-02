// Governance - Category: state | Purpose: Riverpod state notifier for Patient Care Team
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PatientCareTeamNotifier extends StateNotifier<AsyncValue<void>> {
  PatientCareTeamNotifier() : super(const AsyncValue.data(null));
}
