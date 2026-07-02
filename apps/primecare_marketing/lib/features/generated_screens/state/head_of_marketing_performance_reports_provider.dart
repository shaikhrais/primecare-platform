// Governance - Category: state | Purpose: Riverpod state notifier for Head Of Marketing Performance Reports
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HeadOfMarketingPerformanceReportsNotifier extends StateNotifier<AsyncValue<void>> {
  HeadOfMarketingPerformanceReportsNotifier() : super(const AsyncValue.data(null));
}
