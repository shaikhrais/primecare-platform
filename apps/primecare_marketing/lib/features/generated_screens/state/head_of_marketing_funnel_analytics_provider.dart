// Governance - Category: state | Purpose: Riverpod state notifier for Head Of Marketing Funnel Analytics
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class HeadOfMarketingFunnelAnalyticsNotifier extends StateNotifier<AsyncValue<void>> {
  HeadOfMarketingFunnelAnalyticsNotifier() : super(const AsyncValue.data(null));
}
