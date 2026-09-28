// Governance - Category: state | Purpose: Riverpod state notifier for Territory Expansion Manager Forecast
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class TerritoryExpansionManagerForecastNotifier extends StateNotifier<AsyncValue<void>> {
  TerritoryExpansionManagerForecastNotifier() : super(const AsyncValue.data(null));
}
