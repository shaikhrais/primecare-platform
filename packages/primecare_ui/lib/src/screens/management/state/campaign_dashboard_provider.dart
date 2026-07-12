import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for CampaignDashboardScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CampaignDashboardNotifier extends StateNotifier<AsyncValue<void>> {
  CampaignDashboardNotifier() : super(const AsyncValue.data(null));
}
