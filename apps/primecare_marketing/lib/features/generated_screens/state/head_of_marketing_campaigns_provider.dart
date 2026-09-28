// Governance - Category: state | Purpose: Riverpod state notifier for Head Of Marketing Campaigns
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class HeadOfMarketingCampaignsNotifier extends StateNotifier<AsyncValue<void>> {
  HeadOfMarketingCampaignsNotifier() : super(const AsyncValue.data(null));
}
