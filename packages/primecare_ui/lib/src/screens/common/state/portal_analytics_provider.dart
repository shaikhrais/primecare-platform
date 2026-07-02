// Governance - Category: state | Purpose: Riverpod state notifier for PortalAnalyticsScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PortalAnalyticsNotifier extends StateNotifier<AsyncValue<void>> {
  PortalAnalyticsNotifier() : super(const AsyncValue.data(null));
}
