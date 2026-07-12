import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for VolunteerCoordinatorAnalyticsScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class VolunteerCoordinatorAnalyticsNotifier extends StateNotifier<AsyncValue<void>> {
  VolunteerCoordinatorAnalyticsNotifier() : super(const AsyncValue.data(null));
}
