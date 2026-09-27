// Governance - Category: state | Purpose: Riverpod state notifier for InfrastructureAnalyticsScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class InfrastructureAnalyticsNotifier extends StateNotifier<AsyncValue<void>> {
  InfrastructureAnalyticsNotifier() : super(const AsyncValue.data(null));
}
