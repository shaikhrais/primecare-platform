import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for Franchise Sales Manager Analytics
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FranchiseSalesAnalyticsNotifier extends StateNotifier<AsyncValue<void>> {
  FranchiseSalesAnalyticsNotifier() : super(const AsyncValue.data(null));
}
