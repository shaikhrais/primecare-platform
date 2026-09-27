import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for GeneralManagerAnalyticsScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GeneralManagerAnalyticsNotifier extends StateNotifier<AsyncValue<void>> {
  GeneralManagerAnalyticsNotifier() : super(const AsyncValue.data(null));
}
