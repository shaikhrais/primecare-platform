// Governance - Category: state | Purpose: Riverpod state notifier for Report Incident
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PswIncidentReportNotifier extends StateNotifier<AsyncValue<void>> {
  PswIncidentReportNotifier() : super(const AsyncValue.data(null));
}
