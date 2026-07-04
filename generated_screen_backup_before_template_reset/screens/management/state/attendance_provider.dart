// Governance - Category: state | Purpose: Riverpod state notifier for AttendanceScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AttendanceNotifier extends StateNotifier<AsyncValue<void>> {
  AttendanceNotifier() : super(const AsyncValue.data(null));
}
