// Governance - Category: state | Purpose: Riverpod state notifier for Franchise Sales Manager Sales Pipeline
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class FranchiseSalesManagerSalesPipelineNotifier extends StateNotifier<AsyncValue<void>> {
  FranchiseSalesManagerSalesPipelineNotifier() : super(const AsyncValue.data(null));
}
