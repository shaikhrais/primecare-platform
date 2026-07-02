// Governance - Category: state | Purpose: Riverpod state notifier for TrainingDirectorAnalyticsScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TrainingDirectorAnalyticsNotifier extends StateNotifier<AsyncValue<void>> {
  TrainingDirectorAnalyticsNotifier() : super(const AsyncValue.data(null));
}
