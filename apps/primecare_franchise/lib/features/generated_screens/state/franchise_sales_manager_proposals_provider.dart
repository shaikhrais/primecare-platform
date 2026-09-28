// Governance - Category: state | Purpose: Riverpod state notifier for Franchise Sales Manager Proposals
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class FranchiseSalesManagerProposalsNotifier extends StateNotifier<AsyncValue<void>> {
  FranchiseSalesManagerProposalsNotifier() : super(const AsyncValue.data(null));
}
