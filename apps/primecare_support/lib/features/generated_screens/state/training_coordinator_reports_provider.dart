// Governance - Category: state | Purpose: Riverpod state notifier for Training Coordinator Reports
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class TrainingCoordinatorReportsNotifier extends StateNotifier<AsyncValue<void>> {
  TrainingCoordinatorReportsNotifier() : super(const AsyncValue.data(null));
}
