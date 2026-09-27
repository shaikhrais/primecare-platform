// Governance - Category: state | Purpose: Riverpod state notifier for CaregiverIncidentReportScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CaregiverIncidentReportNotifier extends StateNotifier<AsyncValue<void>> {
  CaregiverIncidentReportNotifier() : super(const AsyncValue.data(null));
}
