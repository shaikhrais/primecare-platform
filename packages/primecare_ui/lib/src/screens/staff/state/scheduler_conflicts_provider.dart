import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for SchedulerConflictsScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SchedulerConflictsNotifier extends StateNotifier<AsyncValue<void>> {
  SchedulerConflictsNotifier() : super(const AsyncValue.data(null));
}
