// Governance - Category: state | Purpose: Riverpod state notifier for RmtAnalyticsScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RmtAnalyticsNotifier extends StateNotifier<AsyncValue<void>> {
  RmtAnalyticsNotifier() : super(const AsyncValue.data(null));
}
