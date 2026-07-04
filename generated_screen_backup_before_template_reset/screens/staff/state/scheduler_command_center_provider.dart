// Governance - Category: state | Purpose: Riverpod state notifier for SchedulerCommandCenterScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SchedulerCommandCenterNotifier extends StateNotifier<AsyncValue<void>> {
  SchedulerCommandCenterNotifier() : super(const AsyncValue.data(null));
}
