// Governance - Category: state | Purpose: Riverpod state notifier for PatientProfileScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PatientProfileNotifier extends StateNotifier<AsyncValue<void>> {
  PatientProfileNotifier() : super(const AsyncValue.data(null));
}
