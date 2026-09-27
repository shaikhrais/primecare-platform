// Governance - Category: state | Purpose: Riverpod state notifier for Staff Training Matrix
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StaffTrainingMatrixNotifier extends StateNotifier<AsyncValue<void>> {
  StaffTrainingMatrixNotifier() : super(const AsyncValue.data(null));
}
