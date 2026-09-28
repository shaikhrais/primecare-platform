// Governance - Category: state | Purpose: Riverpod state notifier for Training Coordinator Attendance
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class TrainingCoordinatorAttendanceNotifier extends StateNotifier<AsyncValue<void>> {
  TrainingCoordinatorAttendanceNotifier() : super(const AsyncValue.data(null));
}
