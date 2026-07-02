// Governance - Category: state | Purpose: Riverpod state notifier for Partnership Manager Active Deals
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PartnershipManagerActiveDealsNotifier extends StateNotifier<AsyncValue<void>> {
  PartnershipManagerActiveDealsNotifier() : super(const AsyncValue.data(null));
}
