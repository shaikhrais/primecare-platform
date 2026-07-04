// Governance - Category: state | Purpose: Riverpod state notifier for IncidentOversightScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class IncidentOversightNotifier extends StateNotifier<AsyncValue<void>> {
  IncidentOversightNotifier() : super(const AsyncValue.data(null));
}
