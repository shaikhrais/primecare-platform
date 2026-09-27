import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for ChiropractorAnalyticsScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChiropractorAnalyticsNotifier extends StateNotifier<AsyncValue<void>> {
  ChiropractorAnalyticsNotifier() : super(const AsyncValue.data(null));
}
