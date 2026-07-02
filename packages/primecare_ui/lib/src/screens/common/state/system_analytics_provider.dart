// Governance - Category: state | Purpose: Riverpod state notifier for SystemAnalyticsScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SystemAnalyticsNotifier extends StateNotifier<AsyncValue<void>> {
  SystemAnalyticsNotifier() : super(const AsyncValue.data(null));
}
