import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for Grant Funding Allocation
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GrantFundingAllocationNotifier extends StateNotifier<AsyncValue<void>> {
  GrantFundingAllocationNotifier() : super(const AsyncValue.data(null));
}
