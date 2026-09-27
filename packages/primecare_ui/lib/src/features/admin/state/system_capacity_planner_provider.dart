import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for System Capacity Planner
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SystemCapacityPlannerNotifier extends StateNotifier<AsyncValue<void>> {
  SystemCapacityPlannerNotifier() : super(const AsyncValue.data(null));
}
