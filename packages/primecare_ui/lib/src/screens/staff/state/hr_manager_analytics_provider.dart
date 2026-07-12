import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for HrManagerAnalyticsScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HrManagerAnalyticsNotifier extends StateNotifier<AsyncValue<void>> {
  HrManagerAnalyticsNotifier() : super(const AsyncValue.data(null));
}
