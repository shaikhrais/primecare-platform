// Governance - Category: state | Purpose: Riverpod state notifier for Territory Expansion Manager Expansion Plans
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class TerritoryExpansionManagerExpansionPlansNotifier extends StateNotifier<AsyncValue<void>> {
  TerritoryExpansionManagerExpansionPlansNotifier() : super(const AsyncValue.data(null));
}
