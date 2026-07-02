// Governance - Category: state | Purpose: Riverpod state notifier for Training Analytics
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TrainingAnalyticsNotifier extends StateNotifier<AsyncValue<void>> {
  TrainingAnalyticsNotifier() : super(const AsyncValue.data(null));
}
