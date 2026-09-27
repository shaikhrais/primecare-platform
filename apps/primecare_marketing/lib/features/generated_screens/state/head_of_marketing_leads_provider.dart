// Governance - Category: state | Purpose: Riverpod state notifier for Head Of Marketing Leads
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HeadOfMarketingLeadsNotifier extends StateNotifier<AsyncValue<void>> {
  HeadOfMarketingLeadsNotifier() : super(const AsyncValue.data(null));
}
