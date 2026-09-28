// Governance - Category: state | Purpose: Riverpod state notifier for Coo Branch Operations
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class CooBranchOperationsNotifier extends StateNotifier<AsyncValue<void>> {
  CooBranchOperationsNotifier() : super(const AsyncValue.data(null));
}
