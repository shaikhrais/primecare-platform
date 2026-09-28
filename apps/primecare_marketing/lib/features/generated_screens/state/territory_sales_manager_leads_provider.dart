// Governance - Category: state | Purpose: Riverpod state notifier for Territory Sales Manager Leads
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class TerritorySalesManagerLeadsNotifier extends StateNotifier<AsyncValue<void>> {
  TerritorySalesManagerLeadsNotifier() : super(const AsyncValue.data(null));
}
