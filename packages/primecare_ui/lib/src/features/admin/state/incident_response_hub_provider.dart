// Governance - Category: state | Purpose: Riverpod state notifier for Incident Response Hub
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class IncidentResponseHubNotifier extends StateNotifier<AsyncValue<void>> {
  IncidentResponseHubNotifier() : super(const AsyncValue.data(null));
}
