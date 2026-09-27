import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for FranchiseOwnerClientsScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FranchiseOwnerClientsNotifier extends StateNotifier<AsyncValue<void>> {
  FranchiseOwnerClientsNotifier() : super(const AsyncValue.data(null));
}
