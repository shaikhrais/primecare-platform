// Governance - Category: state | Purpose: Riverpod state notifier for FranchiseOverviewScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FranchiseOverviewNotifier extends StateNotifier<AsyncValue<void>> {
  FranchiseOverviewNotifier() : super(const AsyncValue.data(null));
}
