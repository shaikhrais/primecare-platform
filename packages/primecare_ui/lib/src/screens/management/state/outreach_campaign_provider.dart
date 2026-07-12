import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for OutreachCampaignScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OutreachCampaignNotifier extends StateNotifier<AsyncValue<void>> {
  OutreachCampaignNotifier() : super(const AsyncValue.data(null));
}
