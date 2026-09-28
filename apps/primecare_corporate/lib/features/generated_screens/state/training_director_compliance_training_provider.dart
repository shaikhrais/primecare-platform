// Governance - Category: state | Purpose: Riverpod state notifier for Training Director Compliance Training
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class TrainingDirectorComplianceTrainingNotifier extends StateNotifier<AsyncValue<void>> {
  TrainingDirectorComplianceTrainingNotifier() : super(const AsyncValue.data(null));
}
