// Governance - Category: state | Purpose: Riverpod state notifier for CooAnalyticsScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CooAnalyticsNotifier extends StateNotifier<AsyncValue<void>> {
  CooAnalyticsNotifier() : super(const AsyncValue.data(null));
}
