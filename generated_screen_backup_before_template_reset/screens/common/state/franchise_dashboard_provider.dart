// Governance - Category: state | Purpose: Riverpod state notifier for FranchiseDashboardScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FranchiseDashboardNotifier extends StateNotifier<AsyncValue<void>> {
  FranchiseDashboardNotifier() : super(const AsyncValue.data(null));
}
