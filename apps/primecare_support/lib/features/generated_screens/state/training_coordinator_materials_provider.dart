// Governance - Category: state | Purpose: Riverpod state notifier for Training Coordinator Materials
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class TrainingCoordinatorMaterialsNotifier extends StateNotifier<AsyncValue<void>> {
  TrainingCoordinatorMaterialsNotifier() : super(const AsyncValue.data(null));
}
