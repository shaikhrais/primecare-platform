// Governance - Category: state | Purpose: Riverpod state notifier for Partnership Manager Partners
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PartnershipManagerPartnersNotifier extends StateNotifier<AsyncValue<void>> {
  PartnershipManagerPartnersNotifier() : super(const AsyncValue.data(null));
}
