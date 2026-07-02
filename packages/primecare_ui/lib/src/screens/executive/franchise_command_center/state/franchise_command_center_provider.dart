// Governance - Category: state | Purpose: Riverpod state notifier for FranchiseCommandCenterScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FranchiseCommandCenterNotifier extends StateNotifier<AsyncValue<void>> {
  FranchiseCommandCenterNotifier() : super(const AsyncValue.data(null));
}
