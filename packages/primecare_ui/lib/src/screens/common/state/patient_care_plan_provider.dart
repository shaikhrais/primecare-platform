import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for PatientCarePlanScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PatientCarePlanNotifier extends StateNotifier<AsyncValue<void>> {
  PatientCarePlanNotifier() : super(const AsyncValue.data(null));
}
