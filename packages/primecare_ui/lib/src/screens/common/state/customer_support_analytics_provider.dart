import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for CustomerSupportAnalyticsScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomerSupportAnalyticsNotifier extends StateNotifier<AsyncValue<void>> {
  CustomerSupportAnalyticsNotifier() : super(const AsyncValue.data(null));
}
