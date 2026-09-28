// Governance - Category: state | Purpose: Riverpod state notifier for Cfo Franchise Financials
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class CfoFranchiseFinancialsNotifier extends StateNotifier<AsyncValue<void>> {
  CfoFranchiseFinancialsNotifier() : super(const AsyncValue.data(null));
}
