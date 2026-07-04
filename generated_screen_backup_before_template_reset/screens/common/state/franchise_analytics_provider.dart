// Governance - Category: state | Purpose: Riverpod state notifier for FranchiseAnalyticsScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FranchiseAnalyticsNotifier extends StateNotifier<AsyncValue<void>> {
  FranchiseAnalyticsNotifier() : super(const AsyncValue.data(null));
}
