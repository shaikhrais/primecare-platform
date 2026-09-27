// Governance - Category: state | Purpose: Riverpod state notifier for Territory Expansion Manager Open Territories
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TerritoryExpansionManagerOpenTerritoriesNotifier extends StateNotifier<AsyncValue<void>> {
  TerritoryExpansionManagerOpenTerritoriesNotifier() : super(const AsyncValue.data(null));
}
