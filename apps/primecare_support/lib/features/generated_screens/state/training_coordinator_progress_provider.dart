// Governance - Category: state | Purpose: Riverpod state notifier for Training Coordinator Progress
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class TrainingCoordinatorProgressNotifier extends StateNotifier<AsyncValue<void>> {
  TrainingCoordinatorProgressNotifier() : super(const AsyncValue.data(null));
}
