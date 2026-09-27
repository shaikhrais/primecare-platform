// Governance - Category: state | Purpose: Riverpod state notifier for Local Marketing Manager Leads
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LocalMarketingManagerLeadsNotifier extends StateNotifier<AsyncValue<void>> {
  LocalMarketingManagerLeadsNotifier() : super(const AsyncValue.data(null));
}
