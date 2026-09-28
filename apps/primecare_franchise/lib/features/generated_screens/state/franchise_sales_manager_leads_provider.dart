// Governance - Category: state | Purpose: Riverpod state notifier for Franchise Sales Manager Leads
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class FranchiseSalesManagerLeadsNotifier extends StateNotifier<AsyncValue<void>> {
  FranchiseSalesManagerLeadsNotifier() : super(const AsyncValue.data(null));
}
