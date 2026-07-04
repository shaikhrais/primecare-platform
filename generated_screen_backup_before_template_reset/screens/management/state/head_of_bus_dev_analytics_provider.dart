// Governance - Category: state | Purpose: Riverpod state notifier for HeadOfBusDevAnalyticsScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HeadOfBusDevAnalyticsNotifier extends StateNotifier<AsyncValue<void>> {
  HeadOfBusDevAnalyticsNotifier() : super(const AsyncValue.data(null));
}
