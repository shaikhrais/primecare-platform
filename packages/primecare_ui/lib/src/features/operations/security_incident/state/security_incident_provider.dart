// Governance - Category: state | Purpose: Riverpod state notifier for Security Incident
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SecurityIncidentNotifier extends StateNotifier<AsyncValue<void>> {
  SecurityIncidentNotifier() : super(const AsyncValue.data(null));
}
