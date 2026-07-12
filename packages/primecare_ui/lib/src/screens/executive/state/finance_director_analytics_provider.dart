import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for FinanceDirectorAnalyticsScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FinanceDirectorAnalyticsNotifier extends StateNotifier<AsyncValue<void>> {
  FinanceDirectorAnalyticsNotifier() : super(const AsyncValue.data(null));
}
