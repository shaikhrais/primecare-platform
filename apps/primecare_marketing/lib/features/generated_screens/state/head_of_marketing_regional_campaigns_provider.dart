// Governance - Category: state | Purpose: Riverpod state notifier for Head Of Marketing Regional Campaigns
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class HeadOfMarketingRegionalCampaignsNotifier extends StateNotifier<AsyncValue<void>> {
  HeadOfMarketingRegionalCampaignsNotifier() : super(const AsyncValue.data(null));
}
