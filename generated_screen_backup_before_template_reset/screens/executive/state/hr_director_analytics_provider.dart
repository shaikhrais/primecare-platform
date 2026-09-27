// Governance - Category: state | Purpose: Riverpod state notifier for HrDirectorAnalyticsScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HrDirectorAnalyticsNotifier extends StateNotifier<AsyncValue<void>> {
  HrDirectorAnalyticsNotifier() : super(const AsyncValue.data(null));
}
