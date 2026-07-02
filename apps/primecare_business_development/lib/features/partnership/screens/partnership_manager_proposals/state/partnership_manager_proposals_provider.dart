// Governance - Category: state | Purpose: Riverpod state notifier for Partnership Manager Proposals
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PartnershipManagerProposalsNotifier extends StateNotifier<AsyncValue<void>> {
  PartnershipManagerProposalsNotifier() : super(const AsyncValue.data(null));
}
