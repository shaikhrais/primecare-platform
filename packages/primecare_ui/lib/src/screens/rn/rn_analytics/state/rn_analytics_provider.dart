// Governance - Category: state | Purpose: Riverpod state notifier for RnAnalyticsScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RnAnalyticsNotifier extends StateNotifier<AsyncValue<void>> {
  RnAnalyticsNotifier() : super(const AsyncValue.data(null));
}
