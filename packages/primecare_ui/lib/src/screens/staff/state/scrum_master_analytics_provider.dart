import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for ScrumMasterAnalyticsScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ScrumMasterAnalyticsNotifier extends StateNotifier<AsyncValue<void>> {
  ScrumMasterAnalyticsNotifier() : super(const AsyncValue.data(null));
}
