// Governance - Category: state | Purpose: Riverpod state notifier for Training Coordinator Workshops
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class TrainingCoordinatorWorkshopsNotifier extends StateNotifier<AsyncValue<void>> {
  TrainingCoordinatorWorkshopsNotifier() : super(const AsyncValue.data(null));
}
