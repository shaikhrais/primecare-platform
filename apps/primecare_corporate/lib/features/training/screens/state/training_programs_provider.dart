// Governance - Category: state | Purpose: Riverpod state notifier for Training Programs
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class TrainingProgramsNotifier extends StateNotifier<AsyncValue<void>> {
  TrainingProgramsNotifier() : super(const AsyncValue.data(null));
}
