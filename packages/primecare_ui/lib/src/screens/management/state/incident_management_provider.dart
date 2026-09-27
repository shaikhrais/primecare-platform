import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for IncidentManagementScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class IncidentManagementNotifier extends StateNotifier<AsyncValue<void>> {
  IncidentManagementNotifier() : super(const AsyncValue.data(null));
}
