// Governance - Category: state | Purpose: Riverpod state notifier for Operations Manager Attendance
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class OperationsManagerAttendanceNotifier extends StateNotifier<AsyncValue<void>> {
  OperationsManagerAttendanceNotifier() : super(const AsyncValue.data(null));
}
