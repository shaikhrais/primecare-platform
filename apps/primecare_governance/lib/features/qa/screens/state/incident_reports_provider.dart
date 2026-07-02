// Governance - Category: state | Purpose: Riverpod state notifier for Incident Reports
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class IncidentReportsNotifier extends StateNotifier<AsyncValue<void>> {
  IncidentReportsNotifier() : super(const AsyncValue.data(null));
}
