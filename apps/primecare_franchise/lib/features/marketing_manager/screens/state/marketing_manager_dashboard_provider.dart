// Governance - Category: state | Purpose: Riverpod state notifier for Marketing Manager Dashboard
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class MarketingManagerDashboardNotifier extends StateNotifier<AsyncValue<void>> {
  MarketingManagerDashboardNotifier() : super(const AsyncValue.data(null));
}
