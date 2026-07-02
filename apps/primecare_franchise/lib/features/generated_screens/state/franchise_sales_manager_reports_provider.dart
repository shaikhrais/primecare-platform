// Governance - Category: state | Purpose: Riverpod state notifier for Franchise Sales Manager Reports
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FranchiseSalesManagerReportsNotifier extends StateNotifier<AsyncValue<void>> {
  FranchiseSalesManagerReportsNotifier() : super(const AsyncValue.data(null));
}
