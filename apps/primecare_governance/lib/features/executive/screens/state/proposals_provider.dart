// Governance - Category: state | Purpose: Riverpod state notifier for Proposals
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class ProposalsNotifier extends StateNotifier<AsyncValue<void>> {
  ProposalsNotifier() : super(const AsyncValue.data(null));
}
