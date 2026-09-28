// Governance - Category: state | Purpose: Riverpod state notifier for Clinic Incident Report
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class ClinicIncidentReportNotifier extends StateNotifier<AsyncValue<void>> {
  ClinicIncidentReportNotifier() : super(const AsyncValue.data(null));
}
