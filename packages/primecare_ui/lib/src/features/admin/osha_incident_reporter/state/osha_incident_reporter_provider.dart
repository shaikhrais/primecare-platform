// Governance - Category: state | Purpose: Riverpod state notifier for Osha Incident Reporter
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OshaIncidentReporterNotifier extends StateNotifier<AsyncValue<void>> {
  OshaIncidentReporterNotifier() : super(const AsyncValue.data(null));
}
