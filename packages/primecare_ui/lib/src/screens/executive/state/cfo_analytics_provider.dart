import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for CfoAnalyticsScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CfoAnalyticsNotifier extends StateNotifier<AsyncValue<void>> {
  CfoAnalyticsNotifier() : super(const AsyncValue.data(null));
}
