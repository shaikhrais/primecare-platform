// Governance - Category: state | Purpose: Riverpod state notifier for TrainingHubAnalyticsScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TrainingHubAnalyticsNotifier extends StateNotifier<AsyncValue<void>> {
  TrainingHubAnalyticsNotifier() : super(const AsyncValue.data(null));
}
