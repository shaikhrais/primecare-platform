// Governance - Category: state | Purpose: Riverpod state notifier for Territory Sales Manager Competitors
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class TerritorySalesManagerCompetitorsNotifier extends StateNotifier<AsyncValue<void>> {
  TerritorySalesManagerCompetitorsNotifier() : super(const AsyncValue.data(null));
}
