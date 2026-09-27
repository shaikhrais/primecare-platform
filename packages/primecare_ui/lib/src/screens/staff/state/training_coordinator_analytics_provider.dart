import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for TrainingCoordinatorAnalyticsScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TrainingCoordinatorAnalyticsNotifier extends StateNotifier<AsyncValue<void>> {
  TrainingCoordinatorAnalyticsNotifier() : super(const AsyncValue.data(null));
}
