// Governance - Category: state | Purpose: Riverpod state notifier for Territory Expansion Manager Reports
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class TerritoryExpansionManagerReportsNotifier extends StateNotifier<AsyncValue<void>> {
  TerritoryExpansionManagerReportsNotifier() : super(const AsyncValue.data(null));
}
