// Governance - Category: state | Purpose: Riverpod state notifier for SchedulerAnalyticsScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SchedulerAnalyticsNotifier extends StateNotifier<AsyncValue<void>> {
  SchedulerAnalyticsNotifier() : super(const AsyncValue.data(null));
}
