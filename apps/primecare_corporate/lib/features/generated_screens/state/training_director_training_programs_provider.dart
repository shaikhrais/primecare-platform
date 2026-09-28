// Governance - Category: state | Purpose: Riverpod state notifier for Training Director Training Programs
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class TrainingDirectorTrainingProgramsNotifier extends StateNotifier<AsyncValue<void>> {
  TrainingDirectorTrainingProgramsNotifier() : super(const AsyncValue.data(null));
}
