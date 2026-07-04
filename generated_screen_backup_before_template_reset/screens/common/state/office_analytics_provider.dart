// Governance - Category: state | Purpose: Riverpod state notifier for OfficeAnalyticsScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OfficeAnalyticsNotifier extends StateNotifier<AsyncValue<void>> {
  OfficeAnalyticsNotifier() : super(const AsyncValue.data(null));
}
