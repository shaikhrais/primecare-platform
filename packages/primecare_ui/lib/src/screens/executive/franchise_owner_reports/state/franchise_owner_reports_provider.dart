// Governance - Category: state | Purpose: Riverpod state notifier for FranchiseOwnerReportsScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FranchiseOwnerReportsNotifier extends StateNotifier<AsyncValue<void>> {
  FranchiseOwnerReportsNotifier() : super(const AsyncValue.data(null));
}
