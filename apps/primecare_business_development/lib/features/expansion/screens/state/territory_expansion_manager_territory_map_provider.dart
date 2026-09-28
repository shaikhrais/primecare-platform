// Governance - Category: state | Purpose: Riverpod state notifier for Territory Expansion Manager Territory Map
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class TerritoryExpansionManagerTerritoryMapNotifier extends StateNotifier<AsyncValue<void>> {
  TerritoryExpansionManagerTerritoryMapNotifier() : super(const AsyncValue.data(null));
}
