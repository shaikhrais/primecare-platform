// Governance - Category: state | Purpose: Riverpod state notifier for RpnAnalyticsScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RpnAnalyticsNotifier extends StateNotifier<AsyncValue<void>> {
  RpnAnalyticsNotifier() : super(const AsyncValue.data(null));
}
