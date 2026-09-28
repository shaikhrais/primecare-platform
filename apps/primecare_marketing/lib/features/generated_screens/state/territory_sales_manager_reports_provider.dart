// Governance - Category: state | Purpose: Riverpod state notifier for Territory Sales Manager Reports
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class TerritorySalesManagerReportsNotifier extends StateNotifier<AsyncValue<void>> {
  TerritorySalesManagerReportsNotifier() : super(const AsyncValue.data(null));
}
