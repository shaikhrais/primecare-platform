// Governance - Category: state | Purpose: Riverpod state notifier for Regional Manager Ontario Dashboard
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegionalManagerOntarioDashboardNotifier extends StateNotifier<AsyncValue<void>> {
  RegionalManagerOntarioDashboardNotifier() : super(const AsyncValue.data(null));
}
