// Governance - Category: state | Purpose: Riverpod state notifier for Local Marketing Manager Campaigns
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class LocalMarketingManagerCampaignsNotifier extends StateNotifier<AsyncValue<void>> {
  LocalMarketingManagerCampaignsNotifier() : super(const AsyncValue.data(null));
}
