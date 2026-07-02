// Governance - Category: state | Purpose: Riverpod state notifier for OwnerAnalyticsScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OwnerAnalyticsNotifier extends StateNotifier<AsyncValue<void>> {
  OwnerAnalyticsNotifier() : super(const AsyncValue.data(null));
}
