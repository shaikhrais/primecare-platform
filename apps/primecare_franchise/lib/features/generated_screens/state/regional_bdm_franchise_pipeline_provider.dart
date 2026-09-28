// Governance - Category: state | Purpose: Riverpod state notifier for Regional Bdm Franchise Pipeline
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class RegionalBdmFranchisePipelineNotifier extends StateNotifier<AsyncValue<void>> {
  RegionalBdmFranchisePipelineNotifier() : super(const AsyncValue.data(null));
}
