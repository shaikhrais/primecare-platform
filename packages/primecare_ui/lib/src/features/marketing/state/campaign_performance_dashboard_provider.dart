import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for Campaign Performance Dashboard
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CampaignPerformanceDashboardNotifier extends StateNotifier<AsyncValue<void>> {
  CampaignPerformanceDashboardNotifier() : super(const AsyncValue.data(null));
}
