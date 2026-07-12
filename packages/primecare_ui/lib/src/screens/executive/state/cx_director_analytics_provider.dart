import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for CxDirectorAnalyticsScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CxDirectorAnalyticsNotifier extends StateNotifier<AsyncValue<void>> {
  CxDirectorAnalyticsNotifier() : super(const AsyncValue.data(null));
}
