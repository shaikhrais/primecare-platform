// Governance - Category: state | Purpose: Riverpod state notifier for Marketing Manager Campaigns
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MarketingManagerCampaignsNotifier extends StateNotifier<AsyncValue<void>> {
  MarketingManagerCampaignsNotifier() : super(const AsyncValue.data(null));
}
