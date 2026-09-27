// Governance - Category: state | Purpose: Riverpod state notifier for IntakeCoordinatorAnalyticsScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class IntakeCoordinatorAnalyticsNotifier extends StateNotifier<AsyncValue<void>> {
  IntakeCoordinatorAnalyticsNotifier() : super(const AsyncValue.data(null));
}
