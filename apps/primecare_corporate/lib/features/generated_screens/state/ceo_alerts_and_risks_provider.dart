// Governance - Category: state | Purpose: Riverpod state notifier for Ceo Alerts And Risks
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class CeoAlertsAndRisksNotifier extends StateNotifier<AsyncValue<void>> {
  CeoAlertsAndRisksNotifier() : super(const AsyncValue.data(null));
}
