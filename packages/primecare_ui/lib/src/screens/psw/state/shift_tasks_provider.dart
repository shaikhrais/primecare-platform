import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for Shift Tasks
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ShiftTasksNotifier extends StateNotifier<AsyncValue<void>> {
  ShiftTasksNotifier() : super(const AsyncValue.data(null));
}
