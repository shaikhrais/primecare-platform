// Governance - Category: state | Purpose: Riverpod state notifier for Regional Manager Branch Comparison
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class RegionalManagerBranchComparisonNotifier extends StateNotifier<AsyncValue<void>> {
  RegionalManagerBranchComparisonNotifier() : super(const AsyncValue.data(null));
}
