// Governance - Category: state | Purpose: Riverpod state notifier for ExercisePrescriptionScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ExercisePrescriptionNotifier extends StateNotifier<AsyncValue<void>> {
  ExercisePrescriptionNotifier() : super(const AsyncValue.data(null));
}
