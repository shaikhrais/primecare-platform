// Governance - Category: state | Purpose: Riverpod state notifier for CooBranchComparisonScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CooBranchComparisonNotifier extends StateNotifier<AsyncValue<void>> {
  CooBranchComparisonNotifier() : super(const AsyncValue.data(null));
}
