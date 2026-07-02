// Governance - Category: state | Purpose: Riverpod state notifier for Simulation Lab Scheduler
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SimulationLabSchedulerNotifier extends StateNotifier<AsyncValue<void>> {
  SimulationLabSchedulerNotifier() : super(const AsyncValue.data(null));
}
