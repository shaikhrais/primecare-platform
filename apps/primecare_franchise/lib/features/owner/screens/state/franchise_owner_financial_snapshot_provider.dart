// Governance - Category: state | Purpose: Riverpod state notifier for Franchise Owner Financial Snapshot
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class FranchiseOwnerFinancialSnapshotNotifier extends StateNotifier<AsyncValue<void>> {
  FranchiseOwnerFinancialSnapshotNotifier() : super(const AsyncValue.data(null));
}
