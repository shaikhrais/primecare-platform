// Governance - Category: state | Purpose: Riverpod state notifier for GrowthAnalyticsScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GrowthAnalyticsNotifier extends StateNotifier<AsyncValue<void>> {
  GrowthAnalyticsNotifier() : super(const AsyncValue.data(null));
}
