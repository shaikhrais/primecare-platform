import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for HswIncidentReportsScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HswIncidentReportsNotifier extends StateNotifier<AsyncValue<void>> {
  HswIncidentReportsNotifier() : super(const AsyncValue.data(null));
}
