import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for Security Incident Logger
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SecurityIncidentLoggerNotifier extends StateNotifier<AsyncValue<void>> {
  SecurityIncidentLoggerNotifier() : super(const AsyncValue.data(null));
}
