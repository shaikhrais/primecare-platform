// Governance - Category: state | Purpose: Riverpod state notifier for Trainer Assignments
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class TrainerAssignmentsNotifier extends StateNotifier<AsyncValue<void>> {
  TrainerAssignmentsNotifier() : super(const AsyncValue.data(null));
}
