import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for LeadAnalyticsScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LeadAnalyticsNotifier extends StateNotifier<AsyncValue<void>> {
  LeadAnalyticsNotifier() : super(const AsyncValue.data(null));
}
