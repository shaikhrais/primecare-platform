// Governance - Category: state | Purpose: Riverpod state notifier for Training Coordinator Training Schedule
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TrainingCoordinatorTrainingScheduleNotifier extends StateNotifier<AsyncValue<void>> {
  TrainingCoordinatorTrainingScheduleNotifier() : super(const AsyncValue.data(null));
}
