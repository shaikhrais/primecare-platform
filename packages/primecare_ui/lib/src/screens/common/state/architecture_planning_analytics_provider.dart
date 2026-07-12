import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for ArchitecturePlanningAnalyticsScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ArchitecturePlanningAnalyticsNotifier extends StateNotifier<AsyncValue<void>> {
  ArchitecturePlanningAnalyticsNotifier() : super(const AsyncValue.data(null));
}
