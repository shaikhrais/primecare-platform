// Governance - Category: state | Purpose: Riverpod state notifier for HrHiringAnalyticsScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HrHiringAnalyticsNotifier extends StateNotifier<AsyncValue<void>> {
  HrHiringAnalyticsNotifier() : super(const AsyncValue.data(null));
}
